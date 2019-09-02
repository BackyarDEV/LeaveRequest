package com.backyardev;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backyardev.util.DatabaseConnection;
import com.backyardev.util.LeaveReqObject;

public class LeaveServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		String name = req.getParameter("name");
		String ecode = req.getParameter("ecode");
		String projectName = req.getParameter("project");
		String teamLead = req.getParameter("tLead");
		String projectManager = req.getParameter("manager");
		String startDate = req.getParameter("leave-start");
		String endDate = req.getParameter("leave-end");
		String leaveType = req.getParameter("leave-type");
		String dayLeave = req.getParameter("day-leave");
		String leaveDesc = req.getParameter("leave-desc");
		int numberOfDays = Integer.parseInt(req.getParameter("number-days"));
		int id;
		Connection conn;
		String sql;
		
		try {
			
			LeaveReqObject obj = new LeaveReqObject();
			obj.setEcode(ecode);
			obj.setName(name);
			obj.setTeamLead(teamLead);
			obj.setProjectManager(projectManager);
			obj.setProjectName(projectName);
			obj.setStartDate(startDate);
			obj.setEndDate(endDate);
			obj.setNumberOfDays(numberOfDays);
			obj.setLeaveType(leaveType);
			obj.setLeaveDesc(leaveDesc);
			
			DatabaseConnection db = DatabaseConnection.getInstance();
			conn = db.getConnection();
			PreparedStatement pst;
			if(dayLeave.equals("half-day")) {
				obj.setHalfDayLeave(1);
				sql = "insert into LEAVE_REQUEST(ecode, name, project_name, team_lead, project_manager, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, half_day_leave) values(?,?,?,?,?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			} else {
				obj.setFullDayLeave(1);
				sql = "insert into LEAVE_REQUEST(ecode, name, project_name, team_lead, project_manager, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, full_day_leave) values(?,?,?,?,?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			}
			pst.setString(1, ecode);
			pst.setString(2, name);
			pst.setString(3, projectName);
			pst.setString(4, teamLead);
			pst.setString(5, projectManager);
			pst.setString(6, startDate);
			pst.setString(7, endDate);
			pst.setString(8, leaveType);
			pst.setString(9, leaveDesc);
			
			boolean execute = pst.execute();
			if(!execute) {
				sql = "select id from LEAVE_REQUEST where ecode = ? order by leave_request_time desc";
				pst.clearBatch();
				pst =  conn.prepareStatement(sql);
				pst.setString(1, ecode);
				ResultSet rs = pst.executeQuery();
				if(rs.next()) {
					id = rs.getInt("id");
					obj.setId(id);
					sql = "insert into LEAVE_STATUS(id) values(" + id + ")";
					pst.clearBatch();
					pst = conn.prepareStatement(sql);
					execute = pst.execute();
					if (!execute) {
						//TODO send leave request mail to concerned party
						
					}
				}
				
				
				System.out.println("Data right success!");
				
				res.getWriter().write("true");
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/LeaveForm.jsp");
		rd.forward(req, resp);
	}
}
