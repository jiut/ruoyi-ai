package org.ruoyi.designer.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.ruoyi.designer.domain.*;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 完整设计师档案VO
 *
 * @author ruoyi
 */
@Data
@Schema(description = "完整设计师档案信息")
public class CompleteProfileVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 设计师基础信息
     */
    @Schema(description = "设计师基础信息")
    private Designer designer;

    /**
     * 工作经历列表
     */
    @Schema(description = "工作经历列表")
    private List<WorkExperience> workExperiences;

    /**
     * 教育背景列表
     */
    @Schema(description = "教育背景列表")
    private List<Education> educations;

    /**
     * 作品列表
     */
    @Schema(description = "作品列表")
    private List<Work> works;

    /**
     * 获奖记录列表
     */
    @Schema(description = "获奖记录列表")
    private List<Award> awards;
} 