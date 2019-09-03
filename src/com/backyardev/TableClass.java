package com.backyardev;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.backyardev.util.DatabaseConnection;
import com.backyardev.util.LeaveReqObject;


public class TableClass {
	public  ArrayList<LeaveReqObject>  getTable(String ecode, String desg, String tl_name) {
		Connection  conn;
		ResultSet resultSet = null ;
		String sql;
		PreparedStatement ps = null;
		ArrayList<LeaveReqObject>  lr  = new ArrayList<LeaveReqObject>(); 
		try{ 
			DatabaseConnection dc = DatabaseConnection.getInstance();
			conn = dc.getConnection();
			if (desg.equals("Admin") || desg.equals("Super_Admin")) {
				sql = "SELECT * FROM LEAVE_REQUEST, LEAVE_STATUS WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id order by leave_request_time desc";
				ps = conn.prepareStatement(sql);
			} else if (desg.equals("TeamLead")) {
				sql = "SELECT * FROM LEAVE_REQUEST, LEAVE_STATUS WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND team_lead = ? order by leave_request_time desc";
				ps = conn.prepareStatement(sql);
				ps.setString(1, tl_name);
			} else {
				sql = "SELECT * FROM LEAVE_REQUEST, LEAVE_STATUS WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND ecode = ? order by leave_request_time desc";

				ps = conn.prepareStatement(sql);
				ps.setString(1, ecode);
			}
			resultSet = ps.executeQuery();

			while (resultSet.next()) {
				LeaveReqObject obj = new LeaveReqObject();
				if(resultSet.getInt("status")== 0) {
					obj.setStatus("Pending");
				} else if(resultSet.getInt("status")== 1) {
					obj.setStatus("Approved");
				} else {
					obj.setStatus("Rejected");
				}
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
		return lr;
	}
}