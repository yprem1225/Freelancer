package com.freelancer.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.JobSkill;

import com.util.DBConnection;

public class JobSkillService {
	
	public  void addSkill(int jobId , String skill) throws SQLException {
		 String sql = "INSERT INTO job_skills (job_id, skill_name) VALUES (?, ?)";
		 
		 try {
			Connection con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, jobId);
			ps.setString(2, skill);
			
			ps.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		

	}
	
	public void deleteSkillByJobId(int jobId) throws  SQLException {
		  String sql = "DELETE FROM job_skills WHERE job_id = ?";
		  
		  Connection con;
		try {
			con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			  
			  ps.setInt(1, jobId);
			  ps.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	
	@SuppressWarnings("rawtypes")
	public List getSkillsByJobId(int jobId) {
        List<JobSkill> list = new ArrayList<>();
        String sql = "SELECT * FROM job_skills WHERE job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JobSkill js = new JobSkill();
                js.setId(rs.getInt("id"));
                js.setJobId(rs.getInt("job_id"));
                js.setSkillName(rs.getString("skill_name"));
                list.add(js);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
