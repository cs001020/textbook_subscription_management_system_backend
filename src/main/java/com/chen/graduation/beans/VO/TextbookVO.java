package com.chen.graduation.beans.VO;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 教材VO
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Data
@ApiModel("教材")
public class TextbookVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("教材名")
    private String bookName;
    @ApiModelProperty("ISBN码")
    private String isbn;
    @ApiModelProperty("作者")
    private String author;
    @ApiModelProperty("装订")
    private String binding;
    @ApiModelProperty("印次")
    private String print;
    @ApiModelProperty("开本")
    private String folio;
    @ApiModelProperty("价格")
    private BigDecimal price;
    @ApiModelProperty("字数")
    private String words;
    @ApiModelProperty("出版社")
    private String publishingHouse;
    @ApiModelProperty("页数")
    private Integer pageNumber;
    @ApiModelProperty("出版日期")
    private Date publicationDate;
    @ApiModelProperty("封面图片地址(前缀https://kodo.warframe.top/book/)")
    private String imgUrl;
    @ApiModelProperty("描述")
    private String description;
    @ApiModelProperty("状态")
    private String state;
    @ApiModelProperty("库存")
    private Integer stock;
    @ApiModelProperty("反馈数量")
    private Integer feedbackCount;

    private static final long serialVersionUID = 1L;
}
