package com.backyardev.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class CompoffMail {
		int user_id,days;
		String eCode,project,name,teamLead, proManager,status,compDate,ticket,desc,nightShift,CompoffType;
		int id;
		Character ns = ' ',holiday = ' ';
		
		public static boolean prepareMail(CompoffReqObject obj) throws FileNotFoundException, IOException
		{
			boolean returnBool = false;
			try 
			{
				CompoffMail details = new CompoffMail();
				details.name = obj.getName();
				details.eCode = obj.getEcode();
				details.project = obj.getProject();
				details.teamLead = obj.getTeamLead();
				details.proManager = obj.getManager();
				details.status = obj.getStatus();
				details.compDate = obj.getCompDate();
				details.ticket = obj.getTicket();
				details.desc = obj.getDesc();
				details.id = obj.getId();
				details.nightShift = obj.getNightShift();


				
				
				String choice;
				choice = details.nightShift;
				switch (choice) {
				case "Night Shift":
					details.ns = 'X';
					details.CompoffType = "Night Shift";
					break;
				case "No":
					details.holiday = 'X'; 
					details.CompoffType = "Holiday";
				default:
					//Do nothing 
					
				}
				
				
				
				returnBool = sendMail(details);
			        
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			return returnBool;
	    }
		
		public static boolean sendMail(CompoffMail details)  throws FileNotFoundException, IOException{
			
			boolean returnBool = false;
			Properties prop = new Properties();
			
			prop.load(new FileInputStream("/home/diksha/leave-servlet/servlet.properties"));
			String EMAIL_U = prop.getProperty("EMAIL_U");
			String EMAIL_P = prop.getProperty("EMAIL_P");
			
			
			   
			String to = "dikshawadhwa185@gmail.com";
			System.out.println("To Ok");

			String from = "dikshawadhwa0220@gmail.com";
			System.out.println("from Ok");

			final String username = EMAIL_U;//change accordingly
			final String password = EMAIL_P;//change accordingly
			
			String host = "smtp.gmail.com";
			
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", "587");
			System.out.println("Credentials Ok");

			Session session = Session.getInstance(props,
			   new javax.mail.Authenticator() {
			      protected PasswordAuthentication getPasswordAuthentication() {
			         return new PasswordAuthentication(username, password);
			      }
			});

			try {
			     Message message = new MimeMessage(session);
			
				message.setFrom(new InternetAddress(from));
				
				message.setRecipients(Message.RecipientType.CC,
				         InternetAddress.parse(to));
				System.out.println("Recipients Ok");

				  
				message.setSubject("Leave Approval- "+ details.eCode +" - "+details.name + " - "+ details.compDate + " - " + details.CompoffType);
				System.out.println("Subject Ok");
  
				message.setContent( "<div>"
					   
					  +" <table border=1 style=\"width:80%;text-align:left;\">"
						 +"  <tr><td style = \"text-align: center; color:black;\"><b>LEAVE APPLICATION FORM</b></td><td>   </td></tr>"
						 +" <tr><th style = \"color: black;\">E-Code</th><td style = \"color: black;\">"+details.eCode+"</td></tr>"
						 +"  <tr><th style = \"color: black;\">Name</th><td style = \"color: black;\">"+details.name+"</td></tr>"
						 +"  <tr><th style = \"color: black;\">Project</th><td style = \"color: black;\">"+details.project+"</td></tr>"
						 +" <tr><th style = \"color: black;\">Team/Project Lead Name</th><td style =\"color: black;\">"+details.teamLead+"</td></tr>"
						 +" <tr><th style = \"color: black;\">Team/Project Manager Name</th><td style =\"color: black;\">"+details.proManager+"</td></tr>"
						 +" <tr style =\"background-color:black;\"><td style = \"color: black;\">Blank Line</td><td>   </td></tr>"

						 
						 +" <tr><th style = \"color: black;\">Compoff Type (Mark X against applicable one) </th><td>   </td></tr>"
						 +" <tr><th style = \"color: black;\">Night-Shift</th><td style = \"color: black;\">"+details.ns+"</td></tr>"

						 +" <tr><th style = \"color: black;\">Holiday</th><td style = \"color: black;\">"+details.holiday+"</td></tr>"
						 +" <tr style = \"background-color:black;\"><td style = \"color: black;\">Blank Line</td><td>   </td></tr>"
						 
						 +" <tr><th style = \"color: black;\">Description</th><td style = \"color: black;\">"+details.desc+"</td></tr>"
						 +"</table>	"
					  
					  	
					   +"</div>	",
			       "text/html");
				System.out.println("Message Ok");

				// Send message
				Transport.send(message);
				System.out.println("Sent Message Ok");

				returnBool = true;
			
			} catch (MessagingException e) {
				returnBool = false;
				e.printStackTrace();
				throw new RuntimeException(e);
			}
			return returnBool;
		}
	}
	

