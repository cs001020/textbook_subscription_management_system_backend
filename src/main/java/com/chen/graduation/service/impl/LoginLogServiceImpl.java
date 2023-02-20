package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.LoginLog;
import com.chen.graduation.service.LoginLogService;
import com.chen.graduation.mapper.LoginLogMapper;
import org.springframework.stereotype.Service;

/**
* @author CHEN
* @description 针对表【tb_login_log(登录日志)】的数据库操作Service实现
* @createDate 2023-02-20 17:04:52
*/
@Service
public class LoginLogServiceImpl extends ServiceImpl<LoginLogMapper, LoginLog>
    implements LoginLogService{

}




