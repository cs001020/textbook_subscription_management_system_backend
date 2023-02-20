package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_user_info
 */
@TableName(value ="tb_user_info")
@Data
public class UserInfo implements Serializable {

    @TableId(type = IdType.AUTO)
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
