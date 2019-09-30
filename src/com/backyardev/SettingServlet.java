package com.backyardev;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backyardev.util.LeaveRequestService;

public class SettingServlet extends HttpServlet{

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		try{
			if(session.getAttribute("ecode") != null) {
				RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/setting.jsp");
				rd.forward(req, resp);
			} else {
				resp.sendRedirect("login");
			}
		} catch(NullPointerException ex) {
			resp.sendRedirect("login");
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		PrintWriter out = resp.getWriter();
		String pass = req.getParameter("setpass");
		String conf = req.getParameter("confpass");
		HttpSession session = req.getSession(false);
		String ecode = String.valueOf(session.getAttribute("ecode"));
		boolean updatePass = false;
		try {
			updatePass = LeaveRequestService.updatePassword(ecode, pass, conf);
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.print(updatePass);
	}
}
