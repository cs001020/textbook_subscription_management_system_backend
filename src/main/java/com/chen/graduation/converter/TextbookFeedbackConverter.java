package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.TextbookFeedbackInsertDTO;
import com.chen.graduation.beans.PO.TextbookFeedback;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.SimpleUserInfoVO;
import com.chen.graduation.beans.VO.TextbookFeedbackVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * 教材转换器
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Mapper(componentModel = "spring")
public interface TextbookFeedbackConverter {

    /**
     * po2vo
     *
     * @param textbookFeedback 教材反馈
     * @return {@link TextbookFeedbackVO}
     */
    @Mapping(target ="simpleUserInfoVO" ,expression = "java(getUserInfo(textbookFeedback.getUser()))")
    TextbookFeedbackVO po2vo(TextbookFeedback textbookFeedback);

    /**
     * dto2po
     *
     * @param textbookFeedbackInsertDTO 教科书反馈插入dto
     * @return {@link TextbookFeedback}
     */
    TextbookFeedback dto2po(TextbookFeedbackInsertDTO textbookFeedbackInsertDTO);


    /**
     * pos2vos
     *
     * @param textbookFeedbackList 教科书反馈列表
     * @return {@link List}<{@link TextbookFeedbackVO}>
     */
    List<TextbookFeedbackVO> pos2vos(List<TextbookFeedback> textbookFeedbackList);

    /**
     * 获取用户信息
     *
     * @param user 用户
     * @return {@link SimpleUserInfoVO}
     */
    default SimpleUserInfoVO getUserInfo(User user){
        SimpleUserInfoVO simpleUserInfoVO = new SimpleUserInfoVO();
        simpleUserInfoVO.setName(user.getName());
        simpleUserInfoVO.setAvatar(user.getIcon());
        return simpleUserInfoVO;
    }
}
