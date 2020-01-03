/**
 * 跨域上传组件
 * 
 * @param style
 *            组件为IFRAME，此属性为IFRAME的样式，默认为：width: 40px; height: 20px; border :
 *            none;
 * @param remotUrl
 *            远程请求路径，默认为：http://192.168.0.154:2112/upload.jsp
 * @param callback
 *            图片上传后的处理方法名称，方法会传入一个图片以逗号分割的字符串，默认为：showImg
 * @param domain
 *            调用网站的域名，默认值为：document.domain
 * @param counts
 *            单词最大上传文件数量，默认值为：10
 * @param multi
 *            是否开启多文件上传，默认值为：false
 * @param buttonImg
 *            上传的按钮图片，默认值为：服务器上按钮图片
 * @param sizeLimit
 *            文件上传大小限制，默认值为：1024 * 1024 * 5
 * @param buttonImgWidth
 *            按钮图片宽度，默认值为：40
 * @param buttonImgHeight
 *            按钮图片高度，默认值为：20
 * @param queueSizeLimit
 *            多文件上传时一次选择的文件数量，默认值为：10
 * @param fileExt
 *            允许上传的文件类型，默认值为：jpg,gif,png,bmp
 * @param folder
 *            上传到服务器上的文件夹名称，必选项，无默认值
 * @param watermark
 *            是否添加水印 true 或者 false
 */
(function($) {
	$.fn.JrUpload = function(opts) {
		if (undefined == opts || undefined == opts.folder) {
			alert("请配置文件夹名称！");
			return;
		}
		var defualts = {
			style : "width: 40px; height: 20px; border : none;",
			buttonImgWidth : 40,
			buttonImgHeight : 20,
			remotUrl : "http://product.21-sun.com/upload.jsp",
			callback : "showImg",
			domain : document.domain + ":" + window.location.port,
			multi : false,
			counts : 10,
			buttonImg : "/plugin/upload/uploadify/upload.gif",
			sizeLimit : 1024 * 1024 * 0.8,
			queueSizeLimit : 10,
			fileExt : "jpg,gif,png,bmp",
			watermark : true
		};
		var opts = $.extend({}, defualts, opts);
		var htm = "<iframe border='0' frameborder='0' ";
		htm += " style='" + opts.style + "'";
		htm += " scrolling='no' ";
		htm += " src='" + opts.remotUrl + "?callback=" + opts.callback;// 回调函数
		htm += "&domain=" + opts.domain;// 域名
		htm += "&counts=" + opts.counts;// 最大上传文件数量
		htm += "&multi=" + opts.multi;// 是否允许多文件上传
		htm += "&buttonImg=" + opts.buttonImg;// 按钮图片
		htm += "&sizeLimit=" + opts.sizeLimit;// 文件上传大小限制
		htm += "&buttonImgWidth=" + opts.buttonImgWidth;// 图片宽度
		htm += "&buttonImgHeight=" + opts.buttonImgHeight;// 图片高度
		htm += "&queueSizeLimit=" + opts.queueSizeLimit;// 多文件上传时选择的文件数量
		htm += "&fileExt=" + opts.fileExt;// 允许上传的文件类型
		htm += "&folder=" + opts.folder;
		htm += "&watermark=" + opts.watermark
		htm += " '";
		htm += "></iframe> ";
		$(this).html(htm);
	};
})(jQuery);
