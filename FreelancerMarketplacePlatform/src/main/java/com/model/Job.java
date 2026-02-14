package com.model;

import java.util.List;

public class Job {
	private int jobId;
	private int userId;
	private String title;
	private String complexity;
	private String duration;
	private String freelancerLevel;
	private String budget;
	private String description;
	private String status;
	private List<JobSkill> skills;
	public int getJobId() {
		return jobId;
	}
	public void setJobId(int jobId) {
		this.jobId = jobId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getComplexity() {
		return complexity;
	}
	public void setComplexity(String complexity) {
		this.complexity = complexity;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getFreelancerLevel() {
		return freelancerLevel;
	}
	public void setFreelancerLevel(String freelancerLevel) {
		this.freelancerLevel = freelancerLevel;
	}
	public String getBudget() {
		return budget;
	}
	public void setBudget(String budget) {
		this.budget = budget;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public List<JobSkill> getSkills() {
		return skills;
	}
	public void setSkills(List<JobSkill> skills) {
		this.skills = skills;
	}

	
	
	

}
