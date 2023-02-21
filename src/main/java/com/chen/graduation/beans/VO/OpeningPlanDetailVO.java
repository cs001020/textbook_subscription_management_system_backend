package com.chen.graduation.beans.VO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.chen.graduation.enums.OpenPlanDetailsTypeEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * 开课计划详情VO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("开课计划详情")
public class OpeningPlanDetailVO {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("课程名")
    private String courseName;
    @ApiModelProperty("学分")
    private Integer credit;
    @ApiModelProperty("总课时")
    private Integer teachingHours;
    @ApiModelProperty("教学周数")
    private Integer weeksTeach;
    @ApiModelProperty("类型")
    private String type;

}
