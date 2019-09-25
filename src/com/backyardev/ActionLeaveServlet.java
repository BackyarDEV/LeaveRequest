package com.backyardev;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backyardev.util.LeaveRequestService;

@WebServlet("/ActionLeaveServlet")
public class ActionLeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		int compId = 0;
		String action = request.getParameter("action");
		
		if(action.equals("approve")) {
			status = 1;
		}else if(action.equals("reject")){
			status = -1;
		}
		
		
		try {
			DatabaseConnection db = DatabaseConnection.getInstance();
			conn = db.getConnection();
			sql = "UPDATE LEAVE_STATUS SET STATUS  = "+ status + " WHERE id =  " + id ;
			pst = conn.prepareStatement(sql);
			pst.execute();
			
			//Method to get id of comp-off request from leave request
			try {
				
				compId = DatabaseQueries.getCompId(id);
				
			}catch(NullPointerException e){
				e.printStackTrace();
			}
			//Method to set status of comp-off request
			try {
				
				DatabaseQueries.setCompOffStatus(compId,status);
				
			}catch(NullPointerException e){
				e.printStackTrace();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.getWriter().write("true");

	}

}
