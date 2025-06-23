/**
 * 技能标签工具类
 * 用于处理技能标签的分类、颜色和渲染
 *
 * @author ruoyi
 * @version 1.0.0
 */
class SkillTagUtils {

    // 技能标签分类映射表（英文简写 -> 分类）
    static categoryMap = new Map([
        // ========== 设计工具/软件类 (TOOL) ==========
        ['figma', 'tool'],
        ['sketch', 'tool'],
        ['axure_rp', 'tool'],
        ['photoshop', 'tool'],
        ['illustrator', 'tool'],
        ['after_effects', 'tool'],
        ['cinema_4d', 'tool'],
        ['blender', 'tool'],
        ['3d_max', 'tool'],
        ['maya', 'tool'],
        ['adobe_xd', 'tool'],
        ['invision', 'tool'],
        ['framer', 'tool'],
        ['principle', 'tool'],
        ['zeplin', 'tool'],
        ['abstract', 'tool'],
        ['lottie', 'tool'],

        // ========== 设计专业领域类 (FIELD) ==========
        ['interaction_design', 'field'],
        ['ui_design', 'field'],
        ['brand_design', 'field'],
        ['product_design', 'field'],
        ['motion_design', 'field'],
        ['game_art', 'field'],
        ['web_design', 'field'],
        ['mobile_design', 'field'],
        ['graphic_design', 'field'],
        ['logo_design', 'field'],
        ['interface_design', 'field'],
        ['brand_identity', 'field'],
        ['animation_design', 'field'],
        ['branding', 'field'],

        // ========== 设计技能/方法类 (SKILL) ==========
        ['user_experience', 'skill'],
        ['user_research', 'skill'],
        ['prototype_design', 'skill'],
        ['design_system', 'skill'],
        ['information_architecture', 'skill'],
        ['visual_system', 'skill'],
        ['wireframing', 'skill'],
        ['user_testing', 'skill'],
        ['persona_design', 'skill'],
        ['journey_mapping', 'skill'],
        ['usability_testing', 'skill'],
        ['visual_design', 'skill'],
        ['typography', 'skill'],
        ['color_theory', 'skill'],
        ['illustration', 'skill'],
        ['character_design', 'skill'],
        ['scene_design', 'skill'],
        ['visual_identity', 'skill'],
        ['animation', 'skill'],
        ['effects', 'skill'],
        ['3d_modeling', 'skill'],
        ['photography', 'skill'],
        ['video_editing', 'skill']
    ]);

    // 英文简写到中文显示名称的映射表
    static nameMap = new Map([
        // ========== 设计工具/软件类 (TOOL) ==========
        ['figma', 'Figma'],
        ['sketch', 'Sketch'],
        ['axure_rp', 'Axure RP'],
        ['photoshop', 'Photoshop'],
        ['illustrator', 'Illustrator'],
        ['after_effects', 'After Effects'],
        ['cinema_4d', 'Cinema 4D'],
        ['blender', 'Blender'],
        ['3d_max', '3D Max'],
        ['maya', 'Maya'],
        ['adobe_xd', 'Adobe XD'],
        ['invision', 'InVision'],
        ['framer', 'Framer'],
        ['principle', 'Principle'],
        ['zeplin', 'Zeplin'],
        ['abstract', 'Abstract'],
        ['lottie', 'Lottie'],

        // ========== 设计专业领域类 (FIELD) ==========
        ['interaction_design', '交互设计'],
        ['ui_design', 'UI设计'],
        ['brand_design', '品牌设计'],
        ['product_design', '产品设计'],
        ['motion_design', '动效设计'],
        ['game_art', '游戏美术'],
        ['web_design', '网页设计'],
        ['mobile_design', '移动端设计'],
        ['graphic_design', '平面设计'],
        ['logo_design', 'LOGO设计'],
        ['interface_design', '界面设计'],
        ['brand_identity', '品牌标识'],
        ['animation_design', '动画制作'],
        ['branding', '品牌设计'],

        // ========== 设计技能/方法类 (SKILL) ==========
        ['user_experience', '用户体验'],
        ['user_research', '用户研究'],
        ['prototype_design', '原型设计'],
        ['design_system', '设计系统'],
        ['information_architecture', '信息架构'],
        ['visual_system', '视觉系统'],
        ['wireframing', '线框设计'],
        ['user_testing', '用户测试'],
        ['persona_design', '用户画像'],
        ['journey_mapping', '用户旅程'],
        ['usability_testing', '可用性测试'],
        ['visual_design', '视觉设计'],
        ['typography', '字体设计'],
        ['color_theory', '色彩理论'],
        ['illustration', '插画'],
        ['character_design', '角色设计'],
        ['scene_design', '场景设计'],
        ['visual_identity', '视觉识别'],
        ['animation', '动画'],
        ['effects', '动效'],
        ['3d_modeling', '3D建模'],
        ['photography', '摄影'],
        ['video_editing', '视频剪辑']
    ]);

    // 主题配置（仅保留默认主题）
    static themes = {
        default: {
            tool: {
                bg: 'bg-blue-500/20',
                text: 'text-blue-400',
                border: 'border-blue-500/30'
            },
            field: {
                bg: 'bg-purple-500/20',
                text: 'text-purple-400',
                border: 'border-purple-500/30'
            },
            skill: {
                bg: 'bg-pink-500/20',
                text: 'text-pink-400',
                border: 'border-pink-500/30'
            }
        }
    };

    /**
     * 获取标签分类
     * @param {string} tag - 英文简写标签名称
     * @returns {string} 分类代码：'tool', 'field', 'skill'
     */
    static getTagCategory(tag) {
        return this.categoryMap.get(tag) || 'skill';
    }

    /**
     * 获取标签中文显示名称
     * @param {string} tag - 英文简写标签名称
     * @returns {string} 中文显示名称
     */
    static getTagDisplayName(tag) {
        return this.nameMap.get(tag) || tag;
    }

    /**
     * 获取标签样式类名
     * @param {string} tag - 英文简写标签名称
     * @param {string} theme - 主题名称，默认 'default'
     * @param {object} options - 自定义配置
     * @returns {string} CSS类名字符串
     */
    static getTagClasses(tag, theme = 'default', options = {}) {
        const category = this.getTagCategory(tag);
        const themeConfig = this.themes[theme] || this.themes.default;
        const colorConfig = themeConfig[category] || themeConfig.skill;

        const defaultOptions = {
            baseClasses: 'text-xs px-2 py-1 rounded-full border',
            spacing: ''
        };

        const config = { ...defaultOptions, ...options };

        return `${config.baseClasses} ${colorConfig.bg} ${colorConfig.text} ${colorConfig.border} ${config.spacing}`.trim();
    }

    /**
     * 生成单个标签HTML
     * @param {string} tag - 英文简写标签名称
     * @param {string} theme - 主题名称
     * @param {object} options - 自定义配置
     * @returns {string} HTML字符串
     */
    static generateTagHTML(tag, theme = 'default', options = {}) {
        const classes = this.getTagClasses(tag, theme, options);
        const displayName = this.getTagDisplayName(tag);
        return `<span class="${classes}">${displayName}</span>`;
    }

    /**
     * 生成多个标签HTML
     * @param {Array} tags - 英文简写标签数组
     * @param {string} theme - 主题名称
     * @param {object} options - 自定义配置
     * @returns {string} HTML字符串
     */
    static generateTagsHTML(tags, theme = 'default', options = {}) {
        const defaultOptions = {
            gap: 'gap-2',
            wrapper: 'div',
            wrapperClasses: 'flex flex-wrap'
        };

        const config = { ...defaultOptions, ...options };

        const tagsHTML = tags.map(tag => this.generateTagHTML(tag, theme, config)).join(' ');

        if (config.wrapper) {
            return `<${config.wrapper} class="${config.wrapperClasses} ${config.gap}">${tagsHTML}</${config.wrapper}>`;
        }

        return tagsHTML;
    }

    /**
     * 直接渲染标签到DOM元素
     * @param {string|Element} container - 容器选择器或DOM元素
     * @param {Array} tags - 英文简写标签数组
     * @param {string} theme - 主题名称
     * @param {object} options - 自定义配置
     */
    static renderTags(container, tags, theme = 'default', options = {}) {
        const element = typeof container === 'string' ? document.querySelector(container) : container;
        if (!element) {
            console.warn('SkillTagUtils: 容器元素未找到');
            return;
        }

        element.innerHTML = this.generateTagsHTML(tags, theme, options);
    }

    /**
     * 按分类分组标签
     * @param {Array} tags - 英文简写标签数组
     * @returns {object} 分组后的标签对象
     */
    static groupTagsByCategory(tags) {
        const grouped = {
            tool: [],
            field: [],
            skill: []
        };

        tags.forEach(tag => {
            const category = this.getTagCategory(tag);
            if (grouped[category]) {
                grouped[category].push(tag);
            }
        });

        return grouped;
    }

    /**
     * 渲染分组标签
     * @param {string|Element} container - 容器选择器或DOM元素
     * @param {Array} tags - 英文简写标签数组
     * @param {string} theme - 主题名称
     * @param {object} options - 自定义配置
     */
    static renderGroupedTags(container, tags, theme = 'default', options = {}) {
        const element = typeof container === 'string' ? document.querySelector(container) : container;
        if (!element) {
            console.warn('SkillTagUtils: 容器元素未找到');
            return;
        }

        const grouped = this.groupTagsByCategory(tags);
        const categoryNames = {
            tool: '🔵 设计工具',
            field: '🟣 专业领域',
            skill: '🩷 技能方法'
        };

        const defaultOptions = {
            showGroupTitle: true,
            groupGap: 'gap-4',
            itemGap: 'gap-2'
        };

        const config = { ...defaultOptions, ...options };

        let html = `<div class="space-y-${config.groupGap}">`;

        Object.entries(grouped).forEach(([category, categoryTags]) => {
            if (categoryTags.length > 0) {
                html += `<div class="skill-group">`;

                if (config.showGroupTitle) {
                    html += `<h4 class="text-sm font-medium text-gray-600 mb-2">${categoryNames[category]}</h4>`;
                }

                html += `<div class="flex flex-wrap ${config.itemGap}">`;
                categoryTags.forEach(tag => {
                    html += this.generateTagHTML(tag, theme, config);
                });
                html += `</div></div>`;
            }
        });

        html += `</div>`;
        element.innerHTML = html;
    }

    /**
     * 获取所有可用的主题
     * @returns {Array} 主题名称数组
     */
    static getAvailableThemes() {
        return ['default'];
    }

    /**
     * 添加自定义主题
     * @param {string} name - 主题名称
     * @param {object} config - 主题配置
     */
    static addTheme(name, config) {
        this.themes[name] = config;
    }

    /**
     * 获取分类统计信息
     * @param {Array} tags - 英文简写标签数组
     * @returns {object} 统计信息
     */
    static getCategoryStats(tags) {
        const stats = { tool: 0, field: 0, skill: 0 };

        tags.forEach(tag => {
            const category = this.getTagCategory(tag);
            if (stats[category] !== undefined) {
                stats[category]++;
            }
        });

        return stats;
    }
}

// 如果在Node.js环境中使用
if (typeof module !== 'undefined' && module.exports) {
    module.exports = SkillTagUtils;
}

// 如果在浏览器环境中使用
if (typeof window !== 'undefined') {
    window.SkillTagUtils = SkillTagUtils;
}
