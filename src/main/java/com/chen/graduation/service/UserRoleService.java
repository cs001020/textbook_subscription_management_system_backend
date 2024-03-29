package com.chen.graduation.service;

import com.chen.graduation.beans.PO.UserRole;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 10065
* @description 针对表【tb_faculty_role(角色权限)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface UserRoleService extends IService<UserRole> {

    /**
     * 通过角色ID查询角色使用数量
     *
     * @param roleId 角色id
     * @return int
     */
    int countUserRoleByRoleId(Long roleId);
}
