package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.mapper.PermissionMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_permission(权限)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission>
    implements PermissionService{

    @Override
    public List<Permission> getPermissionByUserId(Long userId) {
        return baseMapper.getPermissionByUserId(userId);
    }
}




