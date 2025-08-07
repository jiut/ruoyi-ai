package org.ruoyi.common.core.utils.file;

import org.springframework.web.multipart.MultipartFile;

/**
 * 视频文件验证工具类
 *
 * @author ruoyi
 */
public class VideoValidationUtils {

    /**
     * 默认视频文件大小限制：500MB
     */
    public static final long DEFAULT_MAX_SIZE = 500 * 1024 * 1024L;

    /**
     * 最小视频文件大小：1KB
     */
    public static final long MIN_SIZE = 1024L;

    /**
     * 验证视频文件
     *
     * @param file 上传的文件
     * @return 验证结果消息，null表示验证通过
     */
    public static String validateVideoFile(MultipartFile file) {
        return validateVideoFile(file, DEFAULT_MAX_SIZE);
    }

    /**
     * 验证视频文件
     *
     * @param file 上传的文件
     * @param maxSize 最大文件大小（字节）
     * @return 验证结果消息，null表示验证通过
     */
    public static String validateVideoFile(MultipartFile file, long maxSize) {
        if (file == null || file.isEmpty()) {
            return "视频文件不能为空";
        }

        // 验证文件大小
        long fileSize = file.getSize();
        if (fileSize < MIN_SIZE) {
            return "视频文件太小，至少需要1KB";
        }
        if (fileSize > maxSize) {
            return String.format("视频文件过大，最大支持%.1fMB", maxSize / 1024.0 / 1024.0);
        }

        // 验证文件扩展名
        if (!FileUtils.isValidFileExtention(file, MimeTypeUtils.ALL_VIDEO_EXTENSION)) {
            return "不支持的视频文件格式，支持的格式：" + String.join(", ", MimeTypeUtils.ALL_VIDEO_EXTENSION);
        }

        // 验证MIME类型
        String contentType = file.getContentType();
        if (contentType == null || !isValidVideoMimeType(contentType)) {
            return "无效的视频文件类型";
        }

        return null; // 验证通过
    }

    /**
     * 验证是否为有效的视频MIME类型
     */
    private static boolean isValidVideoMimeType(String contentType) {
        return contentType.startsWith("video/") || 
               contentType.equals("application/octet-stream"); // 某些视频文件可能使用这个类型
    }

    /**
     * 获取推荐的视频配置信息
     */
    public static String getRecommendedVideoConfig() {
        return "推荐配置：格式MP4，分辨率1920x1080或以下，码率不超过8Mbps，文件大小不超过500MB";
    }

    /**
     * 检查视频文件名是否安全
     */
    public static boolean isSecureVideoFileName(String fileName) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return false;
        }
        
        // 检查是否包含危险字符
        String[] dangerousPatterns = {"..", "/", "\\", ":", "*", "?", "\"", "<", ">", "|"};
        String lowerFileName = fileName.toLowerCase();
        
        for (String pattern : dangerousPatterns) {
            if (lowerFileName.contains(pattern)) {
                return false;
            }
        }
        
        return true;
    }

    /**
     * 格式化文件大小显示
     */
    public static String formatFileSize(long size) {
        if (size <= 0) {
            return "0B";
        }
        
        final String[] units = {"B", "KB", "MB", "GB", "TB"};
        int digitGroups = (int) (Math.log10(size) / Math.log10(1024));
        digitGroups = Math.min(digitGroups, units.length - 1);
        
        return String.format("%.1f %s", size / Math.pow(1024, digitGroups), units[digitGroups]);
    }
} 