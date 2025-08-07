package org.ruoyi.common.core.utils.file;

import org.springframework.web.multipart.MultipartFile;
import org.ruoyi.common.core.annotation.FileSizeLimit;

/**
 * 文件大小限制验证工具类
 *
 * @author ruoyi
 */
public class FileSizeLimitUtils {

    /**
     * 图片文件默认大小限制：10MB
     */
    public static final long IMAGE_MAX_SIZE = 10 * 1024 * 1024L;

    /**
     * 文档文件默认大小限制：50MB
     */
    public static final long DOCUMENT_MAX_SIZE = 50 * 1024 * 1024L;

    /**
     * 视频文件默认大小限制：500MB
     */
    public static final long VIDEO_MAX_SIZE = 500 * 1024 * 1024L;

    /**
     * 音频文件默认大小限制：100MB
     */
    public static final long AUDIO_MAX_SIZE = 100 * 1024 * 1024L;

    /**
     * 压缩文件默认大小限制：200MB
     */
    public static final long ARCHIVE_MAX_SIZE = 200 * 1024 * 1024L;

    /**
     * 根据文件类型获取默认大小限制
     *
     * @param file 上传的文件
     * @return 文件大小限制（字节）
     */
    public static long getDefaultMaxSizeByFileType(MultipartFile file) {
        if (file == null || file.getOriginalFilename() == null) {
            return DOCUMENT_MAX_SIZE;
        }

        String extension = getFileExtension(file.getOriginalFilename()).toLowerCase();

        // 图片文件
        if (isImageFile(extension)) {
            return IMAGE_MAX_SIZE;
        }
        // 视频文件
        else if (isVideoFile(extension)) {
            return VIDEO_MAX_SIZE;
        }
        // 音频文件
        else if (isAudioFile(extension)) {
            return AUDIO_MAX_SIZE;
        }
        // 压缩文件
        else if (isArchiveFile(extension)) {
            return ARCHIVE_MAX_SIZE;
        }
        // 默认文档文件
        else {
            return DOCUMENT_MAX_SIZE;
        }
    }

    /**
     * 验证文件大小
     *
     * @param file 上传的文件
     * @param maxSize 最大文件大小（字节）
     * @return 验证结果消息，null表示验证通过
     */
    public static String validateFileSize(MultipartFile file, long maxSize) {
        if (file == null || file.isEmpty()) {
            return "上传文件不能为空";
        }

        long fileSize = file.getSize();
        if (fileSize > maxSize) {
            return String.format("文件过大，最大支持%.1fMB，当前文件%.1fMB", 
                    maxSize / 1024.0 / 1024.0, 
                    fileSize / 1024.0 / 1024.0);
        }

        return null; // 验证通过
    }

    /**
     * 根据注解验证文件大小
     *
     * @param file 上传的文件
     * @param annotation 文件大小限制注解
     * @return 验证结果消息，null表示验证通过
     */
    public static String validateFileSizeByAnnotation(MultipartFile file, FileSizeLimit annotation) {
        if (!annotation.enabled()) {
            return null; // 跳过验证
        }

        long maxSize = annotation.maxSize();
        // 如果设置了maxSizeMB，优先使用
        if (annotation.maxSizeMB() > 0) {
            maxSize = annotation.maxSizeMB() * 1024 * 1024L;
        }

        String result = validateFileSize(file, maxSize);
        if (result != null && !annotation.message().equals("文件大小超出限制")) {
            return annotation.message();
        }
        return result;
    }

    /**
     * 智能验证文件大小（根据文件类型自动选择限制）
     *
     * @param file 上传的文件
     * @return 验证结果消息，null表示验证通过
     */
    public static String validateFileSizeSmartly(MultipartFile file) {
        long maxSize = getDefaultMaxSizeByFileType(file);
        return validateFileSize(file, maxSize);
    }

    /**
     * 获取文件扩展名
     */
    private static String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "";
        }
        return filename.substring(filename.lastIndexOf(".") + 1);
    }

    /**
     * 判断是否为图片文件
     */
    private static boolean isImageFile(String extension) {
        for (String ext : MimeTypeUtils.IMAGE_EXTENSION) {
            if (ext.equals(extension)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断是否为视频文件
     */
    private static boolean isVideoFile(String extension) {
        for (String ext : MimeTypeUtils.ALL_VIDEO_EXTENSION) {
            if (ext.equals(extension)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断是否为音频文件
     */
    private static boolean isAudioFile(String extension) {
        String[] audioExtensions = {"mp3", "wav", "aac", "flac", "ogg", "wma", "m4a"};
        for (String ext : audioExtensions) {
            if (ext.equals(extension)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断是否为压缩文件
     */
    private static boolean isArchiveFile(String extension) {
        String[] archiveExtensions = {"zip", "rar", "7z", "tar", "gz", "bz2"};
        for (String ext : archiveExtensions) {
            if (ext.equals(extension)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 格式化文件大小显示
     *
     * @param sizeInBytes 文件大小（字节）
     * @return 格式化后的大小字符串
     */
    public static String formatFileSize(long sizeInBytes) {
        if (sizeInBytes < 1024) {
            return sizeInBytes + " B";
        } else if (sizeInBytes < 1024 * 1024) {
            return String.format("%.1f KB", sizeInBytes / 1024.0);
        } else if (sizeInBytes < 1024 * 1024 * 1024) {
            return String.format("%.1f MB", sizeInBytes / 1024.0 / 1024.0);
        } else {
            return String.format("%.1f GB", sizeInBytes / 1024.0 / 1024.0 / 1024.0);
        }
    }
} 