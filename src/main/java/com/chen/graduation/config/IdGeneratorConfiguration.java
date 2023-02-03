package com.chen.graduation.config;

import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * id生成器配置
 *
 * @author CHEN
 * @date 2023/02/03
 */
@Setter
@Configuration
@ConfigurationProperties(prefix = "snowflake")
public class IdGeneratorConfiguration {
    /**
     * 终端id
     */
    private Long workerId= (long) RandomUtil.randomInt(10,100);
    /**
     * 数据中心id
     */
    private Long datacenterId=(long) RandomUtil.randomInt(10,100);

    /**
     * 雪花id生成器
     *
     * @return {@link Snowflake}
     */
    @Bean
    public Snowflake snowflake(){
        return IdUtil.getSnowflake(workerId, datacenterId);
    }
}
