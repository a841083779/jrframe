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
	$('.side_zm li,.side_zm li a').height(h/n);
	$(window).resize(function(){
		var h = $(window).height()-$('.bottomBar').height();
		var n = $('.side_zm li').length;
		$('.side_zm li,.side_zm li a').height(h/n);
	});
	
})

