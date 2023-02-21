package com.chen.graduation.beans.DTO;

import com.chen.graduation.enums.OpenPlanDetailsTypeEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotNull;

/**
 * 开课计划详情DTO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("开课计划详情DTO")
public class OpeningPlanDetailDTO {
    @ApiModelProperty("课程名")
    @NotNull(message = "参数异常")
    private String courseName;
    @ApiModelProperty("学分")
    @Range(max = 10,message = "学分异常")
    @NotNull(message = "参数异常")
    private Integer credit;
    @ApiModelProperty("总课时")
    @Range(max = 10,message = "总课时异常")
    @NotNull(message = "参数异常")
    private Integer teachingHours;
    @ApiModelProperty("教学周数")
    @Range(max = 20,message = "周数异常")
    @NotNull(message = "参数异常")
    private Integer weeksTeach;
    @ApiModelProperty("类型 0(考试) 1(考察)")
    @NotNull(message = "参数异常")
    private OpenPlanDetailsTypeEnums type;

}
