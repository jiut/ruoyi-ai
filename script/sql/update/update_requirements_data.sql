-- 更新现有岗位数据的requirements字段
-- 执行时间：2025-01-27

-- 更新岗位1 - 高级交互设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，设计相关专业，5年以上互联网产品交互设计经验。
精通用户体验设计方法论，能够独立完成用户研究、交互设计、原型设计等工作。
熟练使用 Figma、Sketch、Axure 等设计工具，具备良好的设计表达能力。
对数据敏感，能够基于数据分析进行设计决策。
具备良好的沟通协作能力，能够与多角色团队高效合作。
有游戏行业设计经验者优先。'
WHERE `job_title` = '高级交互设计师' AND `enterprise_id` = 1;

-- 更新岗位2 - 资深视觉设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，设计相关专业，3-5年视觉设计经验。
精通 Photoshop、Illustrator、Sketch 等设计软件。
具备扎实的美术功底和良好的审美能力。
熟悉品牌设计、网页设计、移动端设计等多个设计领域。
有电商或互联网行业经验者优先。
具备良好的沟通能力和团队协作精神。'
WHERE `job_title` = '资深视觉设计师' AND `enterprise_id` = 2;

-- 更新岗位3 - UI设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，设计相关专业，2-3年UI设计经验。
熟练使用 Sketch、Figma、Adobe Creative Suite 等设计工具。
具备良好的视觉设计能力和用户体验意识。
了解前端开发基础知识，能够与开发团队有效沟通。
有移动端产品设计经验者优先。
具备创新思维和学习能力。'
WHERE `job_title` = 'UI设计师' AND `enterprise_id` = 3;

-- 更新岗位4 - 游戏美术设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，美术或设计相关专业，3年以上游戏美术经验。
精通 3D Max、Maya、Photoshop 等美术制作软件。
具备扎实的美术基础和良好的审美能力。
熟悉游戏美术制作流程和技术要求。
有手游或端游项目经验者优先。
具备团队协作精神和责任心。'
WHERE `job_title` = '游戏美术设计师' AND `enterprise_id` = 4;

-- 更新岗位5 - 产品设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，设计或相关专业，3-5年产品设计经验。
熟练使用 Figma、Sketch、Axure 等设计和原型工具。
具备用户体验设计思维和方法论。
有用户研究经验，能够基于数据进行设计决策。
有AI或搜索产品设计经验者优先。
具备良好的沟通能力和创新思维。'
WHERE `job_title` = '产品设计师' AND `enterprise_id` = 5;

-- 更新岗位6 - 动效设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，动画或设计相关专业，2-4年动效设计经验。
精通 After Effects、Cinema 4D、Lottie 等动效制作工具。
具备扎实的动画基础和良好的节奏感。
了解前端动效实现原理，能与开发团队有效沟通。
有移动端产品动效设计经验者优先。
具备创意思维和执行能力。'
WHERE `job_title` = '动效设计师' AND `enterprise_id` = 6;

COMMIT; 