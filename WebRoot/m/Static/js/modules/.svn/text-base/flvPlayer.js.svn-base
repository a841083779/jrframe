/*
* flvPlayer
*/
define(function(require, exports, module) {
	var playerFile=Static+'scripts/modules/flvplayer.swf';

	module.exports=function($src,width,height){
		var w=width?width:500,h=height?height:400;
		return "<embed width='"+w+"' height='"+h+"' src='"+playerFile+"?vcastr_file="+$src+"' wmode='transparent' quality='high' allowFullScreen='true' type='application/x-shockwave-flash'></embed>"
		}

})