package com.chen.graduation.beans.DTO;

import com.chen.graduation.beans.DTO.group.SupplierDtoAddGroup;
import com.chen.graduation.beans.DTO.group.SupplierDtoUpdateGroup;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;


/**
 * 供应商VO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("供应商DTO")
public class SupplierDTO implements Serializable {
    @ApiModelProperty("供应商名")
    @NotBlank(message = "参数异常", groups = SupplierDtoAddGroup.class)
    private String name;
    @ApiModelProperty("描述")
    @NotBlank(message = "参数异常", groups = SupplierDtoAddGroup.class)
    private String description;
    @ApiModelProperty("联系电话")
    @NotBlank(message = "参数异常", groups = SupplierDtoAddGroup.class)
    private String contactNumber;
    @ApiModelProperty("邮箱")
    @NotBlank(message = "参数异常", groups = SupplierDtoAddGroup.class)
    @Email(message = "邮箱格式错误", groups = {SupplierDtoAddGroup.class, SupplierDtoUpdateGroup.class})
    private String email;
    @ApiModelProperty("地址")
    @NotBlank(message = "参数异常", groups = SupplierDtoAddGroup.class)
    private String address;

    private static final long serialVersionUID = 1L;
}
