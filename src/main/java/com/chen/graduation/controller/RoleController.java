package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.RolePermissionVo;
import com.chen.graduation.beans.VO.UserVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.RoleService;
import com.chen.graduation.service.UserService;
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
    @Resource
    private UserService userService;

    @Auth({"system:role:list"})
    @ApiOperation("角色列表")
    @GetMapping("list")
    public AjaxResult<List<Role>> getList(@Validated PageParamDTO pageParamDTO, Role role) {
        return roleService.pageQuery(pageParamDTO, role);
    }

    @Auth({"system:role:edit"})
    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改角色状态")
    @PutMapping("/changeState")
    public AjaxResult<Object> changeStatus(@RequestBody Role role) {
        return roleService.changeStatus(role);
    }

    @Auth({"system:role:edit"})
    @ApiOperation("根据角色id获取详细信息")
    @GetMapping(value = "/{roleId}")
    public AjaxResult<RolePermissionVo> getInfo(@PathVariable Long roleId) {
        return roleService.selectRoleById(roleId);
    }

    @Auth({"system:role:edit"})
    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改角色")
    @PutMapping("/update")
    public AjaxResult<Object> updateRole(@Validated @RequestBody Role role) {
        return roleService.updateRole(role);
    }

    @Auth({"system:role:add"})
    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.INSERT)
    @ApiOperation("新增角色")
    @PostMapping("/add")
    public AjaxResult<Object> add(@Validated @RequestBody Role role) {
        return roleService.saveRole(role);
    }

    @Auth({"system:role:remove"})
    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.DELETE)
    @ApiOperation("删除角色")
    @DeleteMapping("/del/{roleId}")
    public AjaxResult<Object> remove(@PathVariable Long roleId) {
        return roleService.deleteRoleById(roleId);
    }

    @Auth({"system:role:auth"})
    @ApiOperation("查询已分配用户角色列表")
    @GetMapping("/authUser/allocatedList/{roleId}")
    public AjaxResult<List<UserVO>> allocatedList(@Validated PageParamDTO pageParamDTO, User user, @PathVariable Long roleId) {
        return userService.selectAllocatedList(pageParamDTO, user, roleId);
    }

    @Auth({"system:role:auth"})
    @ApiOperation("查询未分配用户角色列表")
    @GetMapping("/authUser/unallocatedList/{roleId}")
    public AjaxResult<List<UserVO>> unallocatedList(@Validated PageParamDTO pageParamDTO, User user, @PathVariable Long roleId) {
        return userService.selectUnallocatedList(pageParamDTO, user, roleId);
    }

    @Auth({"system:role:auth"})
    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.GRANT)
    @ApiOperation("批量选择用户授权")
    @PutMapping("/authUser/selectAll")
    public AjaxResult<Object> selectAuthUserAll(Long roleId, Long[] userIds) {
        return roleService.insertAuthUsers(roleId, userIds);
    }

    @Auth({"system:role:auth"})
    @Log(title = "角色管理", businessTypeEnums = BusinessTypeEnums.GRANT)
    @ApiOperation("批量取消授权用户")
    @DeleteMapping("/authUser/cancelAll")
    public AjaxResult<Object> cancelAuthUserAll(Long roleId, Long[] userIds) {
        return roleService.deleteAuthUsers(roleId, userIds);
    }
}
