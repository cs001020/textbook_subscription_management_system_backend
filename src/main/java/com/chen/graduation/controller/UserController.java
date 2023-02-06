package com.chen.graduation.controller;

import com.chen.graduation.beans.VO.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

/**
 * 登录控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "用户")
@RestController
@RequestMapping("/user")
public class UserController {

    @ApiOperation("教职工登陆")
    @GetMapping("/faculty/login")
    public AjaxResult<Object> facultyLogin() {
        // TODO: 2023/2/1 教职工登陆 for cs
        return AjaxResult.success();
    }

    @ApiOperation("学生登陆")
    @GetMapping("/student/login")
    public AjaxResult<Object> studentLogin() {
        // TODO: 2023/2/1 学生登陆 for cs
        return AjaxResult.success();
    }

    @ApiOperation("教职工信息")
    @GetMapping("/faculty/me")
    public AjaxResult<Object> facultyInfo() {
        // TODO: 2023/2/1 教职工信息 for cs
        return AjaxResult.success();
    }

    @ApiOperation("学生信息")
    @GetMapping("/student/me")
    public AjaxResult<Object> studentInfo() {
        // TODO: 2023/2/1 学生信息 for cs
        return AjaxResult.success();
    }

}
