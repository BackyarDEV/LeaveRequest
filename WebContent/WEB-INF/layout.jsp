<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        
        <link rel="stylesheet" href="static/style.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    	<link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.css" >
        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <title>Welcome</title>
    </head>
    <body>
		<nav class="navbar fixed-top navbar-expand-sm navbar-dark bg-dark" style="box-shadow: 0 10px 10px -10px #333;;">
		    <a class="navbar-brand" href="portal">Frys Web Leave Management</a>
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="navbar-toggler-icon"></span>
		    </button>
			
		    <div class="collapse navbar-collapse" id="navbarSupportedContent">
		        <ul class="navbar-nav ml-auto">
		            <li class="nav-item active">
		                <a class="nav-link" href="portal">Home <span class="sr-only">(current)</span></a>
		            </li>	            
		            <li class="nav-item active">
		                <a class="nav-link" href="setting">Settings </a>
		            </li>	            
		               <li class="nav-item logout-item">
		                <a class="nav-link" href="logout">Logout</a>
		            </li>
		        </ul>
		    </div>
		</nav>
		<div class="sidenav">
		  <a href="portal" id="all-req">My Leave Requests</a>
		  <a href="leave" id="new-req">New Leave Request</a>
		</div>	
		<div style="margin-left: 240px; margin-top: 50px; padding: 40px;">