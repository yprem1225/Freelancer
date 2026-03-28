<%@ page import="java.util.List" %>
<%@ page import="com.model.ChatMessage" %>

<%
    List<ChatMessage> list = (List<ChatMessage>)request.getAttribute("messages");
    // Get current user ID from session to align bubbles correctly
    Integer currentUserId = (Integer) session.getAttribute("userId"); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Chat | WorkPort</title>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --blue: #2563eb;
            --blue2: #1d4ed8;
            --bluelt: #eff6ff;
            --g50: #f9fafb;
            --g100: #f3f4f6;
            --g200: #e5e7eb;
            --g400: #9ca3af;
            --g600: #4b5563;
            --g800: #1f2937;
            --white: #ffffff;
            --shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: #f1f5f9;
            margin: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        /* --- TOP NAVIGATION --- */
        .topbar {
            height: 64px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--g200);
            display: flex; align-items: center;
            padding: 0 5%;
            position: sticky; top: 0; z-index: 1000;
        }

        .logo { display: flex; align-items: center; gap: 8px; text-decoration: none; }
        .logo-txt { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.4rem; font-weight: 800; }
        .logo-txt .w { color: var(--g800); }
        .logo-txt .p { color: var(--blue); }

        .btn-home {
            margin-left: auto;
            display: inline-flex; align-items: center; gap: 6px;
            padding: 8px 16px;
            background: #fff; border: 1.5px solid var(--g200);
            border-radius: 8px; font-size: 13px; font-weight: 700;
            color: var(--g600); cursor: pointer; text-decoration: none;
            transition: all .18s;
        }
        .btn-home:hover { border-color: var(--blue); color: var(--blue); background: var(--bluelt); }

        /* --- CHAT CONTAINER --- */
        .chat-container {
            max-width: 900px;
            width: 95%;
            margin: 20px auto;
            background: var(--white);
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            flex: 1;
            overflow: hidden;
            border: 1.5px solid var(--g200);
            box-shadow: var(--shadow);
        }

        .chat-header {
            padding: 16px 24px;
            background: var(--white);
            border-bottom: 1px solid var(--g200);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .chat-header h2 {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.1rem;
            margin: 0;
            color: var(--g800);
        }

        /* --- MESSAGES AREA --- */
        .messages-area {
            flex: 1;
            padding: 24px;
            overflow-y: auto;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .messages-area::-webkit-scrollbar { width: 5px; }
        .messages-area::-webkit-scrollbar-thumb { background: var(--g200); border-radius: 10px; }

        .msg-wrapper {
            max-width: 75%;
            display: flex;
            flex-direction: column;
        }

        .msg-left { align-self: flex-start; }
        .msg-right { align-self: flex-end; }

        .msg-bubble {
            padding: 12px 16px;
            border-radius: 18px;
            font-size: 14px;
            line-height: 1.5;
        }

        .msg-left .msg-bubble {
            background: var(--white);
            color: var(--g800);
            border: 1px solid var(--g200);
            border-bottom-left-radius: 4px;
        }

        .msg-right .msg-bubble {
            background: var(--blue);
            color: var(--white);
            border-bottom-right-radius: 4px;
        }

        .msg-meta {
            font-size: 10px;
            color: var(--g400);
            margin-top: 4px;
            font-weight: 600;
        }
        .msg-right .msg-meta { text-align: right; }

        .sender-name {
            font-size: 11px;
            font-weight: 800;
            margin-bottom: 4px;
            color: var(--g600);
        }

        /* --- INPUT AREA --- */
        .input-area {
            padding: 16px 24px;
            background: var(--white);
            border-top: 1px solid var(--g200);
        }

        .chat-form {
            display: flex;
            align-items: center;
            gap: 12px;
            background: var(--g50);
            padding: 8px 12px;
            border-radius: 14px;
            border: 1.5px solid var(--g200);
        }

        .chat-input {
            flex: 1;
            border: none;
            background: transparent;
            padding: 8px;
            font-size: 14px;
            outline: none;
            color: var(--g800);
        }

        .icon-btn {
            color: var(--g400);
            font-size: 20px;
            cursor: pointer;
            background: none;
            border: none;
            padding: 5px;
            transition: color 0.2s;
            display: flex; align-items: center;
        }
        .icon-btn:hover { color: var(--blue); }

        .send-btn {
            background: var(--blue);
            color: var(--white);
            border: none;
            width: 38px;
            height: 38px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }
        .send-btn:hover { background: var(--blue2); transform: scale(1.05); }

    </style>
</head>
<body>

    <nav class="topbar">
        <a href="ClientHomeServlet" class="logo">
            <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:32px;height:32px;">
                <rect width="34" height="34" rx="9" fill="#2563eb"/>
                <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
                <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
                <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
        </a>
        <a href="ClientHomeServlet" class="btn-home">
            <i class="bi bi-house-door"></i> Back to DashBoard
        </a>
    </nav>

    <div class="chat-container">
        <div class="chat-header">
            <i class="bi bi-chat-dots-fill" style="color: var(--blue)"></i>
            <h2>Project Messages</h2>
        </div>

        <div class="messages-area" id="msgBox">
            <%
                if(list != null){
                    for(ChatMessage m : list){
                        boolean isMe = (currentUserId != null && currentUserId.equals(m.getSenderId()));
            %>
                <div class="msg-wrapper <%= isMe ? "msg-right" : "msg-left" %>">
                    <% if(!isMe) { %>
                        <span class="sender-name">User <%=m.getSenderId()%></span>
                    <% } %>
                    <div class="msg-bubble">
                        <%=m.getMessage()%>
                    </div>
                    <div class="msg-meta"><%=m.getTime()%></div>
                </div>
            <%
                    }
                }
            %>
        </div>

        <div class="input-area">
            <form action="SendMessageServlet" method="post" class="chat-form">
                
                <button type="button" class="icon-btn" onclick="document.getElementById('file-input').click()">
                    <i class="bi bi-plus-circle"></i>
                </button>
                <input type="file" id="file-input" name="file" style="display:none">

                <input type="hidden" name="chatId" value="<%=request.getAttribute("chatId")%>">
                <input type="hidden" name="jobId" value="<%=request.getAttribute("jobId")%>">

                <input type="text" name="message" class="chat-input" placeholder="Type your message here..." required>

                <button type="submit" class="send-btn">
                    <i class="bi bi-send-fill"></i>
                </button>
            </form>
        </div>
    </div>

    <script>
        // Smooth scroll to bottom on load
        const box = document.getElementById('msgBox');
        box.scrollTop = box.scrollHeight;
    </script>

</body>
</html>