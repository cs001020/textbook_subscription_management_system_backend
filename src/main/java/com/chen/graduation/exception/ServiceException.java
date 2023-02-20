package com.chen.graduation.exception;

/**
 *业务异常
 *
 * @author CHEN
 * @date 2023/02/06
 */
public class ServiceException extends RuntimeException{
    private String msg;

    public ServiceException(){
        super("错误请求！！！");
    }

    public ServiceException(String msg){
        super(msg);
    }

}
