package com.chen.graduation.controller;

import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.RolePermissionVo;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.RoleService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 角色控制器
 *
 * @author CHEN
 * @date 2023/03/16
 */
@Slf4j
@Api(tags = "角色")
@ApiSupport(author = "1006596474@qq.com", order = 7)
@RestController
@RequestMapping("/role")
public class RoleController {

    @Resource
    private RoleService roleService;

    @ApiOperation("角色列表")
    @GetMapping("list")
    public AjaxResult<List<Role>> getList(@Validated PageParamDTO pageParamDTO, Role role) {
        return roleService.pageQuery(pageParamDTO, role);
    }

    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改角色状态")
    @PutMapping("/changeState")
    public AjaxResult<Object> changeStatus(@RequestBody Role role) {
        return roleService.changeStatus(role);
    }

    @ApiOperation("根据角色id获取详细信息")
    @GetMapping(value = "/{roleId}")
    public AjaxResult<RolePermissionVo> getInfo(@PathVariable Long roleId) {
        return roleService.selectRoleById(roleId);
    }

    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改角色")
    @PutMapping("/update")
    public AjaxResult<Object> updateRole(@Validated @RequestBody Role role) {
        return roleService.updateRole(role);
    }

    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.INSERT)
    @ApiOperation("新增角色")
    @PostMapping("/add")
    public AjaxResult<Object> add(@Validated @RequestBody Role role) {
        return roleService.saveRole(role);
    }
}
