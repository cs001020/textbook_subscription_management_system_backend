package com.chen.graduation.service;

import com.chen.graduation.beans.PO.Permission;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_permission(权限)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface PermissionService extends IService<Permission> {

    /**
     * 通过用户id获取权限
     *
     * @param userId 用户id
     * @return {@link List}<{@link Permission}>
     */
    List<Permission> getPermissionByUserId(Long userId);

    /**
     * 通过角色id获取权限
     * 包含所有权限
     * 该角色拥护的权限 flag为true
     *
     * @param roleId 角色id
     * @return {@link List}<{@link Permission}>
     */
    List<Permission> selectPermissionTreeByRoleId(Long roleId);

    /**
     * 查询所有权限 按照树形结构显示
     *
     * @param permission 许可
     * @return {@link AjaxResult}<{@link List}<{@link Permission}>>
     */
    AjaxResult<List<Permission>> treeList(Permission permission);

    /**
     * 插入新增权限
     *
     * @param permission 权限
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> insertPermission(Permission permission);

    /**
     * 根据id号获取详细信息
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Permission}>
     */
    AjaxResult<Permission> getPermissionByPermissionId(Long id);

    /**
     * 更新权限
     *
     * @param permission 许可
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updatePermission(Permission permission);

    /**
     * 根据id删除权限
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deletePermissionById(Long id);

    /**
     * 修改权限状态
     *
     * @param permission 权限
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> changeState(Permission permission);
}
