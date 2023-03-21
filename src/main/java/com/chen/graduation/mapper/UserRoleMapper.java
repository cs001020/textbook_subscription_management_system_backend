package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.UserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
* @author 10065
* @description 针对表【tb_faculty_role(角色权限)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.FacultyRole
*/
public interface UserRoleMapper extends BaseMapper<UserRole> {

    /**
     * 通过角色ID查询角色使用数量
     *
     * @param roleId 角色id
     * @return int
     */
    int countUserRoleByRoleId(@Param("id") Long roleId);
}




