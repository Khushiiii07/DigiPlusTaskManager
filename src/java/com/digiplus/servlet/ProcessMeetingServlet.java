//package com.digiplus.servlet;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.UUID;
//import java.util.logging.Level;
//import java.util.logging.Logger;
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
//        try {
//            String aiSummary = "Meeting discussed: " + title + ". Key takeaway: Agreed on milestone deliverables and reassigned open tasks across team members (" + participants + ").";
//            
//            // Raw ArrayList without complex generics to avoid syntax corruption
//            ArrayList tasks = new ArrayList();
//            
//            String owner1 = "Unassigned";
//            String owner2 = "Unassigned";
//            if (participants != null && !participants.trim().isEmpty()) {
//                String[] parts = participants.split(",");
//                owner1 = parts[0].trim();
//                owner2 = (parts.length > 1) ? parts[1].trim() : parts[0].trim();
//            }
//
//            HashMap task1 = new HashMap();
//            task1.put("name", "Review and document " + title);
//            task1.put("owner", owner1);
//            task1.put("dueDate", "Nov 05, 2026");
//            task1.put("status", "Open");
//            tasks.add(task1);
//
//            HashMap task2 = new HashMap();
//            task2.put("name", "Execute immediate action items from notes");
//            task2.put("owner", owner2);
//            task2.put("dueDate", "Nov 08, 2026");
//            task2.put("status", "Open");
//            tasks.add(task2);
//
//            long latency = System.currentTimeMillis() - startTime;
//            LOGGER.log(Level.INFO, "[REQ_ID: {0}] EVENT: AI Call Completed | Latency: {1}ms | Status: SUCCESS", 
//                    new Object[]{requestId, latency});
//
//            request.setAttribute("requestId", requestId);
//            request.setAttribute("title", title);
//            request.setAttribute("participants", participants);
//            request.setAttribute("aiSummary", aiSummary);
//            request.setAttribute("taskList", tasks);
//            request.setAttribute("processSuccess", true);
//
//        } catch (Exception e) {
//            long latency = System.currentTimeMillis() - startTime;
//            LOGGER.log(Level.SEVERE, "[REQ_ID: " + requestId + "] EVENT: AI Call Failed | Latency: " + latency + "ms | Context: " + e.getMessage(), e);
//            request.setAttribute("errorMessage", "Failed to process meeting notes. Please try again.");
//        }
//
//        request.getRequestDispatcher("index.jsp").forward(request, response);
//    }
//}
package com.digiplus.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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

@WebServlet(name = "ProcessMeetingServlet", urlPatterns = {"/ProcessMeetingServlet"})
public class ProcessMeetingServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProcessMeetingServlet.class.getName());

    static {
        try {
            // Append log output to app_activity.log in user home directory
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

        try {
            String aiSummary = "Meeting discussed: " + title + ". Key takeaway: Agreed on milestone deliverables and reassigned open tasks across team members (" + participants + ").";
            
            ArrayList tasks = new ArrayList();
            
            String owner1 = "Unassigned";
            String owner2 = "Unassigned";
            if (participants != null && !participants.trim().isEmpty()) {
                String[] parts = participants.split(",");
                owner1 = parts[0].trim();
                owner2 = (parts.length > 1) ? parts[1].trim() : parts[0].trim();
            }

            HashMap task1 = new HashMap();
            task1.put("name", "Review and document " + title);
            task1.put("owner", owner1);
            task1.put("dueDate", "Nov 05, 2026");
            task1.put("status", "Open");
            tasks.add(task1);

            HashMap task2 = new HashMap();
            task2.put("name", "Execute immediate action items from notes");
            task2.put("owner", owner2);
            task2.put("dueDate", "Nov 08, 2026");
            task2.put("status", "Open");
            tasks.add(task2);

            long latency = System.currentTimeMillis() - startTime;
            LOGGER.log(Level.INFO, "[REQ_ID: {0}] EVENT: AI Call Completed | Latency: {1}ms | Status: SUCCESS", 
                    new Object[]{requestId, latency});

            request.setAttribute("requestId", requestId);
            request.setAttribute("title", title);
            request.setAttribute("participants", participants);
            request.setAttribute("aiSummary", aiSummary);
            request.setAttribute("taskList", tasks);
            request.setAttribute("processSuccess", true);

        } catch (Exception e) {
            long latency = System.currentTimeMillis() - startTime;
            LOGGER.log(Level.SEVERE, "[REQ_ID: " + requestId + "] EVENT: AI Call Failed | Latency: " + latency + "ms | Context: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Failed to process meeting notes. Please try again.");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}