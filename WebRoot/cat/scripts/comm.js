$(document).ready(function(e) {
    $('.nav_bg .category .n').mouseover(function(){
		$(this).next('.con1_left').show();
	});
	$('.nav_bg .category .con1_left').mouseleave(function(){
		$(this).hide();
	})
});