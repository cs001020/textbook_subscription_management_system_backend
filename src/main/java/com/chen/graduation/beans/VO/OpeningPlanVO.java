package com.chen.graduation.beans.VO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.chen.graduation.beans.PO.Grade;
import com.chen.graduation.beans.PO.Major;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
import com.chen.graduation.beans.PO.TeachingGroup;
import com.chen.graduation.enums.OpenPlanStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 开课计划VO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("开课计划")
public class OpeningPlanVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("创建时间")
    private Date createTime;
    @ApiModelProperty("教学组")
    private TeachingGroupVO teachingGroup;
    @ApiModelProperty("二级学院")
    private SecondaryCollegeVO secondaryCollege;
    @ApiModelProperty("专业")
    private MajorVO major;
    @ApiModelProperty("班级")
    private Grade grade;
    @ApiModelProperty("教师")
    private TeacherVO teacher;
    @ApiModelProperty("状态")
    private OpenPlanStateEnums state;
    @ApiModelProperty("开课计划详情")
    private List<OpeningPlanDetailVO> openingPlanDetails;

    private static final long serialVersionUID = 1L;


}
