package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.UserRole;
import com.chen.graduation.service.UserRoleService;
import com.chen.graduation.mapper.UserRoleMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_faculty_role(角色权限)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class UserRoleUserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole>
    implements UserRoleService {

    @Override
    public int countUserRoleByRoleId(Long roleId) {
        return baseMapper.countUserRoleByRoleId(roleId);
    }
}




