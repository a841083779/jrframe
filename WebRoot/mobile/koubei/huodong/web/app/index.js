/**
 * index
 */
define(function(require) {
	var $ = require('$');
	var base=require('base');
	require('./common');
	
	var wch = $('.work_c li:first').height();
	$('.work_c .last').height(wch);
	$(window).resize(function(){
		var wch = $('.work_c li:first').height();
		$('.work_c .last').height(wch);
	})

})

