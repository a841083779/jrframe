// JavaScript Document
jQuery(function(){
	var a_width = jQuery("body").width();
	if (a_width < 1150) {
		jQuery(".sideGuide-con").hide();
	} else {
		jQuery(".sideGuide-con").show();
	}
	jQuery(window).resize(function(){
		var b_width = jQuery(window).width();
		if (b_width < 1150) {
			jQuery(".sideGuide-con").hide();
		} else {
			jQuery(".sideGuide-con").show();
		}
	});
})