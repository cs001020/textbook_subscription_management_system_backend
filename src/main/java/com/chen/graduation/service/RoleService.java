package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.RolePermissionVo;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_role(角色)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface RoleService extends IService<Role> {

    /**
     * 角色分页查询
     *
     * @param pageParamDTO 页面参数dto
     * @param role
     * @return {@link AjaxResult}<{@link List}<{@link Role}>>
     */
    AjaxResult<List<Role>> pageQuery(PageParamDTO pageParamDTO, Role role);

    /**
     * 查询所有角色
     * 当前用户拥有的角色flag将为true
     *
     * @param userId 用户id
     * @return {@link List}<{@link Role}>
     */
    List<Role> selectRolesByUserId(Long userId);

    /**
     * 改变状态
     *
     * @param role 角色
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> changeStatus(Role role);

    /**
     * 选择角色通过id
     *
     * @param roleId 角色id
     * @return {@link AjaxResult}<{@link RolePermissionVo}>
     */
    AjaxResult<RolePermissionVo> selectRoleById(Long roleId);
}
