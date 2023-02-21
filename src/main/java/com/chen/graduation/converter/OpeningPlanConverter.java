package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import com.chen.graduation.beans.VO.TextbookVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import java.util.List;

/**
 * 教材转换器
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Mapper(componentModel = "spring")
public interface OpeningPlanConverter {

    /**
     * po2vo
     *
     * @param openingPlan 开放计划
     * @return {@link OpeningPlanVO}
     */
    @Mappings(value = {
            @Mapping(target = "state", expression = "java(openingPlan.getState().getStateName())"),
            @Mapping(target = "openingPlanDetails", expression = "java(org.mapstruct.factory.Mappers.getMapper(OpeningPlanDetailConverter.class).pos2vos(openingPlan.getOpeningPlanDetails()))")
    })
    OpeningPlanVO po2vo(OpeningPlan openingPlan);

    /**
     * dto2po
     *
     * @param openingPlanDTO 开放计划dto
     * @return {@link OpeningPlan}
     */
    @Mappings(value = {
            @Mapping(target = "openingPlanDetails", expression = "java(org.mapstruct.factory.Mappers.getMapper(OpeningPlanDetailConverter.class).dto2pos(openingPlanDTO.getOpeningPlanDetailDTOList()))")
    })
    OpeningPlan dto2po(OpeningPlanDTO openingPlanDTO);

    /**
     * pos2vos
     *
     * @param openingPlanList 开放计划列表
     * @return {@link List}<{@link OpeningPlanVO}>
     */
    List<OpeningPlanVO> pos2vos(List<OpeningPlan> openingPlanList);
}
