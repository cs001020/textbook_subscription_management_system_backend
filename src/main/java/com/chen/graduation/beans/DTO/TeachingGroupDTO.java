package com.chen.graduation.beans.DTO;

import com.alibaba.fastjson.serializer.ToStringSerializer;
import com.alibaba.fastjson2.annotation.JSONField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * 教学组dto
 *
 * @author CHEN
 * @date 2023/03/02
 */
@Data
@ApiModel("教学组DTO")
public class TeachingGroupDTO {

    @ApiModelProperty("组名")
    @NotBlank(message = "组名不能为空")
    private String name;

}
