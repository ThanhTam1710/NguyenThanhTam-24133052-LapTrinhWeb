<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login with Cookie - 24133052_NguyenThanhTam</title>
</head>
<body>
    <h2>Đăng Nhập (Sử dụng Cookie)</h2>
    <p>Sinh viên: <b>Nguyễn Thanh Tâm</b> - MSSV: <b>24133052</b></p>
    <form action="${pageContext.request.contextPath}/login-cookie" method="post"> 
        <label>UserName:</label>
        <input type="text" name="username" placeholder="syber096 hoặc thanhtam" required><br><br>
        
        <label>Password:</label>
        <input type="password" name="password" placeholder="thanhtam123 hoặc 123" required><br><br>
        
        <input type="submit" value="Login"> 
    </form>
</body>
</html>
