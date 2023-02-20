package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.UserInfo;
import com.chen.graduation.service.UserInfoService;
import com.chen.graduation.mapper.UserInfoMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_faculty_info(教职工信息)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo>
    implements UserInfoService {

}




