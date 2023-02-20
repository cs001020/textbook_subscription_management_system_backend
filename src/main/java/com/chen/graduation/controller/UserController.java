package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SimpleUserInfoVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
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

    @ApiOperation("账号密码登陆")
    @GetMapping("/login/account")
    public AjaxResult<SimpleUserInfoVO> accountLogin(@Validated @RequestBody AccountLoginDTO accountLoginDTO) {
        // TODO: 2023/2/1 账号密码登陆 for cs
        return null;
    }

    @ApiOperation("短信验证码登陆")
    @GetMapping("/login/sms")
    public AjaxResult<Object> smsLogin() {
        // TODO: 2023/2/1 短信验证码登陆 for cs
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
