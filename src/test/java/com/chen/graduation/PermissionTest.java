package com.chen.graduation;

import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.service.PermissionService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@SpringBootTest
public class PermissionTest {
    @Resource
    private PermissionService permissionService;

    @Test
    void test1() {
        for (Permission permission : permissionService.list()) {
            System.out.println(permission);
        }

    }
}
