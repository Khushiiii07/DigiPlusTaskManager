//package com.digiplus.servlet;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.UUID;
//import java.util.logging.FileHandler;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import java.util.logging.SimpleFormatter;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@WebServlet(name = "ProcessMeetingServlet", urlPatterns = {"/ProcessMeetingServlet"})
//public class ProcessMeetingServlet extends HttpServlet {
//
//    private static final Logger LOGGER = Logger.getLogger(ProcessMeetingServlet.class.getName());
//
//    static {
//        try {
//            FileHandler fh = new FileHandler(System.getProperty("user.home") + "/app_activity.log", true);
//            fh.setFormatter(new SimpleFormatter());
//            LOGGER.addHandler(fh);
//        } catch (IOException e) {
//            LOGGER.log(Level.SEVERE, "Failed to initialize file logger", e);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        long startTime = System.currentTimeMillis();
//        String requestId = UUID.randomUUID().toString();
//
//        String title = request.getParameter("title");
//        String participants = request.getParameter("participants");
//        String rawNotes = request.getParameter("rawNotes");
//
//        LOGGER.log(Level.INFO, "[REQ_ID: {0}] EVENT: Meeting Processing Started | Title: {1}", 
//                new Object[]{requestId, title});
//
//        // Generate actual comprehensive summary from the user's input notes
//        String aiSummary = generateRealSummary(title, participants, rawNotes);
//
//        // Build Dynamic Task Allocation for all participants
//        ArrayList<HashMap<String, String>> tasks = new ArrayList<>();
//        if (participants != null && !participants.trim().isEmpty()) {
//            String[] parts = participants.split(",");
//            for (int i = 0; i < parts.length; i++) {
//                String person = parts[i].trim();
//                HashMap<String, String> task = new HashMap<>();
//
//                if (i == 0) {
//                    task.put("name", "Prepare technical documentation for " + title);
//                    task.put("dueDate", "Nov 05, 2026");
//                } else if (i == 1) {
//                    task.put("name", "Execute migration & verification steps for " + title);
//                    task.put("dueDate", "Nov 08, 2026");
//                } else {
//                    task.put("name", "Lead security audit & compliance review for " + title);
//                    task.put("dueDate", "Nov 10, 2026");
//                }
//
//                task.put("owner", person);
//                task.put("status", "Open");
//                tasks.add(task);
//            }
//        }
//
//        long latency = System.currentTimeMillis() - startTime;
//        LOGGER.log(Level.INFO, "[REQ_ID: {0}] EVENT: Processing Completed | Latency: {1}ms | Status: SUCCESS", 
//                new Object[]{requestId, latency});
//
//        request.setAttribute("requestId", requestId);
//        request.setAttribute("title", title);
//        request.setAttribute("participants", participants);
//        request.setAttribute("aiSummary", aiSummary);
//        request.setAttribute("taskList", tasks);
//        request.setAttribute("processSuccess", true);
//
//        request.getRequestDispatcher("index.jsp").forward(request, response);
//    }
//
//    private String generateRealSummary(String title, String participants, String notes) {
//        if (notes == null || notes.trim().isEmpty()) {
//            return "No meeting notes provided for " + title + ".";
//        }
//
//        // Split notes into sentences
//        String[] sentences = notes.split("(?<=[.!?])\\s+");
//        if (sentences.length <= 3) {
//            return notes.trim();
//        }
//
//        StringBuilder summaryBuilder = new StringBuilder();
//        summaryBuilder.append("Executive Overview for ").append(title).append(": ");
//
//        // Parse key sentences containing core decisions, assignments, and updates
//        for (String sentence : sentences) {
//            String lower = sentence.toLowerCase();
//            if (lower.contains("confirmed") || lower.contains("decided") || lower.contains("will") 
//                    || lower.contains("agreed") || lower.contains("scheduled") || lower.contains("raised")
//                    || lower.contains("lead") || lower.contains("need to")) {
//                summaryBuilder.append(sentence.trim()).append(" ");
//            }
//        }
//
//        String result = summaryBuilder.toString().trim();
//        return result.length() > 60 ? result : notes.substring(0, Math.min(notes.length(), 250)) + "...";
//    }
//}
package com.digiplus.servlet;

import com.digiplus.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ProcessMeetingServlet", urlPatterns = {"/ProcessMeetingServlet"})
public class ProcessMeetingServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProcessMeetingServlet.class.getName());

    static {
        try {
            FileHandler fh = new FileHandler(System.getProperty("user.home") + "/app_activity.log", true);
            fh.setFormatter(new SimpleFormatter());
            LOGGER.addHandler(fh);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize file logger", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long startTime = System.currentTimeMillis();
        String requestId = UUID.randomUUID().toString();

        String title = request.getParameter("title");
        String participants = request.getParameter("participants");
        String rawNotes = request.getParameter("rawNotes");

        LOGGER.log(Level.INFO, "[REQ_ID: {0}] EVENT: Meeting Processing Started | Title: {1}", 
                new Object[]{requestId, title});

        // Generate actual summary
        String aiSummary = generateRealSummary(title, participants, rawNotes);

        // Build Dynamic Task Allocation
        ArrayList<HashMap<String, String>> tasks = new ArrayList<>();
        if (participants != null && !participants.trim().isEmpty()) {
            String[] parts = participants.split(",");
            for (int i = 0; i < parts.length; i++) {
                String person = parts[i].trim();
                HashMap<String, String> task = new HashMap<>();

                if (i == 0) {
                    task.put("name", "Prepare technical documentation for " + title);
                    task.put("dueDate", "Nov 05, 2026");
                } else if (i == 1) {
                    task.put("name", "Execute migration & verification steps for " + title);
                    task.put("dueDate", "Nov 08, 2026");
                } else {
                    task.put("name", "Lead security audit & compliance review for " + title);
                    task.put("dueDate", "Nov 10, 2026");
                }

                task.put("owner", person);
                task.put("status", "Open");
                tasks.add(task);
            }
        }

        // --- Save directly into Apache Derby Database ---
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO meeting_history (title, participants, summary) VALUES (?, ?, ?)")) {
            ps.setString(1, title);
            ps.setString(2, participants);
            ps.setString(3, aiSummary);
            ps.executeUpdate();
            LOGGER.log(Level.INFO, "[DB] Meeting recorded in Apache Derby DB.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[DB ERROR] Could not save meeting to Derby DB", e);
        }

        // Keep Session Fallback for Active Catch-Up Brief
        HttpSession session = request.getSession();
        session.setAttribute("lastSummary", aiSummary);

        long latency = System.currentTimeMillis() - startTime;
        LOGGER.log(Level.INFO, "[REQ_ID: {0}] EVENT: Processing Completed | Latency: {1}ms | Status: SUCCESS", 
                new Object[]{requestId, latency});

        request.setAttribute("requestId", requestId);
        request.setAttribute("title", title);
        request.setAttribute("participants", participants);
        request.setAttribute("aiSummary", aiSummary);
        request.setAttribute("taskList", tasks);
        request.setAttribute("processSuccess", true);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private String generateRealSummary(String title, String participants, String notes) {
        if (notes == null || notes.trim().isEmpty()) {
            return "No meeting notes provided for " + title + ".";
        }

        String[] sentences = notes.split("(?<=[.!?])\\s+");
        if (sentences.length <= 3) {
            return notes.trim();
        }

        StringBuilder summaryBuilder = new StringBuilder();
        summaryBuilder.append("Executive Overview for ").append(title).append(": ");

        for (String sentence : sentences) {
            String lower = sentence.toLowerCase();
            if (lower.contains("confirmed") || lower.contains("decided") || lower.contains("will") 
                    || lower.contains("agreed") || lower.contains("scheduled") || lower.contains("raised")
                    || lower.contains("lead") || lower.contains("need to")) {
                summaryBuilder.append(sentence.trim()).append(" ");
            }
        }

        String result = summaryBuilder.toString().trim();
        return result.length() > 60 ? result : notes.substring(0, Math.min(notes.length(), 250)) + "...";
    }
}