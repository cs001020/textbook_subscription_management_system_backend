package com.chen.graduation.controller;

import com.chen.graduation.model.VO.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 开课计划控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "开课计划")
@RestController
@RequestMapping("/plan")
public class OpeningPlanController {

    @ApiOperation("导入开课计划")
    @PostMapping("/import")
    public AjaxResult<Object> addPlan() {
        // TODO: 2023/2/1 导入开课计划 for cs
        return AjaxResult.success();
    }

    @ApiOperation("查看开课计划")
    @GetMapping("/get")
    public AjaxResult<Object> query() {
        // TODO: 2023/2/1 查看开课计划 for cs 
        return AjaxResult.success();
    }
}
