package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.SecondaryCollegeDTO;
import com.chen.graduation.beans.PO.SecondaryCollege;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;
import org.mapstruct.Mapper;

import java.util.List;


/**
 * 二级学院转换器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Mapper(componentModel = "spring")
public interface SecondaryCollegeConverter {


    /**
     * po2vo
     *
     * @param secondaryCollege 二级学院
     * @return {@link SecondaryCollegeVO}
     */
    SecondaryCollegeVO po2vo(SecondaryCollege secondaryCollege);


    /**
     * po2vos
     *
     * @param secondaryCollegeList 二级学院名单
     * @return {@link List}<{@link SecondaryCollegeVO}>
     */
    List<SecondaryCollegeVO> po2vos(List<SecondaryCollege> secondaryCollegeList);

    /**
     * dto2po
     *
     * @param secondaryCollegeDTO 二级学院dto
     * @return {@link SecondaryCollege}
     */
    SecondaryCollege dto2po(SecondaryCollegeDTO secondaryCollegeDTO);
}
