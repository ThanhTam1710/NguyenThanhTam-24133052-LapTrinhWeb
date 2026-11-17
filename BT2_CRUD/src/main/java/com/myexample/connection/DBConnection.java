package com.myexample.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC";
    private final String portNumber = "1433";
    private final String instance = ""; // Để trống nếu là SQL Server Default Instance
    private final String userID = "sa"; 
    private final String password = "123"; // Mật khẩu sa của SQL Server

    private static volatile long lastFailTime = 0;

    public Connection getConnection() throws Exception {
        // Nếu vừa thử kết nối thất bại trong vòng 10 giây qua, chuyển ngay sang fallback in-memory để web phản hồi tức thì
        if (System.currentTimeMillis() - lastFailTime < 10000) {
            throw new Exception("SQL Server connection cooldown (fallback in-memory)");
        }

        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                + ";loginTimeout=2;encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        if (instance != null && !instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance
                    + ";loginTimeout=2;encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        try {
            Connection conn = DriverManager.getConnection(url, userID, password);
            lastFailTime = 0;
            return conn;
        } catch (Exception e) {
            lastFailTime = System.currentTimeMillis();
            throw e;
        }
    }
}
