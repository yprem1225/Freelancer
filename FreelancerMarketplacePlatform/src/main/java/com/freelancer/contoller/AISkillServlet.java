package com.freelancer.contoller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;

import java.net.URL;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class AISkillServlet
 */
@SuppressWarnings("serial")
@WebServlet("/AISkillServlet")
public class AISkillServlet extends HttpServlet {
	private static final String API_KEY = "sk-ant-api03-your-key-here";
  
	@SuppressWarnings("deprecation")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String query = request.getParameter("query");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Build JSON body
            String body = "{"
                + "\"model\":\"claude-haiku-4-5-20251001\","
                + "\"max_tokens\":300,"
                + "\"system\":\"You are a freelance job platform assistant. Respond ONLY with a JSON array of 6-8 relevant skill names as strings. No explanation, no markdown, just the raw JSON array.\","
                + "\"messages\":[{\"role\":\"user\",\"content\":\"Suggest skills for: " + query + "\"}]"
                + "}";

            // Open connection
            URL url = new URL("https://api.anthropic.com/v1/messages");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("x-api-key", API_KEY);
            conn.setRequestProperty("anthropic-version", "2023-06-01");
            conn.setDoOutput(true);

            // Send request
            OutputStream os = conn.getOutputStream();
            os.write(body.getBytes("UTF-8"));
            os.flush();
            os.close();

            // Read response
            BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8")
            );
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            br.close();

            response.getWriter().write(sb.toString());

        } catch (Exception e) {
            response.setStatus(200);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
	}

	
}
