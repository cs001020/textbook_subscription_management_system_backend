package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_faculty_role
 */
@TableName(value ="tb_faculty_role")
@Data
public class FacultyRole implements Serializable {
    private Long id;

    private Long facultyId;

    private Long roleId;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}