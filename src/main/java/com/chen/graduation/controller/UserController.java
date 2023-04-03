package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.*;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.*;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.UserService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    @Auth({SystemConstants.LOGIN_PERM})
    @ApiOperation("登出")
    @PostMapping("/logout")
    public AjaxResult<Object> logout() {
        return userService.logout();
    }

    @Auth({SystemConstants.LOGIN_PERM})
    @ApiOperation("个人信息")
    @GetMapping("/info")
    public AjaxResult<SimpleUserInfoVO> getUserInfo() {
        return userService.info();
    }

    @Auth({SystemConstants.LOGIN_PERM})
    @ApiOperation("个人资料")
    @GetMapping("/profile")
    public AjaxResult<UserProfileVO> getUserProfile() {
        return userService.profile();
    }

    @Auth({SystemConstants.LOGIN_PERM})
    @Log(title = "个人资料", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("用户修改头像")
    @PostMapping("/avatar")
    public AjaxResult<Object> updateUserAvatar(@RequestParam("avatarfile") MultipartFile file) {
        return userService.updateUserAvatar(file);
    }

    @Auth({SystemConstants.LOGIN_PERM})
    @Log(title = "个人资料", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("用户修改资料")
    @PostMapping("/profile")
    public AjaxResult<Object> updateUserProfile(@RequestBody @Validated UserProfileUpdateDTO userProfileUpdateDTO) {
        return userService.updateUserProfile(userProfileUpdateDTO);
    }

    @Auth({SystemConstants.LOGIN_PERM})
    @Log(title = "个人资料", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("用户修改密码")
    @PostMapping("/pwd")
    public AjaxResult<Object> updateUserPwd(@RequestBody @Validated UserRestPasswordDTO userRestPasswordDTO) {
        return userService.updateUserPwd(userRestPasswordDTO);
    }

    @Auth({"academic:openingPlan:add","academic:openingPlan:edit"})
    @ApiOperation("获取教师列表(未被封禁的教师用户)")
    @GetMapping("/teacher")
    public AjaxResult<List<User>> getTeacher(@Validated PageParamDTO pageParamDTO, User user) {
        return userService.teacher(pageParamDTO,user);
    }

    @Auth({"system:user:list"})
    @ApiOperation("获取用户列表")
    @GetMapping("/list")
    public AjaxResult<List<UserVO>> list(@Validated UserSearchDTO userSearchDTO) {
        return userService.selectUserList(userSearchDTO);
    }
    @Auth({"system:user:edit"})
    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改用户状态")
    @PutMapping("/changeState")
    public AjaxResult<Object> changeState(@RequestBody User user) {
        return userService.changeState(user);
    }

    @Auth({"system:user:edit"})
    @ApiOperation("根据id获取详细用户信息")
    @GetMapping("/userInfo/{id}")
    public AjaxResult<User> userInfo(@PathVariable Long id) {
        return AjaxResult.success(userService.getById(id));
    }

    @Auth({"system:user:edit"})
    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改用户")
    @PutMapping("/update")
    public AjaxResult<Object> updateUser(@RequestBody User user) {
        return userService.updateUser(user);
    }

    @Auth({"system:user:remove"})
    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.DELETE)
    @ApiOperation("删除用户")
    @DeleteMapping("/delete/{id}")
    public AjaxResult<Object> delete(@PathVariable Long id) {
        return userService.deleteUser(id);
    }

    @Auth({"system:user:resetPwd"})
    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("重置密码")
    @PutMapping("/resetPwd")
    public AjaxResult<Object> resetPwd(@RequestBody User user) {
        return userService.resetPwd(user);
    }

    @Auth({"system:user:auth"})
    @ApiOperation("根据用户id获取授权角色")
    @GetMapping("/authRole/{userId}")
    public AjaxResult<UserRoleVo> authRole(@PathVariable("userId") Long userId)
    {
        return userService.authRole(userId);
    }

    @Auth({"system:user:auth"})
    @Log(title = "用户管理", businessTypeEnums = BusinessTypeEnums.GRANT)
    @ApiOperation("分配角色")
    @PutMapping("/authRole")
    public AjaxResult<Object> insertAuthRole( Long userId, Long[] roleIds) {
        return userService.insertUserAuth(userId, roleIds);
    }

}
