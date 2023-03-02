package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.MajorDTO;
import com.chen.graduation.beans.PO.Major;
import com.chen.graduation.beans.VO.MajorVO;
import org.mapstruct.Mapper;

import java.util.List;


/**
 * 专业转换器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Mapper(componentModel = "spring")
public interface MajorConverter {


    /**
     * po2vo
     *
     * @param major 主要
     * @return {@link MajorVO}
     */
    MajorVO po2vo(Major major);


    /**
     * po2vos
     *
     * @param majorList 主要列表
     * @return {@link List}<{@link MajorVO}>
     */
    List<MajorVO> po2vos(List<Major> majorList);

    /**
     * dto2po
     *
     * @param majorDTO 主要dto
     * @return {@link Major}
     */
    Major dto2po(MajorDTO majorDTO);
}
