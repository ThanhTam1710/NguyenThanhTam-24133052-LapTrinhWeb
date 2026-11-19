package com.myexample.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

import jakarta.servlet.annotation.WebFilter;

/**
 * Cấu hình SiteMesh Decorator 3 kết hợp Bootstrap 5 Template
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 * Môn học: Lập trình Web (HCMUTE)
 */
@WebFilter(filterName = "sitemesh", urlPatterns = "/*")
public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Đặt prefix rỗng để SiteMesh không tự cộng /WEB-INF/decorators/
        builder.setDecoratorPrefix("")
               .addDecoratorPath("/*", "/decorators/web.jsp")
               // Loại trừ các đường dẫn stream hình ảnh, video, dữ liệu nhị phân
               .addExcludedPath("/media*")
               .addExcludedPath("/image*")
               .addExcludedPath("/static/*")
               .addExcludedPath("/assets/*");
    }
}
