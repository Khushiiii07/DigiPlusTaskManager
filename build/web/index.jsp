<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DigiPlus AI | Work Transfer & Knowledge Platform</title>
    
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
            --accent-emerald: #10b981;
            --text-heading: #ffffff;
            --text-body: #cbd5e1;
            --text-subtle: #94a3b8;
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
            transition: all 0.25s ease-in-out;
        }

        .custom-card:hover {
            border-color: var(--accent-purple);
            box-shadow: 0 12px 28px -5px rgba(99, 102, 241, 0.25);
        }

        .card-title-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
        }

        .form-label {
            color: var(--text-subtle) !important;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }

        .form-control, .form-select {
            background-color: var(--input-bg) !important;
            border: 1px solid var(--border-color) !important;
            color: #ffffff !important;
            border-radius: 10px;
            padding: 0.75rem 1rem;
        }

        .form-control::placeholder {
            color: #64748b !important;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-purple) !important;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25) !important;
        }

        .btn-gradient {
            background: linear-gradient(135deg, var(--accent-purple), #4f46e5);
            color: #ffffff !important;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            transition: transform 0.15s ease, opacity 0.2s ease;
        }

        .btn-gradient:hover {
            opacity: 0.95;
            transform: translateY(-1px);
        }

        .table-custom {
            color: var(--text-body) !important;
            background-color: transparent !important;
        }

        .table-custom th {
            background-color: var(--input-bg) !important;
            color: var(--text-subtle) !important;
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

        .status-open {
            background: rgba(245, 158, 11, 0.2);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .status-done {
            background: rgba(16, 185, 129, 0.2);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .ai-output-box {
            background-color: var(--input-bg);
            border: 1px dashed var(--border-color);
            border-radius: 12px;
            padding: 1.25rem;
            min-height: 110px;
        }
    </style>
</head>
<body>

    <%
        String reqTitle = request.getAttribute("title") != null ? (String) request.getAttribute("title") : "";
        String reqParticipants = request.getAttribute("participants") != null ? (String) request.getAttribute("participants") : "";
        String reqNotes = request.getParameter("rawNotes") != null ? request.getParameter("rawNotes") : "";
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>

    <!-- Navigation Header -->
    <header class="app-header py-3 mb-4">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2">
                <i class="fa-solid fa-brain fs-3" style="color: var(--accent-purple) !important;"></i>
                <span class="fs-4 brand-badge">DigiPlus AI</span>
                <span class="badge bg-secondary bg-opacity-20 text-light border border-secondary border-opacity-20 ms-2">v1.0</span>
            </div>
            <div class="d-flex align-items-center gap-3">
                <span class="small text-light d-none d-md-inline"><i class="fa-solid fa-circle text-success me-1"></i> System Ready</span>
                <a href="knowledge-base.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                    <i class="fa-solid fa-book me-1"></i> Knowledge Base
                </a>
            </div>
        </div>
    </header>

    <div class="container pb-5">
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger bg-danger bg-opacity-20 text-danger border-danger border-opacity-30 mb-4 rounded-3" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i><%= errorMessage %>
            </div>
        <% } %>

        <div class="row g-4">
            
            <!-- LEFT PANEL: Capture Form -->
            <div class="col-lg-5">
                <div class="custom-card p-4">
                    <div class="d-flex align-items-center gap-3 mb-4">
                        <div class="card-title-icon bg-primary bg-opacity-20 text-primary">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </div>
                        <div>
                            <h5 class="mb-0 fw-bold text-white">Capture & Transfer</h5>
                            <small style="color: var(--text-subtle);">Turn unstructured notes into action items</small>
                        </div>
                    </div>

                    <form action="ProcessMeetingServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label fw-bold">MEETING / HANDOVER TITLE</label>
                            <input type="text" name="title" class="form-control" value="<%= reqTitle %>" placeholder="e.g. Backend API Migration Review" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">PARTICIPANTS / DELEGATES</label>
                            <input type="text" name="participants" class="form-control" value="<%= reqParticipants %>" placeholder="e.g. Alex, Sarah, David" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">UNSTRUCTURED NOTES / EMAIL / TRANSCRIPT</label>
                            <textarea name="rawNotes" class="form-control" rows="7" placeholder="Paste unstructured meeting notes, Slack messages, or emails here..." required><%= reqNotes %></textarea>
                        </div>

                        <button type="submit" class="btn btn-gradient w-100 d-flex align-items-center justify-content-center gap-2">
                            <i class="fa-solid fa-wand-magic-sparkles"></i> Process & Structure with AI
                        </button>
                    </form>
                </div>
            </div>

            <!-- RIGHT PANEL: AI Outputs & Action Items -->
            <div class="col-lg-7">
                
                <!-- AI Structured Summary Box -->
                <div class="custom-card p-4 mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="card-title-icon bg-info bg-opacity-20 text-info">
                                <i class="fa-solid fa-robot"></i>
                            </div>
                            <div>
                                <h5 class="mb-0 fw-bold text-white">AI Structured Summary</h5>
                                <small style="color: var(--text-subtle);">Extracted decisions & core updates</small>
                            </div>
                        </div>
                        <span class="badge bg-secondary bg-opacity-50 text-light">Auto-Generated</span>
                    </div>

                    <div class="ai-output-box">
                    <% 
                        String summary = (String) request.getAttribute("aiSummary");
                        Boolean isSuccess = (Boolean) request.getAttribute("processSuccess");
                        if (isSuccess != null && isSuccess && summary != null) {
                    %>
                        <div class="text-success small mb-2"><i class="fa-solid fa-check-circle me-1"></i> AI Processing Complete (Request ID: <%= request.getAttribute("requestId") %>)</div>
                        <p class="mb-0 text-white fw-medium"><%= summary %></p>
                    <% } else { %>
                        <p class="mb-0 small" style="color: var(--text-body);">
                            <i class="fa-solid fa-circle-info me-1 text-info"></i> Submit meeting notes on the left to view the AI-generated context recap and decision points.
                        </p>
                    <% } %>
                    </div>
                </div>

                <!-- Action Items Table -->
                <div class="custom-card p-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="card-title-icon bg-success bg-opacity-20 text-success">
                                <i class="fa-solid fa-list-check"></i>
                            </div>
                            <div>
                                <h5 class="mb-0 fw-bold text-white">Action Items Lifecycle</h5>
                                <small style="color: var(--text-subtle);">Tracking open and carried-forward tasks</small>
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-light rounded-pill" data-bs-toggle="modal" data-bs-target="#addTaskModal">
                            <i class="fa-solid fa-plus me-1"></i> Add Task
                        </button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-custom align-middle mb-0" id="actionTaskTable">
                            <thead>
                                <tr>
                                    <th>Task Name</th>
                                    <th>Owner</th>
                                    <th>Due Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                java.util.List<java.util.Map<String, String>> tasks = (java.util.List<java.util.Map<String, String>>) request.getAttribute("taskList");
                                if (tasks != null && !tasks.isEmpty()) {
                                    for (java.util.Map<String, String> task : tasks) {
                            %>
                                <tr>
                                    <td class="fw-semibold"><%= task.get("name") %></td>
                                    <td class="text-info fw-medium"><%= task.get("owner") %></td>
                                    <td style="color: var(--text-subtle);" class="small"><%= task.get("dueDate") %></td>
                                    <td>
                                        <% if ("Open".equalsIgnoreCase(task.get("status"))) { %>
                                            <span class="status-badge status-open"><i class="fa-solid fa-clock me-1"></i> Open</span>
                                        <% } else { %>
                                            <span class="status-badge status-done"><i class="fa-solid fa-check me-1"></i> Closed</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <% 
                                    }
                                } else { 
                            %>
                                <tr>
                                    <td class="fw-semibold">Refactor Auth Middleware</td>
                                    <td class="text-info fw-medium">Sarah</td>
                                    <td style="color: var(--text-subtle);" class="small">Nov 02, 2026</td>
                                    <td><span class="status-badge status-open"><i class="fa-solid fa-clock me-1"></i> Open</span></td>
                                </tr>
                                <tr>
                                    <td class="fw-semibold">Configure Logging Pipeline</td>
                                    <td class="text-info fw-medium">Alex</td>
                                    <td style="color: var(--text-subtle);" class="small">Oct 31, 2026</td>
                                    <td><span class="status-badge status-done"><i class="fa-solid fa-check me-1"></i> Closed</span></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

        </div>

        <!-- CATCH-UP BRIEF BANNER -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="custom-card p-4 d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="card-title-icon bg-warning bg-opacity-20 text-warning fs-4">
                            <i class="fa-solid fa-bolt"></i>
                        </div>
                        <div>
                            <h6 class="mb-1 fw-bold text-white">Missed a meeting or taking over a role?</h6>
                            <p class="mb-0 small" style="color: var(--text-subtle);">Generate an instant catch-up brief with linked historical context.</p>
                        </div>
                    </div>
                    <a href="catchup-brief.jsp?title=<%= reqTitle %>&participants=<%= reqParticipants %>" class="btn btn-outline-info rounded-pill px-4 text-nowrap">
                        <i class="fa-solid fa-compass me-1"></i> Generate Catch-Up Brief
                    </a>
                </div>
            </div>
        </div>

    </div>

    <!-- Modal for Dynamic Task Creation -->
    <div class="modal fade" id="addTaskModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-secondary" style="background-color: var(--card-bg); color: var(--text-body);">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title text-white"><i class="fa-solid fa-plus-circle me-2 text-info"></i>Add Action Item</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold">TASK NAME</label>
                        <input type="text" id="newTaskName" class="form-control" placeholder="e.g. Conduct security vulnerability assessment">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">OWNER / DELEGATE</label>
                        <input type="text" id="newTaskOwner" class="form-control" placeholder="e.g. Sarah">
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-gradient" onclick="addNewTask()">Add Task</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function addNewTask() {
            const name = document.getElementById('newTaskName').value.trim();
            const owner = document.getElementById('newTaskOwner').value.trim();

            if (!name || !owner) {
                alert('Please fill out both Task Name and Owner.');
                return;
            }

            const tableBody = document.querySelector('#actionTaskTable tbody');
            const newRow = document.createElement('tr');
            newRow.innerHTML = `
                <td class="fw-semibold">\${name}</td>
                <td class="text-info fw-medium">\${owner}</td>
                <td style="color: var(--text-subtle);" class="small">Nov 05, 2026</td>
                <td><span class="status-badge status-open"><i class="fa-solid fa-clock me-1"></i> Open</span></td>
            `;

            tableBody.appendChild(newRow);

            // Reset inputs and close modal
            document.getElementById('newTaskName').value = '';
            document.getElementById('newTaskOwner').value = '';
            const modalElement = document.getElementById('addTaskModal');
            const modalInstance = bootstrap.Modal.getInstance(modalElement);
            modalInstance.hide();
        }
    </script>
</body>
</html>