package com.shop.swp391.listener;

import com.shop.swp391.dal.SettingDAO;
import com.shop.swp391.entity.Setting;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebListener
public class SettingContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        // Khởi tạo SettingDAO
        SettingDAO settingDAO = new SettingDAO();
        
        // Lấy tất cả các setting từ database
        List<Setting> allSettings = settingDAO.findAll();
        
        // Nhóm các setting theo type
        Map<String, List<Setting>> settingsByType = allSettings.stream()
                .filter(setting -> "Active".equals(setting.getStatus()))
                .collect(Collectors.groupingBy(Setting::getType));
        
        // Đặt các setting vào ServletContext
        context.setAttribute("appSettings", settingsByType);
        
        // Tạo một map đơn giản cho các setting phổ biến để truy cập nhanh
        Map<String, String> commonSettings = new HashMap<>();
        for (Setting setting : allSettings) {
            if ("Active".equals(setting.getStatus())) {
                String key = setting.getKey();
                commonSettings.put(key, setting.getValue());
            }
        }
        context.setAttribute("settings", commonSettings);
        
        System.out.println("Application settings loaded into ServletContext");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Dọn dẹp nếu cần
    }
} 