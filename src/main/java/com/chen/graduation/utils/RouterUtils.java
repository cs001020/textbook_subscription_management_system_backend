package com.chen.graduation.utils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.VO.MetaVo;
import com.chen.graduation.beans.VO.RouterVo;
import com.chen.graduation.enums.PermissionTypeEnums;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 路由工具
 *
 * @author CHEN
 * @date 2023/03/01
 */
public class RouterUtils {

    public static List<RouterVo> buildRouterTree(List<Permission> permissionList) {
        //过滤出路由权限
        List<Permission> routerPermissionList = permissionList.stream().filter(permission ->
                {
                    return (PermissionTypeEnums.DIRECTORY.equals(permission.getType()) || PermissionTypeEnums.ROUT.equals(permission.getType()));
                }
        ).collect(Collectors.toList());
        //树化
        List<Permission> routerPermissionTreeList = PermissionUtils.buildTree(routerPermissionList);
        //转换并返回
        return convertToRouter(routerPermissionTreeList);
    }

    private static List<RouterVo> convertToRouter(List<Permission> routerPermissionTreeList) {
        //初始化
        List<RouterVo> routerVoList = new ArrayList<>();
        for (Permission permission : routerPermissionTreeList) {
            RouterVo router = new RouterVo();
            router.setName(permission.getName());
            router.setHidden(false);
            router.setAlwaysShow(false);
            router.setPath(getRouterPath(permission));
            router.setComponent(permission.getComponent());
            router.setMeta(new MetaVo(permission.getName(), permission.getIcon()));
            List<Permission> children = permission.getChildren();
            //存在子节点
            if (CollUtil.isNotEmpty(children)) {
                //递归转换子节点
                router.setChildren(convertToRouter(children));
                router.setAlwaysShow(true);
                if (PermissionTypeEnums.DIRECTORY.equals(permission.getType())){
                    router.setRedirect(router.getPath()+"/"+children.get(0).getPath());
                }
            }
            routerVoList.add(router);
        }
        return routerVoList;
    }

    private static String getRouterPath(Permission permission) {
        if (permission.getParentId().intValue() == 0) {
            return "/" + permission.getPath();
        }
        return permission.getPath();
    }
}
