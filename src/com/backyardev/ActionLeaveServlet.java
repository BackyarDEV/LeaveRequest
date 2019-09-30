package com.backyardev;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backyardev.util.LeaveRequestService;

@WebServlet("/ActionLeaveServlet")
public class ActionLeaveServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sess = request.getSession(false);
		int id = Integer.parseInt(request.getParameter("id"));
		String action = request.getParameter("action");
		String reviewer = (String) sess.getAttribute("name");
		response.getWriter().print(LeaveRequestService.setLeaveStatus(id, action, reviewer));
	}

}
