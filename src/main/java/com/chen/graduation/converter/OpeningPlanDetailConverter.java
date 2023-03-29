package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.OpeningPlanDetailDTO;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
import com.chen.graduation.beans.VO.OpeningPlanDetailVO;
import org.mapstruct.Mapper;

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
     * dto2po
     *
     * @param openingPlanDetailDTO 开放计划细节dto
     * @return {@link OpeningPlan}
     */
    OpeningPlan dto2po(OpeningPlanDetailDTO openingPlanDetailDTO);

    /**
     * dto2po
     *
     * @param openingPlanDetailDTO 开放计划细节dto
     * @return {@link OpeningPlan}
     */
    List<OpeningPlanDetail>  dto2pos(List<OpeningPlanDetailDTO> openingPlanDetailDTO);
}
