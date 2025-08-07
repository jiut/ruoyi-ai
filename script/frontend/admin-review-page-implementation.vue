<template>
  <div class="admin-review-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h1>系统管理员审核</h1>
      <div class="header-actions">
        <NButton @click="refreshData" :loading="loading">
          <template #icon>
            <NIcon><RefreshIcon /></NIcon>
          </template>
          刷新
        </NButton>
      </div>
    </div>

    <!-- 基础统计条 -->
    <div class="stats-section">
      <NGrid :cols="2" :x-gap="16">
        <NGridItem>
          <NCard title="待审核申请" size="small">
            <NStatistic :value="stats.pendingCount" />
            <template #suffix>
              <NText depth="3">个</NText>
            </template>
          </NCard>
        </NGridItem>
        <NGridItem>
          <NCard title="今日已审核" size="small">
            <NStatistic :value="stats.reviewedToday" />
            <template #suffix>
              <NText depth="3">个</NText>
            </template>
          </NCard>
        </NGridItem>
      </NGrid>
    </div>

    <!-- 申请列表表格 -->
    <div class="table-section">
      <NDataTable 
        :columns="columns" 
        :data="applications"
        :pagination="pagination"
        :loading="loading"
        :scroll-x="1200"
        @update:page="handlePageChange" />
    </div>

    <!-- 审核操作弹窗 -->
    <NModal v-model:show="showReviewModal" preset="card" style="width: 600px" title="审核申请">
      <div class="review-modal-content">
        <div class="application-info">
          <h4>{{ selectedApplication?.taskTitle }}</h4>
          <div class="info-grid">
            <div class="info-item">
              <span class="label">申请人：</span>
              <span>{{ selectedApplication?.designerName }}</span>
            </div>
            <div class="info-item">
              <span class="label">报价：</span>
              <span>¥{{ selectedApplication?.proposedPrice }}</span>
            </div>
            <div class="info-item">
              <span class="label">预计：</span>
              <span>{{ selectedApplication?.estimatedDays }}天</span>
            </div>
          </div>
          <div class="proposal-section">
            <h5>申请提案</h5>
            <NText>{{ selectedApplication?.proposal }}</NText>
          </div>
        </div>
        
        <NDivider />
        
        <NForm ref="reviewFormRef" :model="reviewForm" :rules="reviewRules">
          <NFormItem label="审核结果" required path="decision">
            <NRadioGroup v-model:value="reviewForm.decision">
              <NSpace>
                <NRadio value="APPROVED">
                  <NText type="success">通过</NText>
                </NRadio>
                <NRadio value="REJECTED">
                  <NText type="error">拒绝</NText>
                </NRadio>
              </NSpace>
            </NRadioGroup>
          </NFormItem>
          <NFormItem label="审核反馈" path="feedback">
            <NInput 
              v-model:value="reviewForm.feedback" 
              type="textarea" 
              :rows="4"
              :placeholder="reviewForm.decision === 'APPROVED' ? 
                '请输入通过理由（可选）' : 
                '请输入拒绝理由（建议填写）'" 
              :maxlength="1000"
              show-count />
          </NFormItem>
        </NForm>
      </div>
      
      <template #action>
        <NSpace>
          <NButton @click="showReviewModal = false">取消</NButton>
          <NButton 
            type="primary" 
            @click="submitReview" 
            :loading="reviewing"
            :disabled="!reviewForm.decision">
            确认{{ reviewForm.decision === 'APPROVED' ? '通过' : '拒绝' }}
          </NButton>
        </NSpace>
      </template>
    </NModal>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed, h } from 'vue'
import { 
  NDataTable, NGrid, NGridItem, NCard, NStatistic, NText, NSpace,
  NButton, NModal, NForm, NFormItem, NInput, NRadioGroup, NRadio,
  NDivider, NIcon, useMessage, useDialog
} from 'naive-ui'
import { RefreshIcon } from '@vicons/ionicons5'

// 基础数据定义
interface BasicReviewStats {
  pendingCount: number
  reviewedToday: number
}

interface TaskApplication {
  applicationId: number
  taskTitle: string
  designerName: string
  proposedPrice: number
  estimatedDays: number
  proposal: string
  createTime: string
}

interface AdminReviewRequest {
  decision: 'APPROVED' | 'REJECTED'
  feedback: string
}

// 响应式数据
const message = useMessage()
const dialog = useDialog()
const loading = ref(false)
const reviewing = ref(false)
const showReviewModal = ref(false)

// 统计数据
const stats = reactive<BasicReviewStats>({
  pendingCount: 0,
  reviewedToday: 0
})

// 申请列表
const applications = ref<TaskApplication[]>([])
const selectedApplication = ref<TaskApplication | null>(null)

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 10,
  itemCount: 0,
  showSizePicker: true,
  pageSizes: [10, 20, 50]
})

// 审核表单
const reviewForm = reactive<AdminReviewRequest>({
  decision: '' as any,
  feedback: ''
})

const reviewFormRef = ref()

// 表单验证规则
const reviewRules = {
  decision: [
    { required: true, message: '请选择审核结果', trigger: 'change' }
  ]
}

// 表格列定义
const columns = computed(() => [
  { 
    title: 'ID', 
    key: 'applicationId', 
    width: 80,
    fixed: 'left' as const
  },
  { 
    title: '任务标题', 
    key: 'taskTitle', 
    width: 200, 
    ellipsis: { tooltip: true }
  },
  { 
    title: '设计师', 
    key: 'designerName', 
    width: 120 
  },
  { 
    title: '报价', 
    key: 'proposedPrice', 
    width: 100,
    render: (row: TaskApplication) => `¥${row.proposedPrice}`
  },
  { 
    title: '预计天数', 
    key: 'estimatedDays', 
    width: 100,
    render: (row: TaskApplication) => `${row.estimatedDays}天`
  },
  { 
    title: '申请时间', 
    key: 'createTime', 
    width: 160,
    render: (row: TaskApplication) => formatTime(row.createTime)
  },
  { 
    title: '操作', 
    key: 'actions', 
    width: 200,
    fixed: 'right' as const,
    render: (row: TaskApplication) => h(NSpace, { size: 'small' }, [
      h(NButton, { 
        size: 'small', 
        type: 'success',
        onClick: () => handleQuickReview(row, 'APPROVED') 
      }, '快速通过'),
      h(NButton, { 
        size: 'small',
        type: 'error',
        onClick: () => handleQuickReview(row, 'REJECTED') 
      }, '快速拒绝'),
      h(NButton, { 
        size: 'small',
        type: 'primary',
        onClick: () => handleDetailReview(row) 
      }, '详细审核')
    ])
  }
])

// API调用（模拟实现）
const adminReviewApi = {
  // 获取基础统计
  getBasicStats: async (): Promise<BasicReviewStats> => {
    const response = await fetch('/designer/task-application/admin/review/basic-stats')
    const result = await response.json()
    return result.data
  },

  // 获取待审核申请列表
  getPendingApplications: async (page: number, pageSize: number): Promise<{
    rows: TaskApplication[]
    total: number
  }> => {
    const response = await fetch(`/designer/task-application/admin/pending?page=${page}&pageSize=${pageSize}`)
    const result = await response.json()
    return {
      rows: result.data,
      total: result.total || result.data.length
    }
  },

  // 执行审核操作
  reviewApplication: async (id: number, data: AdminReviewRequest): Promise<{ success: boolean, message: string }> => {
    const response = await fetch(`/designer/task-application/${id}/admin-review`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    })
    const result = await response.json()
    return {
      success: result.code === 200,
      message: result.msg
    }
  }
}

// 业务方法
const fetchStats = async () => {
  try {
    const data = await adminReviewApi.getBasicStats()
    Object.assign(stats, data)
  } catch (error) {
    console.error('获取统计数据失败:', error)
    message.error('获取统计数据失败')
  }
}

const fetchApplications = async () => {
  loading.value = true
  try {
    const data = await adminReviewApi.getPendingApplications(pagination.page, pagination.pageSize)
    applications.value = data.rows
    pagination.itemCount = data.total
  } catch (error) {
    console.error('获取申请列表失败:', error)
    message.error('获取申请列表失败')
  } finally {
    loading.value = false
  }
}

const refreshData = async () => {
  await Promise.all([fetchStats(), fetchApplications()])
}

// 快速审核（无反馈）
const handleQuickReview = async (application: TaskApplication, decision: 'APPROVED' | 'REJECTED') => {
  const action = decision === 'APPROVED' ? '通过' : '拒绝'
  
  dialog.warning({
    title: `确认${action}`,
    content: `确定要${action}设计师"${application.designerName}"的申请吗？`,
    positiveText: `确认${action}`,
    negativeText: '取消',
    onPositiveClick: async () => {
      try {
        const result = await adminReviewApi.reviewApplication(application.applicationId, {
          decision,
          feedback: decision === 'APPROVED' ? '系统管理员快速审核通过' : '不符合平台要求'
        })
        
        if (result.success) {
          message.success(`申请已${action}`)
          await refreshData()
        } else {
          message.error(result.message || '操作失败')
        }
      } catch (error) {
        message.error('操作失败，请重试')
      }
    }
  })
}

// 详细审核（带反馈）
const handleDetailReview = (application: TaskApplication) => {
  selectedApplication.value = application
  reviewForm.decision = '' as any
  reviewForm.feedback = ''
  showReviewModal.value = true
}

// 提交审核
const submitReview = async () => {
  try {
    await reviewFormRef.value?.validate()
    
    if (!selectedApplication.value) return
    
    reviewing.value = true
    
    const result = await adminReviewApi.reviewApplication(
      selectedApplication.value.applicationId,
      reviewForm
    )
    
    if (result.success) {
      message.success(`申请${reviewForm.decision === 'APPROVED' ? '通过' : '拒绝'}成功`)
      showReviewModal.value = false
      await refreshData()
    } else {
      message.error(result.message || '操作失败')
    }
    
  } catch (error) {
    console.error('审核操作失败:', error)
    message.error('操作失败，请重试')
  } finally {
    reviewing.value = false
  }
}

// 分页处理
const handlePageChange = (page: number) => {
  pagination.page = page
  fetchApplications()
}

// 工具函数
const formatTime = (time: string): string => {
  return new Date(time).toLocaleString('zh-CN')
}

// 生命周期
onMounted(() => {
  refreshData()
})
</script>

<style scoped>
.admin-review-page {
  padding: 24px;
  background: #f5f5f5;
  min-height: 100vh;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.page-header h1 {
  margin: 0;
  color: #333;
  font-size: 24px;
  font-weight: 600;
}

.stats-section {
  margin-bottom: 24px;
}

.table-section {
  background: white;
  border-radius: 8px;
  padding: 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.review-modal-content {
  max-height: 60vh;
  overflow-y: auto;
}

.application-info {
  margin-bottom: 16px;
}

.application-info h4 {
  margin: 0 0 12px 0;
  color: #333;
  font-size: 18px;
}

.info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
  margin-bottom: 16px;
}

.info-item {
  display: flex;
  align-items: center;
}

.info-item .label {
  font-weight: 600;
  margin-right: 8px;
  color: #666;
}

.proposal-section h5 {
  margin: 0 0 8px 0;
  color: #333;
  font-size: 14px;
  font-weight: 600;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .admin-review-page {
    padding: 16px;
  }
  
  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
  
  .info-grid {
    grid-template-columns: 1fr;
  }
}
</style> 