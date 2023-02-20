package com.chen.graduation.controller;

import com.chen.graduation.beans.VO.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 教科书反馈控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "教材反馈")
@RestController
@RequestMapping("/feedback")
public class TextbookFeedbackController {
    @ApiOperation("增")
    @PostMapping("/add")
    public AjaxResult<Object> add(){
        // TODO: 2023/2/1 增 for ylf
        return AjaxResult.success();
    }

    @ApiOperation("删")
    @PostMapping("/delete")
    public AjaxResult<Object> delete(){
        // TODO: 2023/2/1 删 for ylf
        return AjaxResult.success();
    }

    @ApiOperation("改")
    @PostMapping("/update")
    public AjaxResult<Object> update(){
        // TODO: 2023/2/1 改 for ylf
        return AjaxResult.success();
    }

    @ApiOperation("查")
    @PostMapping("/get")
    public AjaxResult<Object> get(){
        // TODO: 2023/2/1 查 for ylf
        return AjaxResult.success();
    }
}
