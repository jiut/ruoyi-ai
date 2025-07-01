package org.ruoyi.mybatis.config;

import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;

/**
 * MyBatis Plus JSON 配置
 * 确保JSON字段能够正确序列化和反序列化
 *
 * @author ruoyi
 */
@Slf4j
@Configuration
@ConditionalOnClass({JacksonTypeHandler.class, ObjectMapper.class})
public class MybatisPlusJsonConfig {

    @Bean
    public ObjectMapper objectMapper() {
        return new ObjectMapper();
    }

    @EventListener(ApplicationStartedEvent.class)
    public void init() {
        // 设置全局的ObjectMapper给JacksonTypeHandler使用
        JacksonTypeHandler.setObjectMapper(objectMapper());
        log.info("MyBatis Plus JSON配置初始化完成，已设置全局ObjectMapper");
    }
} 