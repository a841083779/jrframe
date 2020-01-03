// youkuPlayer
define(function(require, exports, module) {

	module.exports=function(youkuID,width,height){
		var w=width?width:500,h=height?height:400;
		return "<embed width='"+w+"' height='"+h+"' src='http://static.youku.com/v1.0.0149/v/swf/qplayer.swf?VideoIDS="+youkuID+"&winType=adshow&isAutoPlay=false' wmode='transparent' quality='high' allowFullScreen='true' type='application/x-shockwave-flash'></embed>"
		}

})