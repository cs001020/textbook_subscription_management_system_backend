package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SimpleUserInfoVO;
import com.chen.graduation.beans.VO.TokenVO;
import com.chen.graduation.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

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

    @Resource
    private UserService userService;

    @ApiOperation("账号密码登陆")
    @PostMapping("/login/account")
    public AjaxResult<TokenVO> accountLogin(@Validated @RequestBody AccountLoginDTO accountLoginDTO) {
        return userService.accountLogin(accountLoginDTO);
    }

    @ApiOperation("短信验证码登陆")
    @PostMapping("/login/sms")
    public AjaxResult<TokenVO> smsLogin(@Validated @RequestBody SmsLoginDTO smsLoginDTO) {
        return userService.smsLogin(smsLoginDTO);
    }

    @ApiOperation("个人简易信息")
    @GetMapping("/info")
    public AjaxResult<SimpleUserInfoVO> getUserInfo() {
        return userService.info();
    }


}
