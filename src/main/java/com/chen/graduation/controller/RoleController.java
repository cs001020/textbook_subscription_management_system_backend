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

    /**
     * 修改保存角色
     */
    //@Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    //@PutMapping
    //public AjaxResult edit(@Validated @RequestBody SysRole role)
    //{
    //    roleService.checkRoleAllowed(role);
    //    roleService.checkRoleDataScope(role.getRoleId());
    //    if (!roleService.checkRoleNameUnique(role))
    //    {
    //        return error("修改角色'" + role.getRoleName() + "'失败，角色名称已存在");
    //    }
    //    else if (!roleService.checkRoleKeyUnique(role))
    //    {
    //        return error("修改角色'" + role.getRoleName() + "'失败，角色权限已存在");
    //    }
    //    role.setUpdateBy(getUsername());
    //
    //    if (roleService.updateRole(role) > 0)
    //    {
    //        // 更新缓存用户权限
    //        LoginUser loginUser = getLoginUser();
    //        if (StringUtils.isNotNull(loginUser.getUser()) && !loginUser.getUser().isAdmin())
    //        {
    //            loginUser.setPermissions(permissionService.getMenuPermission(loginUser.getUser()));
    //            loginUser.setUser(userService.selectUserByUserName(loginUser.getUser().getUserName()));
    //            tokenService.setLoginUser(loginUser);
    //        }
    //        return success();
    //    }
    //    return error("修改角色'" + role.getRoleName() + "'失败，请联系管理员");
    //}
}
