package com.backyardev;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backyardev.util.DatabaseConnection;
import com.backyardev.util.Password;

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
		
		System.out.println("really?");
		String pass = req.getParameter("setpass");
		String conf = req.getParameter("confpass");
		String hash;
		HttpSession session = req.getSession(false);
		String ecode = String.valueOf(session.getAttribute("ecode"));
		Connection conn;
		String sql = "update EMPLOYEES set pass_hash = ? where ecode = ?";
		
		try {
			DatabaseConnection dc = DatabaseConnection.getInstance();
			conn = dc.getConnection();
			if (pass.equals(conf)) {
				hash = Password.getSaltedHash(pass);
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, hash);
				ps.setString(2, ecode);
				System.out.println(ps);
				boolean execute = ps.execute();
				if (!execute) {
					resp.getWriter().write("true");
				} else {
					System.out.println("tumse naa ho payega!");
				}
			} else {
				resp.getWriter().write("pass_no_match");
			}
			
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
}
