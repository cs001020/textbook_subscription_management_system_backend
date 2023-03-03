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
 * 专业dto
 *
 * @author CHEN
 * @date 2023/03/03
 */
@Data
@ApiModel("专业DTO")
public class MajorDTO implements Serializable {
    @ApiModelProperty("二级学院id")
    private Long secondaryCollegeId;
    @ApiModelProperty("专业名")
    private String name;

    private static final long serialVersionUID = 1L;
}
