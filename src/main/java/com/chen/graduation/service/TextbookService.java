package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.PO.Textbook;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_textbook(教材)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface TextbookService extends IService<Textbook> {

    /**
     * 教材搜索
     *
     * @param textbookSearchDTO 教材搜索dto
     * @return {@link AjaxResult}<{@link List}<{@link TextbookVO}>>
     */
    AjaxResult<List<TextbookVO>> search(TextbookSearchDTO textbookSearchDTO);

    /**
     * 添加教材
     *
     * @param textbookDTO 教科书dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> addTextBook(TextbookDTO textbookDTO);

    /**
     * 通过id
     *
     * @param ids id
     * @return {@link AjaxResult}<{@link List}<{@link TextbookVO}>>
     */
    AjaxResult<List<TextbookVO>> getByIds(String ids);

    /**
     * 学生查询属于自己的教材
     *
     * @return {@link AjaxResult}<{@link List}<{@link TextbookVO}>>
     */
    AjaxResult<List<TextbookVO>> me();

    /**
     * 添加教材库存
     *
     * @param id    id
     * @param count 数
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> addStock(Long id, Integer count);

    /**
     * 更新教材
     *
     * @param textbook 教科书
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateTextbook(Textbook textbook);
}
