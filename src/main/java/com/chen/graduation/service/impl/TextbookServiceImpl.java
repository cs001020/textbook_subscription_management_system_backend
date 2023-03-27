package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.enums.SortableEnums;
import com.chen.graduation.enums.TextbookOrderStateEnums;
import com.chen.graduation.enums.TextbookStateEnums;
import com.chen.graduation.enums.UserTypeEnums;
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
    private TextbookFeedbackService textbookFeedbackService;
    @Resource
    @Lazy
    private TextbookOrderService textbookOrderService;
    @Resource
    private UserService userService;

    @Override
    public AjaxResult<List<TextbookVO>> search(TextbookSearchDTO textbookSearchDTO) {
        //查询
        Page<Textbook> page =baseMapper.search(new Page<>(textbookSearchDTO.getPage(), textbookSearchDTO.getSize()),textbookSearchDTO);
        //po转换成vo
        List<TextbookVO> textbookVOList = textbookConverter.pos2vos(page.getRecords());;
        //封装响应
        AjaxResult<List<TextbookVO>> success = AjaxResult.success(textbookVOList);
        success.setTotal(page.getTotal());
        //返回
        return success;
    }

    // TODO: 2023/2/25 好像用不上
    @Override
    @CacheEvict(value = RedisConstants.TEXTBOOK_PAGE_CACHE_KET, allEntries = true)
    public AjaxResult<Object> addTextBook(TextbookDTO textbookDTO) {
        //转换
        Textbook textbook = textbookConverter.dto2po(textbookDTO);
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
        if (Objects.isNull(user)||Objects.isNull(user.getGradeId())||!UserTypeEnums.STUDENT.equals(user.getType())){
           return AjaxResult.success(Collections.emptyList());
        }
        //根据学生班级id查询已经发放教材订单
        List<TextbookOrder> textbookOrderList = textbookOrderService.lambdaQuery().eq(TextbookOrder::getGradeId, user.getGradeId()).eq(TextbookOrder::getState, TextbookOrderStateEnums.GRANTED).list();
        if (CollectionUtil.isEmpty(textbookOrderList)){
            return AjaxResult.success(Collections.emptyList());
        }
        //获取审核ids
        List<String> collect1 = textbookOrderList.stream().map(TextbookOrder::getTextbookIds).collect(Collectors.toList());
        //获取教材ids
        List<Long> textBookIds=new ArrayList<>();
        collect1.forEach(ids->{
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
        if (Objects.isNull(count)|| count <=0){
            throw new ServiceException("参数异常");
        }
        //获取教材信息
        Textbook textbook = getById(id);
        TextbookStateEnums state = textbook.getState();
        Integer stock = textbook.getStock();
        //教材状态判断
        if (TextbookStateEnums.AUDIT.equals(state)||TextbookStateEnums.DISCARD.equals(state)){
            throw new ServiceException("该图书无法添加库存");
        }
        //修改库存
        textbook.setStock(stock+count);
        if (TextbookStateEnums.UNDER_STOCK.equals(state)){
            textbook.setState(TextbookStateEnums.NORMAL);
        }
        boolean update = lambdaUpdate().eq(Textbook::getId, id).set(Textbook::getStock, stock + count).set(Textbook::getState,state).update();
        //日志
        log.info("TextbookServiceImpl.addStock业务结束，结果:{}",update);
        //响应
        return AjaxResult.success(update);
    }
}




