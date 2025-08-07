package org.ruoyi.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ObjectUtil;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.constant.UserConstants;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.domain.dto.RoleDTO;
import org.ruoyi.common.core.domain.model.LoginUser;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.core.utils.StreamUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.excel.core.ExcelResult;
import org.ruoyi.common.excel.utils.ExcelUtil;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.tenant.helper.TenantHelper;
import org.ruoyi.common.core.constant.GlobalConstants;

import org.ruoyi.common.redis.utils.RedisUtils;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.system.domain.bo.SysDeptBo;
import org.ruoyi.system.domain.bo.SysUserBo;
import org.ruoyi.system.domain.request.UserRequest;
import org.ruoyi.system.domain.request.BindPhoneRequest;
import org.ruoyi.system.domain.vo.*;
import org.ruoyi.system.listener.SysUserImportListener;
import org.ruoyi.system.service.*;
import org.ruoyi.system.mapper.SysUserRoleMapper;
import org.ruoyi.system.mapper.SysRoleMapper;
import org.ruoyi.system.domain.SysUserRole;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户信息
 *
 * @author Lion Li
 */
@Slf4j
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/user")
public class SysUserController extends BaseController {

    private final ISysUserService userService;
    private final ISysRoleService roleService;
    private final ISysPostService postService;
    private final ISysDeptService deptService;
    private final ISysTenantService tenantService;
    private final ISysOssService ossService;
    private final ISysPermissionService permissionService;
    private final SysUserRoleMapper userRoleMapper;
    private final SysRoleMapper roleMapper;
    /**
     * 获取用户列表
     */
    @SaCheckPermission("system:user:list")
    @GetMapping("/list")
    public TableDataInfo<SysUserVo> list(SysUserBo user, PageQuery pageQuery) {
        return userService.selectPageUserList(user, pageQuery);
    }

    /**
     * 获取用户列表
     */
    @GetMapping("/getUserOption")
    public R<List<SysUserOptionVo>> getUserOption() {
        List<SysUserVo> sysUserVos = userService.selectUserList(new SysUserBo());
        List<SysUserOptionVo> collect = sysUserVos.stream()
            .map(this::convertToUserOptionVo)
            .collect(Collectors.toList());
        return R.ok(collect);
    }

    private SysUserOptionVo convertToUserOptionVo(SysUserVo sysUserVo) {
        SysUserOptionVo sysUserOptionVo = new SysUserOptionVo();
        sysUserOptionVo.setUserId(sysUserVo.getUserId());
        sysUserOptionVo.setName(sysUserVo.getNickName());
        return sysUserOptionVo;
    }

    /**
     * 导出用户列表
     */
    @Log(title = "用户管理", businessType = BusinessType.EXPORT)
    @SaCheckPermission("system:user:export")
    @PostMapping("/export")
    public void export(SysUserBo user, HttpServletResponse response) {
        List<SysUserVo> list = userService.selectUserList(user);
        List<SysUserExportVo> listVo = MapstructUtils.convert(list, SysUserExportVo.class);
        ExcelUtil.exportExcel(listVo, "用户数据", SysUserExportVo.class, response);
    }

    /**
     * 导入数据
     *
     * @param file          导入文件
     * @param updateSupport 是否更新已存在数据
     */
    @Log(title = "用户管理", businessType = BusinessType.IMPORT)
    @SaCheckPermission("system:user:import")
    @PostMapping(value = "/importData", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<Void> importData(@RequestPart("file") MultipartFile file, boolean updateSupport) throws Exception {
        ExcelResult<SysUserImportVo> result = ExcelUtil.importExcel(file.getInputStream(), SysUserImportVo.class, new SysUserImportListener(updateSupport));
        return R.ok(result.getAnalysis());
    }

    /**
     * 获取导入模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil.exportExcel(new ArrayList<>(), "用户数据", SysUserImportVo.class, response);
    }

    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    @GetMapping("/getInfo")
    public R<UserInfoVo> getInfo() {
        UserInfoVo userInfoVo = new UserInfoVo();
        LoginUser loginUser = LoginHelper.getLoginUser();
        if (TenantHelper.isEnable() && LoginHelper.isSuperAdmin()) {
            // 超级管理员 如果重新加载用户信息需清除动态租户
            TenantHelper.clearDynamic();
        }
        SysUserVo user = userService.selectUserById(loginUser.getUserId());
        userInfoVo.setUser(user);
        userInfoVo.setPermissions(loginUser.getMenuPermission());
        userInfoVo.setRoles(loginUser.getRolePermission());
        return R.ok(userInfoVo);
    }

    /**
     * 根据用户编号获取详细信息
     *
     * @param userId 用户ID
     */
    @SaCheckPermission("system:user:query")
    @GetMapping(value = {"/", "/{userId}"})
    public R<SysUserInfoVo> getInfo(@PathVariable(value = "userId", required = false) Long userId) {
        userService.checkUserDataScope(userId);
        SysUserInfoVo userInfoVo = new SysUserInfoVo();
        List<SysRoleVo> roles = roleService.selectRoleAll();
        userInfoVo.setRoles(LoginHelper.isSuperAdmin(userId) ? roles : StreamUtils.filter(roles, r -> !r.isSuperAdmin()));
        userInfoVo.setPosts(postService.selectPostAll());
        if (ObjectUtil.isNotNull(userId)) {
            SysUserVo sysUser = userService.selectUserById(userId);
            userInfoVo.setUser(sysUser);
            userInfoVo.setRoleIds(StreamUtils.toList(sysUser.getRoles(), SysRoleVo::getRoleId));
            userInfoVo.setPostIds(postService.selectPostListByUserId(userId));
        }
        return R.ok(userInfoVo);
    }

    /**
     * 新增用户
     */
    @SaCheckPermission("system:user:add")
    @Log(title = "用户管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody SysUserBo user) {
        if (!userService.checkUserNameUnique(user)) {
            return R.fail("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
        } else if (StringUtils.isNotEmpty(user.getPhonenumber()) && !userService.checkPhoneUnique(user)) {
            return R.fail("新增用户'" + user.getUserName() + "'失败，手机号码已存在");
        } else if (StringUtils.isNotEmpty(user.getEmail()) && !userService.checkEmailUnique(user)) {
            return R.fail("新增用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        if (TenantHelper.isEnable()) {
            if (!tenantService.checkAccountBalance(TenantHelper.getTenantId())) {
                return R.fail("当前租户下用户名额不足，请联系管理员");
            }
        }
        if(StringUtils.isEmpty(user.getPassword())){
            user.setPassword("123456");
        }
        if(StringUtils.isEmpty(user.getNickName())){
            user.setNickName(user.getUserName());
        }
        user.setDeptId(103L);
        user.setPassword(BCrypt.hashpw(user.getPassword()));
        return toAjax(userService.insertUser(user));
    }

    /**
     * 修改用户
     */
    @SaCheckPermission("system:user:edit")
    @Log(title = "用户管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody SysUserBo user) {
        userService.checkUserAllowed(user.getUserId());
        userService.checkUserDataScope(user.getUserId());
        if (!userService.checkUserNameUnique(user)) {
            return R.fail("修改用户'" + user.getUserName() + "'失败，登录账号已存在");
        } else if (StringUtils.isNotEmpty(user.getPhonenumber()) && !userService.checkPhoneUnique(user)) {
            return R.fail("修改用户'" + user.getUserName() + "'失败，手机号码已存在");
        } else if (StringUtils.isNotEmpty(user.getEmail()) && !userService.checkEmailUnique(user)) {
            return R.fail("修改用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        return toAjax(userService.updateUser(user));
    }

    /**
     * 修改用户名称
     */
    @Log(title = "修改用户名称", businessType = BusinessType.UPDATE)
    @PostMapping("/editName")
    public R<Void> editName(@RequestBody @Validated  UserRequest userRequest) {
        LoginUser loginUser = LoginHelper.getLoginUser();
        userService.updateUserName(loginUser.getUserId(), userRequest.getNickName());
        return R.ok("操作成功!");
    }

    /**
     * 修改用户头像
     */
    @Log(title = "修改用户头像", businessType = BusinessType.UPDATE)
    @PostMapping("/edit/avatar")
    public R<Void> editAvatar(@RequestPart("file") MultipartFile file) {
        if (ObjectUtil.isNull(file)) {
            return R.fail("上传文件不能为空");
        }
        LoginUser loginUser = LoginHelper.getLoginUser();
        // 获取当前登录用户
        SysOssVo oss = ossService.upload(file);
        userService.updateUserAvatar(loginUser.getUserId(), oss.getUrl());
        return R.ok(oss.getUrl());
    }

    /**
     * 小程序-修改用户
     */
    @PostMapping("/edit/xcxUser")
    public R<SysUserVo> editXcxUser(@RequestBody SysUserBo user) {
        return R.ok(userService.updateXcxUser(user));
    }

    /**
     * 删除用户
     *
     * @param userIds 角色ID串
     */
    @SaCheckPermission("system:user:remove")
    @Log(title = "用户管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{userIds}")
    public R<Void> remove(@PathVariable Long[] userIds) {
        if (ArrayUtil.contains(userIds, LoginHelper.getUserId())) {
            return R.fail("当前用户不能删除");
        }
        return toAjax(userService.deleteUserByIds(userIds));
    }

    /**
     * 重置密码
     */
    @SaCheckPermission("system:user:resetPwd")
    @Log(title = "用户管理", businessType = BusinessType.UPDATE)
    @PutMapping("/resetPwd")
    public R<Void> resetPwd(@RequestBody SysUserBo user) {
        userService.checkUserAllowed(user.getUserId());
        userService.checkUserDataScope(user.getUserId());
        user.setPassword(BCrypt.hashpw(user.getPassword()));
        return toAjax(userService.resetUserPwd(user.getUserId(), user.getPassword()));
    }

    /**
     * 状态修改
     */
    @SaCheckPermission("system:user:edit")
    @Log(title = "用户管理", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public R<Void> changeStatus(@RequestBody SysUserBo user) {
        userService.checkUserAllowed(user.getUserId());
        userService.checkUserDataScope(user.getUserId());
        return toAjax(userService.updateUserStatus(user.getUserId(), user.getStatus()));
    }

    /**
     * 根据用户编号获取授权角色
     *
     * @param userId 用户ID
     */
    @SaCheckPermission("system:user:query")
    @GetMapping("/authRole/{userId}")
    public R<SysUserInfoVo> authRole(@PathVariable Long userId) {
        SysUserVo user = userService.selectUserById(userId);
        List<SysRoleVo> roles = roleService.selectRolesByUserId(userId);
        SysUserInfoVo userInfoVo = new SysUserInfoVo();
        userInfoVo.setUser(user);
        userInfoVo.setRoles(LoginHelper.isSuperAdmin(userId) ? roles : StreamUtils.filter(roles, r -> !r.isSuperAdmin()));
        return R.ok(userInfoVo);
    }

    /**
     * 用户授权角色
     *
     * @param userId  用户Id
     * @param roleIds 角色ID串
     */
    @SaCheckPermission("system:user:edit")
    @Log(title = "用户管理", businessType = BusinessType.GRANT)
    @PutMapping("/authRole")
    public R<Void> insertAuthRole(Long userId, Long[] roleIds) {
        userService.checkUserDataScope(userId);
        userService.insertUserAuth(userId, roleIds);
        return R.ok();
    }

    /**
     * 获取部门树列表
     */
    @SaCheckPermission("system:user:list")
    @GetMapping("/deptTree")
    public R<List<Tree<Long>>> deptTree(SysDeptBo dept) {
        List<Tree<Long>> trees = deptService.selectDeptTreeList(dept);
        return R.ok(trees);
    }


    /**
     * 根据部门ID统计用户数量 /system/user/list/dept/
     *
     * @param deptId 部门ID
     */ 
    @SaCheckPermission("system:user:list:dept")
    @GetMapping("/list/dept/{deptId}")
    public R<List<SysUserVo>> countUsersByDept(@PathVariable Long deptId) {
        SysUserBo user = new SysUserBo();
        user.setDeptId(deptId);
        List<SysUserVo> userList = userService.selectUserList(user);
        return R.ok(userList);
    }

    /**
     * 普通用户角色选择（专用接口）
     * 仅允许普通角色用户选择专业角色，绕过数据权限检查
     * 限制：1. 只能由普通角色用户调用；2. 用户只能选择一次角色
     */
    @PostMapping("/selectRole")
    public R<Void> selectRole(@RequestBody SelectRoleRequest request) {
        LoginUser loginUser = LoginHelper.getLoginUser();
        Long userId = loginUser.getUserId();
        
        // 获取用户实际拥有的角色列表 - 修复：直接从mapper获取，绕过数据权限检查
        List<SysRoleVo> userRoles = roleMapper.selectRolePermissionByUserId(userId);
        
        // 1. 检查是否为普通角色用户（角色ID=2，角色标识为common）
        boolean isNormalRole = false;
        boolean hasSelectedProfessionalRole = false;
        
        for (SysRoleVo role : userRoles) {
            // 检查是否有普通角色
            if (role.getRoleId().equals(UserConstants.RoleIds.COMMON_ROLE_ID) && UserConstants.RoleKeys.COMMON.equals(role.getRoleKey())) {
                isNormalRole = true;
            }
            // 检查是否已经有专业角色 - 改为使用角色key进行验证
            String roleKey = role.getRoleKey();
            if (UserConstants.RoleKeys.DESIGNER.equals(roleKey) || // 设计师
                UserConstants.RoleKeys.ENTERPRISE.equals(roleKey) || // 企业管理员  
                UserConstants.RoleKeys.SCHOOL.equals(roleKey)) { // 院校管理员
                hasSelectedProfessionalRole = true;
            }
        }
        
        // 只允许普通角色用户调用
        if (!isNormalRole) {
            log.warn("非普通角色用户尝试选择角色 - userId: {}, userRoles: {}", userId, userRoles);
            return R.fail("只有普通角色用户可以选择角色");
        }
        
        // 2. 检查用户是否已经选择过专业角色（一次性选择限制）
        if (hasSelectedProfessionalRole) {
            log.warn("用户已选择专业角色，不能重复选择 - userId: {}, userRoles: {}", userId, userRoles);
            return R.fail("您已经选择过角色，不能重复选择");
        }
        
        // 3. 验证目标角色是否为允许的专业角色 - 改为使用角色ID验证（因为请求中传的是角色ID）
        Long[] allowedRoleIds = {
            UserConstants.RoleIds.DESIGNER_ROLE_ID, 
            UserConstants.RoleIds.ENTERPRISE_ROLE_ID, 
            UserConstants.RoleIds.SCHOOL_ROLE_ID
        };
        Long targetRoleId = request.getRoleId();
        if (!Arrays.asList(allowedRoleIds).contains(targetRoleId)) {
            log.warn("用户选择了无效的角色 - userId: {}, targetRoleId: {}", userId, targetRoleId);
            return R.fail("无效的角色选择");
        }
        
        // 4. 直接操作用户角色关联表，完全绕过权限检查
        try {
            // 删除用户现有的所有角色关联
            userRoleMapper.delete(new LambdaQueryWrapper<SysUserRole>()
                .eq(SysUserRole::getUserId, userId));
            
            // 插入新的专业角色关联
            SysUserRole userRole = new SysUserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(targetRoleId);
            userRoleMapper.insert(userRole);
            
            // 5. 更新登录用户缓存信息
            updateLoginUserCache(loginUser);
            
            log.info("用户角色选择成功 - userId: {}, 从普通角色(common)切换到专业角色: {}", userId, targetRoleId);
            return R.ok("角色选择成功！");
            
        } catch (Exception e) {
            log.error("角色选择失败 - userId: {}, roleId: {}", userId, targetRoleId, e);
            return R.fail("角色选择失败，请重试");
        }
    }

    /**
     * 更新登录用户缓存信息
     * 在角色选择后刷新用户的角色权限信息
     */
    private void updateLoginUserCache(LoginUser loginUser) {
        try {
            // 重新获取用户完整信息
            SysUserVo user = userService.selectUserById(loginUser.getUserId());
            
            // 更新角色权限信息
            loginUser.setRolePermission(permissionService.getRolePermission(loginUser.getUserId()));
            loginUser.setMenuPermission(permissionService.getMenuPermission(loginUser.getUserId()));
            
            // 更新角色对象列表
            List<RoleDTO> roles = BeanUtil.copyToList(user.getRoles(), RoleDTO.class);
            loginUser.setRoles(roles);
            
            // 更新Sa-Token缓存中的登录用户信息
            StpUtil.getTokenSession().set(LoginHelper.LOGIN_USER_KEY, loginUser);
            
            log.info("登录用户缓存信息已更新 - userId: {}", loginUser.getUserId());
            
        } catch (Exception e) {
            log.error("更新登录用户缓存失败 - userId: {}", loginUser.getUserId(), e);
        }
    }

    /**
     * 角色选择请求对象
     */
    @Data
    public static class SelectRoleRequest {
        private Long roleId;
    }

    /**
     * 绑定用户手机号
     * 验证短信验证码后绑定手机号到当前登录用户
     */
    @Log(title = "绑定手机号", businessType = BusinessType.UPDATE)
    @PostMapping("/bind/phone")
    public R<Void> bindPhone(@Validated @RequestBody BindPhoneRequest request) {
        try {
            // 获取当前登录用户
            LoginUser loginUser = LoginHelper.getLoginUser();
            Long userId = loginUser.getUserId();
            
            // 验证短信验证码
            String code = RedisUtils.getCacheObject(GlobalConstants.CAPTCHA_CODE_KEY + request.getPhonenumber());
            if (StringUtils.isBlank(code)) {
                log.warn("验证码已过期 - userId: {}, phone: {}", userId, request.getPhonenumber());
                return R.fail("验证码已过期，请重新获取");
            }
            
            if (!code.equals(request.getSmsCode())) {
                log.warn("验证码错误 - userId: {}, phone: {}, inputCode: {}", userId, request.getPhonenumber(), request.getSmsCode());
                return R.fail("验证码错误");
            }
            
            // 绑定手机号
            boolean success = userService.bindUserPhone(userId, request.getPhonenumber());
            
            if (success) {
                // 绑定成功后清除验证码缓存
                RedisUtils.deleteObject(GlobalConstants.CAPTCHA_CODE_KEY + request.getPhonenumber());
                
                log.info("用户手机号绑定成功 - userId: {}, phone: {}", userId, request.getPhonenumber());
                return R.ok("手机号绑定成功");
            } else {
                log.error("用户手机号绑定失败 - userId: {}, phone: {}", userId, request.getPhonenumber());
                return R.fail("手机号绑定失败，请重试");
            }
            
        } catch (Exception e) {
            log.error("绑定手机号异常 - request: {}", request, e);
            return R.fail(e.getMessage());
        }
    }

}
