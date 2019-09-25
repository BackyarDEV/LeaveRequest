package com.backyardev;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backyardev.util.LeaveRequestService;

/**
 * Servlet implementation class ActionCompLeaveServlet
 */
public class ActionCompLeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sess = request.getSession(false);
		int id = Integer.parseInt(request.getParameter("id"));
		String action = request.getParameter("action");
		String reason = null;
		String reviewer = (String)sess.getAttribute("name");
		if(action.equals("reject")) {
			reason = request.getParameter("reason");
		}
		response.getWriter().write(LeaveRequestService.setCompStatus(id, action, reason, reviewer));
	}
}


