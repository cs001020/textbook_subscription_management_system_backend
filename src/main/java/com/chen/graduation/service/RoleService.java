package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;

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
     * @return {@link AjaxResult}<{@link List}<{@link Role}>>
     */
    AjaxResult<List<Role>> pageQuery(PageParamDTO pageParamDTO);

    /**
     * 查询所有角色
     * 当前用户拥有的角色flag将为true
     *
     * @param userId 用户id
     * @return {@link List}<{@link Role}>
     */
    List<Role> selectRolesByUserId(Long userId);
}
