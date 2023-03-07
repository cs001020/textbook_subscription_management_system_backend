package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.OperateLogSearchDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.OperateLog;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OperateLogVO;
import com.chen.graduation.converter.OperateLogConverter;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.OperateLogService;
import com.chen.graduation.mapper.OperateLogMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;

/**
* @author CHEN
* @description 针对表【tb_operate_log(操作日志)】的数据库操作Service实现
* @createDate 2023-02-20 17:04:52
*/
@Service
public class OperateLogServiceImpl extends ServiceImpl<OperateLogMapper, OperateLog>
    implements OperateLogService{

    @Resource
    private OperateLogConverter operateLogConverter;

    @Override
    public AjaxResult<List<OperateLogVO>> selectOperLogList(OperateLogSearchDTO operateLogSearchDTO) {
        //查询数据库
        Page<OperateLog> operateLogPage = baseMapper.selectOperLogList(new Page<>(operateLogSearchDTO.getPage(), operateLogSearchDTO.getSize()), operateLogSearchDTO);
        //转换对象
        List<OperateLogVO> operateLogVOList = operateLogConverter.po2vos(operateLogPage.getRecords());
        //封装返回对象
        AjaxResult<List<OperateLogVO>> success = AjaxResult.success(operateLogVOList);
        success.setTotal(operateLogPage.getTotal());
        //响应
        return success;
    }
}




