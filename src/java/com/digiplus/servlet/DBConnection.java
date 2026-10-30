package com.digiplus.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {

    private static final String JDBC_URL = "jdbc:derby:" + System.getProperty("user.home") + "/DigiPlusDB;create=true";
    private static final String DRIVER = "org.apache.derby.jdbc.EmbeddedDriver";

    static {
        try {
            // Load embedded Derby driver into memory
            Class.forName(DRIVER);
            initDatabase();
        } catch (ClassNotFoundException e) {
            System.err.println("[DB ERROR] Apache Derby Driver not found! Ensure derby.jar is added to project libraries.");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            // Ensure driver is registered before requesting a connection
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Derby Embedded Driver class (" + DRIVER + ") not found in runtime classpath.", e);
        }
        return DriverManager.getConnection(JDBC_URL);
    }

    private static void initDatabase() {
        String createTableSQL = "CREATE TABLE meeting_history ("
                + "id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, "
                + "title VARCHAR(255), "
                + "participants VARCHAR(255), "
                + "summary VARCHAR(3000), "
                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                + ")";

        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(createTableSQL);
            System.out.println("[DB] Table 'meeting_history' created successfully.");
        } catch (SQLException e) {
            // Error code X0Y32 indicates the table already exists in Derby
            if ("X0Y32".equals(e.getSQLState())) {
                System.out.println("[DB] Table 'meeting_history' already initialized.");
            } else {
                System.err.println("[DB ERROR] Failed to initialize database schema: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}