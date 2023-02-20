package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.mapper.TextbookMapper;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 10065
 * @description 针对表【tb_textbook(教材)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
public class TextbookServiceImpl extends ServiceImpl<TextbookMapper, Textbook>
        implements TextbookService {

    @Resource
    private TextbookConverter textbookConverter;

    @Override
    @Cacheable(value = RedisConstants.TEXTBOOK_PAGE_CACHE_KET,key = "#pageParamDTO.page+'-'+#pageParamDTO.size")
    public AjaxResult<List<TextbookVO>> pageQuery(PageParamDTO pageParamDTO) {
        //分页查询
        Page<Textbook> page = page(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()));
        //po转换成vo
        List<TextbookVO> textbookVOList = textbookConverter.pos2vos(page.getRecords());
        //封装响应
        AjaxResult<List<TextbookVO>> success = AjaxResult.success(textbookVOList);
        success.setTotal(page.getTotal());
        //返回
        return success;
    }
}




