<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Knowledge Base | DigiPlus AI</title>
    
    <!-- Google Fonts & FontAwesome Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --bg-main: #0b0f19;
            --card-bg: #151c2c;
            --input-bg: #1e293b;
            --accent-purple: #6366f1;
            --accent-cyan: #38bdf8;
            --text-body: #cbd5e1;
            --border-color: #334155;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-main);
            color: var(--text-body);
            min-height: 100vh;
        }

        .app-header {
            background: rgba(21, 28, 44, 0.9);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .brand-badge {
            background: linear-gradient(135deg, #818cf8, var(--accent-cyan));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }

        .custom-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.5);
        }

        .table-custom {
            color: var(--text-body) !important;
            background-color: transparent !important;
        }

        .table-custom th {
            background-color: var(--input-bg) !important;
            color: #94a3b8 !important;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border-color);
        }

        .table-custom td {
            background-color: var(--card-bg) !important;
            color: #f1f5f9 !important;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
        }

        .status-processed {
            background: rgba(16, 185, 129, 0.2);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
    </style>
</head>
<body class="pb-5">

    <!-- Header Navigation -->
    <header class="app-header py-3 mb-4">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2">
                <i class="fa-solid fa-brain fs-3" style="color: var(--accent-purple);"></i>
                <span class="fs-4 brand-badge">DigiPlus AI</span>
                <span class="border-start border-secondary ps-3 ms-2 text-light fw-semibold">Knowledge Base</span>
            </div>
            <a href="index.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Workspace
            </a>
        </div>
    </header>

    <div class="container">
        <div class="custom-card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="fw-bold text-white mb-1">
                        <i class="fa-solid fa-clock-rotate-left text-info me-2"></i>Historical Meeting Transcripts
                    </h5>
                    <small style="color: #94a3b8;">Persistent logs stored in Apache Derby Database.</small>
                </div>
                <span class="badge bg-secondary bg-opacity-30 text-light border border-secondary border-opacity-20">
                    Derby DB Active
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-custom align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Date & Time</th>
                            <th>Meeting Title</th>
                            <th>Participants</th>
                            <th>Summary Preview</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try (java.sql.Connection conn = com.digiplus.util.DBConnection.getConnection();
                             java.sql.Statement stmt = conn.createStatement();
                             java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM meeting_history ORDER BY created_at DESC")) {
                            
                            boolean hasData = false;
                            while (rs.next()) {
                                hasData = true;
                    %>
                        <tr>
                            <td class="small text-muted"><%= rs.getTimestamp("created_at") %></td>
                            <td class="fw-semibold text-white"><%= rs.getString("title") %></td>
                            <td class="text-info fw-medium"><%= rs.getString("participants") %></td>
                            <td class="small text-truncate" style="max-width: 280px;"><%= rs.getString("summary") %></td>
                            <td>
                                <span class="status-badge status-processed">
                                    <i class="fa-solid fa-check me-1"></i> Processed
                                </span>
                            </td>
                        </tr>
                    <%
                            }
                            if (!hasData) {
                    %>
                        <tr>
                            <td colspan="5" class="text-center py-5" style="color: #94a3b8;">
                                <i class="fa-solid fa-folder-open fs-2 d-block mb-3 text-secondary"></i>
                                <p class="mb-1 fw-medium text-light">No meeting transcripts logged in Derby DB yet.</p>
                                <small class="text-muted">Submit meeting notes on the main workspace page to save entries permanently.</small>
                            </td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                        <tr>
                            <td colspan="5" class="text-danger p-4">
                                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                                Database Error: <%= e.getMessage() %>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>