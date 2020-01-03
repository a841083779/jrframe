/**
 * newsdetail
 */

define(function(require) {
	var $ = require('$');		
	var helper=require('helper');
	var com=require('./common');

	//启动入口js之前输出jrInfo，示例：
	//var jrInfo={'id':'15909','table':'jrcms_information','wn':'20140121110658735','cn':'20140121152505806'}

	if(typeof(jrInfo)==='object'){
		/*
		* 浏览次数
		*/	
		helper.ViewCount(jrInfo,function(count){
			$('#viewCountId').text(count);
			});
		/*
		*上一条下一条
		*/
		helper.getInforPN(jrInfo,function(prev,next){
			$('#prev').find('a').text(prev.title).attr('href',prev.file).end().find('.date').text(prev.date);
			$('#next').find('a').text(next.title).attr('href',next.file).end().find('.date').text(next.date);
			});
		/*
		* 返回列表
		*/
		helper.backToChannel(jrInfo,function(href){
			$('#b2l').attr('href',href);
			});
			
	}
	
	
})

