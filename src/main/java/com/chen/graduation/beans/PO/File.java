package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 文件
 *
 * @author CHEN
 * @date 2023/03/26
 */
@TableName(value = "tb_file")
@Data
public class File {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String fileUrl;
    private String fileHash;
    private Date createTime;
    private Long isDeleted;
}
