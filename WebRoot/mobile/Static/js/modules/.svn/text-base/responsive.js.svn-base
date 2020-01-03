/*
* responsive
*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./responsive.css');
	
	var _getType=function(callback){
			var _Type = 'Pc';
			if(window.getComputedStyle){
				var bodyMark=window.getComputedStyle(document.body, ":after").getPropertyValue("content");
				_Type = /Pc/.test(bodyMark) ? 'Pc' : (/Pad/.test(bodyMark) ? 'Pad' : 'Mobile');
				};
			if(!callback) return _Type;
			callback(_Type);
		};
	//响应图片
	_getType(function(type){
		var $resImage = $('img[data-fullsrc]');
		$resImage.each(function() {
			var bigSrc=$(this).data('fullsrc'),
				 src = bigSrc.replace(/\w+\.\w{3}$/, function(bigSrc){
					 	return (/Mobile/.test(type)) ? "small/"+bigSrc : bigSrc ;
					 });
			$(this).attr('src',src);
		});
	});
	//输出
	module.exports={
		getType:_getType//,
	};

})