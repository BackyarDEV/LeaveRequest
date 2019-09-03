package com.backyardev.util;

import java.io.FileNotFoundException;
import java.io.IOException;


public class LeaveMail {
	
	int user_id,days;
	String f_name,eCode,project,teamLead, proManager;
	String startDate,endDate;
	String name,description,leaveType = "";
	String address;
	Character sl = ' ',cl = ' ',el = ' ',ml = ' ',wh = ' ',bm = ' ',fdl = ' ',hdl = ' ';
	
	public void prepareMail(LeaveReqObject obj) throws FileNotFoundException, IOException
	{
		try 
		{
			LeaveMail details = new LeaveMail();
			details.name = obj.getName();
			details.eCode = obj.getEcode();
			details.project = obj.getProjectName();
			details.teamLead = obj.getTeamLead();
			details.startDate = obj.getStartDate();
			details.endDate = obj.getEndDate();
			details.days = obj.getNumberOfDays();
			details.proManager = obj.getProjectManager();
			
			
			if(obj.getHalfDayLeave() == 1) {
				details.hdl = 'X';
			}
			if(obj.getFullDayLeave() == 1) {
				details.fdl = 'X';
			}
			
			String choice;
			choice = obj.getLeaveType();
			switch (choice) {
			case "Sick Leave":
				details.sl = 'X';
				details.leaveType = "Sick Leave";
				break;
			case "Casual Leave":
				details.cl = 'X';
				details.leaveType = "Casual Leave";
				break;
			case "Earned Leave":
				details.el = 'X';
				details.leaveType = "Earned Leave";
				break;
			case "Maternity Leave":
				details.ml = 'X';
				details.leaveType = "Maternity Leave";
				break;
			case "On Office Duty":
				details.wh = 'X';
				details.leaveType = "On Office Duty";
				break;
			case "Biometric Miss Out":
				details.bm = 'X';
				details.leaveType = "Biometric Miss Out";
				break;
			default:
				//Do nothing 
				
			}
			
			details.description = obj.getLeaveDesc();
			
			SendEmail.sendMail(details);
		        
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
    }
}