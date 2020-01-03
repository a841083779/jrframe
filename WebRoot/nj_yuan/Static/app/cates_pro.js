/**
 * index
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	require('./common');
	
	require('on-scroll');
	$('.cb_section').onScroll({
		offset:1,
		target:'.cate_target'
	});
	
})

