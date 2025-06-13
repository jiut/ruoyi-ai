package org.ruoyi.common.web.config;

import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Web MVC配置
 *
 * @author ruoyi
 */
@Configuration
@AutoConfiguration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addFormatters(FormatterRegistry registry) {
        // 添加String到Date的转换器
        registry.addConverter(new StringToDateConverter());
        // 添加String到Map的转换器
        registry.addConverter(new StringToMapConverter());
    }

    /**
     * String到Date转换器
     */
    public static class StringToDateConverter implements Converter<String, Date> {
        private static final String[] DATE_PATTERNS = {
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd",
            "yyyy/MM/dd HH:mm:ss",
            "yyyy/MM/dd"
        };

        @Override
        public Date convert(String source) {
            if (source == null || source.trim().isEmpty()) {
                return null;
            }
            
            for (String pattern : DATE_PATTERNS) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat(pattern);
                    return sdf.parse(source);
                } catch (ParseException e) {
                    // 继续尝试下一个格式
                }
            }
            return null;
        }
    }

    /**
     * String到Map转换器
     */
    public static class StringToMapConverter implements Converter<String, Map<String, Object>> {
        @Override
        public Map<String, Object> convert(String source) {
            if (source == null || source.trim().isEmpty()) {
                return new HashMap<>();
            }
            // 这里可以添加JSON字符串解析逻辑
            return new HashMap<>();
        }
    }
} 