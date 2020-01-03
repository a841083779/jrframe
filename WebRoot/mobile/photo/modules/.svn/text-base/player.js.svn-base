/*
* name: player.js
* version: v1.0
* update: 如果传入flv会会返回flv播放器
* date: 2014-08-26
*/

define(function(require, exports, module) {
	var playerFile=require.resolve('./player4flv.swf').slice(0,-3);
	
	module.exports=function($src,width,height){
		var src, w = width ? width : 480, h = height ? height : 320 ;
		
		if(/\.flv$/.test($src)){
			return '<embed width="'+w+'" height="'+h+'" src="'+playerFile+'?vcastr_file='+$src+'" wmode="transparent" quality="high" allowFullScreen="true" type="application/x-shockwave-flash"></embed>'
			
		}else{
			src = $src;
			if(/(.*)\.(mp4|webm)$/.test($src)){
				src = /(.*)\.(mp4|webm)$/.exec($src)[1]
			}
			
			return '<video controls preload="auto" width="'+w+'" height="'+h+'" >'+
			 '<source src="'+src+'.mp4" type="video/mp4">'+
			 '<source src="'+src+'.webm" type="video/webm">'+
			 '<embed width="'+w+'" height="'+h+'" src="'+playerFile+'?vcastr_file='+src+'.flv" wmode="transparent" quality="high" allowFullScreen="true" type="application/x-shockwave-flash"></embed>'+
			'</video>'
		}
		
	}

})