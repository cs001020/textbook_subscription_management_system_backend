package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.TextbookFeedback;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_textbook_feedback(教材反馈)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.TextbookFeedback
*/
public interface TextbookFeedbackMapper extends BaseMapper<TextbookFeedback> {


    /**
     * 得到反馈教科书id
     *
     * @param textbookId 教科书id
     * @return {@link List}<{@link TextbookFeedback}>
     */
    List<TextbookFeedback> getFeedbackByTextbookId(@Param("id") Long textbookId);
}




