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
				sql = "insert into LEAVE_REQUEST(ecode, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, half_day_leave) values(?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			} else {
				sql = "insert into LEAVE_REQUEST(ecode, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, full_day_leave) values(?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			}
			pst.setString(1, obj.getEcode());
			pst.setString(2, obj.getStartDate());
			pst.setString(3, obj.getEndDate());
			pst.setString(4, obj.getLeaveType());
			pst.setString(5, obj.getLeaveDesc());
			
			boolean execute = pst.execute();
			if(!execute) {
				id = getLeaveId(obj.getEcode());
				returnBool = setLeaveStatus(id);
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		 
		return returnBool;
	}

	private static int getLeaveId(String ecode) {
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
	
	private static boolean setLeaveStatus(int id) {
		
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
				sql = "SELECT LEAVE_REQUEST.id, LEAVE_REQUEST.ecode, LEAVE_REQUEST.leave_start_date, LEAVE_REQUEST.leave_end_date, "
						+ "LEAVE_REQUEST.number_of_days, LEAVE_REQUEST.full_day_leave, LEAVE_REQUEST.half_day_leave, LEAVE_REQUEST.leave_type, "
						+ "LEAVE_REQUEST.leave_desc, LEAVE_STATUS.status, EMPLOYEES.name, EMPLOYEES.project, EMPLOYEES.team_lead, "
						+ "EMPLOYEES.project_manager FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND "
						+ "EMPLOYEES.ecode = LEAVE_REQUEST.ecode order by leave_request_time desc";
				pst = conn.prepareStatement(sql);
			} else if (desg.equals("TeamLead")) {
				sql = "SELECT LEAVE_REQUEST.id, LEAVE_REQUEST.ecode, LEAVE_REQUEST.leave_start_date, LEAVE_REQUEST.leave_end_date, "
						+ "LEAVE_REQUEST.number_of_days, LEAVE_REQUEST.full_day_leave, LEAVE_REQUEST.half_day_leave, LEAVE_REQUEST.leave_type, "
						+ "LEAVE_REQUEST.leave_desc, LEAVE_STATUS.status, EMPLOYEES.name, EMPLOYEES.project, EMPLOYEES.team_lead, "
						+ "EMPLOYEES.project_manager FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND "
						+ "EMPLOYEES.ecode = LEAVE_REQUEST.ecode AND EMPLOYEES.team_lead = ? order by leave_request_time desc";
				pst = conn.prepareStatement(sql);
				pst.setString(1, tl_name);
			} else {
				sql = "SELECT LEAVE_REQUEST.id, LEAVE_REQUEST.ecode, LEAVE_REQUEST.leave_start_date, LEAVE_REQUEST.leave_end_date, "
						+ "LEAVE_REQUEST.number_of_days, LEAVE_REQUEST.full_day_leave, LEAVE_REQUEST.half_day_leave, LEAVE_REQUEST.leave_type, "
						+ "LEAVE_REQUEST.leave_desc, LEAVE_STATUS.status, EMPLOYEES.name, EMPLOYEES.project, EMPLOYEES.team_lead, "
						+ "EMPLOYEES.project_manager FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id "
						+ "AND LEAVE_REQUEST.ecode = ? AND LEAVE_REQUEST.ecode = EMPLOYEES.ecode order by leave_request_time desc";
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
				
				if(rs.getInt("half_day_leave") == 1) {
					obj.setHalfDayLeave(1);
				} else if(rs.getInt("full_day_leave") == 1) {
					obj.setFullDayLeave(1);
				} 
				
				obj.setId(rs.getInt("id"));
				obj.setEcode(rs.getString("ecode"));
				obj.setName(rs.getString("name"));
				obj.setTeamLead(rs.getString("team_lead"));
				obj.setProjectManager(rs.getString("project_manager"));
				obj.setProjectName(rs.getString("project"));
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
	
	public static boolean insertCompoffRequest(CompoffReqObject obj) {
		
		boolean returnBool = false;
		sql = "Insert into COMPOFF_REQUEST(ecode, comp_date, description, ticket_scr, night_shift) values(?,?,?,?," +obj.getNightShift()+ ")";
		try {
			conn = createConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, obj.getEcode());
			pst.setString(2, obj.getCompDate());
			pst.setString(3, obj.getDesc());
			pst.setString(4, obj.getTicket());

			returnBool = !pst.execute();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return returnBool;
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
