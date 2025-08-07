package org.ruoyi.designer.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 企业管理员申请视图（严格隐藏系统管理员信息）
 * 根据设计文档透明性原则实现
 *
 * @author ruoyi
 */
@Data
public class EnterpriseApplicationView {
    
    /** 申请ID */
    private Long applicationId;
    
    /** 任务ID */
    private Long taskId;
    
    /** 任务标题 */
    private String taskTitle;
    
    /** 设计师姓名 */
    private String designerName;
    
    /** 设计师头像 */
    private String designerAvatar;
    
    /** 申请提案 */
    private String proposal;
    
    /** 报价金额 */
    private BigDecimal proposedPrice;
    
    /** 预计完成天数 */
    private Integer estimatedDays;
    
    /** 作品集链接 */
    private List<String> portfolioLinks;
    
    /** 企业管理员视角的状态 */
    private String status;
    
    /** 企业管理员的反馈 */
    private String feedback;
    
    /** 申请时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    /** 企业管理员审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date reviewTime;
    
    // 严格保证：以下字段不会出现在JSON序列化中
    @JsonIgnore
    private String adminReviewStatus;
    @JsonIgnore
    private String adminReviewFeedback;
    @JsonIgnore
    private Date adminReviewTime;
    @JsonIgnore
    private Long adminReviewBy;
    @JsonIgnore
    private String reviewMode;
} 