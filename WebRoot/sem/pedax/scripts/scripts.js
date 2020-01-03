// JavaScript Document
//index of job
jQuery(document).ready(
function() 
{
	jQuery(".deal_Title").click(function(){
		jQuery(this).next("div").slideToggle("slow")
		.siblings(".deal_menuCont:visible").slideUp("slow");
		jQuery(this).toggleClass("deaTi");
		jQuery(this).siblings(".deaTi").removeClass("deaTi");
	});
});

jQuery(document).ready(
function() 
{
	jQuery(".deal_Title11").click(function(){
		jQuery(this).next("div").slideToggle("slow")
		.siblings(".deal_menuCont11:visible").slideUp("slow");
		jQuery(this).toggleClass("deaTi11");
		jQuery(this).siblings(".deaTi11").removeClass("deaTi11");
	});
});
