package com.chen.graduation.beans.DTO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.chen.graduation.enums.TextbookStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.ISBN;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;


/**
 * 教科书dto
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Data
@ApiModel("教材DTO")
public class TextbookDTO implements Serializable {
    @ApiModelProperty("教材名")
    @NotBlank(message = "参数异常")
    private String bookName;
    @ApiModelProperty("ISBN码")
    @ISBN(message = "isbn码格式错误")
    @NotBlank(message = "参数异常")
    private String isbn;
    @ApiModelProperty("作者")
    @NotBlank(message = "参数异常")
    private String author;
    @ApiModelProperty("装订")
    private String binding;
    @ApiModelProperty("印次")
    private String print;
    @ApiModelProperty("开本")
    private String folio;
    @ApiModelProperty("价格")
    @NotNull(message = "参数异常")
    private BigDecimal price;
    @ApiModelProperty("字数")
    private String words;
    @ApiModelProperty("出版社")
    private String publishingHouse;
    @ApiModelProperty("页数")
    private String pageNumber;
    @ApiModelProperty("库存")
    private Integer stock;
    @ApiModelProperty("出版日期")
    private Date publicationDate;
    @ApiModelProperty("封面图片地址")
    @NotBlank(message = "参数异常")
    private String imgUrl;
    @ApiModelProperty("描述")
    @NotBlank(message = "参数异常")
    private String description;


    private static final long serialVersionUID = 1L;
}
