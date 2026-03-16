package com.freelancer.contoller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.FreelancerService;
import com.model.FreelancerProfile;

/**
 * Servlet implementation class FreelancerProfileServlet
 */
@WebServlet("/FreelancerProfileServlet")
public class FreelancerProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreelancerProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);

		if(session==null || session.getAttribute("id")==null){
		response.sendRedirect("login.jsp");
		return;
		}
		
		
		
		int id=(int)session.getAttribute("id");

		FreelancerService service=new FreelancerService();

		try{

		FreelancerProfile profile=service.getProfile(id);

		request.setAttribute("profile",profile);

		request.getRequestDispatcher("freelancer_dashboard.jsp")
		.forward(request,response);

		}catch(Exception e){ e.printStackTrace(); }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);

		int id=(int)session.getAttribute("id");

		FreelancerProfile p=new FreelancerProfile();
		
		String exp = request.getParameter("experience");
		String rate = request.getParameter("rate");

		

		p.setId(id);
		p.setPhone(request.getParameter("phone"));
		p.setTitle(request.getParameter("title"));
		p.setSkills(request.getParameter("skills"));
		
		if(exp != null && !exp.trim().isEmpty()){
		    p.setExperienceYears(Integer.parseInt(exp));
		}else{
		    p.setExperienceYears(0);
		}

		if(rate != null && !rate.trim().isEmpty()){
		    p.setHourlyRate(Double.parseDouble(rate));
		}else{
		    p.setHourlyRate(0);
		}
		
		p.setBio(request.getParameter("bio"));

		FreelancerService service=new FreelancerService();

		try{
		service.updateProfile(p);
		response.sendRedirect("FreelancerProfileServlet");
		}catch(Exception e){e.printStackTrace();
		}
	}

}
