package com.freelancer.services;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Job;
import com.util.DBConnection;

public class JobService {
    
    // Create job - returns new job ID
    public int createJob(Job job) throws SQLException, ClassNotFoundException {
    	Connection con=DBConnection.getConnection();
    	
    	String sql = "INSERT INTO jobs(user_id, title, status) VALUES (?, ?, 'DRAFT')";
    	PreparedStatement ps= con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
    	ps.setInt(1, job.getUserId());
    	ps.setString(2, job.getTitle());
    	ps.executeUpdate();
    	
    	ResultSet rs=ps.getGeneratedKeys();
    	if(rs.next()) {
    		return rs.getInt(1);
    	}
		return 0;
    } 
    
    //UPDATE title when user comes back
    public void updateJobTitle(int jobId, String title) throws ClassNotFoundException, SQLException {
		Connection con = DBConnection.getConnection();
		
		String sql="UPDATE jobs SET title=? WHERE job_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, title);
		ps.setInt(2, jobId);
		ps.executeUpdate();
	}
    
    //fetch title (for pre-fill)
    
    public String getJobTitle(int jobId) throws ClassNotFoundException, SQLException {
    	Connection con = DBConnection.getConnection();
    	String sql = "select title from jobs where job_id=?";
    	PreparedStatement ps = con.prepareStatement(sql);
    	ps.setInt(1,jobId);
    	
    	ResultSet rs = ps.executeQuery();
    	if (rs.next()) {
    		System.out.println("title fetched");
			return rs.getString("title");
			
		}
    	
    	
		return "" ;
	}
    
    @SuppressWarnings("unchecked")
	public Job getJobById(int jobId) throws SQLException {
    	Job job = new Job();
    	try {
			Connection con = DBConnection.getConnection();
			String sql= "SELECT * FROM jobs WHERE job_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, jobId);
			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				job.setJobId(jobId);
				job.setUserId(rs.getInt("user_id"));
		        job.setTitle(rs.getString("title"));
				job.setComplexity(rs.getString("complexity"));
				job.setDuration(rs.getString("duration"));
				job.setFreelancerLevel(rs.getString("freelancer_level"));
				job.setBudget(rs.getString("budget"));
		        job.setDescription(rs.getString("description"));
		        job.setStatus(rs.getString("status"));

		        JobSkillService skillService = new JobSkillService();
		        job.setSkills(skillService.getSkillsByJobId(jobId));
			}

    	} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return job;
	}
    // to come back and update job details
    public void updateJobDetails(Job job) throws SQLException {
    	try {
			Connection connection = DBConnection.getConnection();
			String sql = "UPDATE jobs SET complexity=?, duration=?, freelancer_level=? WHERE job_id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			
			    ps.setString(1, job.getComplexity());
	            ps.setString(2, job.getDuration());
	            ps.setString(3, job.getFreelancerLevel());
	            ps.setInt(4, job.getJobId());
	            ps.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    // to get jobBudget when hit back button  
    public Integer getBudgetById(int jobId) throws SQLException {
    	 Integer budget = null;
    	try {
			Connection con = DBConnection.getConnection();
			
			String sql =  "SELECT budget FROM jobs WHERE job_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, jobId); 
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				budget= rs.getInt("budget");
			}
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		return budget;
	}
    // to press back and update jobbudget
    public void updateJobBudget(int jobId , int budget) throws ClassNotFoundException, SQLException {
		
    	Connection con = DBConnection.getConnection();
    	
    	String sql = "UPDATE jobs SET budget = ? WHERE job_id = ?";
    	PreparedStatement ps = con.prepareStatement(sql);
    	
    	ps.setInt(1, budget);
    	ps.setInt(2, jobId);
    	
    	ps.executeUpdate();

	}
    
    //to get description from DB
    public String getDescriptionById(int JobId) throws SQLException {
    	
    	try {
			Connection con = DBConnection.getConnection();
			String sql = "SELECT description FROM jobs WHERE job_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, JobId);
			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				return rs.getString("description");
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	

	}
    

    //to update,insert description and change status to active
    
    public void updateDescriptionAndActivate(int jobId , String description ) throws SQLException {
		
    	try {
			Connection con = DBConnection.getConnection();
			String sql = "UPDATE jobs SET description = ?, status = 'active' WHERE job_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, description);
			ps.setInt(2, jobId);
			
			ps.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
	}
    
    // to check whether profile is completed before post job
    
    public boolean isProfileCompleted(int clientId) throws SQLException {
    	
    	Connection con;
		try {
			con = DBConnection.getConnection();
			String sql = "SELECT profile_completed FROM clients WHERE user_id = ?";
	    	PreparedStatement ps = con.prepareStatement(sql);
	    	ps.setInt(1, clientId);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	if (rs.next()) {
	    		return rs.getInt("profile_completed")==100; // if 100 = 100 return true or else false 
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
    
    //to get active jobs
    
    @SuppressWarnings("unchecked")
	public List<Job> getActiveJobsByUser(int id) throws SQLException {
    	List<Job> jobs = new ArrayList<Job>();
    	
    	try {
			Connection con = DBConnection.getConnection();
			
			String sql = "SELECT * FROM jobs WHERE status='active' AND user_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1,id);
			
			ResultSet rs = ps.executeQuery();
			
			JobSkillService skillservice = new JobSkillService();
			
			while (rs.next()) {

	            Job job = new Job();
	            job.setJobId(rs.getInt("job_id"));
	            job.setUserId(rs.getInt("user_id"));
	            job.setTitle(rs.getString("title"));
	            job.setComplexity(rs.getString("complexity"));
	            job.setDuration(rs.getString("duration"));
	            job.setFreelancerLevel(rs.getString("freelancer_level"));
	            job.setBudget(rs.getString("budget"));
	            job.setDescription(rs.getString("description"));
	            job.setStatus(rs.getString("status"));

	            // 👇 attach skills
	            job.setSkills(skillservice.getSkillsByJobId(job.getJobId()));
	            

	            jobs.add(job);
	        }
			
			System.out.println("Active jobs found: " + jobs.size()); // DEBUG

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jobs;
	}
    
    
    // to delete active jobs
    
    public void deleteJobById(int jobId) throws ClassNotFoundException, SQLException {
    	
    	Connection con = DBConnection.getConnection();
    	
    	// First delete skills (important because of foreign key)
    	 String sql =  "DELETE FROM job_skills WHERE job_id=?";
    	 PreparedStatement ps1 = con.prepareStatement(sql);
         ps1.setInt(1, jobId);
         ps1.executeUpdate();
         
         // Then delete job
         String deleteJob = "DELETE FROM jobs WHERE job_id=?";
         PreparedStatement ps2 = con.prepareStatement(deleteJob);
         ps2.setInt(1, jobId);
         ps2.executeUpdate();
	}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}