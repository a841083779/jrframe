/*
 * base
 */
define(function(require, exports, module) {
   var $ = require('$');
	var userAgent = navigator.userAgent.toLowerCase();
	
	//默认装载storage模块
	require('modules/storage');
	
	//提供方法
	module.exports={
		ie6:(function(){
			return (!-[1,] && !window.XMLHttpRequest)
			})(),
		ie7:(function(){
			return /msie 7/.test(userAgent)
			})(),
		ie8:(function(){
			return /msie 8/.test(userAgent)
			})(),
		getStyle:function(elem,attr){
			if(elem.currentStyle){return elem.currentStyle[attr]}else if(document.defaultView&&document.defaultView.getComputedStyle){attr=attr.replace(/([A-Z])/g,'-$1').toLowerCase();return document.defaultView.getComputedStyle(elem,null).getPropertyValue(attr)}else{return null}
			}//,
			
		}
		
});