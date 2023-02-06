package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_supplier
 */
@TableName(value ="tb_supplier")
@Data
public class Supplier implements Serializable {
    private Long id;

    private String name;

    private String description;

    private String contactNumber;

    private String email;

    private String address;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}