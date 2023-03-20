package com.chen.graduation.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.RolePermissionVo;
import com.chen.graduation.enums.RoleStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.service.RoleService;
import com.chen.graduation.mapper.RoleMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
* @author 10065
* @description 针对表【tb_role(角色)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role>
    implements RoleService{
    @Resource
    private PermissionService permissionService;

    @Override
    public AjaxResult<List<Role>>   pageQuery(PageParamDTO pageParamDTO, Role role) {
        //参数获取
        String name = role.getName();
        String description = role.getDescription();
        RoleStateEnums state = role.getState();
        //数据库查询
        Page<Role> page = lambdaQuery()
                .like(StrUtil.isNotBlank(name),Role::getName,name)
                .like(StrUtil.isNotBlank(description),Role::getDescription,description)
                .eq(!Objects.isNull(state),Role::getState,state)
                .orderByAsc(Role::getSortValue)
                .page(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()));
        //封装对象
        AjaxResult<List<Role>> success = AjaxResult.success(page.getRecords());
        success.setTotal(page.getTotal());
        //打印日志
        log.info("RoleServiceImpl.pageQuery业务结束，结果:{}",success);
        return success;
    }

    @Override
    public List<Role> selectRolesByUserId(Long userId) {
        List<Role> allRoleList = lambdaQuery().orderByAsc(Role::getSortValue).list();
        List<Role> userRoleList=baseMapper.getRoleByUserId(userId);
        for (Role role : allRoleList) {
            for (Role userRole : userRoleList) {
                if (role.getId().longValue() == userRole.getId().longValue())
                {
                    role.setFlag(true);
                    break;
                }
            }
        }
        return allRoleList;
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> changeStatus(Role role) {
        //参数获取
        Long id = role.getId();
        RoleStateEnums state = role.getState();
        //校验
        if (Objects.isNull(id)||Objects.isNull(state)){
            throw new ServiceException("参数异常");
        }
        //更新
        boolean update = lambdaUpdate().eq(Role::getId, id).set(Role::getState, state).update();
        //日志
        log.info("RoleServiceImpl.changeStatus业务结束，结果:{}",update);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    public AjaxResult<RolePermissionVo> selectRoleById(Long roleId) {
        //获取角色
        Role role = getById(roleId);
        //获取权限列表
        List<Permission> permissionList=permissionService.selectPermissionTreeByRoleId(roleId);
        //封装结果
        RolePermissionVo rolePermissionVo = new RolePermissionVo();
        rolePermissionVo.setRole(role);
        rolePermissionVo.setPermissionList(permissionList);
        //日志
        log.info("RoleServiceImpl.selectRoleById业务结束，结果:{}",rolePermissionVo);
        //返回
        return AjaxResult.success(rolePermissionVo);
    }
}




