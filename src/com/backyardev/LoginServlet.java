package com.backyardev;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backyardev.util.EmployeesObjectClass;
import com.backyardev.util.LeaveRequestService;

public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String pass = req.getParameter("password");
		
		boolean returnBool = LeaveRequestService.loginService(email, pass);
		if(returnBool) {
			HttpSession session = req.getSession(true);
			session.setAttribute("ecode", EmployeesObjectClass.getEcode());
			session.setAttribute("email", email);
			session.setAttribute("desg", EmployeesObjectClass.getDesignation());
			session.setAttribute("name", EmployeesObjectClass.getName());
			session.setAttribute("project", EmployeesObjectClass.getProject());
			session.setAttribute("manager", EmployeesObjectClass.getProjectManager());
			session.setAttribute("lead", EmployeesObjectClass.getTeamLead());
		}
		
		PrintWriter out = resp.getWriter();
		out.print(returnBool);
	}
}
