package com.chen.graduation.beans.VO;

import com.alibaba.fastjson.serializer.ToStringSerializer;
import com.alibaba.fastjson2.annotation.JSONField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 教学团队签证官
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Data
@ApiModel("教学组VO")
public class TeachingGroupVO {
    @ApiModelProperty("id")
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;
    @ApiModelProperty("组名")
    private String name;
}
