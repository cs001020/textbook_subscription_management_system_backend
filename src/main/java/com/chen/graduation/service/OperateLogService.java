package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.OperateLogSearchDTO;
import com.chen.graduation.beans.PO.OperateLog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OperateLogVO;

import java.util.List;

/**
* @author CHEN
* @description 针对表【tb_operate_log(操作日志)】的数据库操作Service
* @createDate 2023-02-20 17:04:52
*/
public interface OperateLogService extends IService<OperateLog> {

    /**
     * 查询操作日志列表
     *
     * @param operateLogSearchDTO 操作日志搜索dto
     * @return {@link List}<{@link OperateLogVO}>
     */
    AjaxResult<List<OperateLogVO>> selectOperLogList(OperateLogSearchDTO operateLogSearchDTO);
}
