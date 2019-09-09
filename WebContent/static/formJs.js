	//Function to submit form
	$(function(){
			$('#new-req').css('color', '#f1f1f1');
			$('#submitFormModal').modal({ show: false});
	});
	$('.form').submit(function(s){
		s.preventDefault();
		$('#submitFormModal').modal('show');
		console.log('here');
		$('#submitFormBtn').click(function(){
			console.log('clickity click!');
			$('#progress').css('display', 'block');
			var form = $('.form');
			var url = form.attr("action");
			var method = form.attr("method");
			
			$.ajax({
				type: method,
				url: url,
				data: form.serialize(),
				success: function(data){
					if (data == "true"){
						window.location.replace('portal');
					} else if (data == "null") {
						$('#submitFormModal').modal("hide");
						alert('All fields are compulsory!');
					} else if (data == 'mail_not_sent') {
						$('#submitFormModal').modal( "hide");
						alert('There was a problem sending a Leave Request Mail!');
					}
				}
			});
		});
	});
			
	  //Methods to count leave days
	 function GetDays(){
	        var dropdt = new Date(document.getElementById("leave-end").value);
	        var pickdt = new Date(document.getElementById("leave-start").value);
	        console.log("Start date:", dropdt);
	        console.log("End date:", pickdt);
	        return parseInt((dropdt - pickdt) / (24 * 3600 * 1000)+1);
	       
 	 }
	
	function cal(){
	    if(document.getElementById("leave-end")){
	        var days = GetDays();
	        document.getElementById("number-days").value=GetDays();
	        console.log(GetDays());
	    }  
	}
	
	//Method for calander range
	$( "#leave-start" ).datepicker({
		  dateFormat: "yy-mm-dd"
	}); 
	$( "#leave-end" ).datepicker({
		  dateFormat: "yy-mm-dd"
	}); 
	
	 $( function() {
		    var dateFormat =  "yy-mm-dd",
		      from = $( "#leave-start" )
		        .datepicker({
		          defaultDate: "+1w",
		          changeMonth: true,
		          numberOfMonths: 1
		        })
		        .on( "change", function() {
		          to.datepicker( "option", "minDate", getDate( this ) );
		        }),
		      to = $( "#leave-end" ).datepicker({
		        defaultDate: "+1w",
		        changeMonth: true,
		        numberOfMonths: 1
		      })
		      .on( "change", function() {
		        from.datepicker( "option", "maxDate", getDate( this ) );
		      });
		 
		    function getDate( element ) {
		      var date;
		      try {
		        date = $.datepicker.parseDate( dateFormat, element.value );
		      } catch( error ) {
		        date = null;
		      }
		 
		      return date;
		    }
		  } );
	//Start validation
	  $.validate();
			
			
			
			
			
			
			
			
			
			