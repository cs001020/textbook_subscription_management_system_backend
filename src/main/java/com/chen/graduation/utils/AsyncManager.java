package com.chen.graduation.utils;

import cn.hutool.extra.spring.SpringUtil;

import java.util.TimerTask;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 异步任务管理器
 *
 * @author CHEN
 * @date 2023/03/05
 */
public class AsyncManager {

    /**
     * 操作延迟10毫秒
     */
    private final int OPERATE_DELAY_TIME = 10;

    /**
     * 异步操作任务调度线程池
     */
    private final ScheduledExecutorService executor = SpringUtil.getBean("scheduledExecutorService");

    /**
     * 单例模式
     */
    private AsyncManager(){}

    /**
     * 实例
     */
    private static final AsyncManager INSTANCE = new AsyncManager();

    public static AsyncManager me()
    {
        return INSTANCE;
    }

    /**
     * 执行任务
     *
     * @param task 任务
     */
    public void execute(TimerTask task)
    {
        executor.schedule(task, OPERATE_DELAY_TIME, TimeUnit.MILLISECONDS);
    }

    /**
     * 停止任务线程池
     */
    public void shutdown()
    {
        ThreadUtils.shutdownAndAwaitTermination(executor);
    }
}
