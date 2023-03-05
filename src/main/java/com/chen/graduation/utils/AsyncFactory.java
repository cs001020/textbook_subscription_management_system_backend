package com.chen.graduation.utils;

import cn.hutool.extra.spring.SpringUtil;
import com.chen.graduation.beans.PO.OperateLog;

import com.chen.graduation.service.impl.OperateLogServiceImpl;

import java.util.TimerTask;

/**
 * 异步工厂（产生任务用）
 *
 * @author CHEN
 * @date 2023/03/05
 */
public class AsyncFactory {
    /**
     * 操作日志记录
     *
     * @param operateLog 操作日志信息
     * @return 任务task
     */
    public static TimerTask recordOperate(final OperateLog operateLog) {
        return new TimerTask() {
            @Override
            public void run() {
                SpringUtil.getBean(OperateLogServiceImpl.class).save(operateLog);
            }
        };
    }
}
