package com.chen.graduation.controller;

import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.utils.PermissionUtils;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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

    @GetMapping("list")
    @ApiOperation("获取权限列表(树形结构)")
    public AjaxResult<List<Permission>> list(Permission permission){
        return permissionService.treeList(permission);
    }

    @PostMapping("add")
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> add(@RequestBody Permission permission){
        boolean save = permissionService.save(permission);
        return AjaxResult.success(save);
    }
}
