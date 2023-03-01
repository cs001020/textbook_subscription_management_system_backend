package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.enums.PermissionStateEnums;
import com.chen.graduation.enums.PermissionTypeEnums;
import lombok.Data;

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
    private PermissionTypeEnums type;

    /**
     * 状态 默认0(正常) 1(停用)
     */
    private PermissionStateEnums state;

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
