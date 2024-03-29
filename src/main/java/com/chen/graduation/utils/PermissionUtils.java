package com.chen.graduation.utils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.chen.graduation.beans.PO.Permission;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限工具
 *
 * @author CHEN
 * @date 2023/03/01
 */
public class PermissionUtils {
    public static List<Permission> buildTree(List<Permission> permissionList) {
        //创建集合封装最终数据
        List<Permission> tree = new ArrayList<>();
        //遍历所有菜单集合
        for (Permission permission : permissionList) {
            //父id为0 为入口
            if (permission.getParentId().equals(0L)){
                findChildren(permission,permissionList);
                tree.add(permission);
            }
        }
        return tree;
    }

    /**
     * 获取按钮或请求权限 权限标识
     *
     * @param permissionList 权限列表
     * @return {@link List}<{@link String}>
     */
    public static List<String> getButtonOrRequestPermission(List<Permission> permissionList) {
        List<String> permissions=new ArrayList<>();
        for (Permission permission : permissionList) {
            String perms = permission.getPerms();
            if (StrUtil.isNotBlank(perms)){
                permissions.add(perms);
            }
        }
        return permissions;
    }

    private static void findChildren(Permission permission, List<Permission> permissionList) {
        //循环遍历
        for (Permission permission1 : permissionList) {
            //找到子节点
            if (permission.getId().equals(permission1.getParentId())){
                //初始化
                if (permission.getChildren()==null){
                    permission.setChildren(new ArrayList<>());
                }
                //让子节点再去寻找其子节点
                findChildren(permission1,permissionList);
                //父节点设置子节点
                permission.getChildren().add(permission1);
            }
        }
    }
}
