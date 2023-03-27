package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.update.LambdaUpdateChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.enums.*;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.*;
import com.chen.graduation.mapper.TextbookMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author 10065
 * @description 针对表【tb_textbook(教材)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class TextbookServiceImpl extends ServiceImpl<TextbookMapper, Textbook>
        implements TextbookService {

    @Resource
    private TextbookConverter textbookConverter;
    @Resource
    @Lazy
    private TextbookOrderService textbookOrderService;
    @Resource
    private UserService userService;

    @Override
    public AjaxResult<List<TextbookVO>> search(TextbookSearchDTO textbookSearchDTO) {
        //查询
        Page<Textbook> page = baseMapper.search(new Page<>(textbookSearchDTO.getPage(), textbookSearchDTO.getSize()), textbookSearchDTO);
        //po转换成vo
        List<TextbookVO> textbookVOList = textbookConverter.pos2vos(page.getRecords());
        ;
        //封装响应
        AjaxResult<List<TextbookVO>> success = AjaxResult.success(textbookVOList);
        success.setTotal(page.getTotal());
        //返回
        return success;
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> addTextBook(TextbookDTO textbookDTO) {
        //转换
        Textbook textbook = textbookConverter.dto2po(textbookDTO);
        //教材吗唯一性检查
        if (UniqueEnums.UN_UNIQUE.equals(checkTextbookNameUnique(textbook))) {
            throw new ServiceException("添加教材《" + textbook.getBookName() + "》失败，教材名已存在");
        }
        //教材状态判断
        textbook.setState(TextbookStateEnums.NORMAL);
        if (Objects.isNull(textbookDTO.getStock()) || textbook.getStock().equals(0)) {
            textbook.setState(TextbookStateEnums.UNDER_STOCK);
        }
        //插入
        boolean success = this.save(textbook);
        //打印日志
        log.info("TextbookServiceImpl.addTextBook业务结束，结果:{}", success);
        //返回
        if (!success) {
            throw new ServiceException("插入异常");
        }
        return AjaxResult.success();
    }

    @Override
    public AjaxResult<List<TextbookVO>> getByIds(String ids) {
        //获取id列表
        List<Long> collect = null;
        try {
            collect = Arrays.stream(ids.split(",")).map(Long::valueOf).collect(Collectors.toList());
        } catch (Exception e) {
            throw new ServiceException("参数异常");
        }
        //参数校验
        if (CollectionUtil.isEmpty(collect)) {
            throw new ServiceException("参数异常");
        }
        //数据库查询
        List<Textbook> textbookList = baseMapper.getByIds(collect);
        //转换成VO
        List<TextbookVO> textbookVOList = textbookConverter.pos2vos(textbookList);
        log.info("TextbookServiceImpl.getByIds业务结束，结果:{}", textbookVOList);
        return AjaxResult.success(textbookVOList);
    }

    // FIXME: 2023/3/16 优化
    @Override
    public AjaxResult<List<TextbookVO>> me() {
        //查询当前用户
        Long userId = UserHolderContext.getUserId();
        User user = userService.getById(userId);
        //非学生用户返回空列表
        if (Objects.isNull(user) || Objects.isNull(user.getGradeId()) || !UserTypeEnums.STUDENT.equals(user.getType())) {
            return AjaxResult.success(Collections.emptyList());
        }
        //根据学生班级id查询已经发放教材订单
        List<TextbookOrder> textbookOrderList = textbookOrderService.lambdaQuery().eq(TextbookOrder::getGradeId, user.getGradeId()).eq(TextbookOrder::getState, TextbookOrderStateEnums.GRANTED).list();
        if (CollectionUtil.isEmpty(textbookOrderList)) {
            return AjaxResult.success(Collections.emptyList());
        }
        //获取审核ids
        List<String> collect1 = textbookOrderList.stream().map(TextbookOrder::getTextbookIds).collect(Collectors.toList());
        //获取教材ids
        List<Long> textBookIds = new ArrayList<>();
        collect1.forEach(ids -> {
            List<Long> collect = Arrays.stream(ids.split(",")).map(Long::valueOf).collect(Collectors.toList());
            textBookIds.addAll(collect);
        });
        //数据库查询
        return this.getByIds(StrUtil.join(",", textBookIds));
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> addStock(Long id, Integer count) {
        //参数校验
        if (Objects.isNull(count) || count <= 0) {
            throw new ServiceException("参数异常");
        }
        //获取教材信息
        Textbook textbook = getById(id);
        TextbookStateEnums state = textbook.getState();
        Integer stock = textbook.getStock();
        //教材状态判断
        if (TextbookStateEnums.AUDIT.equals(state) || TextbookStateEnums.DISCARD.equals(state)) {
            throw new ServiceException("该图书无法添加库存");
        }
        //修改库存
        LambdaUpdateChainWrapper<Textbook> lambdaUpdate = lambdaUpdate();
        lambdaUpdate.set(Textbook::getStock, stock + count);
        if (TextbookStateEnums.UNDER_STOCK.equals(state)) {
            lambdaUpdate.set(Textbook::getState, TextbookStateEnums.NORMAL);
        }
        boolean update = lambdaUpdate.eq(Textbook::getId, id).update();
        //日志
        log.info("TextbookServiceImpl.addStock业务结束，结果:{}", update);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updateTextbook(Textbook textbook) {
        //参数校验
        if (Objects.isNull(textbook.getId())) {
            throw new ServiceException("参数异常");
        }
        //状态校验
        Textbook textbook1 = getById(textbook.getId());
        if (TextbookStateEnums.AUDIT.equals(textbook1.getState())) {
            throw new ServiceException("图书审核中,禁止修改");
        }
        //教材名唯一性检查
        if (UniqueEnums.UN_UNIQUE.equals(checkTextbookNameUnique(textbook))) {
            throw new ServiceException("添加教材《" + textbook.getBookName() + "》失败，教材名已存在");
        }
        //正常状态下无库存或0库存 设置状态为库存不足
        if (TextbookStateEnums.NORMAL.equals(textbook.getState()) && textbook.getStock().equals(0)) {
            textbook.setState(TextbookStateEnums.UNDER_STOCK);
        }
        if (TextbookStateEnums.UNDER_STOCK.equals(textbook.getState()) && textbook.getStock()>0) {
            textbook.setState(TextbookStateEnums.NORMAL);
        }
        //更新
        boolean update = updateById(textbook);
        //日志
        log.info("TextbookServiceImpl.updateTextbook业务结束，结果:{}", update);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> discardTextbook(Long id) {
        //获取教材
        Textbook textbook = getById(id);
        //教材状态判断
        if (TextbookStateEnums.AUDIT.equals(textbook.getState())){
            throw new ServiceException("教材审核中,禁止修改");
        }
        //修改
        boolean update = lambdaUpdate().eq(Textbook::getId, id).set(Textbook::getState, TextbookStateEnums.DISCARD).update();
        //日志
        log.info("TextbookServiceImpl.discardTextbook业务结束，结果:{}",update);
        //响应
        return AjaxResult.success(update);
    }


    /**
     * 检查教材名唯一性
     *
     * @param textbook 教科书
     * @return {@link UniqueEnums}
     */
    private UniqueEnums checkTextbookNameUnique(Textbook textbook) {
        String bookName = textbook.getBookName();
        if (StrUtil.isBlank(bookName)) {
            return UniqueEnums.UNIQUE;
        }
        Page<Textbook> page = lambdaQuery().eq(Textbook::getBookName, bookName).page(new Page<>(1, 1));
        List<Textbook> textbookList = page.getRecords();
        if (CollectionUtil.isEmpty(textbookList) || textbookList.get(0).getId().equals(textbook.getId())) {
            return UniqueEnums.UNIQUE;
        }
        return UniqueEnums.UN_UNIQUE;
    }
}




