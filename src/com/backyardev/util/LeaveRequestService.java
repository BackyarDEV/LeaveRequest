package com.backyardev.util;

import java.sql.ResultSet;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LeaveRequestService {

	public static String loginService(HttpServletRequest req,String email, String pass) {
		
		String ecode, project, lead, manager, name, desg, hash, returnString = null;
		
		if(!validateMail(email)) {
			returnString = "invalid_mail";
		} else {
			
			ResultSet rs = DatabaseQueries.getAuth(email);
			
			try {
				
				if(!rs.next()) {
					returnString = "invalid_mail";
				} else {
					ecode = rs.getString("ecode");
					desg = rs.getString("designation");
					hash = rs.getString("pass_hash");
					name = rs.getString("name");
					project = rs.getString("project");
					lead = rs.getString("team_lead");
					manager = rs.getString("project_manager");
					if (Password.check(pass, hash)) {
						HttpSession session = req.getSession(true);
						session.setAttribute("ecode", ecode);
						session.setAttribute("email", email);
						session.setAttribute("desg", desg);
						session.setAttribute("name", name);
						session.setAttribute("project", project);
						session.setAttribute("manager", manager);
						session.setAttribute("lead", lead);
						
						returnString = "true";
					} else {
						returnString = "wrong_pass";
					}
				}
			} catch(Exception ex) {
				returnString = "500";
				ex.printStackTrace();
			}
		}
		DatabaseQueries.closeConnection();
		return returnString;
	}
	
	public static String leaveService(LeaveReqObject obj) {
		String returnString = null;
		try {
			if(DatabaseQueries.insertLeaveRequest(obj)) {
				if (LeaveMail.prepareMail(obj)){
					returnString = "true";
				} else {
					returnString = "mail_not_sent";
				}
			} else {
				returnString = "insertion_error";
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return returnString;
	}
	
	public static String compOffService(CompoffReqObject obj) {
		String returnString = null;
		try {
			if(DatabaseQueries.insertCompoffRequest(obj)) {
				returnString = "true";	
			} else {
				returnString = "insertion_error";
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return returnString;
	}

	private static boolean validateMail(String mail){
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
