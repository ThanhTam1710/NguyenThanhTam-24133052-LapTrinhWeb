<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login with Session - 24133052_NguyenThanhTam</title>
</head>
<body>
    <h2>Đăng Nhập (Sử dụng Session)</h2>
    <p>Sinh viên: <b>Nguyễn Thành Tâm</b> - MSSV: <b>24133052</b></p>
    <form action="${pageContext.request.contextPath}/login-session" method="post"> 
        <label>UserName:</label>
        <input type="text" name="username" placeholder="thanhtam hoặc tamnt" required><br><br>
        <label>Password:</label>
        <input type="password" name="password" placeholder="123" required><br><br>
        <input type="submit" value="Login"> 
    </form>
</body>
</html>
