package com.chen.graduation.beans.PO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.chen.graduation.enums.RoleStateEnums;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * @TableName tb_role
 */
@TableName(value ="tb_role")
@Data
public class Role implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    @NotBlank(message = "权限字符不能为空")
    @Size(min = 0, max = 100, message = "权限字符长度不能超过100个字符")
    private String name;
    @NotBlank(message = "角色名称不能为空")
    @Size(min = 0, max = 30, message = "角色名称长度不能超过30个字符")
    private String description;
    @NotNull(message = "状态不能为空")
    private RoleStateEnums state;
    @NotNull(message = "显示顺序不能为空")
    private Integer sortValue;
    @JsonIgnore
    private Date createTime;
    @JsonIgnore
    private Date updateTime;

    @JSONField(serialize = false)
    @JsonIgnore
    private Long isDeleted;
    @TableField(exist = false)
    @NotNull(message = "参数异常")
    private Long[] permissionIds;
    @TableField(exist = false)
    private Boolean flag;

    private static final long serialVersionUID = 1L;
}
