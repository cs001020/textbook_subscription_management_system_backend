package com.chen.graduation;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 教材预订管理系统后端应用程序
 *
 * @author CHEN
 * @date 2023/01/27
 */
@SpringBootApplication
public class TextbookSubscriptionManagementSystemBackendApplication {
    // TODO: 2023/2/21 鉴权 
    public static void main(String[] args) {
        SpringApplication.run(TextbookSubscriptionManagementSystemBackendApplication.class, args);
    }

}
