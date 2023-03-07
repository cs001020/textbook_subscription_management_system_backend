package com.chen.graduation.beans.DTO;

import com.baomidou.mybatisplus.annotation.TableField;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.enums.OperateLogStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Range;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.Serializable;


/**
 * 操作日志搜索dto
 *
 * @author CHEN
 * @date 2023/03/06
 */
@Data
@ApiModel("操作日志搜索dto")
public class OperateLogSearchDTO implements Serializable {
    @ApiModelProperty("模块标题")
    private String title;
    @ApiModelProperty("业务类型")
    private BusinessTypeEnums businessType;
    @ApiModelProperty("操作人员")
    private String operatorName;
    @ApiModelProperty("操作状态")
    private OperateLogStateEnums status;
    @ApiModelProperty("开始时间,请输入正确格式(yyyy-MM-dd)")
    private String beginTime;
    @ApiModelProperty("结束时间,请输入正确格式(yyyy-MM-dd)")
    private String endTime;
    @ApiModelProperty(value = "页号", allowableValues = "range[1,infinity]", example = "1")
    @Range(min = 1, message = "分页参数异常")
    @NotNull(message = "分页参数异常")
    private Integer page;
    @ApiModelProperty(value = "页码", allowableValues = "range[1,50]", example = "10")
    @Range(min = 1, max = 50, message = "分页参数异常")
    @NotNull(message = "分页参数异常")
    private Integer size;



    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

}
