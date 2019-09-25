package com.backyardev.util;

public class EmployeesObjectClass {
	
	private static String name, ecode, email, project, teamLead, projectManager, designation;

	public static String getName() {
		return name;
	}

	public void setName(String name) {
		EmployeesObjectClass.name = name;
	}

	public static String getEcode() {
		return ecode;
	}

	public void setEcode(String ecode) {
		EmployeesObjectClass.ecode = ecode;
	}

	public void setEmail(String email) {
		EmployeesObjectClass.email = email;
	}
	
	public static String getEmail() {
		return email;
	}
	
	public static String getProject() {
		return project;
	}

	public void setProject(String project) {
		EmployeesObjectClass.project = project;
	}

	public static String getTeamLead() {
		return teamLead;
	}

	public void setTeamLead(String teamLead) {
		EmployeesObjectClass.teamLead = teamLead;
	}

	public static String getProjectManager() {
		return projectManager;
	}

	public void setProjectManager(String projectManager) {
		EmployeesObjectClass.projectManager = projectManager;
	}

	public static String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		EmployeesObjectClass.designation = designation;
	}
	
}
