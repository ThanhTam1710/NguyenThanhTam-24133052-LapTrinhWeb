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

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        if (instance != null && !instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance
                    + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}
