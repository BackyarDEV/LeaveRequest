$('.targetRow').click(function() {
	var url = "comp/"+$(this).attr("id").trim()
	console.log(url);
	window.location.replace(url);
});
	
$('.btn-check').click(function(s) {

    var url = "ActionCompLeaveServlet";
    var method = "post";
    var id = $(this).attr("id")
    console.log(id);

    $.ajax({
        type: method,
        url: url,
        data: {
            'id': id,
            'action': 'approve'
        },
        success: function(data) {
            if (data == "true") {
                window.location.replace('comp');
            } else {
                alert('Error!');
            }
        }
    });
});
	
$('.btn-reject').click(function(s) {

    var url = "ActionCompLeaveServlet";
    var method = "post";
    var id = $(this).attr("id")
    console.log(id);

    $.ajax({
        type: method,
        url: url,
        data: {
            'id': id,
            'action': 'reject'
        },
        success: function(data) {
            if (data == "true") {
                window.location.replace('comp');
            } else {
                alert('Error!');
            }
        }
    });
});