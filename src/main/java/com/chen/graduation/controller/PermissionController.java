package com.chen.graduation.controller;

import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.utils.PermissionUtils;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 权限控制器
 *
 * @author CHEN
 * @date 2023/03/02
 */
@Slf4j
@Api(tags = "权限")
@ApiSupport(author = "1006596474@qq.com",order = 7)
@RestController
@RequestMapping("/permission")
public class PermissionController {

    @Resource
    private PermissionService permissionService;

    // FIXME: 2023/3/2 暂用 记得修改
    @GetMapping("list")
    public AjaxResult<List<Permission>> getList(){
        List<Permission> list = permissionService.lambdaQuery().orderByAsc(Permission::getSortValue).list();
        List<Permission> permissionList = PermissionUtils.buildTree(list);
        return AjaxResult.success(permissionList);
    }

    @PostMapping("add")
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> add(@RequestBody Permission permission){
        boolean save = permissionService.save(permission);
        return AjaxResult.success(save);
    }
}
