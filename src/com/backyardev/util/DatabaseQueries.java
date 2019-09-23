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
	
	//Get Database connection
	public static Connection createConnection() {
		
		try {
			DatabaseConnection dc = DatabaseConnection.getInstance();
			conn = dc.getConnection();
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return conn;
	}
	
	// Get Auth for login
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
	
	//Get email id of teamLead
	public static ResultSet getTLmail(String tl_name) {
		conn = createConnection();
		sql = "select email from EMPLOYEES where name = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, tl_name);
			rs = pst.executeQuery();
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return rs;
	}
	
	// InsertLeaveRequest - Inserts leaves in LEAVE_REQUEST table
	public static boolean insertLeaveRequest(LeaveReqObject obj) {
		
		conn = createConnection();
		int id, numberOfDays = obj.getNumberOfDays();
		boolean returnBool = false;
		try {
			if (obj.getHalfDayLeave() == 1) {
				sql = "insert into LEAVE_REQUEST(ecode,leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, half_day_leave,avail_comp,comp_id) values(?,?,?,?,?,  " + numberOfDays + " ," + 1 + ",?,?"+");";
				pst = conn.prepareStatement(sql);
			} else {
				sql = "insert into LEAVE_REQUEST(ecode, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, full_day_leave,avail_comp,comp_id) values(?,?,?,?,?," + numberOfDays + " ," + 1 +  ",?,?"+");";
				pst = conn.prepareStatement(sql);
			}
			pst.setString(1, obj.getEcode());
			pst.setString(2, obj.getStartDate());
			pst.setString(3, obj.getEndDate());
			pst.setString(4, obj.getLeaveType());
			pst.setString(5, obj.getLeaveDesc());
			pst.setInt(6, obj.getAvailComp());
			pst.setString(7, obj.getCompId());
			
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

	// Get Leave ID
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
	
	//Get Comp-off Leave ID from Leave_Requests
	public static int getCompId(int  id) {
		conn = createConnection();
		int  compId = 0;
		sql = "SELECT comp_id from LEAVE_REQUEST where id = ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				compId = rs.getInt("comp_id");
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return compId;
		
	}
	
	//Get Comp-off  date from Compoff_Requests
	public static ArrayList<CompoffReqObject> getCompLeaveDate(int id) {
		int compId = getCompId(id);
		ArrayList<CompoffReqObject> al = new ArrayList<>();
		sql = "select comp_date from COMPOFF_REQUEST  where id = ? ";
		try {
			pst.clearBatch();
			pst =  conn.prepareStatement(sql);
			pst.setInt(1, compId);
			ResultSet rs = pst.executeQuery();
			if(rs.next()) {
				CompoffReqObject obj = new CompoffReqObject();
				obj.setCompDate(rs.getString("comp_date"));
				al.add(obj);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		}

		return al;
	}
	
	// Set Leave Status
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
  
	// Get table for leave requests
	public static ResultSet getLeaveTable(String desg, String tl_name, String ecode) {
			
			conn = createConnection();
			try{ 
				if (desg.equals("Admin") || desg.equals("Super_Admin")) {
					sql = "SELECT LEAVE_REQUEST.id, "
							+ "LEAVE_REQUEST.ecode, "
							+ "LEAVE_REQUEST.leave_start_date, "
							+ "LEAVE_REQUEST.leave_end_date, "
							+ "LEAVE_REQUEST.number_of_days, "
							+ "LEAVE_REQUEST.full_day_leave, "
							+ "LEAVE_REQUEST.half_day_leave, "
							+ "LEAVE_REQUEST.leave_type, "
							+ "LEAVE_REQUEST.leave_desc, "
							+ "LEAVE_STATUS.status, "
							+ "EMPLOYEES.name, "
							+ "EMPLOYEES.project, "
							+ "EMPLOYEES.team_lead, "
							+ "EMPLOYEES.project_manager "
							+ "FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND "
							+ "EMPLOYEES.ecode = LEAVE_REQUEST.ecode order by leave_request_time desc";
					pst = conn.prepareStatement(sql);
				} else if (desg.equals("TeamLead")) {
					sql = "SELECT LEAVE_REQUEST.id, "
							+ "LEAVE_REQUEST.ecode, "
							+ "LEAVE_REQUEST.leave_start_date, "
							+ "LEAVE_REQUEST.leave_end_date, "
							+ "LEAVE_REQUEST.number_of_days, "
							+ "LEAVE_REQUEST.full_day_leave, "
							+ "LEAVE_REQUEST.half_day_leave, "
							+ "LEAVE_REQUEST.leave_type, "
							+ "LEAVE_REQUEST.leave_desc, "
							+ "LEAVE_STATUS.status, "
							+ "EMPLOYEES.name, "
							+ "EMPLOYEES.project, "
							+ "EMPLOYEES.team_lead, "
							+ "EMPLOYEES.project_manager "
							+ "FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id AND "
							+ "EMPLOYEES.ecode = LEAVE_REQUEST.ecode AND EMPLOYEES.team_lead = ? order by leave_request_time desc";
					pst = conn.prepareStatement(sql);
					pst.setString(1, tl_name);
				} else {
					sql = "SELECT LEAVE_REQUEST.id, "
							+ "LEAVE_REQUEST.ecode, "
							+ "LEAVE_REQUEST.leave_start_date, "
							+ "LEAVE_REQUEST.leave_end_date, "
							+ "LEAVE_REQUEST.number_of_days, "
							+ "LEAVE_REQUEST.full_day_leave, "
							+ "LEAVE_REQUEST.half_day_leave, "
							+ "LEAVE_REQUEST.leave_type, "
							+ "LEAVE_REQUEST.leave_desc, "
							+ "LEAVE_STATUS.status, "
							+ "EMPLOYEES.name, "
							+ "EMPLOYEES.project, "
							+ "EMPLOYEES.team_lead, "
							+ "EMPLOYEES.project_manager "
							+ "FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.id = LEAVE_STATUS.id "
							+ "AND LEAVE_REQUEST.ecode = ? AND LEAVE_REQUEST.ecode = EMPLOYEES.ecode order by leave_request_time desc";
					pst = conn.prepareStatement(sql);
					pst.setString(1, ecode);
				}
				rs = pst.executeQuery();
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return rs;
		}
	
	// Get Compoff Table for compoff leave requests
	public static ResultSet getCompoffTable(String desg, String tl_name, String ecode) {
			
			conn = createConnection();
			try {
				if (desg.equals("Admin") || desg.equals("Super_Admin")) {
					sql = "select COMPOFF_REQUEST.id, "
							+ "COMPOFF_REQUEST.ecode, "
							+ "COMPOFF_REQUEST.comp_date, "
							+ "COMPOFF_REQUEST.description, "
							+ "COMPOFF_REQUEST.ticket_scr, "
							+ "COMPOFF_REQUEST.night_shift, "
							+ "COMPOFF_REQUEST.status, "
							+ "EMPLOYEES.name,"
							+ "EMPLOYEES.project,"
							+ "EMPLOYEES.team_lead,"
							+ "EMPLOYEES.project_manager "
							+ "from COMPOFF_REQUEST, EMPLOYEES where COMPOFF_REQUEST.ecode = EMPLOYEES.ecode "
							+ "order by COMPOFF_REQUEST.request_timestamp desc";
					pst = conn.prepareStatement(sql);
				} else if (desg.equals("TeamLead")) {
					sql = "select COMPOFF_REQUEST.id,"
							+ "COMPOFF_REQUEST.ecode," 
							+ "COMPOFF_REQUEST.comp_date," 
							+ "COMPOFF_REQUEST.description," 
							+ "COMPOFF_REQUEST.ticket_scr," 
							+ "COMPOFF_REQUEST.night_shift," 
							+ "COMPOFF_REQUEST.status," 
							+ "EMPLOYEES.name," 
							+ "EMPLOYEES.project," 
							+ "EMPLOYEES.team_lead," 
							+ "EMPLOYEES.project_manager "
							+ "from COMPOFF_REQUEST, EMPLOYEES where COMPOFF_REQUEST.ecode = EMPLOYEES.ecode "
							+ "and EMPLOYEES.team_lead = ? " 
							+ "order by COMPOFF_REQUEST.request_timestamp desc";
					pst = conn.prepareStatement(sql);
					pst.setString(1, tl_name);
				} else {
					sql = "select COMPOFF_REQUEST.id, "
							+ "COMPOFF_REQUEST.ecode, "
							+ "COMPOFF_REQUEST.comp_date, "
							+ "COMPOFF_REQUEST.description, "
							+ "COMPOFF_REQUEST.ticket_scr, "
							+ "COMPOFF_REQUEST.night_shift, "
							+ "COMPOFF_REQUEST.status, "
							+ "EMPLOYEES.name, "
							+ "EMPLOYEES.project, "
							+ "EMPLOYEES.team_lead, "
							+ "EMPLOYEES.project_manager "
							+ "from COMPOFF_REQUEST, EMPLOYEES where COMPOFF_REQUEST.ecode = EMPLOYEES.ecode "
							+ "and COMPOFF_REQUEST.ecode = ? "
							+ "order by COMPOFF_REQUEST.request_timestamp desc";
					pst = conn.prepareStatement(sql);
					pst.setString(1, ecode);
				}
				rs = pst.executeQuery();
				
			} catch(Exception ex) {
				ex.printStackTrace();
			}
			return rs;
		}
	
	// Inserts Comp-off leaves in COMPOFF_REQUEST table
	public static boolean insertCompoffRequest(CompoffReqObject obj) {
		
		boolean returnBool = false;
		int nightShiftDefault = 0;
		if (("Night Shift").equalsIgnoreCase(obj.getNightShift())) {
			nightShiftDefault = 1;
		}
		sql = "Insert into COMPOFF_REQUEST(ecode, comp_date, description, ticket_scr, night_shift) values(?,?,?,?,?)";
		try {
			conn = createConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, obj.getEcode());
			pst.setString(2, obj.getCompDate());
			pst.setString(3, obj.getDesc());
			pst.setString(4, obj.getTicket());
			pst.setInt(5, nightShiftDefault);
			returnBool = !pst.execute();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return returnBool;
	}
	
	// Get indivisual leave on click of tr 
	public static ResultSet getLeave(String id) {
		conn = createConnection();
		try {
			sql = "SELECT LEAVE_REQUEST.id, "
					+ "LEAVE_REQUEST.ecode, "
					+ "LEAVE_REQUEST.leave_start_date, "
					+ "LEAVE_REQUEST.leave_end_date, "
					+ "LEAVE_REQUEST.number_of_days, "
					+ "LEAVE_REQUEST.full_day_leave, "
					+ "LEAVE_REQUEST.half_day_leave, "
					+ "LEAVE_REQUEST.leave_type, "
					+ "LEAVE_REQUEST.comp_id, "
					+ "LEAVE_REQUEST.leave_desc, "
					+ "LEAVE_STATUS.status, "
					+ "EMPLOYEES.name, "
					+ "EMPLOYEES.project, "
					+ "EMPLOYEES.team_lead, "
					+ "EMPLOYEES.project_manager "
					+ "FROM LEAVE_REQUEST, LEAVE_STATUS, EMPLOYEES WHERE LEAVE_REQUEST.ecode = EMPLOYEES.ecode AND "
					+ "LEAVE_REQUEST.id = LEAVE_STATUS.id AND "
					+ "LEAVE_REQUEST.id = ? AND "
					+ "LEAVE_REQUEST.ecode = EMPLOYEES.ecode order by leave_request_time desc";
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			rs = pst.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
		
	}
	
	// Get indivisual comp-off leave on click of tr
	public static ResultSet getCompLeave(String id) {
		conn = createConnection();
		try {
			sql = "select COMPOFF_REQUEST.id, "
					+ "COMPOFF_REQUEST.ecode, "
					+ "COMPOFF_REQUEST.comp_date, "
					+ "COMPOFF_REQUEST.description, "
					+ "COMPOFF_REQUEST.ticket_scr, "
					+ "COMPOFF_REQUEST.night_shift, "
					+ "COMPOFF_REQUEST.status, "
					+ "EMPLOYEES.name,"
					+ "EMPLOYEES.project,"
					+ "EMPLOYEES.team_lead,"
					+ "EMPLOYEES.project_manager "
					+ "from COMPOFF_REQUEST, EMPLOYEES where COMPOFF_REQUEST.ecode = EMPLOYEES.ecode AND "
					+ "COMPOFF_REQUEST.id = ?  "
					+ "order by COMPOFF_REQUEST.request_timestamp desc";
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			rs = pst.executeQuery();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
		
	}

	// Get Comp-off dates for availing in Leave Form
	public static  ArrayList<CompoffReqObject> getCompoffDates(String ecode) {
		ArrayList<CompoffReqObject> al = new ArrayList<>();
		sql = "select * from COMPOFF_REQUEST where ecode = ? order by COMPOFF_REQUEST.request_timestamp desc ";
		try {
			conn = createConnection();
			pst =  conn.prepareStatement(sql);
			pst.setString(1, ecode);
			ResultSet rs = pst.executeQuery();
			
			while(rs.next()) {
				CompoffReqObject obj = new CompoffReqObject();
				obj.setId(rs.getInt("id"));
				obj.setCompDate(rs.getString("comp_date"));
				al.add(obj);
			}
	
		} catch(Exception ex) {
			ex.printStackTrace();
    }
		return al;
	}

	// Close connection
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