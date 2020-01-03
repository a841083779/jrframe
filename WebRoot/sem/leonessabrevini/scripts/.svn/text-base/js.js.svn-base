//banner
	var t = n = 0, count;
jQuery(document).ready(function(){	
	count=jQuery("http://www.leonessabrevini.com/scripts/.b_ .blc").length;
	jQuery(".b_ .blc:not(:first-child)").hide();
	jQuery(".button a").click(function() {
		var i = jQuery(this).text() - 1;
		n = i;
		if (i >= count) return;
		jQuery("http://www.leonessabrevini.com/scripts/.b_ .blc").filter(":visible").fadeOut(500).parent().children().eq(i).fadeIn(1000);
		jQuery(this).toggleClass("on");
		jQuery(this).siblings().removeAttr("class");
	});
	t = setInterval("showAuto()", 4000);
	jQuery(".scrol_new").hover(function(){clearInterval(t)}, function(){t = setInterval("showAuto()", 4000);});
})
function showAuto()
{
	n = n >=(count - 1) ? 0 : ++n;
	jQuery(".scrol_new a").eq(n).trigger('click');
}
