package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.LoginLogSearchDTO;
import com.chen.graduation.beans.PO.LoginLog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.LoginLogVO;

import java.util.List;

/**
* @author CHEN
* @description 针对表【tb_login_log(登录日志)】的数据库操作Service
* @createDate 2023-02-20 17:04:52
*/
public interface LoginLogService extends IService<LoginLog> {

    /**
     * 查询登录日志列表
     *
     * @param loginLogSearchDTO 登录日志搜索dto
     * @return {@link AjaxResult}<{@link List}<{@link LoginLogVO}>>
     */
    AjaxResult<List<LoginLogVO>> selectLoginLogList(LoginLogSearchDTO loginLogSearchDTO);
}
