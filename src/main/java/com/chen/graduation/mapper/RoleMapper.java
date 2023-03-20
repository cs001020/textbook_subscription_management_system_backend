package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_role(角色)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.Role
*/
public interface RoleMapper extends BaseMapper<Role> {

    List<Role> getRoleByUserId(@Param("userId") Long userId);
}




