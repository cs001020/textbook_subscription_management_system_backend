package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.service.RoleService;
import com.chen.graduation.mapper.RoleMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_role(角色)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role>
    implements RoleService{

}




