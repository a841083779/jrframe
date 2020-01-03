/**
 * joblist
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');
	//
	$(document).ready(function() {
        $('.j_list .jt:first').addClass('jt_act');
		$('.j_list .jc:first').slideDown();
		$(".jt").click(function(){
			$(this).next("div").slideToggle('fast').siblings(".jc:visible").slideUp('fast');
			$(this).toggleClass("jt_act");
			$(this).siblings(".jt_act").removeClass("jt_act");
		});
    });
})

