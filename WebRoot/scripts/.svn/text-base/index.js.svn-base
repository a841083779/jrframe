//分类
var t2,n2 = 0, count2=0;
jQuery(document).ready(function(){	
	count2=jQuery("div.menuContain .sort").length;
	//jQuery("div.menuContain .sort").hide();
	//jQuery("div.menuContain .sort:first").show();
	jQuery(".new_menu li").mouseover(function() {
		var i = jQuery(this).attr("value") - 1;
		n2 = i;
		if (i >= count2) return;
		jQuery("div.menuContain .sort").filter(":visible").fadeOut(10).parent().children().eq(i).fadeIn(10);
		jQuery(this).addClass("cur");
		jQuery("#ajax_index_"+i).load("/ajax/ajax_index_"+i+".htm");
		jQuery(this).siblings().removeClass("cur");
	});
	jQuery(".new_menu li").dblclick(function() {
		var i = jQuery(this).attr("value") - 1;
		n2 = i;
		if (i >= count2) return;
		jQuery("div.menuContain .sort").filter(":visible").fadeOut(10).parent().children().eq(i).fadeIn(10);
		jQuery(this).addClass("cur");
		jQuery("#ajax_index_"+i).load("/ajax/ajax_index_"+i+".htm");
		jQuery(this).siblings().removeClass("cur");
	});
	t2 = setInterval("showAuto2()", 8000);
	jQuery("div.Allcate,.sort").hover(function(){clearInterval(t2)}, function(){t2 = setInterval("showAuto2()", 8000);});
//	jQuery(".bigad div").hover(function() {
//		jQuery(this).parent().css("background-color","#000000");
//		jQuery(this).siblings().css("opacity",0.6);
//	},function() {
//		jQuery(".bigad div").css("opacity",1);
//	});
})
function showAuto2(){
	n2 = n2 >=(count2 - 1) ? 0 : ++n2;
	jQuery(".new_menu li:eq("+n2+")").dblclick();
}
//品牌推荐
var t1,n1 = 0, count1=0;
jQuery(document).ready(function(){	
	count1=jQuery(".brsImg li").length;
	jQuery(".brsImg li:not(:first-child)").hide();
	jQuery(".brsBtn li").click(function() {
		var i = jQuery(this).text() - 1;
		n1 = i;
		if (i >= count1) return;
		jQuery(".brsImg li").filter(":visible").fadeOut(500).parent().children().eq(i).fadeIn(500);
		jQuery(this).toggleClass("bcur");
		jQuery(this).siblings().removeAttr("class");
	});
	t1 = setInterval("showAuto1()", 3000);
	jQuery(".brsBtn").hover(function(){clearInterval(t1)}, function(){t1 = setInterval("showAuto1()", 3000);});
})
function showAuto1(){
	n1 = n1 >=(count1 - 1) ? 0 : ++n1;
	jQuery(".brsBtn li").eq(n1).trigger('click');
}
//floor
jQuery(function(){
	jQuery(".leftTitle").hover(function(){
		jQuery(this).toggleClass("leftTitleHover");
	},function(){
		jQuery(this).removeClass("leftTitleHover");
	});
})
//晒图
jQuery(function(){
	jQuery('.pic01 li').hover(function(){
		jQuery("div.text", this).stop().animate({top:'0px'},{queue:false,duration:160});
	}, function() {
		jQuery("div.text", this).stop().animate({top:'92px'},{queue:false,duration:160});
	});
	jQuery('.pic02 li').hover(function(){
		jQuery("div.text", this).stop().animate({top:'0px'},{queue:false,duration:160});
	}, function() {
		jQuery("div.text", this).stop().animate({top:'94px'},{queue:false,duration:160});
	});
})