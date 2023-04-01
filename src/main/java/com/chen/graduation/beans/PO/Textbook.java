package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.chen.graduation.enums.TextbookStateEnums;
import lombok.Data;
import org.hibernate.validator.constraints.ISBN;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @TableName tb_textbook
 */
@TableName(value ="tb_textbook")
@Data
public class Textbook implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    @NotBlank(message = "参数异常")
    private String bookName;
    @ISBN(message = "isbn码格式错误")
    @NotBlank(message = "参数异常")
    private String isbn;

    private String barCode;
    @NotBlank(message = "参数异常")
    private String author;

    private String binding;

    private String print;

    private String folio;
    @NotNull(message = "参数异常")
    private BigDecimal price;

    private String words;

    private String publishingHouse;

    private Integer pageNumber;

    private String issueNumber;

    private Integer prePacketNumber;

    private Date publicationDate;
    @NotBlank(message = "参数异常")
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
