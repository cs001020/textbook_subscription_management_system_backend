package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_permission
 */
@TableName(value ="tb_permission")
@Data
public class Permission implements Serializable {
    private Long id;

    private String url;

    private String name;

    private String description;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}