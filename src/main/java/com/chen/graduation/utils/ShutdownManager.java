package com.chen.graduation.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.PreDestroy;

/**
 * 关闭管理器
 * 确保应用退出时能关闭后台线程
 *
 * @author CHEN
 * @date 2023/03/05
 */
@Component
@Slf4j
public class ShutdownManager {
    @PreDestroy
    public void destroy()
    {
        shutdownAsyncManager();
    }

    /**
     * 停止异步执行任务
     */
    private void shutdownAsyncManager()
    {
        try
        {
            log.info("====关闭后台任务任务线程池====");
            AsyncManager.me().shutdown();
        }
        catch (Exception e)
        {
            log.error(e.getMessage(), e);
        }
    }
}
