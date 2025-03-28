package com.shop.swp391.controller.utils;

import com.shop.swp391.entity.Setting;
import jakarta.servlet.ServletContext;

import java.util.List;
import java.util.Map;
import com.shop.swp391.listener.SettingContextListener;
import jakarta.servlet.ServletContextEvent;

public class SettingUtils {
    
    /**
     * Lấy giá trị setting theo type và value
     * 
     * @param context ServletContext
     * @param type Loại setting
     * @param key Khóa setting
     * @return Giá trị setting hoặc null nếu không tìm thấy
     */
    public static String getSetting(ServletContext context, String type, String key) {
        @SuppressWarnings("unchecked")
        Map<String, String> settings = (Map<String, String>) context.getAttribute("settings");
        if (settings != null) {
            return settings.get(type + "." + key);
        }
        return null;
    }
    
    /**
     * Lấy tất cả các setting theo type
     * 
     * @param context ServletContext
     * @param type Loại setting
     * @return Danh sách các setting thuộc type hoặc null nếu không tìm thấy
     */
    public static List<Setting> getSettingsByType(ServletContext context, String type) {
        @SuppressWarnings("unchecked")
        Map<String, List<Setting>> settingsByType = 
                (Map<String, List<Setting>>) context.getAttribute("appSettings");
        if (settingsByType != null) {
            return settingsByType.get(type);
        }
        return null;
    }
    
    /**
     * Cập nhật lại các setting trong ServletContext
     * 
     * @param context ServletContext
     */
    public static void refreshSettings(ServletContext context) {
        SettingContextListener listener = new SettingContextListener();
        listener.contextInitialized(new ServletContextEvent(context));
    }
} 