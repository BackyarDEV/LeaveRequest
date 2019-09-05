package com.backyardev.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DatabaseQueries {
	
	private static Connection conn = null;
	private static ResultSet rs = null;
	private static PreparedStatement pst = null;
	private static String sql = "";
	
	private static Connection createConnection() {
		
		try {
			DatabaseConnection dc = DatabaseConnection.getInstance();
			conn = dc.getConnection();
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return conn;
	}
	
	public static ResultSet getAuth(String email) {
		
		conn = createConnection();
		sql = "select * from EMPLOYEES where email = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, email);
			rs = pst.executeQuery();
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return rs;
	}

	public static boolean insertLeaveRequest(LeaveReqObject obj) {
		
		conn = createConnection();
		int id, numberOfDays = obj.getNumberOfDays();
		boolean returnBool = false;
		try {
			if (obj.getHalfDayLeave() == 1) {
				sql = "insert into LEAVE_REQUEST(ecode, name, project_name, team_lead, project_manager, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, half_day_leave) values(?,?,?,?,?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			} else {
				sql = "insert into LEAVE_REQUEST(ecode, name, project_name, team_lead, project_manager, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, full_day_leave) values(?,?,?,?,?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			}
			pst.setString(1, obj.getEcode());
			pst.setString(2, obj.getName());
			pst.setString(3, obj.getProjectName());
			pst.setString(4, obj.getTeamLead());
			pst.setString(5, obj.getProjectManager());
			pst.setString(6, obj.getStartDate());
			pst.setString(7, obj.getEndDate());
			pst.setString(8, obj.getLeaveType());
			pst.setString(9, obj.getLeaveDesc());
			
			boolean execute = pst.execute();
			if(!execute) {
				id = getId(obj.getEcode());
				returnBool = setStatus(id);
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		 
		return returnBool;
	}

	private static int getId(String ecode) {
		int id = 0;
		sql = "select id from LEAVE_REQUEST where ecode = ? order by leave_request_time desc";
		try {
			pst.clearBatch();
			pst =  conn.prepareStatement(sql);
			pst.setString(1, ecode);
			ResultSet rs = pst.executeQuery();
			if(rs.next()) {
				id = rs.getInt("id");
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return id;
	}
	
	private static boolean setStatus(int id) {
		
		sql = "insert into LEAVE_STATUS(id) values(" + id + ");";
		boolean returnBool = false;
		try {
			pst.clearBatch();
			pst = conn.prepareStatement(sql);
			returnBool = !pst.execute();
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return returnBool;
	}

	public static ArrayList<LeaveReqObject> getTable(String desg, String tl_name, String ecode) {
		
		ArrayList<LeaveReqObject> lr = new ArrayList<LeaveReqObject>();
		conn = createConnection();
		try{ 
			if (desg.equals("Admin") || desg.equals("Super_Admin")) {
				sql = "SELECT * FROM LEAVE_REQUEST, LEAVE_STATUS WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id order by leave_request_time desc";
				pst = conn.prepareStatement(sql);
			} else if (desg.equals("TeamLead")) {
				sql = "SELECT * FROM LEAVE_REQUEST, LEAVE_STATUS WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND team_lead = ? order by leave_request_time desc";
				pst = conn.prepareStatement(sql);
				pst.setString(1, tl_name);
			} else {
				sql = "SELECT * FROM LEAVE_REQUEST, LEAVE_STATUS WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND ecode = ? order by leave_request_time desc";
				pst = conn.prepareStatement(sql);
				pst.setString(1, ecode);
			}
			rs = pst.executeQuery();
			
			while (rs.next()) {
				LeaveReqObject obj = new LeaveReqObject();
				if(rs.getInt("status")== 0) {
					obj.setStatus("Pending");
				} else if(rs.getInt("status")== 1) {
					obj.setStatus("Approved");
				} else {
					obj.setStatus("Rejected");
				}
				obj.setId(rs.getInt("id"));
				obj.setEcode(rs.getString("ecode"));
				obj.setName(rs.getString("name"));
				obj.setTeamLead(rs.getString("team_lead"));
				obj.setProjectManager(rs.getString("project_manager"));
				obj.setProjectName(rs.getString("project_name"));
				obj.setStartDate(rs.getString("leave_start_date"));
				obj.setEndDate(rs.getString("leave_end_date"));
				obj.setNumberOfDays(rs.getInt("number_of_days"));
				obj.setLeaveType(rs.getString("leave_type"));
				obj.setLeaveDesc(rs.getString("leave_desc"));
				lr.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return lr;
	}
	
	public static void closeConnection() {
		
		try {
			if (conn != null) {
				conn.close();
			} if (pst != null) {
				pst.close();
			} if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		
	}
}
