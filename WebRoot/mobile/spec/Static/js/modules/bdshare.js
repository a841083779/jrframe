// bdshare
define(function(require, exports, module) {
	var $=require('$');
	module.exports=function(conf){
		var config={
			title:'',
			desc:'',
			url:'',
			tag:'',
			size:'',
			style:'',
			mini : ''
			};
		$.extend(config,conf);
		window._bd_share_config = {
			common : {
			},
			share : [{
				bdText : encodeURIComponent(config.title),	
				bdDesc : encodeURIComponent(config.desc),	
				bdUrl : encodeURIComponent(config.url),
				tag : config.tag,
				bdSize : config.size,
				bdStyle : config.style,
				bdMini : config.mini
			}]
		};

		with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
	}

})