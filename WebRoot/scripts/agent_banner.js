// JavaScript Document
var t4 = n4 = 0, count;
jQuery(document).ready(function(){	
	count4=jQuery(".bannerShow ul.imgs li").length;
	jQuery(".bannerShow ul.imgs li:not(:first-child)").hide();
	jQuery(".bannerShow ul.nums li").click(function() {
		var i = jQuery(this).attr("value") - 1;
		n4 = i;
		if (i >= count4) return;
		jQuery(".bannerShow ul.imgs li").filter(":visible").fadeOut(500).parent().children().eq(i).fadeIn(800);
		jQuery(this).toggleClass("cur");
		jQuery(this).siblings().removeAttr("class");
	});
	t4 = setInterval("showAuto4()", 4000);
	jQuery(".bannerShow").hover(function(){clearInterval(t4)}, function(){t4 = setInterval("showAuto4()", 4000);});
})

function showAuto4()
{
	n4 = n4 >=(count4 - 1) ? 0 : ++n4;
	jQuery(".bannerShow ul.nums li").eq(n4).trigger('click');
}