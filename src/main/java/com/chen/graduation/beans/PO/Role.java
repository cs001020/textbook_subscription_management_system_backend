package com.chen.graduation.beans.PO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.enums.RoleStateEnums;
import lombok.Data;

/**
 * @TableName tb_role
 */
@TableName(value ="tb_role")
@Data
public class Role implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private String description;

    private RoleStateEnums state;

    private Date createTime;

    private Date updateTime;
    @TableField(exist = false)
    private boolean flag;

    @JSONField(serialize = false)
    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
