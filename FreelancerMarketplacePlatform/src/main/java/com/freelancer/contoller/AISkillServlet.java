package com.freelancer.contoller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/AISkillServlet")
public class AISkillServlet extends HttpServlet {

    // ✅ Your new Gemini API key
    private static final String API_KEY = "AIzaSyDC8RtgYrMQNXT1SvFn9zRCagrsWvQiCAs";

    private static final String API_URL =
    	    "https://generativelanguage.googleapis.com/v1beta/models/"
    	    + "gemini-2.5-flash:generateContent?key=";
    
    private static final Map<String, String> cache = 
            Collections.synchronizedMap(new LinkedHashMap<>() {
                protected boolean removeEldestEntry(Map.Entry e) {
                    return size() > 100; // keep last 100 queries
                }
            });

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        
     // Return cached result if available
        if (cache.containsKey(query)) {
            System.out.println("Cache HIT for: " + query);
            response.setContentType("application/json");
            response.getWriter().write(cache.get(query));
            return;
        }


        System.out.println("=== AISkillServlet HIT ===");
        System.out.println("Query received: " + query);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // ── Guard ──────────────────────────────────────
        if (query == null || query.trim().length() < 3) {
            response.getWriter().write("[]");
            return;
        }

        // ── Sanitize ───────────────────────────────────
        String safeQuery = query.replace("\\", "\\\\")
                                .replace("\"", "\\\"")
                                .replace("\n", " ")
                                .replace("\r", " ")
                                .trim();

        try {
            String prompt =
                "You are a freelance job platform assistant. "
              + "Respond ONLY with a raw JSON array of 6 to 8 relevant "
              + "freelance skill name strings. "
              + "No markdown, no backticks, no explanation, no extra text. "
              + "Example: [\\\"React\\\",\\\"Node.js\\\",\\\"MongoDB\\\"]. "
              + "Suggest skills for: " + safeQuery;

            String body = "{"
                + "\"contents\":[{"
                +   "\"parts\":[{"
                +     "\"text\":\"" + prompt + "\""
                +   "}]"
                + "}],"
                + "\"generationConfig\":{"
                +   "\"temperature\":0.4,"
                +   "\"maxOutputTokens\":1024"
                + "}"
                + "}";

            System.out.println("Request body: " + body);
            System.out.println("Calling Gemini API...");

            URL url = new URL(API_URL + API_KEY);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(15000);
            conn.setDoOutput(true);

            byte[] bodyBytes = body.getBytes("UTF-8");
            OutputStream os = conn.getOutputStream();
            os.write(bodyBytes);
            os.flush();
            os.close();

            int statusCode = conn.getResponseCode();
            System.out.println("HTTP Status Code: " + statusCode);

            BufferedReader br;
            if (statusCode == 200) {
                br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));
            } else {
                br = new BufferedReader(
                    new InputStreamReader(conn.getErrorStream(), "UTF-8"));
                StringBuilder errSb = new StringBuilder();
                String errLine;
                while ((errLine = br.readLine()) != null) errSb.append(errLine);
                br.close();
                System.err.println("Gemini API Error [" + statusCode + "]: " + errSb);
                response.getWriter().write("{\"error\":\"API error " + statusCode + "\"}");
                return;
            }

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            br.close();
            conn.disconnect();

            String geminiJson = sb.toString();
            System.out.println("Gemini RAW response: " + geminiJson);

            String skillsArray = extractSkillsArray(geminiJson);
            System.out.println("Extracted skills array: " + skillsArray);

            String escapedSkills = skillsArray.replace("\\", "\\\\")
                                              .replace("\"", "\\\"");

            String finalResponse = "{\"content\":[{\"text\":\""
                + escapedSkills + "\"}]}";

            System.out.println("Final response to JSP: " + finalResponse);
            
            cache.put(query, finalResponse);           // save to cache
            response.getWriter().write(finalResponse);


        } catch (Exception e) {
            System.err.println("EXCEPTION in AISkillServlet: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private String extractSkillsArray(String geminiJson) {
        try {
            int textIndex = geminiJson.indexOf("\"text\":");
            if (textIndex == -1) {
                System.out.println("extractSkillsArray: 'text' field not found");
                return "[]";
            }

            int afterColon = geminiJson.indexOf(":", textIndex) + 1;
            while (afterColon < geminiJson.length()
                   && geminiJson.charAt(afterColon) == ' ') {
                afterColon++;
            }

            int start = geminiJson.indexOf("\"", afterColon) + 1;
            int end = start;
            while (end < geminiJson.length()) {
                end = geminiJson.indexOf("\"", end);
                if (end == -1) break;
                int backslashes = 0;
                int check = end - 1;
                while (check >= 0 && geminiJson.charAt(check) == '\\') {
                    backslashes++;
                    check--;
                }
                if (backslashes % 2 == 0) break;
                end++;
            }

            if (end == -1 || end <= start) {
                System.out.println("extractSkillsArray: could not find end quote");
                return "[]";
            }

            String raw = geminiJson.substring(start, end);
            System.out.println("Raw extracted text: " + raw);

            raw = raw.replace("\\\"", "\"")
                     .replace("\\n", "")
                     .replace("\\r", "")
                     .replace("\\t", "")
                     .trim();

            raw = raw.replaceAll("(?i)```json", "")
                     .replaceAll("```", "")
                     .trim();

            if (!raw.startsWith("[")) {
                System.out.println("extractSkillsArray: result does not start with [");
                return "[]";
            }

            return raw;

        } catch (Exception e) {
            System.err.println("extractSkillsArray EXCEPTION: " + e.getMessage());
            e.printStackTrace();
            return "[]";
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // delegate
    }
}