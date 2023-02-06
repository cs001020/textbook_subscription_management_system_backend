package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_role_permission
 */
@TableName(value ="tb_role_permission")
@Data
public class RolePermission implements Serializable {
    private Long id;

    private Long roleId;

    private Long permissionId;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}