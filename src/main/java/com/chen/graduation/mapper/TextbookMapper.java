package com.chen.graduation.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.PO.Textbook;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.chen.graduation.beans.PO.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_textbook(教材)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.Textbook
*/
public interface TextbookMapper extends BaseMapper<Textbook> {

    /**
     * 根据id列表获取图书
     *
     * @param ids id列表
     * @return {@link List}<{@link Textbook}>
     */
    List<Textbook> getByIds(@Param("ids") List<Long> ids);


    /**
     * 搜索
     *
     * @param objectPage        对象页面
     * @param textbookSearchDTO 教科书搜索dto
     * @return {@link Page}<{@link Textbook}>
     */
    Page<Textbook> search(Page<Object> objectPage,@Param("dto") TextbookSearchDTO textbookSearchDTO);
}




