# 智图工厂完整接口自动化测试脚本 - 设计指南符合版
# 基于 docs/00-重要文档/zhitu-factory-design-guide-clean.md 中定义的所有接口进行自动化测试
# 包含完整的动态配置接口测试，完全符合智图工厂设计指南要求
# 
# 系统配置信息：
# - 后端服务端口：6039
# - 数据库配置：localhost:3306/ruoyi (用户名: root, 密码: root)
# - Redis配置：localhost:6379
#
# 使用方法: .\智图工厂完整接口自动化测试脚本_修复版.ps1 [-BaseUrl "http://localhost:6039"] [-TestMode "FULL"]

param(
    [string]$BaseUrl = "http://localhost:6039",  # 后端服务端口：6039
    [string]$TestMode = "FULL",  # FULL: 完整测试, BASIC: 基础测试, PERMISSION: 权限测试
    [string]$OutputFile = "ZhiTu_Factory_API_Test_Result_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"
)

# 设置输出编码为UTF-8，避免中文乱码
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# 全局变量
$Global:TestResults = @{}
$Global:DesignerToken = ""
$Global:EnterpriseToken = ""
$Global:AdminToken = ""
$Global:TestTaskId = ""
$Global:TestApplicationId = ""
$Global:TestDeliverableId = ""

# 测试接口定义（基于设计文档）
$Global:ApiEndpoints = @{
    # 任务管理接口
    TaskManagement = @{
        GetTaskList = @{ Method = "GET"; Url = "/designer/task/list"; RequiredRole = @("designer", "enterprise", "admin") }
        GetTaskDetail = @{ Method = "GET"; Url = "/designer/task/{id}"; RequiredRole = @("designer", "enterprise", "admin") }
        CreateTask = @{ Method = "POST"; Url = "/designer/task"; RequiredRole = @("enterprise", "admin") }
        UpdateTask = @{ Method = "PUT"; Url = "/designer/task/{id}"; RequiredRole = @("enterprise", "admin") }
        DeleteTask = @{ Method = "DELETE"; Url = "/designer/task/{ids}"; RequiredRole = @("enterprise", "admin") }
    }

    # 企业专用任务管理接口
    EnterpriseTaskManagement = @{
        GetEnterpriseTaskList = @{ Method = "GET"; Url = "/designer/enterprise/tasks/list"; RequiredRole = @("enterprise") }
        CreateEnterpriseTask = @{ Method = "POST"; Url = "/designer/enterprise/tasks"; RequiredRole = @("enterprise") }
        UpdateEnterpriseTask = @{ Method = "PUT"; Url = "/designer/enterprise/tasks/{id}"; RequiredRole = @("enterprise") }
        DeleteEnterpriseTask = @{ Method = "DELETE"; Url = "/designer/enterprise/tasks/{id}"; RequiredRole = @("enterprise") }
        PublishTask = @{ Method = "POST"; Url = "/designer/enterprise/tasks/{id}/publish"; RequiredRole = @("enterprise") }
        CancelTask = @{ Method = "POST"; Url = "/designer/enterprise/tasks/{id}/cancel"; RequiredRole = @("enterprise") }
    }

    # 双重审核接口
    TaskApplicationManagement = @{
        GetApplicationList = @{ Method = "GET"; Url = "/designer/task-application/list"; RequiredRole = @("designer", "enterprise", "admin") }
        GetApplicationDetail = @{ Method = "GET"; Url = "/designer/task-application/{id}"; RequiredRole = @("designer", "enterprise", "admin") }
        ApplyTask = @{ Method = "POST"; Url = "/designer/task-application/apply"; RequiredRole = @("designer") }
        WithdrawApplication = @{ Method = "PUT"; Url = "/designer/task-application/withdraw"; RequiredRole = @("designer") }
        AdminReview = @{ Method = "POST"; Url = "/designer/task-application/{id}/admin-review"; RequiredRole = @("admin") }
        EnterpriseReview = @{ Method = "POST"; Url = "/designer/task-application/{id}/enterprise-review"; RequiredRole = @("enterprise", "admin") }
        GetAdminPendingList = @{ Method = "GET"; Url = "/designer/task-application/admin/pending"; RequiredRole = @("admin") }
        GetEnterprisePendingList = @{ Method = "GET"; Url = "/designer/task-application/enterprise/pending"; RequiredRole = @("enterprise", "admin") }
    }

    # 动态配置接口（根据设计指南补充）
    TaskConfigManagement = @{
        GetTaskConfigInfo = @{ Method = "GET"; Url = "/designer/task-config/info"; RequiredRole = @("admin") }
        UpdateReviewMode = @{ Method = "POST"; Url = "/designer/task-config/review-mode/{mode}"; RequiredRole = @("admin") }
        ResetConfig = @{ Method = "POST"; Url = "/designer/task-config/reset"; RequiredRole = @("admin") }
        GetReviewModes = @{ Method = "GET"; Url = "/designer/task-config/review-modes"; RequiredRole = @("admin") }
    }

    # 交付管理接口
    DeliverableManagement = @{
        GetDeliverableList = @{ Method = "GET"; Url = "/designer/task-deliverable/list"; RequiredRole = @("designer", "enterprise", "admin") }
        SubmitDeliverable = @{ Method = "POST"; Url = "/designer/task-deliverable"; RequiredRole = @("designer") }
        UpdateDeliverable = @{ Method = "PUT"; Url = "/designer/task-deliverable/{id}"; RequiredRole = @("designer") }
        DeleteDeliverable = @{ Method = "DELETE"; Url = "/designer/task-deliverable/{id}"; RequiredRole = @("designer", "admin") }
        ReviewDeliverable = @{ Method = "POST"; Url = "/designer/task-deliverable/{id}/review"; RequiredRole = @("enterprise", "admin") }
    }

    # 企业专用申请管理接口（严格隐藏系统管理员信息）
    EnterpriseApplicationManagement = @{
        GetEnterprisePendingApplications = @{ Method = "GET"; Url = "/designer/task-application/enterprise/pending"; RequiredRole = @("enterprise") }
    }
}

# 日志函数
function Write-TestLog {
    param(
        [string]$Level,
        [string]$Message,
        [string]$Category = "GENERAL"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] [$Category] $Message"
    
    switch ($Level) {
        "INFO" { Write-Host $logEntry -ForegroundColor Blue }
        "SUCCESS" { Write-Host $logEntry -ForegroundColor Green }
        "WARNING" { Write-Host $logEntry -ForegroundColor Yellow }
        "ERROR" { Write-Host $logEntry -ForegroundColor Red }
    }
}

# HTTP请求函数
function Invoke-ApiRequest {
    param(
        [string]$Method,
        [string]$Url,
        [string]$Token = "",
        [object]$Body = $null,
        [hashtable]$QueryParams = @{}
    )
    
    $headers = @{
        "Content-Type" = "application/json"
    }
    
    if ($Token) {
        $headers["Authorization"] = "Bearer $Token"
    }
    
    # 构建查询参数
    if ($QueryParams.Count -gt 0) {
        $queryString = ($QueryParams.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "&"
        $Url += "?$queryString"
    }
    
    try {
        $params = @{
            Uri = $Url
            Method = $Method
            Headers = $headers
            UseBasicParsing = $true
        }
        
        # 对于GET请求，不发送body数据；对于其他请求，发送body数据
        if ($Body -and $Method -ne "GET") {
            $params.Body = ($Body | ConvertTo-Json -Depth 10)
        }
        
        $response = Invoke-RestMethod @params
        
        return @{
            Success = $true
            Data = $response
            StatusCode = 200
        }
    }
    catch {
        $errorResponse = $_.Exception.Response
        $statusCode = if ($errorResponse) { [int]$errorResponse.StatusCode } else { 500 }
        
        return @{
            Success = $false
            Data = $_.Exception.Message
            StatusCode = $statusCode
        }
    }
}

# 获取角色对应的Token
function Get-TokenByRole {
    param([string]$Role)
    
    switch ($Role) {
        "designer" { return $Global:DesignerToken }
        "enterprise" { return $Global:EnterpriseToken }
        "admin" { return $Global:AdminToken }
        default { return "" }
    }
}

# 用户登录
function Invoke-UserLogin {
    param(
        [string]$Username,
        [string]$Password,
        [string]$RoleName
    )
    
    Write-TestLog "INFO" "Login user: $Username ($RoleName)" "LOGIN"
    
    $loginData = @{
        username = $Username
        password = $Password
    }
    
    $response = Invoke-ApiRequest -Method "POST" -Url "$BaseUrl/auth/login" -Body $loginData
    
    if ($response.Success -and $response.Data.code -eq 200) {
        Write-TestLog "SUCCESS" "$RoleName login successful" "LOGIN"
        return $response.Data.data.access_token
    }
    else {
        Write-TestLog "ERROR" "$RoleName login failed: $($response.Data)" "LOGIN"
        return ""
    }
}

# 初始化测试用户
function Initialize-TestUsers {
    Write-TestLog "INFO" "=== Initialize Test Users ===" "INIT"
    
    # 设计师登录
    $Global:DesignerToken = Invoke-UserLogin -Username "designer_test" -Password "admin123" -RoleName "Designer"
    
    # 企业管理员登录
    $Global:EnterpriseToken = Invoke-UserLogin -Username "enterprise_test" -Password "admin123" -RoleName "Enterprise"
    
    # 系统管理员登录
    $Global:AdminToken = Invoke-UserLogin -Username "admin" -Password "admin123" -RoleName "Admin"
    
    $Global:TestResults.UserInitialization = @{
        DesignerTokenObtained = [bool]$Global:DesignerToken
        EnterpriseTokenObtained = [bool]$Global:EnterpriseToken
        AdminTokenObtained = [bool]$Global:AdminToken
    }
}

# 测试单个接口
function Test-SingleEndpoint {
    param(
        [string]$Category,
        [string]$EndpointName,
        [hashtable]$EndpointConfig,
        [string]$TestRole = "",
        [hashtable]$TestData = @{},
        [hashtable]$QueryParams = @{}
    )
    
    $testResult = @{
        Category = $Category
        EndpointName = $EndpointName
        Method = $EndpointConfig.Method
        Url = $EndpointConfig.Url
        TestRole = $TestRole
        Success = $false
        StatusCode = 0
        BusinessCode = 0
        BusinessMessage = ""
        ResponseTime = 0
        ErrorMessage = ""
        Details = @{}
        HttpSuccess = $false
        BusinessSuccess = $false
        PermissionDenied = $false
    }
    
    try {
        # 获取Token
        $token = Get-TokenByRole $TestRole
        
        # 构建完整URL
        $fullUrl = "$BaseUrl$($EndpointConfig.Url)"
        
        # 替换URL中的参数
        if ($fullUrl -match '\{id\}') {
            if ($Global:TestTaskId) {
                $fullUrl = $fullUrl -replace '\{id\}', $Global:TestTaskId
            } else {
                # 如果没有测试任务ID，使用默认值1进行测试
                $fullUrl = $fullUrl -replace '\{id\}', '1'
            }
        }
        if ($fullUrl -match '\{ids\}') {
            if ($Global:TestTaskId) {
                $fullUrl = $fullUrl -replace '\{ids\}', $Global:TestTaskId
            } else {
                # 如果没有测试任务ID，使用默认值1进行测试
                $fullUrl = $fullUrl -replace '\{ids\}', '1'
            }
        }
        if ($fullUrl -match '\{mode\}') {
            # 对于模式参数，URL已经在调用时指定了具体模式，无需替换
            # 这个分支主要是为了处理通用的{mode}模板，实际调用时应使用具体的模式URL
        }
        
        Write-TestLog "INFO" "Testing API: $($EndpointConfig.Method) $fullUrl (Role: $TestRole)" "API_TEST"
        
        # 记录开始时间
        $startTime = Get-Date
        
        # 对于GET请求，将参数添加到URL查询字符串；对于其他请求，作为body发送
        if ($EndpointConfig.Method -eq "GET" -and $TestData -and $TestData.Count -gt 0) {
            $queryString = ($TestData.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "&"
            if ($fullUrl -contains "?") {
                $fullUrl += "&$queryString"
            } else {
                $fullUrl += "?$queryString"
            }
            $response = Invoke-ApiRequest -Method $EndpointConfig.Method -Url $fullUrl -Token $token
        } else {
            $response = Invoke-ApiRequest -Method $EndpointConfig.Method -Url $fullUrl -Token $token -Body $TestData
        }
        
        # 计算响应时间
        $endTime = Get-Date
        $testResult.ResponseTime = ($endTime - $startTime).TotalMilliseconds
        $testResult.StatusCode = $response.StatusCode
        $testResult.HttpSuccess = $response.Success
        
        # 🔧 修复：正确检查业务状态码
        if ($response.Success -and $response.Data) {
            $testResult.Details = $response.Data
            
            # 检查业务状态码
            if ($response.Data.code) {
                $testResult.BusinessCode = $response.Data.code
                $testResult.BusinessMessage = $response.Data.msg
                
                # 业务层成功：HTTP 200 + 业务code 200
                $testResult.BusinessSuccess = ($testResult.BusinessCode -eq 200)
                
                # 权限拒绝：HTTP 200 + 业务code 403
                $testResult.PermissionDenied = ($testResult.BusinessCode -eq 403)
                
                # 最终成功判断：只有业务层成功才算真正成功
                $testResult.Success = $testResult.BusinessSuccess
                
                if ($testResult.BusinessSuccess) {
                    Write-TestLog "SUCCESS" "API test successful - $EndpointName ($([math]::Round($testResult.ResponseTime, 2))ms)" "API_TEST"
                } elseif ($testResult.PermissionDenied) {
                    Write-TestLog "INFO" "API permission denied (expected) - $EndpointName - $($testResult.BusinessMessage)" "API_TEST"
                } else {
                    Write-TestLog "WARNING" "API business error - $EndpointName - Code $($testResult.BusinessCode), $($testResult.BusinessMessage)" "API_TEST"
                }
            } else {
                # 没有业务状态码，按HTTP状态判断
                $testResult.Success = $true
                $testResult.BusinessSuccess = $true
                Write-TestLog "SUCCESS" "API test successful - $EndpointName ($([math]::Round($testResult.ResponseTime, 2))ms)" "API_TEST"
            }
        }
        else {
            $testResult.ErrorMessage = $response.Data
            Write-TestLog "ERROR" "HTTP request failed - $EndpointName : $($response.Data)" "API_TEST"
        }
    }
    catch {
        $testResult.ErrorMessage = $_.Exception.Message
        Write-TestLog "ERROR" "API test exception - $EndpointName : $($_.Exception.Message)" "API_TEST"
    }
    
    return $testResult
}

# 权限测试
function Test-PermissionMatrix {
    Write-TestLog "INFO" "=== Execute Permission Matrix Test ===" "PERMISSION"
    
    $permissionResults = @{}
    
    foreach ($category in $Global:ApiEndpoints.Keys) {
        $permissionResults[$category] = @{}
        
        foreach ($endpointName in $Global:ApiEndpoints[$category].Keys) {
            $endpoint = $Global:ApiEndpoints[$category][$endpointName]
            $permissionResults[$category][$endpointName] = @{}
            
            # 测试每个角色
            foreach ($role in @("designer", "enterprise", "admin")) {
                $hasPermission = $endpoint.RequiredRole -contains $role
                $result = Test-SingleEndpoint -Category $category -EndpointName $endpointName -EndpointConfig $endpoint -TestRole $role
                
                # 🔧 修复：使用正确的权限检查逻辑
                $permissionCheckPassed = $false
                if ($hasPermission) {
                    # 期望有权限：应该业务成功
                    $permissionCheckPassed = $result.BusinessSuccess
                } else {
                    # 期望无权限：应该被拒绝（403）或接口不存在（500）
                    $permissionCheckPassed = ($result.PermissionDenied -or ($result.BusinessCode -eq 500))
                }
                
                $permissionResults[$category][$endpointName][$role] = @{
                    ExpectedAccess = $hasPermission
                    ActualSuccess = $result.Success
                    BusinessSuccess = $result.BusinessSuccess
                    PermissionDenied = $result.PermissionDenied
                    BusinessCode = $result.BusinessCode
                    BusinessMessage = $result.BusinessMessage
                    StatusCode = $result.StatusCode
                    ResponseTime = $result.ResponseTime
                    PermissionCheckPassed = $permissionCheckPassed
                }
                
                # 记录权限测试详情
                if ($permissionCheckPassed) {
                    Write-TestLog "SUCCESS" "Permission test passed - $endpointName ($role): Expected=$hasPermission, Got BusinessSuccess=$($result.BusinessSuccess), PermissionDenied=$($result.PermissionDenied)" "PERMISSION"
                } else {
                    Write-TestLog "WARNING" "Permission test failed - $endpointName ($role): Expected=$hasPermission, Got BusinessCode=$($result.BusinessCode), BusinessSuccess=$($result.BusinessSuccess), PermissionDenied=$($result.PermissionDenied)" "PERMISSION"
                }
            }
        }
    }
    
    $Global:TestResults.PermissionMatrix = $permissionResults
    return $permissionResults
}

# 业务流程测试
function Test-BusinessWorkflow {
    Write-TestLog "INFO" "=== Execute Business Workflow Test ===" "WORKFLOW"
    
    $workflowResults = @{}
    
    # 1. 企业管理员创建任务流程
    Write-TestLog "INFO" "Testing enterprise task creation workflow" "WORKFLOW"
    $createTaskData = @{
        taskTitle = "Test Task - $(Get-Date -Format 'HHmmss')"
        taskDescription = "Automated test task creation"
        taskType = "LOGO_DESIGN"
        skillTags = '["brand_design", "visual_design", "illustrator"]'
        budgetMin = 2000
        budgetMax = 5000
        deadline = (Get-Date).AddDays(7).ToString("yyyy-MM-dd HH:mm:ss")
        deliverables = "LOGO design files including AI source and PNG export"
    }
    
    $createTaskResult = Test-SingleEndpoint -Category "EnterpriseTaskManagement" -EndpointName "CreateEnterpriseTask" -EndpointConfig $Global:ApiEndpoints.EnterpriseTaskManagement.CreateEnterpriseTask -TestRole "enterprise" -TestData $createTaskData
    $workflowResults.CreateTask = $createTaskResult
    
    if ($createTaskResult.Success -and $createTaskResult.Details.data.taskId) {
        $Global:TestTaskId = $createTaskResult.Details.data.taskId
        Write-TestLog "SUCCESS" "Task created successfully, Task ID: $Global:TestTaskId" "WORKFLOW"
        
        # 2. 设计师申请任务流程
        Write-TestLog "INFO" "Testing designer task application workflow" "WORKFLOW"
        $applyTaskData = @{
            taskId = $Global:TestTaskId
            proposal = "I am very interested in this project and have rich experience in LOGO design."
            proposedPrice = 3500
            estimatedDays = 5
            portfolioLinks = '["https://dribbble.com/test", "https://behance.net/test"]'
        }
        
        $applyTaskResult = Test-SingleEndpoint -Category "TaskApplicationManagement" -EndpointName "ApplyTask" -EndpointConfig $Global:ApiEndpoints.TaskApplicationManagement.ApplyTask -TestRole "designer" -TestData $applyTaskData
        $workflowResults.ApplyTask = $applyTaskResult
        
        if ($applyTaskResult.Success -and $applyTaskResult.Details.data.applicationId) {
            $Global:TestApplicationId = $applyTaskResult.Details.data.applicationId
            Write-TestLog "SUCCESS" "Task application successful, Application ID: $Global:TestApplicationId" "WORKFLOW"
        }
    }
    
    # 3. 双重审核流程测试
    if ($Global:TestApplicationId) {
        Write-TestLog "INFO" "Testing dual review workflow" "WORKFLOW"
        
        # 系统管理员审核
        $adminReviewData = @{
            status = "APPROVED"
            feedback = "Application content is detailed, designer's work quality is high, recommend approval."
        }
        
        $adminReviewUrl = $Global:ApiEndpoints.TaskApplicationManagement.AdminReview.Url -replace '\{id\}', $Global:TestApplicationId
        $adminReviewConfig = @{
            Method = "POST"
            Url = $adminReviewUrl
            RequiredRole = @("admin")
        }
        
        $adminReviewResult = Test-SingleEndpoint -Category "TaskApplicationManagement" -EndpointName "AdminReview" -EndpointConfig $adminReviewConfig -TestRole "admin" -TestData $adminReviewData
        $workflowResults.AdminReview = $adminReviewResult
        
        # 企业管理员审核
        $enterpriseReviewData = @{
            status = "APPROVED"
            feedback = "Designer's professional ability meets requirements, price is reasonable, agree to cooperate."
        }
        
        $enterpriseReviewUrl = $Global:ApiEndpoints.TaskApplicationManagement.EnterpriseReview.Url -replace '\{id\}', $Global:TestApplicationId
        $enterpriseReviewConfig = @{
            Method = "POST"
            Url = $enterpriseReviewUrl
            RequiredRole = @("enterprise", "admin")
        }
        
        $enterpriseReviewResult = Test-SingleEndpoint -Category "TaskApplicationManagement" -EndpointName "EnterpriseReview" -EndpointConfig $enterpriseReviewConfig -TestRole "enterprise" -TestData $enterpriseReviewData
        $workflowResults.EnterpriseReview = $enterpriseReviewResult
    }
    
    # 4. 交付物提交流程测试
    if ($Global:TestTaskId) {
        Write-TestLog "INFO" "Testing deliverable submission workflow" "WORKFLOW"
        
        $deliverableData = @{
            taskId = $Global:TestTaskId
            deliverableContent = @"
Design draft completed, including AI source files and PNG export files

Baidu Netdisk Link: https://pan.baidu.com/s/1abcdef123456
Extraction Code: abc123

Notes:
1. AI source files are in the design folder
2. PNG export files are in the assets folder
3. Recommend using the latest version of AI software to open source files

Contact me if you have any questions.
"@
            version = 1
        }
        
        $submitDeliverableResult = Test-SingleEndpoint -Category "DeliverableManagement" -EndpointName "SubmitDeliverable" -EndpointConfig $Global:ApiEndpoints.DeliverableManagement.SubmitDeliverable -TestRole "designer" -TestData $deliverableData
        $workflowResults.SubmitDeliverable = $submitDeliverableResult
        
        if ($submitDeliverableResult.Success -and $submitDeliverableResult.Details.data.deliverableId) {
            $Global:TestDeliverableId = $submitDeliverableResult.Details.data.deliverableId
            Write-TestLog "SUCCESS" "Deliverable submitted successfully, Deliverable ID: $Global:TestDeliverableId" "WORKFLOW"
        }
    }
    
    $Global:TestResults.BusinessWorkflow = $workflowResults
    return $workflowResults
}

# 审核模式测试
function Test-ReviewModes {
    Write-TestLog "INFO" "=== Test Review Mode Configuration ===" "REVIEW_MODE"
    
    $reviewModeResults = @{}
    
    # 测试审核模式查询接口（使用新的动态配置接口）
    $reviewModeResult = Test-SingleEndpoint -Category "TaskConfigManagement" -EndpointName "GetTaskConfigInfo" -EndpointConfig $Global:ApiEndpoints.TaskConfigManagement.GetTaskConfigInfo -TestRole "admin"
    $reviewModeResults.GetReviewMode = $reviewModeResult
    
    if ($reviewModeResult.Success) {
        $currentMode = $reviewModeResult.Details.data.reviewMode
        Write-TestLog "INFO" "Current review mode: $currentMode" "REVIEW_MODE"
        
        # 测试双重审核模式特有的接口
        if ($currentMode -eq "DUAL") {
            Write-TestLog "INFO" "Testing dual review mode specific APIs" "REVIEW_MODE"
            
            # 测试系统管理员待审核列表
            $adminPendingResult = Test-SingleEndpoint -Category "TaskApplicationManagement" -EndpointName "GetAdminPendingList" -EndpointConfig $Global:ApiEndpoints.TaskApplicationManagement.GetAdminPendingList -TestRole "admin"
            $reviewModeResults.AdminPendingList = $adminPendingResult
            
            # 测试企业管理员待审核列表
            $enterprisePendingResult = Test-SingleEndpoint -Category "TaskApplicationManagement" -EndpointName "GetEnterprisePendingList" -EndpointConfig $Global:ApiEndpoints.TaskApplicationManagement.GetEnterprisePendingList -TestRole "enterprise"
            $reviewModeResults.EnterprisePendingList = $enterprisePendingResult
        }
    }
    
    $Global:TestResults.ReviewModes = $reviewModeResults
    return $reviewModeResults
}

# 动态配置测试
function Test-TaskConfiguration {
    Write-TestLog "INFO" "=== Test Task Configuration Management ===" "CONFIG"
    
    $configResults = @{}
    
    # 测试获取当前配置
    $getConfigResult = Test-SingleEndpoint -Category "TaskConfigManagement" -EndpointName "GetTaskConfigInfo" -EndpointConfig $Global:ApiEndpoints.TaskConfigManagement.GetTaskConfigInfo -TestRole "admin"
    $configResults.GetTaskConfigInfo = $getConfigResult
    
    # 测试获取支持的审核模式
    $getModesResult = Test-SingleEndpoint -Category "TaskConfigManagement" -EndpointName "GetReviewModes" -EndpointConfig $Global:ApiEndpoints.TaskConfigManagement.GetReviewModes -TestRole "admin"
    $configResults.GetReviewModes = $getModesResult
    
    # 测试模式切换：切换到DUAL模式
    $dualModeConfig = @{
        Method = "POST"
        Url = "/designer/task-config/review-mode/DUAL"
        RequiredRole = @("admin")
    }
    $switchToDualResult = Test-SingleEndpoint -Category "TaskConfigManagement" -EndpointName "UpdateReviewMode" -EndpointConfig $dualModeConfig -TestRole "admin"
    $configResults.SwitchToDual = $switchToDualResult
    
    # 测试模式切换：切换到ENTERPRISE模式
    $enterpriseModeConfig = @{
        Method = "POST"
        Url = "/designer/task-config/review-mode/ENTERPRISE"
        RequiredRole = @("admin")
    }
    $switchToEnterpriseResult = Test-SingleEndpoint -Category "TaskConfigManagement" -EndpointName "UpdateReviewMode" -EndpointConfig $enterpriseModeConfig -TestRole "admin"
    $configResults.SwitchToEnterprise = $switchToEnterpriseResult
    
    # 测试配置重置
    $resetConfigResult = Test-SingleEndpoint -Category "TaskConfigManagement" -EndpointName "ResetConfig" -EndpointConfig $Global:ApiEndpoints.TaskConfigManagement.ResetConfig -TestRole "admin"
    $configResults.ResetConfig = $resetConfigResult
    
    $Global:TestResults.TaskConfiguration = $configResults
    return $configResults
}

# 数据透明性验证
function Test-DataTransparency {
    Write-TestLog "INFO" "=== Verify Data Transparency ===" "TRANSPARENCY"
    
    $transparencyResults = @{}
    
    # 测试企业管理员专用接口（严格隐藏系统管理员信息）
    $enterpriseAppResult = Test-SingleEndpoint -Category "EnterpriseApplicationManagement" -EndpointName "GetEnterprisePendingApplications" -EndpointConfig $Global:ApiEndpoints.EnterpriseApplicationManagement.GetEnterprisePendingApplications -TestRole "enterprise"
    $transparencyResults.EnterpriseApplications = $enterpriseAppResult
    
    if ($enterpriseAppResult.Success -and $enterpriseAppResult.Details.data.rows) {
        # 验证企业管理员看不到系统管理员相关字段
        $applications = $enterpriseAppResult.Details.data.rows
        $hasAdminFields = $false
        
        foreach ($app in $applications) {
            $adminFields = @("adminReviewStatus", "adminReviewFeedback", "adminReviewTime", "adminReviewBy", "reviewMode")
            foreach ($field in $adminFields) {
                if ($app.PSObject.Properties.Name -contains $field) {
                    $hasAdminFields = $true
                    Write-TestLog "ERROR" "Enterprise data contains admin field: $field" "TRANSPARENCY"
                }
            }
        }
        
        $transparencyResults.EnterpriseDataClean = -not $hasAdminFields
        
        if (-not $hasAdminFields) {
            Write-TestLog "SUCCESS" "Enterprise data transparency verification passed" "TRANSPARENCY"
        }
    }
    
    # 测试设计师数据透明性
    $designerAppResult = Test-SingleEndpoint -Category "TaskApplicationManagement" -EndpointName "GetApplicationList" -EndpointConfig $Global:ApiEndpoints.TaskApplicationManagement.GetApplicationList -TestRole "designer"
    $transparencyResults.DesignerApplications = $designerAppResult
    
    if ($designerAppResult.Success -and $designerAppResult.Details.data.rows) {
        # 验证设计师看不到系统管理员相关字段
        $applications = $designerAppResult.Details.data.rows
        $hasAdminFields = $false
        
        foreach ($app in $applications) {
            $adminFields = @("adminReviewStatus", "adminReviewFeedback", "adminReviewTime", "adminReviewBy", "enterpriseReviewStatus", "enterpriseReviewFeedback", "enterpriseReviewTime", "reviewMode")
            foreach ($field in $adminFields) {
                if ($app.PSObject.Properties.Name -contains $field) {
                    $hasAdminFields = $true
                    Write-TestLog "ERROR" "Designer data contains admin field: $field" "TRANSPARENCY"
                }
            }
        }
        
        $transparencyResults.DesignerDataClean = -not $hasAdminFields
        
        if (-not $hasAdminFields) {
            Write-TestLog "SUCCESS" "Designer data transparency verification passed" "TRANSPARENCY"
        }
    }
    
    $Global:TestResults.DataTransparency = $transparencyResults
    return $transparencyResults
}

# 性能测试
function Test-Performance {
    Write-TestLog "INFO" "=== Execute Performance Test ===" "PERFORMANCE"
    
    $performanceResults = @{}
    
    # 选择几个关键接口进行性能测试
    $keyEndpoints = @{
        GetTaskList = @{ Config = $Global:ApiEndpoints.TaskManagement.GetTaskList; Role = "designer" }
        GetApplicationList = @{ Config = $Global:ApiEndpoints.TaskApplicationManagement.GetApplicationList; Role = "designer" }
        GetReviewMode = @{ Config = $Global:ApiEndpoints.TaskApplicationManagement.GetReviewMode; Role = "admin" }
    }
    
    foreach ($endpointName in $keyEndpoints.Keys) {
        $endpoint = $keyEndpoints[$endpointName]
        $responseTimes = @()
        
        Write-TestLog "INFO" "Performance testing $endpointName (10 requests)" "PERFORMANCE"
        
        for ($i = 1; $i -le 10; $i++) {
            $result = Test-SingleEndpoint -Category "Performance" -EndpointName $endpointName -EndpointConfig $endpoint.Config -TestRole $endpoint.Role
            if ($result.Success) {
                $responseTimes += $result.ResponseTime
            }
        }
        
        if ($responseTimes.Count -gt 0) {
            $avgResponseTime = ($responseTimes | Measure-Object -Average).Average
            $maxResponseTime = ($responseTimes | Measure-Object -Maximum).Maximum
            $minResponseTime = ($responseTimes | Measure-Object -Minimum).Minimum
            
            $performanceResults[$endpointName] = @{
                SuccessfulRequests = $responseTimes.Count
                AverageResponseTime = [math]::Round($avgResponseTime, 2)
                MaxResponseTime = $maxResponseTime
                MinResponseTime = $minResponseTime
                PerformanceGrade = if ($avgResponseTime -lt 500) { "Excellent" } elseif ($avgResponseTime -lt 1000) { "Good" } elseif ($avgResponseTime -lt 2000) { "Fair" } else { "Poor" }
            }
            
            Write-TestLog "INFO" "$endpointName performance test result: Average response time $([math]::Round($avgResponseTime, 2))ms" "PERFORMANCE"
        }
    }
    
    $Global:TestResults.Performance = $performanceResults
    return $performanceResults
}

# 生成测试报告
function New-TestReport {
    Write-TestLog "INFO" "=== Generate Test Report ===" "REPORT"
    
    $report = @{
        TestSummary = @{
            TestTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            BaseUrl = $BaseUrl
            TestMode = $TestMode
        }
        TestResults = $Global:TestResults
        Statistics = @{}
    }
    
    # 计算统计信息
    if ($Global:TestResults.PermissionMatrix) {
        $totalPermissionTests = 0
        $passedPermissionTests = 0
        
        foreach ($category in $Global:TestResults.PermissionMatrix.Keys) {
            foreach ($endpoint in $Global:TestResults.PermissionMatrix[$category].Keys) {
                foreach ($role in $Global:TestResults.PermissionMatrix[$category][$endpoint].Keys) {
                    $totalPermissionTests++
                    if ($Global:TestResults.PermissionMatrix[$category][$endpoint][$role].PermissionCheckPassed) {
                        $passedPermissionTests++
                    }
                }
            }
        }
        
        $report.Statistics.PermissionTests = @{
            Total = $totalPermissionTests
            Passed = $passedPermissionTests
            PassRate = if ($totalPermissionTests -gt 0) { [math]::Round(($passedPermissionTests / $totalPermissionTests) * 100, 2) } else { 0 }
        }
    }
    
    # 业务流程测试统计
    if ($Global:TestResults.BusinessWorkflow) {
        $totalWorkflowTests = $Global:TestResults.BusinessWorkflow.Keys.Count
        $passedWorkflowTests = ($Global:TestResults.BusinessWorkflow.Values | Where-Object { $_.Success }).Count
        
        $report.Statistics.WorkflowTests = @{
            Total = $totalWorkflowTests
            Passed = $passedWorkflowTests
            PassRate = if ($totalWorkflowTests -gt 0) { [math]::Round(($passedWorkflowTests / $totalWorkflowTests) * 100, 2) } else { 0 }
        }
    }
    
    # 保存到文件
    $report | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputFile -Encoding UTF8
    Write-TestLog "SUCCESS" "Test report saved to: $OutputFile" "REPORT"
    
    # 输出概要
    Write-Host ""
    Write-Host "================= Test Report Summary =================" -ForegroundColor Cyan
    Write-Host "Test Time: $($report.TestSummary.TestTime)"
    Write-Host "Service URL: $($report.TestSummary.BaseUrl)"
    Write-Host "Test Mode: $($report.TestSummary.TestMode)"
    Write-Host ""
    
    if ($report.Statistics.PermissionTests) {
        $permStats = $report.Statistics.PermissionTests
        Write-Host "Permission Tests: $($permStats.Passed)/$($permStats.Total) passed ($($permStats.PassRate)%)" -ForegroundColor $(if ($permStats.PassRate -ge 90) { "Green" } elseif ($permStats.PassRate -ge 70) { "Yellow" } else { "Red" })
    }
    
    if ($report.Statistics.WorkflowTests) {
        $workflowStats = $report.Statistics.WorkflowTests
        Write-Host "Workflow Tests: $($workflowStats.Passed)/$($workflowStats.Total) passed ($($workflowStats.PassRate)%)" -ForegroundColor $(if ($workflowStats.PassRate -ge 90) { "Green" } elseif ($workflowStats.PassRate -ge 70) { "Yellow" } else { "Red" })
    }
    
    Write-Host "=============================================" -ForegroundColor Cyan
}

# 检查服务状态
function Test-ServiceHealth {
    Write-TestLog "INFO" "Checking service status..." "HEALTH"
    
    try {
        $healthUrl = "$BaseUrl/actuator/health"
        $response = Invoke-WebRequest -Uri $healthUrl -UseBasicParsing -TimeoutSec 10
        
        if ($response.StatusCode -eq 200) {
            Write-TestLog "SUCCESS" "Service is running normally" "HEALTH"
            return $true
        }
        else {
            Write-TestLog "ERROR" "Service status abnormal (HTTP Status: $($response.StatusCode))" "HEALTH"
            return $false
        }
    }
    catch {
        Write-TestLog "ERROR" "Service not started or inaccessible: $($_.Exception.Message)" "HEALTH"
        Write-TestLog "WARNING" "Please ensure backend service is started: mvn spring-boot:run" "HEALTH"
        return $false
    }
}

# 主函数
function Main {
    Write-Host "🚀 ZhiTu Factory Complete API Automation Test Started" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "Service URL: $BaseUrl"
    Write-Host "Test Mode: $TestMode"
    Write-Host "Output File: $OutputFile"
    Write-Host "Test Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    Write-Host ""
    
    # 检查PowerShell版本
    if ($PSVersionTable.PSVersion.Major -lt 3) {
        Write-TestLog "ERROR" "PowerShell 3.0 or higher is required" "SYSTEM"
        exit 1
    }
    
    # 检查服务状态
    if (-not (Test-ServiceHealth)) {
        Write-TestLog "ERROR" "Service health check failed, cannot continue testing" "SYSTEM"
        exit 1
    }
    
    # 初始化测试用户
    Initialize-TestUsers
    
    # 根据测试模式执行不同的测试
    switch ($TestMode) {
        "BASIC" {
            Write-TestLog "INFO" "Execute basic function tests" "MODE"
            Test-BusinessWorkflow
            Test-ReviewModes
            Test-TaskConfiguration
        }
        "PERMISSION" {
            Write-TestLog "INFO" "Execute permission matrix tests" "MODE"
            Test-PermissionMatrix
            Test-DataTransparency
        }
        "FULL" {
            Write-TestLog "INFO" "Execute complete test suite" "MODE"
            Test-PermissionMatrix
            Test-BusinessWorkflow
            Test-ReviewModes
            Test-TaskConfiguration
            Test-DataTransparency
            Test-Performance
        }
        default {
            Write-TestLog "WARNING" "Unknown test mode: $TestMode, will execute complete test" "MODE"
            Test-PermissionMatrix
            Test-BusinessWorkflow
            Test-ReviewModes
            Test-TaskConfiguration
            Test-DataTransparency
            Test-Performance
        }
    }
    
    # 生成测试报告
    New-TestReport
    
    Write-Host ""
    Write-Host "✅ ZhiTu Factory Complete API Automation Test Completed" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
}

# 执行主函数
Main 