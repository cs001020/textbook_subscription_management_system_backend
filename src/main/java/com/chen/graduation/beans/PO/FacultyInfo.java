package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_faculty_info
 */
@TableName(value ="tb_faculty_info")
@Data
public class FacultyInfo implements Serializable {
    private Long id;

    private Long userFacultyId;

    private Integer sex;

    private Date birthday;

    private String address;

    private String email;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}