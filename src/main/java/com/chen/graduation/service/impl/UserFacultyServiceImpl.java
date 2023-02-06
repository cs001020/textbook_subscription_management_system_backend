package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.UserFaculty;
import com.chen.graduation.service.UserFacultyService;
import com.chen.graduation.mapper.UserFacultyMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_user_faculty(教职工用户)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class UserFacultyServiceImpl extends ServiceImpl<UserFacultyMapper, UserFaculty>
    implements UserFacultyService{

}




