package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.DTO.UserSearchDTO;
import com.chen.graduation.beans.PO.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_user_faculty(教职工用户)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface UserService extends IService<User> {

    /**
     * 账户登录
     *
     * @param accountLoginDTO 账户登录dto
     * @return {@link AjaxResult}<{@link TokenVO}>
     */
    AjaxResult<TokenVO> accountLogin(AccountLoginDTO accountLoginDTO);

    /**
     * 短信登录
     *
     * @param smsLoginDTO 短信登录dto
     * @return {@link AjaxResult}<{@link TokenVO}>
     */
    AjaxResult<TokenVO> smsLogin(SmsLoginDTO smsLoginDTO);

    /**
     * 个人简易信息
     *
     * @return {@link AjaxResult}<{@link SimpleUserInfoVO}>
     */
    AjaxResult<SimpleUserInfoVO> info();

    /**
     * 老师
     *
     * @return {@link AjaxResult}
     */
    AjaxResult<List<User>> teacher(PageParamDTO pageParamDTO, User user);

    /**
     * 注销
     *
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> logout();

    /**
     * 获取用户列表
     *
     * @param userSearchDTO 用户搜索dto
     * @return {@link AjaxResult}<{@link List}<{@link UserVO}>>
     */
    AjaxResult<List<UserVO>> selectUserList(UserSearchDTO userSearchDTO);

    /**
     * 修改用户状态
     *
     * @param user 用户
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> changeState(User user);

    /**
     * 更新用户
     *
     * @param user 用户
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateUser(User user);

    /**
     * 删除用户
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteUser(Long id);

    /**
     * 重置密码
     *
     * @param user 用户
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> resetPwd(User user);

    /**
     * 用户分配角色
     *
     * @param userId  用户id
     * @param roleIds 角色id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> insertUserAuth(Long userId, Long[] roleIds);

    /**
     * 根据用户编号获取授权角色
     *
     * @param userId 用户id
     * @return {@link AjaxResult}<{@link UserRoleVo}>
     */
    AjaxResult<UserRoleVo> authRole(Long userId);

    /**
     * 查询已分配用户角色列表
     *
     * @param pageParamDTO 页面参数dto
     * @param user         用户
     * @param roleId       角色id
     * @return {@link AjaxResult}<{@link UserVO}>
     */
    AjaxResult<List<UserVO>> selectAllocatedList(PageParamDTO pageParamDTO, User user, Long roleId);

    /**
     * 查询未分配用户角色列表
     *
     * @param pageParamDTO 页面参数dto
     * @param user         用户
     * @param roleId       角色id
     * @return {@link AjaxResult}<{@link UserVO}>
     */
    AjaxResult<List<UserVO>> selectUnallocatedList(PageParamDTO pageParamDTO, User user, Long roleId);

    /**
     * 用户资料
     *
     * @return {@link AjaxResult}<{@link UserProfileVO}>
     */
    AjaxResult<UserProfileVO> profile();

    /**
     * 更新用户头像
     *
     * @param file 文件
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateUserAvatar(MultipartFile file);
}
