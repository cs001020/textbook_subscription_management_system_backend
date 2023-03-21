package com.chen.graduation.controller;

import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.DTO.UserSearchDTO;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.*;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.UserService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 登录控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "用户")
@ApiSupport(author = "1006596474@qq.com", order = 1)
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

    @ApiOperation("登出")
    @PostMapping("/logout")
    public AjaxResult<Object> logout() {
        return userService.logout();
    }

    @ApiOperation("个人简易信息")
    @GetMapping("/info")
    public AjaxResult<SimpleUserInfoVO> getUserInfo() {
        return userService.info();
    }

    @ApiOperation("获取教师列表(未被封禁的教师用户)")
    @GetMapping("/teacher")
    public AjaxResult<List<TeacherVO>> getTeacher() {
        return userService.teacher();
    }

    @ApiOperation("获取用户列表")
    @GetMapping("/list")
    public AjaxResult<List<UserVO>> list(@Validated UserSearchDTO userSearchDTO) {
        return userService.selectUserList(userSearchDTO);
    }

    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改用户状态")
    @PutMapping("/changeState")
    public AjaxResult<Object> changeState(@RequestBody User user) {
        return userService.changeState(user);
    }

    @ApiOperation("根据id获取详细用户信息")
    @GetMapping("/userInfo/{id}")
    public AjaxResult<User> userInfo(@PathVariable Long id) {
        return AjaxResult.success(userService.getById(id));
    }

    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改用户")
    @PutMapping("/update")
    public AjaxResult<Object> updateUser(@RequestBody User user) {
        return userService.updateUser(user);
    }

    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.DELETE)
    @ApiOperation("删除用户")
    @DeleteMapping("/delete/{id}")
    public AjaxResult<Object> delete(@PathVariable Long id) {
        return userService.deleteUser(id);
    }

    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("重置密码")
    @PutMapping("/resetPwd")
    public AjaxResult<Object> resetPwd(@RequestBody User user) {
        return userService.resetPwd(user);
    }

    @ApiOperation("根据用户id获取授权角色")
    @GetMapping("/authRole/{userId}")
    public AjaxResult<UserRoleVo> authRole(@PathVariable("userId") Long userId)
    {
        return userService.authRole(userId);
    }

    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.GRANT)
    @ApiOperation("分配角色")
    @PutMapping("/authRole")
    public AjaxResult<Object> insertAuthRole( Long userId, Long[] roleIds) {
        return userService.insertUserAuth(userId, roleIds);
    }

}
