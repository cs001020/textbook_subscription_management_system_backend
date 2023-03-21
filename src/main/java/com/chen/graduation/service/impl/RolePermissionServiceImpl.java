package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.RolePermission;
import com.chen.graduation.service.RolePermissionService;
import com.chen.graduation.mapper.RolePermissionMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_role_permission(角色权限)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class RolePermissionServiceImpl extends ServiceImpl<RolePermissionMapper, RolePermission>
    implements RolePermissionService{

    @Override
    public void updateRolePermission(Role role) {
        //删除原数据
        lambdaUpdate().eq(RolePermission::getRoleId,role.getId()).remove();
        if (CollUtil.isNotEmpty(Arrays.asList(role.getPermissionIds()))){
            this.saveRolePermission(role);
        }
    }

    @Override
    public void saveRolePermission(Role role) {
        //构建对象
        List<RolePermission> rolePermissionList=new ArrayList<>();
        for (Long permissionId : role.getPermissionIds()) {
            RolePermission rolePermission = new RolePermission();
            rolePermission.setRoleId(role.getId());
            rolePermission.setPermissionId(permissionId);
            rolePermissionList.add(rolePermission);
        }
        //新增
        saveBatch(rolePermissionList);
    }
}




