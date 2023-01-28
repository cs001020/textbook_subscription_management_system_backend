package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.model.DO.UserStudent;
import com.chen.graduation.service.UserStudentService;
import com.chen.graduation.mapper.UserStudentMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_user_student(学生用户)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class UserStudentServiceImpl extends ServiceImpl<UserStudentMapper, UserStudent>
    implements UserStudentService{

}




