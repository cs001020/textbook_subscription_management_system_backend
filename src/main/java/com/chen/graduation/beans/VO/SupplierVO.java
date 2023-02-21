package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 供应商VO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("供应商")
public class SupplierVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("供应商名")
    private String name;
    @ApiModelProperty("描述")
    private String description;
    @ApiModelProperty("联系电话")
    private String contactNumber;
    @ApiModelProperty("邮箱")
    private String email;
    @ApiModelProperty("地址")
    private String address;
    @ApiModelProperty("创建时间")
    private Date createTime;


    private static final long serialVersionUID = 1L;
}
