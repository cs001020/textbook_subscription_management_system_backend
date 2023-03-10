package com.chen.graduation;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNode;
import cn.hutool.core.lang.tree.TreeNodeConfig;
import cn.hutool.core.lang.tree.TreeUtil;
import cn.hutool.json.JSONUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.alibaba.fastjson2.JSON;
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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
        System.out.println("耗时：" + (end - start));
        System.out.println(JSONUtil.toJsonStr(permissionList));
    }

    @Test
    void routerTest() {
        List<Permission> list = permissionService.list();
        long start = System.currentTimeMillis();
        List<RouterVo> routerVoList = RouterUtils.buildRouterTree(list);
        long end = System.currentTimeMillis();
        System.out.println("耗时：" + (end - start));
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

    @Test
    void treeUtilsTest() {
        List<Permission> list = permissionService.list();
        //配置
        TreeNodeConfig treeNodeConfig = new TreeNodeConfig();
        // 自定义属性名 都要默认值的
        treeNodeConfig.setIdKey("id");
        //// 最大递归深度
        //treeNodeConfig.setDeep(3);
        long start = System.currentTimeMillis();
        //转换器
        List<Tree<String>> treeNodes = TreeUtil.build(list, "0", treeNodeConfig,
                (treeNode, tree) -> {
                    tree.setId(treeNode.getId().toString());
                    tree.setParentId(treeNode.getParentId().toString());
                    tree.setName(treeNode.getName());
                    // 扩展属性 ...
                    tree.putExtra("path", treeNode.getPath());
                    tree.putExtra("component", treeNode.getComponent());
                });
        System.out.println("耗时："+(System.currentTimeMillis()-start));
        System.out.println(JSON.toJSONString(treeNodes));
    }
}
