/*
 * base
 */
define(function(require, exports, module) {
   var $ = require('$');
	var userAgent = navigator.userAgent.toLowerCase();
	
  /*
   * cookie
   */
  $.cookie = function(name, value, options) {
  	if (typeof value != 'undefined') { // name and value given, set cookie
  		options = options || {};
  		if (value === null) {
  			value = '';
  			options.expires = -1;
  		}
  		var expires = '';
  		if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
  			var date;
  			if (typeof options.expires == 'number') {
  				date = new Date();
  				date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
  			} else {
  				date = options.expires;
  			}
  			expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
  		}
  		var path = options.path ? '; path=' + options.path : '';
  		var domain = options.domain ? '; domain=' + options.domain : '';
  		var secure = options.secure ? '; secure' : '';
  		document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
  	} else { // only name given, get cookie
  		var cookieValue = null;
  		if (document.cookie && document.cookie != '') {
  			var cookies = document.cookie.split(';');
  			for (var i = 0; i < cookies.length; i++) {
  				var cookie = $.trim(cookies[i]);
  				// Does this cookie string begin with the name we want?
  				if (cookie.substring(0, name.length + 1) == (name + '=')) {
  					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
  					break;
  				}
  			}
  		}
  		return cookieValue;
  	}
  };
  /*
   * storage
   */
	$.storage = function(name, value, usecookie) {
		usecookie=true;
		if(typeof value == 'boolean'){
			value == 'undefined';
			usecookie = value;
		};
	if (typeof value != 'undefined') {
		if(window.localStorage) {localStorage.setItem(name, value)};
		if(usecookie){ $.cookie(name, value)};
		} else {
			if( window.localStorage) { return localStorage.getItem(name) };
			if(usecookie) { return $.cookie(name)};
		}
	};
	/*
	* 延迟渲染
	*/
	var _push=function(dom,fn){
		if(!$(dom).length) return false;
		function topush(_dom,_fn){
			$(_dom).each(function(i, e) {
				var _html=$(e).children('textarea').val();
				$(e).html(_html);
				if(_fn){
					_fn(_dom);
					};
				});
		};
		if(fn==void 0){
			if(typeof(dom)==='string'){
				topush(dom,fn);
			}else{
				fn=dom;
				dom='.topush';
				topush(dom,fn);
			}
		}else{
			topush(dom,fn);
		}
	};
	/*
	 * 设备识别
	 */
	var _getType=function(callback){
			var _Type = 'Pc';
			if(window.getComputedStyle){
				var bodyMark=window.getComputedStyle(document.body, ":after").getPropertyValue("content");
				_Type = /Mobile/.test(bodyMark) ? 'Mobile' : (/Pad/.test(bodyMark) ? 'Pad' : 'Pc');
				};
			if(!callback) return _Type;
			callback(_Type);
		};
	/*
	* 响应图片
	*/
	_getType(function(type){
		var $resImage = $('img[data-src][data-small]');
		$resImage.each(function() {
			var src = (/Mobile/.test(type)) ? $(this).data('small') : $(this).data('src');
			$(this).attr('src',src);
		});
	});

	/*
	* 异步加载
	*/
	var loadPage = -1;
	var loadAsync = function(url,param1,param2,num,dom){
		loadPage++;
		$.ajax({
			type:'get',
			url:url,
			data:{'param1':param1,'param2':param2,'page':loadPage,'num':num},
			success:function(data){
				$(dom).append(data)
			},
			error: function(a,b,c){
				$.error(c)
			}
		})
	};


	/*
	* 输出
	*/	
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
			},
		getType:_getType,
		topush:_push,
		toload:loadAsync
			
	}
		
});