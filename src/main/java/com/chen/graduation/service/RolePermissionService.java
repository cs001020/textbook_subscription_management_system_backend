package com.chen.graduation.service;

import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.RolePermission;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 10065
* @description 针对表【tb_role_permission(角色权限)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface RolePermissionService extends IService<RolePermission> {

    /**
     * 更新角色权限关系
     *
     * @param role 角色
     */
    void updateRolePermission(Role role);

    /**
     * 新增角色权限关系
     *
     * @param role 角色
     */
    void saveRolePermission(Role role);
}
