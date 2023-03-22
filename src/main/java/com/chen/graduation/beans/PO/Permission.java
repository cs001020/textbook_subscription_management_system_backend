package com.chen.graduation.beans.PO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.chen.graduation.enums.PermissionStateEnums;
import com.chen.graduation.enums.PermissionTypeEnums;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * @TableName tb_permission
 */
@TableName(value = "tb_permission")
@Data
public class Permission implements Serializable {
    /**
     * 主键id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 上级id
     */
    @NotNull(message = "上级权限不能为空")
    private Long parentId;

    /**
     * 路由地址
     */
    private String path;

    /**
     * 请求路径
     */
    private String requestUrl;

    /**
     * 名称
     */
    @NotBlank(message = "权限名称不能为空")
    @Size(min = 0, max = 50, message = "权限名称长度不能超过50个字符")
    private String name;

    /**
     * 权限标识
     */
    private String perms;

    /**
     * 图标
     */
    private String icon;

    /**
     * 组件路径
     */
    private String component;

    /**
     * 类型 0目录 1路由 2按钮or请求
     */
    @NotNull(message = "权限类型不能为空")
    private PermissionTypeEnums type;

    /**
     * 状态 默认0(正常) 1(停用)
     */
    @NotNull(message = "权限状态不能为空")
    private PermissionStateEnums state;

    /**
     * 创建时间，默认为当前时间，不需要手动设置
     */
    @JsonIgnore
    private Date createTime;

    /**
     * 更新时间，默认为当前时间，可以使用触发器来进行自动更新
     */
    @JsonIgnore
    private Date updateTime;

    /**
     * 逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id
     */
    @JSONField(serialize = false)
    @JsonIgnore
    private Long isDeleted;
    @NotNull(message = "显示顺序不能为空")
    private Integer sortValue;

    @TableField(exist = false)
    List<Permission> children;
    @TableField(exist = false)
    private Boolean flag;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
