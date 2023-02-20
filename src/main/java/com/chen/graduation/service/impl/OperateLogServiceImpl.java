package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.OperateLog;
import com.chen.graduation.service.OperateLogService;
import com.chen.graduation.mapper.OperateLogMapper;
import org.springframework.stereotype.Service;

/**
* @author CHEN
* @description 针对表【tb_operate_log(操作日志)】的数据库操作Service实现
* @createDate 2023-02-20 17:04:52
*/
@Service
public class OperateLogServiceImpl extends ServiceImpl<OperateLogMapper, OperateLog>
    implements OperateLogService{

}




