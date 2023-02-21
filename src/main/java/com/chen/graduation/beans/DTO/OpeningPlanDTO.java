package com.chen.graduation.beans.DTO;

import com.chen.graduation.beans.VO.OpeningPlanDetailVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

/**
 * 开课计划DTO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("开课计划DTO")
public class OpeningPlanDTO {
    @ApiModelProperty("教师id")
    @NotNull(message = "参数异常")
    private Long teacherId;
    @ApiModelProperty("班级id")
    @NotNull(message = "参数异常")
    private Long gradeId;
    @ApiModelProperty("二级院校id")
    @NotNull(message = "参数异常")
    private Long secondaryCollegeId;
    @ApiModelProperty("教学组id")
    @NotNull(message = "参数异常")
    private Long teachingGroupId;
    @ApiModelProperty("开课计划详情")
    @NotEmpty(message = "参数异常")
    @Valid
    private List<OpeningPlanDetailDTO> openingPlanDetailDTOList;


}
