package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.OperateLog;
import com.chen.graduation.beans.VO.OperateLogVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import java.util.List;


/**
 * 操作日志转换器
 *
 * @author CHEN
 * @date 2023/03/06
 */
@Mapper(componentModel = "spring")
public interface OperateLogConverter {


    /**
     * po2vo
     *
     * @param grade 年级
     * @return {@link OperateLogVO}
     */
    @Mappings({
            @Mapping(target = "businessType",expression = "java(grade.getBusinessType().getStateName())"),
            @Mapping(target = "status",expression = "java(grade.getStatus().getStateName())")
    })
    OperateLogVO po2vo(OperateLog grade);

    /**
     * po2vos
     *
     * @param majorList 主要列表
     * @return {@link List}<{@link OperateLogVO}>
     */
    List<OperateLogVO> po2vos(List<OperateLog> majorList);

}
