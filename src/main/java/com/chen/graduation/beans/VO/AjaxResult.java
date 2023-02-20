package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Objects;

/**
 * ajax结果
 *
 * @author CHEN
 * @date 2023/01/27
 */
@Data
@ApiModel("统一响应结果")
public class AjaxResult<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 状态码
     */
    @ApiModelProperty("状态码")
    private Integer code;

    /**
     * 返回内容
     */
    @ApiModelProperty("消息")
    private String msg;

    /**
     * 数据对象
     */
    @ApiModelProperty("数据对象")
    private T data;
    /**
     * 总数量 用于分页
     */
    @ApiModelProperty("总数量 用于分页")
    private Long total;

    /**
     * 响应状态类型
     */
    public enum ResponseType {
        /**
         * 成功
         */
        SUCCESS(200),
        /**
         * 警告
         */
        WARN(301),
        /**
         * 错误
         */
        ERROR(500),
        /**
         * 未认证
         */
        UN_AUTH(401);
        private final int value;

        ResponseType(int value) {
            this.value = value;
        }

        public int value() {
            return this.value;
        }
    }

    /**
     * 初始化一个新创建的 AjaxResult 对象，使其表示一个空消息。
     */
    public AjaxResult() {
    }

    /**
     * 初始化一个新创建的 AjaxResult 对象
     *
     * @param responseType 状态类型
     * @param msg          返回内容
     * @param data         数据对象
     */
    public AjaxResult(ResponseType responseType, String msg, T data) {
        this.code = responseType.value;
        this.msg = msg;
        if (!Objects.isNull(data)) {
            this.data = data;
        }
    }

    /**
     * 返回成功消息
     *
     * @return 成功消息
     */
    public static AjaxResult<Object> success() {
        return new AjaxResult<>(ResponseType.SUCCESS, "操作成功", null);
    }

    /**
     * 返回成功数据
     *
     * @return 成功消息
     */
    public static <T> AjaxResult<T> success(T data) {
        return new AjaxResult<>(ResponseType.SUCCESS, "操作成功", data);
    }

    /**
     * 返回成功消息
     *
     * @param msg 返回内容
     * @return 成功消息
     */
    public static AjaxResult<Object> success(String msg) {
        return new AjaxResult<>(ResponseType.SUCCESS, msg, null);
    }

    /**
     * 返回成功消息
     *
     * @param msg  返回内容
     * @param data 数据对象
     * @return 成功消息
     */
    public static <T> AjaxResult<T> success(String msg, T data) {
        return new AjaxResult<>(ResponseType.SUCCESS, msg, data);
    }

    /**
     * 返回警告消息
     *
     * @param msg 返回内容
     * @return 警告消息
     */
    public static AjaxResult<Object> warn(String msg) {
        return new AjaxResult<>(ResponseType.WARN, msg, null);
    }

    /**
     * 返回警告消息
     *
     * @param msg  返回内容
     * @param data 数据对象
     * @return 警告消息
     */
    public static <T> AjaxResult<T> warn(String msg, T data) {
        return new AjaxResult<>(ResponseType.WARN, msg, data);
    }

    /**
     * 返回错误消息
     *
     * @return AjaxResult
     */
    public static AjaxResult<Object> error() {
        return new AjaxResult<>(ResponseType.ERROR, "操作失败", null);
    }

    /**
     * 返回错误消息
     *
     * @param msg 返回内容
     * @return 警告消息
     */
    public static AjaxResult<Object> error(String msg) {
        return new AjaxResult<>(ResponseType.ERROR, msg, null);
    }

    /**
     * 返回错误消息
     *
     * @param msg  返回内容
     * @param data 数据对象
     * @return 警告消息
     */
    public static <T> AjaxResult<T> error(String msg, T data) {
        return new AjaxResult<>(ResponseType.ERROR, msg, data);
    }

}
