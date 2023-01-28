package com.chen.graduation.model.DTO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 页面参数dto
 *
 * @author CHEN
 * @date 2023/01/28
 */
@Data
@ApiModel("分页参数")
public class PageParamDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "页号", allowableValues = "range[1,infinity]", example = "1")
    @Range(min = 1, message = "分页参数异常")
    @NotNull(message = "分页参数异常")
    private Integer page;
    @ApiModelProperty(value = "页码", allowableValues = "range[1,50]", example = "10")
    @Range(min = 1, max = 50, message = "分页参数异常")
    @NotNull(message = "分页参数异常")
    private Integer size;
}
