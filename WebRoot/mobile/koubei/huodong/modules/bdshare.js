/*
* bdshare.js
*/
define(function(require, exports, module) {

	module.exports=function(conf){
		window._bd_share_config = {
			common : {
			},
			share : conf
		};
		with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
	}

})