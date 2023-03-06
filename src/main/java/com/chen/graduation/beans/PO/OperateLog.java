package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.enums.OpenPlanStateEnums;
import com.chen.graduation.enums.OperateLogStateEnums;
import lombok.Data;

/**
 * 操作日志
 * @TableName tb_operate_log
 */
@TableName(value ="tb_operate_log")
@Data
public class OperateLog implements Serializable {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 模块标题
     */
    private String title;

    /**
     * 业务类型（0其它 1新增 2修改 3删除）
     */
    private BusinessTypeEnums businessType;

    /**
     * 方法名称
     */
    private String method;

    /**
     * 请求方式
     */
    private String requestMethod;

    /**
     * 操作人员
     */
    private String operatorName;

    /**
     * 请求URL
     */
    private String operateUrl;

    /**
     * 主机地址
     */
    private String operateIp;

    /**
     * 请求参数
     */
    private String operateParam;

    /**
     * 返回参数
     */
    private String jsonResult;

    /**
     * 操作状态（0正常 1异常）
     */
    private OperateLogStateEnums status;

    /**
     * 错误消息
     */
    private String errorMsg;

    /**
     * 操作时间
     */
    private Date operateTime;

    /**
     * 创建时间，默认为当前时间，不需要手动设置
     */
    private Date createTime;

    /**
     * 更新时间，默认为当前时间，可以使用触发器来进行自动更新
     */
    private Date updateTime;

    /**
     * 逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id
     */
    private Long isDeleted;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        OperateLog other = (OperateLog) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getTitle() == null ? other.getTitle() == null : this.getTitle().equals(other.getTitle()))
            && (this.getBusinessType() == null ? other.getBusinessType() == null : this.getBusinessType().equals(other.getBusinessType()))
            && (this.getMethod() == null ? other.getMethod() == null : this.getMethod().equals(other.getMethod()))
            && (this.getRequestMethod() == null ? other.getRequestMethod() == null : this.getRequestMethod().equals(other.getRequestMethod()))
            && (this.getOperatorName() == null ? other.getOperatorName() == null : this.getOperatorName().equals(other.getOperatorName()))
            && (this.getOperateUrl() == null ? other.getOperateUrl() == null : this.getOperateUrl().equals(other.getOperateUrl()))
            && (this.getOperateIp() == null ? other.getOperateIp() == null : this.getOperateIp().equals(other.getOperateIp()))
            && (this.getOperateParam() == null ? other.getOperateParam() == null : this.getOperateParam().equals(other.getOperateParam()))
            && (this.getJsonResult() == null ? other.getJsonResult() == null : this.getJsonResult().equals(other.getJsonResult()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getErrorMsg() == null ? other.getErrorMsg() == null : this.getErrorMsg().equals(other.getErrorMsg()))
            && (this.getOperateTime() == null ? other.getOperateTime() == null : this.getOperateTime().equals(other.getOperateTime()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDeleted() == null ? other.getIsDeleted() == null : this.getIsDeleted().equals(other.getIsDeleted()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getTitle() == null) ? 0 : getTitle().hashCode());
        result = prime * result + ((getBusinessType() == null) ? 0 : getBusinessType().hashCode());
        result = prime * result + ((getMethod() == null) ? 0 : getMethod().hashCode());
        result = prime * result + ((getRequestMethod() == null) ? 0 : getRequestMethod().hashCode());
        result = prime * result + ((getOperatorName() == null) ? 0 : getOperatorName().hashCode());
        result = prime * result + ((getOperateUrl() == null) ? 0 : getOperateUrl().hashCode());
        result = prime * result + ((getOperateIp() == null) ? 0 : getOperateIp().hashCode());
        result = prime * result + ((getOperateParam() == null) ? 0 : getOperateParam().hashCode());
        result = prime * result + ((getJsonResult() == null) ? 0 : getJsonResult().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getErrorMsg() == null) ? 0 : getErrorMsg().hashCode());
        result = prime * result + ((getOperateTime() == null) ? 0 : getOperateTime().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
        result = prime * result + ((getIsDeleted() == null) ? 0 : getIsDeleted().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", title=").append(title);
        sb.append(", businessType=").append(businessType);
        sb.append(", method=").append(method);
        sb.append(", requestMethod=").append(requestMethod);
        sb.append(", operatorName=").append(operatorName);
        sb.append(", operateUrl=").append(operateUrl);
        sb.append(", operateIp=").append(operateIp);
        sb.append(", operateParam=").append(operateParam);
        sb.append(", jsonResult=").append(jsonResult);
        sb.append(", status=").append(status);
        sb.append(", errorMsg=").append(errorMsg);
        sb.append(", operateTime=").append(operateTime);
        sb.append(", createTime=").append(createTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", isDeleted=").append(isDeleted);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}
