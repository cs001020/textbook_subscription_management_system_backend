package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.RoleService;
import com.chen.graduation.mapper.RoleMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_role(角色)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role>
    implements RoleService{

    @Override
    public AjaxResult<List<Role>> pageQuery(PageParamDTO pageParamDTO) {
        //数据库查询
        Page<Role> page = lambdaQuery().page(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()));
        //封装对象
        AjaxResult<List<Role>> success = AjaxResult.success(page.getRecords());
        success.setTotal(page.getTotal());
        //打印日志
        log.info("RoleServiceImpl.pageQuery业务结束，结果:{}",success);
        return success;
    }

    @Override
    public List<Role> selectRolesByUserId(Long userId) {
        List<Role> allRoleList = list();
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
}




