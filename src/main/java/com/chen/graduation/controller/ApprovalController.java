package com.chen.graduation.controller;

import com.chen.graduation.model.VO.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 审批控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "审批")
@RestController
@RequestMapping("/approval")
public class ApprovalController {

    @ApiOperation("教学组审批")
    @PostMapping("/group")
    public AjaxResult<Object> teachingGroup(){
        // TODO: 2023/2/1 教学组审批 for cs
        return AjaxResult.success();
    }

    @ApiOperation("二级学院审批")
    @PostMapping("/second")
    public AjaxResult<Object> secondaryCollege(){
        // TODO: 2023/2/1 二级学院审批 for cs
        return AjaxResult.success();
    }

    @ApiOperation("教务处审批")
    @PostMapping("/affairs")
    public AjaxResult<Object> academicAffairsOffice(){
        // TODO: 2023/2/1 教务处审批 for cs
        return AjaxResult.success();
    }

    @ApiOperation("查看审批请客")
    @PostMapping("/query")
    public AjaxResult<Object> query(){
        // TODO: 2023/2/1 查看审批请客 for cs
        return AjaxResult.success();
    }

    @ApiOperation("提交申请")
    @PostMapping("/add")
    public AjaxResult<Object> add(){
        // TODO: 2023/2/1 提交申请 for cs
        return AjaxResult.success();
    }
}
