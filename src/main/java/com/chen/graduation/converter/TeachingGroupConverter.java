package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.TeachingGroup;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import org.mapstruct.Mapper;

import java.util.List;


/**
 * 教学组转换器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Mapper(componentModel = "spring")
public interface TeachingGroupConverter {

    /**
     * po2vo
     *
     * @param teachingGroup 教学组织
     * @return {@link TeachingGroupVO}
     */
    TeachingGroupVO po2vo(TeachingGroup teachingGroup);

    /**
     * po2vos
     *
     * @param teachingGroupList 教学组列表
     * @return {@link List}<{@link TeachingGroupVO}>
     */
    List<TeachingGroupVO> po2vos(List<TeachingGroup> teachingGroupList);

}
