package com.chen.graduation.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.enums.PermissionStateEnums;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.mapper.PermissionMapper;
import com.chen.graduation.utils.PermissionUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

/**
* @author 10065
* @description 针对表【tb_permission(权限)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
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

    @Override
    public AjaxResult<List<Permission>> treeList(Permission permission) {
        //参数获取
        String name = permission.getName();
        PermissionStateEnums state = permission.getState();
        //查询
        List<Permission> list = this.lambdaQuery()
                .like(StrUtil.isNotBlank(name),Permission::getName,name)
                .eq(!Objects.isNull(state),Permission::getState,state)
                .orderByAsc(Permission::getSortValue)
                .list();
        //构建树形结构
        List<Permission> permissionList = PermissionUtils.buildTree(list);
        //日志
        log.info("PermissionServiceImpl.treeList业务结束，结果:{}",permissionList);
        //响应
        return AjaxResult.success(permissionList);
    }
}




