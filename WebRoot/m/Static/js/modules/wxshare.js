define(function(require, exports, module) {
	var $ = require('$');
//分享到微信
module.exports = function(url){
	$('body').append('<div id="wexin_wrap" style="background-clip: padding-box;background-color: #FFFFFF;border: 1px solid rgba(0, 0, 0, 0.3); border-radius: 6px 6px 6px 6px; box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3); left: 50%; margin: -200px 0 0 -200px;overflow: hidden; position: fixed;_position: absolute; top: 50%; width:360px;height:360px; overflow:hidden;"><div style="border-bottom: 1px solid #EEEEEE; padding: 9px 15px;"><a style="text-decoration:none; margin-top: 2px; color: #000000; float: right; font-size: 20px; font-weight: bold; cursor:pointer;line-height: 20px; opacity: 0.2; text-shadow: 0 1px 0 #FFFFFF;" id="weixin_close">×</a><h3 style=" line-height: 30px; margin: 0; font-weight:normal; font-family:" 微软雅黑";"="">分享到微信朋友圈</h3></div><div style="text-align:center;height:251px;"><p><img src="http://s.jiathis.com/qrcode.php?url='+url+'" alt="二维码加载失败" style="margin-top:15px;" width="220" ></p></div><div style=" background-color: #f5f5f5; border-radius: 0 0 6px 6px; border-top: 1px solid #dddddd; box-shadow: 0 1px 0 #ffffff inset; padding:0 10px;padding-top:11px;text-align: right; font-size:12px;"><div style="text-align:left;margin:0; padding:0;font-size:12px;">打开微信，点击底部的“发现”，使用 “扫一扫” 即可将网页分享到我的朋友圈。</div></div></div>');
	$('#weixin_close').click(function(){
		$('#wexin_wrap').remove();
		});
};

})