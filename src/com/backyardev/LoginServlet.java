package com.backyardev;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backyardev.util.DatabaseConnection;
import com.backyardev.util.Password;

public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String pass = req.getParameter("password");
		String ecode;
		String name;
		String desg;
		String sql;
		String hash;
		PrintWriter out = resp.getWriter();
		Connection conn;
		
		boolean validMail = validateMail(email);
		if(!validMail) {
			out.print("invalid_mail");
		} else {
			
			try {
				
				DatabaseConnection dc = DatabaseConnection.getInstance();
				conn = dc.getConnection();
				sql = "select * from EMPLOYEES where email = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, email);
				ResultSet rs = ps.executeQuery();
				if(!rs.next()) {
					out.write("invalid_mail");
				} else {
					ecode = rs.getString("ecode");
					desg = rs.getString("designation");
					hash = rs.getString("pass_hash");
					name = rs.getString("name");
					if (Password.check(pass, hash)) {
						HttpSession session = req.getSession(true);
						session.setAttribute("ecode", ecode);
						session.setAttribute("email", email);
						session.setAttribute("desg", desg);
						session.setAttribute("name", name);
						
						out.write("true");
					} else {
						out.write("wrong_pass");
					}
				}
			} catch(Exception ex) {
				out.print("500");
				ex.printStackTrace();
			}
		}
	}
	
	boolean validateMail(String mail){
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+ 
    			"[a-zA-Z0-9_+&*-]+)*@" + 
                "(?:[a-zA-Z0-9-]+\\.)+[a-z" + 
                "A-Z]{2,7}$";
		Pattern pat = Pattern.compile(emailRegex);
		if(mail == null) {
		return false;
		}
		if (pat.matcher(mail).matches()) {
			if(mail.indexOf("@trantorinc.com", mail.length() - "@trantorinc.com".length()) != -1){
	            return true;
	        } else {
	        	return false;
	        }
		} else {
			return false;
		}
		
	}
	
}
