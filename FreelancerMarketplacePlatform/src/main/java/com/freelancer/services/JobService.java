package com.freelancer.services;

import java.sql.*;
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
				job.setComplexity(rs.getString("complexity"));
				job.setDuration(rs.getString("duration"));
				job.setFreelancerLevel(rs.getString("freelancer_level"));
			}

    	} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return job;
	}
    
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
    
    public void updateJobBudget(int jobId , int budget) throws ClassNotFoundException, SQLException {
		
    	Connection con = DBConnection.getConnection();
    	
    	String sql = "UPDATE jobs SET budget = ? WHERE job_id = ?";
    	PreparedStatement ps = con.prepareStatement(sql);
    	
    	ps.setInt(1, budget);
    	ps.setInt(2, jobId);
    	
    	ps.executeUpdate();

	}
    

    
    

}