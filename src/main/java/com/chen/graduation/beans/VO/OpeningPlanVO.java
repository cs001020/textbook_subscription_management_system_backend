package com.chen.graduation.beans.VO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
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
    @ApiModelProperty("教学组")
    private String teachingGroup;
    @ApiModelProperty("二级学院")
    private String secondaryCollege;
    @ApiModelProperty("教师")
    private TeacherVO teacher;
    @ApiModelProperty("班级")
    private String grade;
    @ApiModelProperty("状态")
    private String state;
    @ApiModelProperty("创建时间")
    private Date createTime;
    @ApiModelProperty("可提交申请")
    private Boolean canAddApproval;
    @ApiModelProperty("开课计划详情")
    private List<OpeningPlanDetailVO> openingPlanDetails;

    private static final long serialVersionUID = 1L;


}
