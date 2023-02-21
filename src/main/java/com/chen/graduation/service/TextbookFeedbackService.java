package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.TextbookFeedbackInsertDTO;
import com.chen.graduation.beans.PO.TextbookFeedback;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookFeedbackVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_textbook_feedback(教材反馈)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface TextbookFeedbackService extends IService<TextbookFeedback> {


    /**
     * 根据教材id获得反馈信息
     *
     * @param textbookId 教科书id
     * @return {@link AjaxResult}<{@link List}<{@link TextbookFeedbackVO}>>
     */
    AjaxResult<List<TextbookFeedbackVO>> getFeedbackByTextbookId(Long textbookId);

    /**
     * 根据id删除教材反馈信息
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteById(Long id);

    /**
     * 添加反馈信息
     *
     * @param textbookFeedbackInsertDTO 教科书反馈插入dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> addFeedback(TextbookFeedbackInsertDTO textbookFeedbackInsertDTO);
}
