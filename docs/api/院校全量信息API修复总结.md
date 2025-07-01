# 院校全量信息API修复总结

## 问题描述
`/designer/school/1/full-info` API接口返回数据不完整，多个JSON字段值为null，包括：
- majorCategories的skills字段
- courseSystem的courses字段
- facultyMembers的expertise字段
- awardTrends的years、internationalData、nationalData、provincialData字段
- employmentCharts的industryData、salaryData、salaryLabels字段
- cardStats的employmentRates、facultyStrengths、studentScores、advantagePrograms字段

## 根本原因
MyBatis Plus没有正确配置JSON类型处理器，导致MySQL数据库中的JSON字段无法正确映射到Java对象。虽然实体类已经使用了`@TableField`注解并指定了`JacksonTypeHandler`，但MyBatis Plus需要一个全局的ObjectMapper配置。

## 解决方案

### 1. 创建MyBatis Plus JSON配置类
在`ruoyi-common-mybatis`模块中创建了`MybatisPlusJsonConfig`配置类：

```java
package org.ruoyi.mybatis.config;

import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;

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
```

### 2. 注册自动配置
在`org.springframework.boot.autoconfigure.AutoConfiguration.imports`文件中添加：
```
org.ruoyi.mybatis.config.MybatisPlusJsonConfig
```

### 3. 验证结果
修复后，API返回了完整的数据，所有JSON字段都正确映射：
- majorCategories的skills字段 ✓
- courseSystem的courses字段 ✓
- facultyMembers的expertise字段 ✓
- awardTrends的所有字段 ✓
- employmentCharts的所有字段 ✓
- cardStats的所有字段 ✓

## 技术要点
1. MyBatis Plus使用`JacksonTypeHandler`处理JSON字段时，需要配置全局的ObjectMapper
2. 使用`@EventListener(ApplicationStartedEvent.class)`确保在应用启动后初始化配置
3. 实体类上需要设置`autoResultMap = true`以启用自动结果映射
4. JSON字段需要使用`@TableField(typeHandler = JacksonTypeHandler.class)`注解

## 修改的文件
1. `/ruoyi-common/ruoyi-common-mybatis/src/main/java/org/ruoyi/mybatis/config/MybatisPlusJsonConfig.java` - 新增
2. `/ruoyi-common/ruoyi-common-mybatis/src/main/resources/META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` - 修改

## 建议
1. 确保所有使用JSON字段的实体类都正确配置了`@TableField`注解和`typeHandler`
2. 在开发环境中可以临时开启DEBUG日志查看MyBatis的SQL执行情况
3. 定期检查数据库中的JSON数据格式是否正确 