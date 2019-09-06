$('.btn-reject').click(function(s) {

    var url = "ActionLeaveServlet";
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
                window.location.replace('portal');
            } else {
                alert('Error!');
            }
        }
    });
});

$('.btn-check').click(function(s) {

    var url = "ActionLeaveServlet";
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
                window.location.replace('portal');
            } else {
                alert('Error!');
            }
        }
    });
});

$(document).ready(function() {
	$('#all-req').css('color', '#f1f1f1');
    $('#data-table').DataTable({
        sorting: false
    },
    {
        "pagingType": "scrolling"
    });
});