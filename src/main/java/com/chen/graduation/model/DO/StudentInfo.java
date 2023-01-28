package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_student_info
 */
@TableName(value ="tb_student_info")
@Data
public class StudentInfo implements Serializable {
    private Long id;

    private Long userStudentId;

    private Integer sex;

    private Date birthday;

    private String address;

    private String email;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}