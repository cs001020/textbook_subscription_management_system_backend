package com.chen.graduation;

import cn.hutool.json.JSON;
import cn.hutool.json.JSONUtil;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.PO.RolePermission;
import com.chen.graduation.beans.VO.RouterVo;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.service.RolePermissionService;
import com.chen.graduation.utils.PermissionUtils;
import com.chen.graduation.utils.RouterUtils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

@SpringBootTest
public class PermissionTest {
    @Resource
    private PermissionService permissionService;
    @Resource
    private RolePermissionService rolePermissionService;

    @Test
    void test1() {
        List<Permission> list = permissionService.list();
        long start = System.currentTimeMillis();
        List<Permission> permissionList = PermissionUtils.buildTree(list);
        long end = System.currentTimeMillis();
        System.out.println("耗时："+(end-start));
        System.out.println(JSONUtil.toJsonStr(permissionList));
    }

    @Test
    void routerTest() {
        List<Permission> list = permissionService.list();
        long start = System.currentTimeMillis();
        List<RouterVo> routerVoList = RouterUtils.buildRouterTree(list);
        long end = System.currentTimeMillis();
        System.out.println("耗时："+(end-start));
        System.out.println(JSONUtil.toJsonStr(routerVoList));
    }

    @Test
    void addPermissionTest() {
        List<Permission> list = permissionService.list();
        for (Permission permission : list) {
            RolePermission rolePermission = new RolePermission();
            rolePermission.setRoleId(1L);
            rolePermission.setPermissionId(permission.getId());
            rolePermissionService.save(rolePermission);
        }
    }
}
