package com.chen.graduation.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.beans.DTO.OperateLogSearchDTO;
import com.chen.graduation.beans.PO.OperateLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
* @author CHEN
* @description 针对表【tb_operate_log(操作日志)】的数据库操作Mapper
* @createDate 2023-02-20 17:04:52
* @Entity com.chen.graduation.mapper.PO.OperateLog
*/
public interface OperateLogMapper extends BaseMapper<OperateLog> {


    /**
     * 查询操作日志列表
     *
     * @param objectPage          对象页面
     * @param operateLogSearchDTO 操作日志搜索dto
     * @return {@link Page}<{@link OperateLog}>
     */
    Page<OperateLog> selectOperLogList(Page<Object> objectPage, @Param("search") OperateLogSearchDTO operateLogSearchDTO);
}




