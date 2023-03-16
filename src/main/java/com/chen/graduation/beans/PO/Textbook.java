package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.enums.TextbookStateEnums;
import lombok.Data;

/**
 * @TableName tb_textbook
 */
@TableName(value ="tb_textbook")
@Data
public class Textbook implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String bookName;

    private String isbn;

    private String barCode;

    private String author;

    private String binding;

    private String print;

    private String folio;

    private String price;

    private String words;

    private String publishingHouse;

    private Integer pageNumber;

    private String issueNumber;

    private String prePacketNumber;

    private Date publicationDate;

    private String imgUrl;

    private String description;

    private TextbookStateEnums state;

    private Integer stock;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    @TableField(exist = false)
    private Integer feedbackCount;

    private static final long serialVersionUID = 1L;
}
