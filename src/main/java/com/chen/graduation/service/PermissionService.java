package com.chen.graduation.service;

import com.chen.graduation.beans.PO.Permission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_permission(权限)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface PermissionService extends IService<Permission> {

    /**
     * 通过用户id获取权限
     *
     * @param userId 用户id
     * @return {@link List}<{@link Permission}>
     */
    List<Permission> getPermissionByUserId(Long userId);

    /**
     * 通过角色id获取权限
     * 包含所有权限
     * 该角色拥护的权限 flag为true
     *
     * @param roleId 角色id
     * @return {@link List}<{@link Permission}>
     */
    List<Permission> selectPermissionTreeByRoleId(Long roleId);
}
