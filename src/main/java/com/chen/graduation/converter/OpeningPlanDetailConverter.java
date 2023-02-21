package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
import com.chen.graduation.beans.VO.OpeningPlanDetailVO;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 教材转换器
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Mapper()
public interface OpeningPlanDetailConverter {

    /**
     * po2vo
     *
     * @param openingPlanDetail 开放计划细节
     * @return {@link OpeningPlanDetailVO}
     */
    @Mapping(target = "type",expression = "java(openingPlanDetail.getType().getTypeName())")
    OpeningPlanDetailVO po2vo(OpeningPlanDetail openingPlanDetail);

    /**
     * pos2vos
     *
     * @param openingPlanDetails 开放计划细节
     * @return {@link List}<{@link OpeningPlanDetailVO}>
     */
    List<OpeningPlanDetailVO> pos2vos(List<OpeningPlanDetail> openingPlanDetails);
}
