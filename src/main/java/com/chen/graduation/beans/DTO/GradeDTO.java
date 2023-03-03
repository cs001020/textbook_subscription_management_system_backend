package com.chen.graduation.beans.DTO;

import com.chen.graduation.beans.DTO.group.GradeInsterGroup;
import com.chen.graduation.beans.DTO.group.GradeUpdateGroup;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;


/**
 * 主要签证官
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Data
@ApiModel("班级DTO")
public class GradeDTO implements Serializable {
    @ApiModelProperty("专业id")
    @NotNull(message = "参数异常", groups = {GradeInsterGroup.class})
    private Long majorId;
    @ApiModelProperty("入学年份")
    @Range(max = 3000, min = 2000, message = "入学年份异常", groups = {GradeInsterGroup.class, GradeUpdateGroup.class})
    @NotNull(message = "参数异常", groups = {GradeInsterGroup.class})
    private Integer year;
    @ApiModelProperty("班级序号([0-9]{1,2}[a-zA-Z]?)(1-2位数字+0-1位字母)")
    @Pattern(regexp = "([0-9]{1,2}[a-zA-Z]?)", message = "班级格式错误", groups = {GradeInsterGroup.class, GradeUpdateGroup.class})
    @NotNull(message = "参数异常", groups = {GradeInsterGroup.class})
    private String number;

    private static final long serialVersionUID = 1L;
}
