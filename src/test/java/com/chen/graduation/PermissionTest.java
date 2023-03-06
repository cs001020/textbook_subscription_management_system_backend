package com.chen.graduation;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
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

    public static void main(String[] args) {
        Map<String, Object> row1 = new LinkedHashMap<>();
        row1.put("姓名", "张三");
        row1.put("年龄", 23);
        row1.put("成绩", 88.32);
        row1.put("是否合格", true);
        row1.put("考试日期", DateUtil.date());

        Map<String, Object> row2 = new LinkedHashMap<>();
        row2.put("姓名", "李四");
        row2.put("年龄", 33);
        row2.put("成绩", 59.50);
        row2.put("是否合格", false);
        row2.put("考试日期", DateUtil.date());

        ArrayList<Map<String, Object>> rows = CollUtil.newArrayList(row1, row2);

        //通过工具类创建writer
        ExcelWriter writer = ExcelUtil.getWriter("d:/writeTest.xlsx");
//通过构造方法创建writer
//ExcelWriter writer = new ExcelWriter("d:/writeTest.xls");

//跳过当前行，既第一行，非必须，在此演示用
        writer.passCurrentRow();

//合并单元格后的标题行，使用默认标题样式
        writer.merge(row1.size() - 1, "测试标题");
//一次性写出内容，强制输出标题
        writer.write(rows, true);
//关闭writer，释放内存
        writer.close();
    }
}
