package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.model.DO.StudentInfo;
import com.chen.graduation.service.StudentInfoService;
import com.chen.graduation.mapper.StudentInfoMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_student_info(学生信息)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class StudentInfoServiceImpl extends ServiceImpl<StudentInfoMapper, StudentInfo>
    implements StudentInfoService{

}




