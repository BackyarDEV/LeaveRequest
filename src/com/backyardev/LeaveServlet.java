package com.backyardev;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backyardev.util.DatabaseConnection;

public class LeaveServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		String name = req.getParameter("name");
		String ecode = req.getParameter("ecode");
		String projectName = req.getParameter("project");
		String teamLead = req.getParameter("tLead");
		String projectManager = req.getParameter("manager");
		String startDate = req.getParameter("leave-start");
		String endDate = req.getParameter("leave-end");
		int numberOfDays = Integer.parseInt(req.getParameter("number-days"));
		String leaveType = req.getParameter("leave-type");
		String dayLeave = req.getParameter("day-leave");
		String leaveDesc = req.getParameter("leave-desc");
		Connection conn;
		String sql;
		
		try {
			
			DatabaseConnection db = DatabaseConnection.getInstance();
			conn = db.getConnection();
			PreparedStatement pst;
			if(dayLeave.equals("half-day")) {
				sql = "insert into LEAVE_REQUEST(ecode, name, project_name, team_lead, project_manager, leave_start_date, leave_end_date, leave_type, leave_desc, number_of_days, half_day_leave) values(?,?,?,?,?,?,?,?,?, " + numberOfDays + " ," + 1 + ");";
				pst = conn.prepareStatement(sql);
			} else {
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
				System.out.println("Data right success!");
				res.getWriter().write("true");
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/result.jsp");
		rd.forward(req, resp);
	}
}
