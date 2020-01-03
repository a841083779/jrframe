/**
 * newslist
 */

define(function(require) {
   var $ = require('$');		
	require('./common');
	
	var helper=require('modules/helper');
	/*
	* 每页显示条数
	*/
	require.async('modules/sele',function(){
		$('.control').sele({
			fn:function(o){
				location.assign("?pageCount="+o);
			}
		});
	});

})

