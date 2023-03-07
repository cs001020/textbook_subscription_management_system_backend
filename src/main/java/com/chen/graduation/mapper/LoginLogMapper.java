package com.chen.graduation.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.beans.DTO.LoginLogSearchDTO;
import com.chen.graduation.beans.PO.LoginLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
* @author CHEN
* @description 针对表【tb_login_log(登录日志)】的数据库操作Mapper
* @createDate 2023-02-20 17:04:52
* @Entity com.chen.graduation.mapper.PO.LoginLog
*/
public interface LoginLogMapper extends BaseMapper<LoginLog> {

    /**
     * 查询登录日志列表
     *
     * @param objectPage        对象页面
     * @param loginLogSearchDTO 登录日志搜索dto
     * @return {@link Page}<{@link LoginLog}>
     */
    Page<LoginLog> selectLoginLogList(Page<Object> objectPage,@Param("search") LoginLogSearchDTO loginLogSearchDTO);
}




