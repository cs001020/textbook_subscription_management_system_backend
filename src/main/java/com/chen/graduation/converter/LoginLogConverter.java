package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.LoginLog;
import com.chen.graduation.beans.PO.OperateLog;
import com.chen.graduation.beans.VO.LoginLogVO;
import com.chen.graduation.beans.VO.OperateLogVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import java.util.List;


/**
 * 登录日志转换器
 *
 * @author CHEN
 * @date 2023/03/06
 */
@Mapper(componentModel = "spring")
public interface LoginLogConverter {


    /**
     * po2vo
     *
     * @param loginLog 登录日志
     * @return {@link LoginLogVO}
     */
    @Mappings({
            @Mapping(target = "state",expression = "java(loginLog.getState().getStateName())")
    })
    LoginLogVO po2vo(LoginLog loginLog);


    /**
     * po2vos
     *
     * @param loginLogList 登录日志列表
     * @return {@link List}<{@link LoginLogVO}>
     */
    List<LoginLogVO> po2vos(List<LoginLog> loginLogList);

}
