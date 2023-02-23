package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.Grade;
import com.chen.graduation.beans.VO.GradeVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;


/**
 * 年级转换器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Mapper(componentModel = "spring")
public interface GradeConverter {


    /**
     * po2vo
     *
     * @param grade 年级
     * @return {@link GradeVO}
     */
    @Mapping(target = "name",expression = "java(getName(grade))")
    GradeVO po2vo(Grade grade);


    /**
     * po2vos
     *
     * @param majorList 主要列表
     * @return {@link List}<{@link GradeVO}>
     */
    List<GradeVO> po2vos(List<Grade> majorList);

    default String getName(Grade grade){
        return grade.getYear()+"级"+grade.getNumber()+"班";
    }

}
