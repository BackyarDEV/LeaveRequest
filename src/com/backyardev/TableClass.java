package com.backyardev;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.backyardev.util.DatabaseConnection;
import com.backyardev.util.LeaveReqObject;

import java.sql.*;

public class TableClass {
	public  ArrayList<LeaveReqObject>  getTable() {
		// Database details
		String JDBC_DRIVER  =  "com.mysql.cj.jdbc.Driver";
	 	String JDBC_DB_URL = "jdbc:mysql://localhost:3306/J1_EMP ";
	 	
	    // JDBC Database Credentials
	   String JDBC_USER = "root";
	   String JDBC_PASS = "root";
	   Connection  conn;
	   ResultSet resultSet = null ;
	   ArrayList<LeaveReqObject>  lr  = new ArrayList();
	   
	   
		try{ 
			DatabaseConnection dc = DatabaseConnection.getInstance();
			conn = dc.getConnection();
			Statement statement= conn.createStatement();
			String sql = "SELECT * FROM LEAVE_REQUEST  WHERE  ecode = 'E01116'";
			
			resultSet = statement.executeQuery(sql);
			
			

			while (resultSet.next()) {
				LeaveReqObject obj = new LeaveReqObject();
				obj.setId(resultSet.getInt("id"));
				obj.setEcode(resultSet.getString("ecode"));
				obj.setName(resultSet.getString("name"));
				obj.setTeamLead(resultSet.getString("team_lead"));
				obj.setProjectManager(resultSet.getString("project_manager"));
				obj.setProjectName(resultSet.getString("project_name"));
				obj.setStartDate(resultSet.getString("leave_start_date"));
				obj.setEndDate(resultSet.getString("leave_end_date"));
				obj.setNumberOfDays(resultSet.getInt("number_of_days"));
				obj.setLeaveType(resultSet.getString("leave_type"));
				obj.setLeaveDesc(resultSet.getString("leave_desc"));
				lr.add(obj);
			}
			
			} catch (Exception e) {
			e.printStackTrace();
			} 
		System.out.println(( lr.get(0)).getEcode());
		System.out.println((lr.get(0)).getName());
		return lr;
	}
}
