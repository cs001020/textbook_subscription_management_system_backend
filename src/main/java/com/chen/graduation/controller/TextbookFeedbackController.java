package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.TextbookFeedbackInsertDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookFeedbackVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.TextbookFeedbackService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 教科书反馈控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "教材反馈")
@ApiSupport(author = "1006596474@qq.com",order = 5)
@RestController
@RequestMapping("/feedback")
public class TextbookFeedbackController {

    @Resource
    private TextbookFeedbackService textbookFeedbackService;
    @Auth({"student:textbook:feedback"})
    @Log(title = "教材反馈",businessTypeEnums = BusinessTypeEnums.INSERT)
    @ApiOperation("添加教材反馈")
    @PostMapping("/add")
    public AjaxResult<Object> addFeedback(@Validated @RequestBody TextbookFeedbackInsertDTO textbookFeedbackInsertDTO){
        return textbookFeedbackService.addFeedback(textbookFeedbackInsertDTO);
    }

    @Auth({"academic:textbook:list","textbookSubscription:openingPlan:submit","textbookSubscription:audit:resubmit","textbookSubscription:audit:list","textbookSubscription:teachingGroup:list","textbookSubscription:secondaryCollege:list","textbookSubscription:academic:list","textbookSubscription:order:list"})
    @ApiOperation("根据教材id获得反馈信息")
    @GetMapping("/get/{textbookId}")
    public AjaxResult<List<TextbookFeedbackVO>> getFeedbackByTextbookId(@PathVariable("textbookId") Long textbookId){
        return textbookFeedbackService.getFeedbackByTextbookId(textbookId);
    }
}
