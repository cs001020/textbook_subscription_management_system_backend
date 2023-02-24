package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.chen.graduation.enums.OpenPlanStateEnums;
import lombok.Data;

/**
 * 开课计划
 * @TableName tb_opening_plan
 */
@TableName(value ="tb_opening_plan")
@Data
public class OpeningPlan implements Serializable {
    /**
     * 主键id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 二级院校id
     */
    private Long secondaryCollegeId;

    /**
     * 教师id
     */
    private Long teacherId;

    /**
     * 班级id
     */
    private Long gradeId;

    /**
     * 教学组id
     */
    private Long teachingGroupId;

    /**
     * 状态 0(等待教师选定教材) 1(已经选定教材，等待审批) 2(审批完成，close)
     */
    private OpenPlanStateEnums state;

    /**
     * 创建时间，默认为当前时间，不需要手动设置
     */
    private Date createTime;

    /**
     * 更新时间，默认为当前时间，可以使用触发器来进行自动更新
     */
    private Date updateTime;

    /**
     * 逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id
     */
    private Long isDeleted;
    @TableField(exist = false)
    private String secondaryCollege;
    @TableField(exist = false)
    private String teacher;
    @TableField(exist = false)
    private String teachingGroup;
    @TableField(exist = false)
    private String grade;
    @TableField(exist = false)
    private List<OpeningPlanDetail> openingPlanDetails;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
