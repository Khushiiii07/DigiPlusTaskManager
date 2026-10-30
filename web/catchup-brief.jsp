<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Catch-Up Brief | DigiPlus AI</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --bg-main: #0b0f19;
            --card-bg: #151c2c;
            --border-color: #334155;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-main);
            color: #cbd5e1;
            min-height: 100vh;
        }

        .no-print-header {
            background: rgba(21, 28, 44, 0.9);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
        }

        .brief-paper {
            background-color: #ffffff;
            color: #0f172a;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            padding: 2.5rem;
        }

        .brief-header {
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }

        /* PRINT STYLING OVERRIDES */
        @media print {
            body {
                background-color: #ffffff !important;
                color: #000000 !important;
            }
            .no-print {
                display: none !important;
            }
            .brief-paper {
                box-shadow: none !important;
                border: none !important;
                padding: 0 !important;
                margin: 0 !important;
            }
        }
    </style>
</head>
<body class="pb-5">

    <!-- Header bar (hidden during print) -->
    <header class="no-print no-print-header py-3 mb-4">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2">
                <i class="fa-solid fa-brain fs-3 text-primary"></i>
                <span class="fs-4 fw-bold text-white">DigiPlus AI | Role Handover Brief</span>
            </div>
            <a href="index.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Workspace
            </a>
        </div>
    </header>

    <div class="container" style="max-width: 850px;">
        
        <!-- Action Toolbar (hidden during print) -->
        <div class="no-print d-flex justify-content-end mb-3">
            <button onclick="window.print()" class="btn btn-warning fw-bold px-4 rounded-pill">
                <i class="fa-solid fa-print me-2"></i> Print / Export PDF
            </button>
        </div>

        <!-- Document Printable Container -->
        <div class="brief-paper">
            <div class="brief-header d-flex justify-content-between align-items-start">
                <div>
                    <h3 class="fw-bold text-dark mb-1">Executive Catch-Up & Handover Brief</h3>
                    <p class="text-muted small mb-0">Generated via DigiPlus AI Automated Summarization Engine</p>
                </div>
                <span class="badge bg-primary px-3 py-2 fs-6">CONFIDENTIAL</span>
            </div>

            <%
                String title = request.getParameter("title");
                String participants = request.getParameter("participants");
                String summary = (String) session.getAttribute("lastSummary");

                if (title == null || title.trim().isEmpty()) title = "Q4 Infrastructure Upgrade & Security Hardening";
                if (participants == null || participants.trim().isEmpty()) participants = "David, Alex, Sarah";
                if (summary == null || summary.trim().isEmpty()) {
                    summary = "The engineering team finalized the database schema migration for Friday at 11 PM. Alex is deploying Redis caching layers to mitigate API gateway latency, and Sarah is refactoring token authentication to satisfy security audit compliance.";
                }
            %>

            <div class="row mb-4">
                <div class="col-6">
                    <small class="text-uppercase fw-bold text-muted d-block">Meeting / Project Title</small>
                    <span class="fs-5 fw-bold text-dark"><%= title %></span>
                </div>
                <div class="col-6">
                    <small class="text-uppercase fw-bold text-muted d-block">Assigned Delegates</small>
                    <span class="fs-5 fw-semibold text-primary"><%= participants %></span>
                </div>
            </div>

            <div class="mb-4">
                <h6 class="fw-bold text-dark text-uppercase border-bottom pb-2">Executive Context Summary</h6>
                <p class="lh-base text-dark fs-6 mt-2"><%= summary %></p>
            </div>

            <div class="mb-4">
                <h6 class="fw-bold text-dark text-uppercase border-bottom pb-2">Action Items Lifecycle</h6>
                <table class="table table-bordered mt-2 align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Action Deliverable</th>
                            <th>Owner</th>
                            <th>Due Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Prepare technical documentation & migration steps</td>
                            <td>David</td>
                            <td>Nov 05, 2026</td>
                            <td><span class="badge bg-warning text-dark">Open</span></td>
                        </tr>
                        <tr>
                            <td>Execute API Gateway Redis Caching Layer</td>
                            <td>Alex</td>
                            <td>Nov 08, 2026</td>
                            <td><span class="badge bg-warning text-dark">Open</span></td>
                        </tr>
                        <tr>
                            <td>Lead Security Audit & Token Authentication Refactoring</td>
                            <td>Sarah</td>
                            <td>Nov 10, 2026</td>
                            <td><span class="badge bg-warning text-dark">Open</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="pt-4 border-top text-center text-muted small">
                Document auto-generated on <%= new java.text.SimpleDateFormat("MMM dd, yyyy - HH:mm").format(new java.util.Date()) %> | DigiPlus AI System ID: <%= java.util.UUID.randomUUID().toString().substring(0, 8) %>
            </div>
        </div>
    </div>
</body>
</html>