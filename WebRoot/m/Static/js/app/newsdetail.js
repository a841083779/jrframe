/**
 * newsdetail
 */

define(function(require) {
   var $ = require('$');		
	var helper=require('modules/helper');
	require('./common');

	if(typeof(jrInfo)==='object'){
		/*
		* 浏览次数
		* helper.ViewCount(jrInfo,callback(count)){...}
		*/	
		helper.ViewCount(jrInfo,function(count){
			$('#viewCountId').text(count);
			});
		/*
		*上一条下一条
		* helper.getInforPN(jrInfo,callback(prev,next)){...}
		*/
		helper.getInforPN(jrInfo,function(prev,next){
			$('#prev').find('a').text(prev.title).attr('href',prev.file).end().find('.date').text(prev.date);
			$('#next').find('a').text(next.title).attr('href',next.file).end().find('.date').text(next.date);
			});
		/*
		* 返回列表
		* backToChannel(jrInfo,callback(href)){...}
		*/
		helper.backToChannel(jrInfo,function(href){
			$('#b2l').attr('href',href);
			});
			
	}
	
	//百度分享
	require.async('modules/bdshare',function(bdshare){
		bdshare(2)
		});
	
})

