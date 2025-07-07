package org.ruoyi.designer.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 用户档案完整度VO
 *
 * @author ruoyi
 */
@Data
@Schema(description = "用户档案完整度信息")
public class ProfileCompletenessVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 设计师完整度信息
     */
    @Schema(description = "设计师完整度信息")
    private DesignerCompletenessVo designer;

    /**
     * 企业完整度信息
     */
    @Schema(description = "企业完整度信息")
    private EnterpriseCompletenessVo enterprise;

    /**
     * 院校完整度信息
     */
    @Schema(description = "院校完整度信息")
    private SchoolCompletenessVo school;
} 