package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.TextbookFeedbackInsertDTO;
import com.chen.graduation.beans.PO.TextbookFeedback;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookFeedbackVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.converter.TextbookFeedbackConverter;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.TextbookFeedbackService;
import com.chen.graduation.mapper.TextbookFeedbackMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 10065
 * @description 针对表【tb_textbook_feedback(教材反馈)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class TextbookFeedbackServiceImpl extends ServiceImpl<TextbookFeedbackMapper, TextbookFeedback>
        implements TextbookFeedbackService {

    @Resource
    private TextbookFeedbackConverter textbookFeedbackConverter;

    @Override
    @Cacheable(value = RedisConstants.TEXTBOOK_FEEDBACK_CACHE_KEY,key = "#textbookId")
    public AjaxResult<List<TextbookFeedbackVO>> getFeedbackByTextbookId(Long textbookId) {
        //数据库查询
        List<TextbookFeedback> textbookFeedbackList = baseMapper.getFeedbackByTextbookId(textbookId);
        //转换VO
        List<TextbookFeedbackVO> textbookFeedbackVOList = textbookFeedbackConverter.pos2vos(textbookFeedbackList);
        //打印日志
        log.info("TextbookFeedbackServiceImpl.getFeedbackByTextbookId业务结束，结果:{}",textbookFeedbackVOList);
        //响应
        return AjaxResult.success(textbookFeedbackVOList);
    }

    // FIXME: 2023/2/21 存在缓存错误删除问题
    @Override
    @CacheEvict(value = RedisConstants.TEXTBOOK_FEEDBACK_CACHE_KEY,allEntries = true)
    public AjaxResult<Object> deleteById(Long id) {
        //删除
        boolean success = this.removeById(id);
        //打印日志
        log.info("TextbookFeedbackServiceImpl.deleteById业务结束，结果:{}",success);
        //返回
        return AjaxResult.success(success);
    }

    @Override
    @CacheEvict(value = RedisConstants.TEXTBOOK_FEEDBACK_CACHE_KEY,key = "#textbookFeedbackInsertDTO.textbookId")
    public AjaxResult<Object> addFeedback(TextbookFeedbackInsertDTO textbookFeedbackInsertDTO) {
        //获取用户id
        Long userId = UserHolderContext.getUserId();
        //封装po
        TextbookFeedback textbookFeedback = textbookFeedbackConverter.dto2po(textbookFeedbackInsertDTO);
        textbookFeedback.setStudentId(userId);
        //插入数据库
        boolean save = save(textbookFeedback);
        //打印日志
        log.info("TextbookFeedbackServiceImpl.addFeedback业务结束，结果:{}",save);
        return AjaxResult.success(save);
    }
}




