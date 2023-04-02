package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.PermissionService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
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
@ApiSupport(author = "1006596474@qq.com", order = 7)
@RestController
@RequestMapping("/permission")
public class PermissionController {

    @Resource
    private PermissionService permissionService;

    @Auth({"system:permission:list","system:role:add"})
    @GetMapping("list")
    @ApiOperation("获取权限列表(树形结构)")
    public AjaxResult<List<Permission>> list(Permission permission) {
        return permissionService.treeList(permission);
    }

    @Auth({"system:permission:add"})
    @Log(title = "权限管理", businessTypeEnums = BusinessTypeEnums.INSERT)
    @PostMapping("add")
    @ApiOperation("新增权限")
    public AjaxResult<Object> add(@RequestBody @Validated Permission permission) {
        return permissionService.insertPermission(permission);
    }

    @Auth({"system:permission:edit"})
    @GetMapping(value = "/{id}")
    @ApiOperation("根据id号获取详细信息")
    public AjaxResult<Permission> getInfo(@PathVariable Long id) {
        return permissionService.getPermissionByPermissionId(id);
    }

    @Auth({"system:permission:edit"})
    @Log(title = "权限管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @PutMapping("/update")
    @ApiOperation("修改菜单")
    public AjaxResult<Object> edit(@Validated @RequestBody Permission permission) {
        return permissionService.updatePermission(permission);
    }

    @Auth({"system:permission:remove"})
    @Log(title = "权限管理", businessTypeEnums = BusinessTypeEnums.DELETE)
    @DeleteMapping("/del/{id}")
    @ApiOperation("根据id删除权限")
    public AjaxResult<Object> remove(@PathVariable("id") Long id) {
        return permissionService.deletePermissionById(id);
    }

    @Auth({"system:permission:edit"})
    @Log(title = "权限管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @PutMapping("/changeSate")
    @ApiOperation("修改权限状态")
    public AjaxResult<Object> changeSate(@RequestBody Permission permission) {
        return permissionService.changeState(permission);
    }
}
