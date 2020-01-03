jQuery.fn.smartFloat = function() {
var position = function(element) {
	var top = element.position().top, pos = element.css("position");
	jQuery(window).scroll(function() {
		var scrolls = jQuery(this).scrollTop();
		if (scrolls > top) {
			if (window.XMLHttpRequest) {
				element.css({
					position: "fixed",
					top:0
				});	
			} else {
				element.css({
					top: scrolls
				});	
			}
		}else {
			element.css({
				position: pos,
				top: top
			});	
		}
	});
};
return jQuery(this).each(function() {
	position(jQuery(this));						 
});
};
//绑定
jQuery("#suoyinfloat").smartFloat();