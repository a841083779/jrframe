/*
* name: video.js
* version: v1.3.1
* update: 跨平台flv扩展名丢失
* date: 2015-03-12
*/

define(function(require, exports, module) {
	var $ = require('jquery');
	var playerFile=require.resolve('./video.swf').slice(0,-3);
	
	module.exports=function(config){
		var opt = {
			src:'',
			w:480,
			h:320,
			auto:false,
			ctrl:true,
			txt:'www.jerei.com'
		};
		
		if(typeof(config)==='object'){
			$.extend(opt, config || {}, $(this).data('config') || {});
		}else{
			opt.src = config;
		};
		
		if(/\.flv\s*$/.test(opt.src)){
			return '<embed width="'+opt.w+'" height="'+opt.h+'" src="'+playerFile+
			'" flashvars="vcastr_file='+opt.src +'&IsAutoPlay='+ (opt.auto ? '1' : '0') +
			'&LogoText='+ opt.txt +
			'" wmode="transparent" quality="high" allowFullScreen="true" type="application/x-shockwave-flash"></embed>'	
		}else{
			src = opt.src;
			if(/(.*)\.(mp4|webm)\s*$/.test(opt.src)){
				src = /(.*)\.(mp4|webm)$/.exec(opt.src)[1];
			};
			
			return '<video '+ (opt.ctrl ? 'controls' : '') +' preload="auto" ' + (opt.auto ? 'autoplay' : '') + ' width="'+opt.w+'" height="'+opt.h+'" >'+
			 '<source src="'+src+'.mp4" type="video/mp4">'+
			 '<source src="'+src+'.webm" type="video/webm">'+
			 '<embed width="'+opt.w+'" height="'+opt.h+'" src="'+playerFile+
			'" flashvars="vcastr_file='+opt.src +'.flv&IsAutoPlay='+ (opt.auto ? '1' : '0') +
			'&LogoText='+ opt.txt +
			'" wmode="transparent" quality="high" allowFullScreen="true" type="application/x-shockwave-flash"></embed>'+
			'</video>'
		};
		
	}

})