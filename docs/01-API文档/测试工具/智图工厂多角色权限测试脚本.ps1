# 智图工厂多角色权限测试脚本 - 支持超级管理员检测
# 解决admin用户具有多角色（superadmin + admin）的权限测试问题
# 
# 使用方法: .\智图工厂多角色权限测试脚本.ps1 [-BaseUrl "http://localhost:6039"]

param(
    [string]$BaseUrl = "http://localhost:6039",
    [string]$OutputFile = "Multi_Role_Permission_Test_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"
)

# 全局变量
$Global:TestResults = @{}
$Global:UserTokens = @{}
$Global:UserRoleInfo = @{}

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
        [object]$Body = $null
    )
    
    $headers = @{
        "Content-Type" = "application/json"
    }
    
    if ($Token) {
        $headers["Authorization"] = "Bearer $Token"
    }
    
    try {
        $params = @{
            Uri = $Url
            Method = $Method
            Headers = $headers
            UseBasicParsing = $true
        }
        
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

# 增强的用户登录和角色分析
function Invoke-EnhancedUserLogin {
    param(
        [string]$Username,
        [string]$Password,
        [string]$UserType
    )
    
    Write-TestLog "INFO" "Login user: $Username ($UserType)" "LOGIN"
    
    $loginData = @{
        username = $Username
        password = $Password
    }
    
    $response = Invoke-ApiRequest -Method "POST" -Url "$BaseUrl/auth/login" -Body $loginData
    
    if ($response.Success -and $response.Data.code -eq 200) {
        $userInfo = $response.Data.data.userInfo
        $token = $response.Data.data.access_token
        
        # 详细分析用户角色信息
        $roleAnalysis = @{
            Username = $Username
            UserType = $UserType
            Token = $token
            UserId = $userInfo.userId
            Roles = @()
            RoleKeys = @()
            RoleNames = @()
            MenuPermissions = $userInfo.menuPermission
            RolePermissions = $userInfo.rolePermission
            IsSuperAdmin = $false
            HasWildcardPermission = $false
        }
        
        # 分析角色信息
        if ($userInfo.roles) {
            foreach ($role in $userInfo.roles) {
                $roleAnalysis.Roles += $role
                $roleAnalysis.RoleKeys += $role.roleKey
                $roleAnalysis.RoleNames += $role.roleName
                
                # 检查是否为超级管理员
                if ($role.roleKey -eq "superadmin") {
                    $roleAnalysis.IsSuperAdmin = $true
                }
            }
        }
        
        # 检查是否有通配符权限
        if ($userInfo.menuPermission -contains "*:*:*") {
            $roleAnalysis.HasWildcardPermission = $true
        }
        
        $Global:UserTokens[$UserType] = $token
        $Global:UserRoleInfo[$UserType] = $roleAnalysis
        
        Write-TestLog "SUCCESS" "$UserType login successful - Roles: $($roleAnalysis.RoleKeys -join ', ')" "LOGIN"
        Write-TestLog "INFO" "SuperAdmin: $($roleAnalysis.IsSuperAdmin), WildcardPerm: $($roleAnalysis.HasWildcardPermission)" "LOGIN"
        
        return $token
    }
    else {
        Write-TestLog "ERROR" "$UserType login failed: $($response.Data)" "LOGIN"
        return ""
    }
}

# 初始化测试用户
function Initialize-TestUsers {
    Write-TestLog "INFO" "=== Initialize Test Users with Role Analysis ===" "INIT"
    
    # 登录并分析各个用户的角色
    Invoke-EnhancedUserLogin -Username "designer_test" -Password "admin123" -UserType "designer"
    Invoke-EnhancedUserLogin -Username "enterprise_test" -Password "admin123" -UserType "enterprise"  
    Invoke-EnhancedUserLogin -Username "admin" -Password "admin123" -UserType "admin"
    
    # 输出详细的角色分析报告
    Write-Host ""
    Write-Host "=== User Role Analysis Report ===" -ForegroundColor Cyan
    
    foreach ($userType in $Global:UserRoleInfo.Keys) {
        $roleInfo = $Global:UserRoleInfo[$userType]
        Write-Host "User: $($roleInfo.Username) ($userType)" -ForegroundColor Yellow
        Write-Host "  Roles: $($roleInfo.RoleNames -join ', ')"
        Write-Host "  Role Keys: $($roleInfo.RoleKeys -join ', ')"
        Write-Host "  Super Admin: $($roleInfo.IsSuperAdmin)"
        Write-Host "  Wildcard Permission: $($roleInfo.HasWildcardPermission)"
        Write-Host "  Menu Permissions: $($roleInfo.MenuPermissions -join ', ')"
        Write-Host ""
    }
}

# 智能权限预期计算
function Get-ExpectedPermission {
    param(
        [string]$UserType,
        [array]$RequiredRoles
    )
    
    $roleInfo = $Global:UserRoleInfo[$UserType]
    
    if (-not $roleInfo) {
        return $false
    }
    
    # 超级管理员拥有所有权限
    if ($roleInfo.IsSuperAdmin -or $roleInfo.HasWildcardPermission) {
        return $true
    }
    
    # 检查是否有任何一个所需角色
    foreach ($requiredRole in $RequiredRoles) {
        if ($roleInfo.RoleKeys -contains $requiredRole) {
            return $true
        }
    }
    
    return $false
}

# 智能权限测试
function Test-IntelligentPermission {
    Write-TestLog "INFO" "=== Execute Intelligent Permission Test ===" "PERMISSION"
    
    # 定义测试接口（简化版，重点关注权限逻辑）
    $testEndpoints = @{
        "TaskConfigManagement" = @{
            "GetTaskConfigInfo" = @{
                Method = "GET"
                Url = "/designer/task-config/info"
                RequiredRoles = @("admin")
                Description = "获取任务配置信息"
            }
            "UpdateReviewMode" = @{
                Method = "POST" 
                Url = "/designer/task-config/review-mode/DUAL"
                RequiredRoles = @("admin")
                Description = "更新审核模式"
            }
        }
        "TaskManagement" = @{
            "GetTaskList" = @{
                Method = "GET"
                Url = "/designer/task/list"
                RequiredRoles = @("designer", "enterprise", "admin")
                Description = "查询任务列表"
            }
        }
        "TaskApplication" = @{
            "GetApplicationList" = @{
                Method = "GET"
                Url = "/designer/task-application/list"
                RequiredRoles = @("designer", "enterprise", "admin")
                Description = "查询申请列表"
            }
        }
    }
    
    $permissionResults = @{}
    
    foreach ($category in $testEndpoints.Keys) {
        $permissionResults[$category] = @{}
        
        foreach ($endpointName in $testEndpoints[$category].Keys) {
            $endpoint = $testEndpoints[$category][$endpointName]
            $permissionResults[$category][$endpointName] = @{}
            
            # 测试每个用户类型
            foreach ($userType in @("designer", "enterprise", "admin")) {
                $token = $Global:UserTokens[$userType]
                $expectedPermission = Get-ExpectedPermission -UserType $userType -RequiredRoles $endpoint.RequiredRoles
                
                if ($token) {
                    Write-TestLog "INFO" "Testing $endpointName with $userType (Expected: $expectedPermission)" "PERMISSION"
                    
                    $fullUrl = "$BaseUrl$($endpoint.Url)"
                    $response = Invoke-ApiRequest -Method $endpoint.Method -Url $fullUrl -Token $token
                    
                    $actualSuccess = $false
                    $businessCode = 0
                    $businessMessage = ""
                    $permissionDenied = $false
                    
                    if ($response.Success -and $response.Data) {
                        $businessCode = $response.Data.code
                        $businessMessage = $response.Data.msg
                        $actualSuccess = ($businessCode -eq 200)
                        $permissionDenied = ($businessCode -eq 403)
                    }
                    
                    # 智能权限检查结果评估
                    $permissionCheckPassed = $false
                    if ($expectedPermission) {
                        # 期望有权限：应该成功
                        $permissionCheckPassed = $actualSuccess
                    } else {
                        # 期望无权限：应该被拒绝
                        $permissionCheckPassed = $permissionDenied
                    }
                    
                    $permissionResults[$category][$endpointName][$userType] = @{
                        ExpectedPermission = $expectedPermission
                        ActualSuccess = $actualSuccess
                        PermissionDenied = $permissionDenied
                        BusinessCode = $businessCode
                        BusinessMessage = $businessMessage
                        PermissionCheckPassed = $permissionCheckPassed
                        UserRoleInfo = $Global:UserRoleInfo[$userType]
                    }
                    
                    # 输出测试结果
                    $statusColor = if ($permissionCheckPassed) { "Green" } else { "Red" }
                    $status = if ($permissionCheckPassed) { "PASS" } else { "FAIL" }
                    Write-Host "  [$status] $userType -> ${endpointName}: Expected=$expectedPermission, Actual=$actualSuccess" -ForegroundColor $statusColor
                }
            }
        }
    }
    
    $Global:TestResults.IntelligentPermission = $permissionResults
    return $permissionResults
}

# 生成智能测试报告
function New-IntelligentTestReport {
    Write-TestLog "INFO" "=== Generate Intelligent Test Report ===" "REPORT"
    
    $report = @{
        TestSummary = @{
            TestTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            BaseUrl = $BaseUrl
            TestType = "Multi-Role Permission Analysis"
        }
        UserRoleAnalysis = $Global:UserRoleInfo
        TestResults = $Global:TestResults
        Statistics = @{}
    }
    
    # 计算统计信息
    if ($Global:TestResults.IntelligentPermission) {
        $totalTests = 0
        $passedTests = 0
        $superAdminCorrectTests = 0
        $regularUserCorrectTests = 0
        
        foreach ($category in $Global:TestResults.IntelligentPermission.Keys) {
            foreach ($endpoint in $Global:TestResults.IntelligentPermission[$category].Keys) {
                foreach ($userType in $Global:TestResults.IntelligentPermission[$category][$endpoint].Keys) {
                    $result = $Global:TestResults.IntelligentPermission[$category][$endpoint][$userType]
                    $totalTests++
                    
                    if ($result.PermissionCheckPassed) {
                        $passedTests++
                        
                        # 区分超级管理员和普通用户的正确测试
                        if ($result.UserRoleInfo.IsSuperAdmin) {
                            $superAdminCorrectTests++
                        } else {
                            $regularUserCorrectTests++
                        }
                    }
                }
            }
        }
        
        $report.Statistics = @{
            TotalPermissionTests = $totalTests
            PassedPermissionTests = $passedTests
            OverallPassRate = if ($totalTests -gt 0) { [math]::Round(($passedTests / $totalTests) * 100, 2) } else { 0 }
            SuperAdminCorrectTests = $superAdminCorrectTests
            RegularUserCorrectTests = $regularUserCorrectTests
        }
    }
    
    # 保存到文件
    $report | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputFile -Encoding UTF8
    Write-TestLog "SUCCESS" "Test report saved to: $OutputFile" "REPORT"
    
    # 输出概要
    Write-Host ""
    Write-Host "================= Multi-Role Permission Test Report =================" -ForegroundColor Cyan
    Write-Host "Test Time: $($report.TestSummary.TestTime)"
    Write-Host "Service URL: $($report.TestSummary.BaseUrl)"
    Write-Host ""
    
    # 用户角色概要
    Write-Host "User Role Summary:" -ForegroundColor Yellow
    foreach ($userType in $Global:UserRoleInfo.Keys) {
        $roleInfo = $Global:UserRoleInfo[$userType]
        $adminStatus = if ($roleInfo.IsSuperAdmin) { " (SUPER ADMIN)" } else { "" }
        Write-Host "  ${userType}: $($roleInfo.RoleKeys -join ', ')$adminStatus"
    }
    Write-Host ""
    
    if ($report.Statistics) {
        $stats = $report.Statistics
        Write-Host "Permission Test Results:" -ForegroundColor Yellow
        Write-Host "  Total Tests: $($stats.TotalPermissionTests)"
        Write-Host "  Passed Tests: $($stats.PassedPermissionTests)"
        Write-Host "  Pass Rate: $($stats.OverallPassRate)%" -ForegroundColor $(if ($stats.OverallPassRate -ge 90) { "Green" } elseif ($stats.OverallPassRate -ge 70) { "Yellow" } else { "Red" })
        Write-Host "  Super Admin Correct: $($stats.SuperAdminCorrectTests)"
        Write-Host "  Regular User Correct: $($stats.RegularUserCorrectTests)"
    }
    
    Write-Host "=============================================" -ForegroundColor Cyan
}

# 主函数
function Main {
    Write-Host "🔍 Multi-Role Permission Analysis for ZhiTu Factory" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "Analyzing admin user's multiple roles (superadmin + admin)" -ForegroundColor Yellow
    Write-Host ""
    
    # 初始化用户并分析角色
    Initialize-TestUsers
    
    # 执行智能权限测试
    Test-IntelligentPermission
    
    # 生成智能测试报告
    New-IntelligentTestReport
    
    Write-Host ""
    Write-Host "✅ Multi-Role Permission Analysis Completed" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
}

# 执行主函数
Main 