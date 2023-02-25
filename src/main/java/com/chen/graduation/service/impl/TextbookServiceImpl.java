package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.enums.SortableEnums;
import com.chen.graduation.enums.TextbookStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.mapper.TextbookMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
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

    @Override
    public AjaxResult<List<TextbookVO>> search(TextbookSearchDTO textbookSearchDTO) {
        //条件构造器
        LambdaQueryWrapper<Textbook> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.orderByAsc(SortableEnums.ASC.equals(textbookSearchDTO.getOrderByStock()), Textbook::getStock);
        lambdaQueryWrapper.orderByAsc(SortableEnums.ASC.equals(textbookSearchDTO.getOrderByPrice()), Textbook::getPrice);
        lambdaQueryWrapper.orderByDesc(SortableEnums.DESC.equals(textbookSearchDTO.getOrderByStock()), Textbook::getStock);
        lambdaQueryWrapper.orderByDesc(SortableEnums.DESC.equals(textbookSearchDTO.getOrderByPrice()), Textbook::getPrice);
        String keyWord = textbookSearchDTO.getKeyWord();
        if (StrUtil.isNotBlank(keyWord)) {
            lambdaQueryWrapper
                    .like(Textbook::getBookName, keyWord).or()
                    .like(Textbook::getDescription, keyWord).or()
                    .like(Textbook::getAuthor, keyWord).or()
                    .like(Textbook::getPublishingHouse, keyWord);
        }
        lambdaQueryWrapper.eq(Textbook::getState, TextbookStateEnums.NORMAL);
        //查询
        Page<Textbook> page = page(new Page<>(textbookSearchDTO.getPage(), textbookSearchDTO.getSize()), lambdaQueryWrapper);
        //po转换成vo
        List<TextbookVO> textbookVOList = textbookConverter.pos2vos(page.getRecords());
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
}




