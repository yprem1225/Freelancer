package com.freelancer.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.FreelancerProfile;
import com.util.DBConnection;

public class FreelancerService {
	
	public FreelancerProfile getProfile(int id) throws SQLException {
		
		try {
			Connection con = DBConnection.getConnection();
			
			String sql = """
				    SELECT u.id, u.name, u.email, u.role,
				           f.phone, f.title, f.skills, f.experience_years,
				           f.hourly_rate, f.bio, f.profile_completed, f.linkedin_url
				    FROM users u
				    LEFT JOIN freelancer_profile f ON u.id = f.user_id
				    WHERE u.id = ?
				    """;

	        PreparedStatement ps = con.prepareStatement(sql);
	        
	        ps.setInt(1,id);

	        ResultSet rs = ps.executeQuery();
	        
	        if(rs.next()){

	            FreelancerProfile p = new FreelancerProfile();

	            p.setId(rs.getInt("id"));
	            p.setName(rs.getString("name"));
	            p.setEmail(rs.getString("email"));
	            p.setRole(rs.getString("role"));

	            p.setPhone(rs.getString("phone"));
	            p.setTitle(rs.getString("title"));
	            p.setSkills(rs.getString("skills"));
	            p.setExperienceYears(rs.getInt("experience_years"));
	            p.setHourlyRate(rs.getDouble("hourly_rate"));
	            p.setBio(rs.getString("bio"));
	            p.setProfileCompleted(rs.getInt("profile_completed"));
	            p.setLinkedinUrl(rs.getString("linkedin_url"));

	            return p;
	        }
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		// TODO Auto-generated method stub
		
	}
	
	
	public void updateProfile(FreelancerProfile profile) throws SQLException {
		
		 try {
		        Connection con = DBConnection.getConnection();

		        int completed = 2;
		        int total = 8; // ← was 7, now 8 (added linkedin)

		        if (profile.getPhone() != null && !profile.getPhone().isEmpty()) completed++;
		        if (profile.getTitle() != null && !profile.getTitle().isEmpty()) completed++;
		        if (profile.getSkills() != null && !profile.getSkills().isEmpty()) completed++;
		        if (profile.getExperienceYears() > 0) completed++;
		        if (profile.getHourlyRate() > 0) completed++;
		        if (profile.getBio() != null && !profile.getBio().isEmpty()) completed++;
		        if (profile.getLinkedinUrl() != null && !profile.getLinkedinUrl().isEmpty()) completed++; // ← NEW

		        int percentage = (completed * 100) / total;

		        String sql = """
		            INSERT INTO freelancer_profile
		            (user_id, phone, title, skills, experience_years, hourly_rate, bio, linkedin_url, profile_completed)
		            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
		            ON DUPLICATE KEY UPDATE
		            phone            = VALUES(phone),
		            title            = VALUES(title),
		            skills           = VALUES(skills),
		            experience_years = VALUES(experience_years),
		            hourly_rate      = VALUES(hourly_rate),
		            bio              = VALUES(bio),
		            linkedin_url     = VALUES(linkedin_url),
		            profile_completed = VALUES(profile_completed)
		            """;

		        PreparedStatement ps = con.prepareStatement(sql);

		        ps.setInt(1, profile.getId());
		        ps.setString(2, profile.getPhone());
		        ps.setString(3, profile.getTitle());
		        ps.setString(4, profile.getSkills());
		        ps.setInt(5, profile.getExperienceYears());
		        ps.setDouble(6, profile.getHourlyRate());
		        ps.setString(7, profile.getBio());
		        ps.setString(8, profile.getLinkedinUrl()); // ← NEW
		        ps.setInt(9, percentage);                  // ← shifted from 8 → 9

		        ps.executeUpdate();
		        con.close();

		    } catch (ClassNotFoundException e) {
		        e.printStackTrace();
		    }

	}

}
