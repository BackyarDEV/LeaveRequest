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

public class SendEmail {
	
   public static void sendMail(LeaveMail details)  throws FileNotFoundException, IOException{
		Properties prop = new Properties();

		prop.load(new FileInputStream("/home/mayanksinha/leave-servlet/servlet.properties"));
	    String EMAIL_U = prop.getProperty("EMAIL_U");
	    String EMAIL_P = prop.getProperty("EMAIL_P");


      // Recipient's email ID needs to be mentioned.
	   
      String to = "mayank.sinha02@gmail.com";

      // Sender's email ID needs to be mentioned
      String from = "dikshawadhwa0220@gmail.com";
      final String username = EMAIL_U;//change accordingly
      final String password = EMAIL_P;//change accordingly

      // Assuming you are sending email through relay.jangosmtp.net
      String host = "smtp.gmail.com";

      Properties props = new Properties();
      props.put("mail.smtp.auth", "true");
      props.put("mail.smtp.starttls.enable", "true");
      props.put("mail.smtp.host", host);
      props.put("mail.smtp.port", "587");

      // Get the Session object.
      Session session = Session.getInstance(props,
         new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
               return new PasswordAuthentication(username, password);
            }
	});

      try {
            // Create a default MimeMessage object.
            Message message = new MimeMessage(session);

   	   // Set From: header field of the header.
	   message.setFrom(new InternetAddress(from));

	   // Set To: header field of the header.
	   message.setRecipients(Message.RecipientType.CC,
              InternetAddress.parse(to+",dikshawadhwa185@gmail.com"));

	   // Set Subject: header field
	   
       message.setSubject("Leave Approval- "+ details.eCode +" - "+details.name + " - "+ details.startDate + " - "+ details.endDate + " - " + details.leaveType);
	   
	   // Send the actual HTML message, as big as you like
	   message.setContent( "<div>"
			   
			  +" <table border=1 style=\"width:80%;text-align:left;\">"
				+"  <tr><td style = \"text-align: center; color:black;\"><b>LEAVE APPLICATION FORM</b></td><td>   </td></tr>"
				 +" <tr><th style = \"color: black;\">E-Code</th><td style = \"color: black;\">"+details.eCode+"</td></tr>"
				+"  <tr><th style = \"color: black;\">Name</th><td style = \"color: black;\">"+details.name+"</td></tr>"
				+"  <tr><th style = \"color: black;\">Project</th><td style = \"color: black;\">"+details.project+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Team/Project Lead Name</th><td style =\"color: black;\">"+details.teamLead+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Team/Project Manager Name</th><td style =\"color: black;\">"+details.proManager+"</td></tr>"
				 +" <tr style =\"background-color:black;\"><td style = \"color: black;\">Blank Line</td><td>   </td></tr>"
				 +" <tr><th style = \"color: black;\">Leave Start Date</th><td style = \"color: black;\">"+details.startDate+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Leave End Date</th><td style = \"color: black;\">"+details.endDate+"</td></tr>"
				 +" <tr><th style = \"color: black;\">No.of Working Days </th><td style = \"color: black;\">"+details.days+"</td></tr>"
				 +" <tr style = \"background-color:black;\"><td style = \"color: black;\">Blank Line</td><td>   </td></tr>"
				 +" <tr><th style = \"color: black;\">Leave Type (Mark X against applicable one) </th><td>   </td></tr>"
				 +" <tr><th style = \"color: black;\">Sick Leave</th><td style = \"color: black;\">"+details.sl+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Casual Leave</th><td style = \"color: black;\">"+details.cl+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Earned Leave</th><td style = \"color: black;\">"+details.el+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Maternity Leave</th><td style = \"color: black;\">"+details.ml+"</td></tr>"
				 +" <tr><th style = \"color: black;\">On Office Duty/Tour/client site/Work From Home</th><td style = \"color: black;\">"+details.wh+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Biometric Miss out</th><td style = \"color: black;\">"+details.bm+"</td></tr>"
				 +" <tr style = \"background-color:black;\"><td style = \"color: black;\">Blank Line</td><td>   </td></tr>"
				 +" <tr><th style = \"color: black;\">Mark X against applicable one</th><td>   </td></tr>"
				 +" <tr><th style = \"color: black;\">Full Day Leave</th><td style = \"color: black;\">"+details.fdl+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Half Day Leave</th><td style = \"color: black;\">"+details.hdl+"</td></tr>"
				 +" <tr><th style = \"color: black;\">Description</th><td style = \"color: black;\">"+details.description+"</td></tr>"
				 +"</table>	"
			  
			  	
			   +"</div>	",
             "text/html");

	   // Send message
	   Transport.send(message);

	   System.out.println("Sent message successfully....");

      } catch (MessagingException e) {
	   e.printStackTrace();
	   throw new RuntimeException(e);
      }
   }
}