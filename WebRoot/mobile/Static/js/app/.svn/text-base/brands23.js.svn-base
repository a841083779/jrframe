/**
 * prolist
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');
	//
	
	require.async('modules/pagescroller',function(){
	   $('.brandsList').pageScroller({navigation:'.side_zm'}); 
	});
	
	var h = $(window).height()-$('.bottomBar').height()-20;
	var n = $('.side_zm li').length;
	var lh = h/n
	$('.side_zm li,.side_zm li a').height(lh).css('line-height',lh+'px');
	$(window).resize(function(){
		var h = $(window).height()-$('.bottomBar').height();
		var n = $('.side_zm li').length;
		var lh = h/n
		$('.side_zm li,.side_zm li a').height(lh).css('line-height',lh+'px');
	});
	
})

