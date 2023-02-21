package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.enums.OpenPlanDetailsTypeEnums;
import lombok.Data;

/**
 * 开课计划详情
 * @TableName tb_opening_plan_detail
 */
@TableName(value ="tb_opening_plan_detail")
@Data
public class OpeningPlanDetail implements Serializable {
    /**
     * 主键id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 开课计划id
     */
    private Long openingPlanId;

    /**
     * 课程名
     */
    private String courseName;

    /**
     * 学分
     */
    private Integer credit;

    /**
     * 总课时
     */
    private Integer teachingHours;

    /**
     * 教学周数
     */
    private Integer weeksTeach;

    /**
     * 类型 0(考试) 1(考察)
     */
    private OpenPlanDetailsTypeEnums type;

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
    private static final long serialVersionUID = 1L;
}
