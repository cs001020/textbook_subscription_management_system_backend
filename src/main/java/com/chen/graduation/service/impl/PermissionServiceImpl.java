package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.mapper.PermissionMapper;
import com.chen.graduation.utils.PermissionUtils;
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

    @Override
    public List<Permission> selectPermissionTreeByRoleId(Long roleId) {
        //查询所有权限
        List<Permission> allPermissionList = list();
        //查询角色拥有的权限
        List<Permission> rolePermissionList = baseMapper.getPermissionByRoleId(roleId);
        //遍历
        for (Permission permission : allPermissionList) {
            for (Permission rolePermission : rolePermissionList) {
                if (permission.getId().longValue()==rolePermission.getId().longValue()){
                    permission.setFlag(true);
                    break;
                }
            }
        }
        //树化 返回
        return PermissionUtils.buildTree(allPermissionList);
    }
}




