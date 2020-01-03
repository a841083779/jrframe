/**
 * prodetail
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');

	require.async('modules/zoom',function(){
		$('.zoom').zoom();
		});
		
	
})

