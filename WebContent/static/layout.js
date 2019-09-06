$(function(){
	if (window.matchMedia("(max-width: 800px)").matches) {
			$('.sidenav').css('width', 0);
	        $('.main-div').css('margin-left', 0);
		} else {
			$('.sidenav').css('width', '240px');
	        $('.main-div').css('margin-left', '240px');
		}
	$('.sidenav-toggle').click(function(){
		var toggleWidth = $(".sidenav").width() == 240 ? "0px" : "240px";
		$('.sidenav').animate({ width: toggleWidth }, 150);
        $('.main-div').animate({ marginLeft: toggleWidth}, 150);
	});
});