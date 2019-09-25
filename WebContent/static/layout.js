$(function(){
	$('.sidenav-toggle').click(function(){
		var toggleWidth;
		if (window.matchMedia("(max-width: 768px)").matches){
			$('.sidenav').css('display', 'block');
			toggleWidth = $(".sidenav").width() > 240 ? "0%" : "100%";
			$('.sidenav').animate({ width: toggleWidth }, 150);
		}else{
			toggleWidth = $(".sidenav").width() == 240 ? "0px" : "240px";
			$('.sidenav').animate({ width: toggleWidth }, 150);
			$('.main-div').animate({ marginLeft: toggleWidth}, 150);
		}
	});
});