package com.chen.graduation.beans.DTO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 教学组dto
 *
 * @author CHEN
 * @date 2023/03/02
 */
@Data
@ApiModel("二级学院DTO")
public class SecondaryCollegeDTO {

    @ApiModelProperty("二级学院名")
    @NotBlank(message = "二级学院名")
    private String name;

}
