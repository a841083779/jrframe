/*
 * name: base
 * version: 0.3
 * update: 增加内部方法
 * date: 2014-10-15
 */

	var userAgent = navigator.userAgent.toLowerCase();
	/*
	* css3 位移[inside]
	*/
	!$.fn._css && ($.fn._css = function(LeftOrTop, number){
		var hasTrans = ( LeftOrTop == 'left' || LeftOrTop == 'top' ) ? true : false,
			canTrans = ( !('transform' in document.createElement('div').style) ) ? false : true,
			theTrans = LeftOrTop == 'left' ? 'translateX' : 'translateY';
		if(number!=void(0)){
			if(canTrans && hasTrans){
				number = parseFloat(number)+'px';
				$(this).data(theTrans,number).css('transform', theTrans + '('+ number +')')
			}else{
				$(this).css(LeftOrTop, number)
			}
			return $(this)	
		}else{
			if(canTrans && hasTrans){
				return $(this).data(theTrans);
			}else{
				return $(this).css(LeftOrTop)
			}
		}		
	});
	/*
	* 异步加载图片[inside]
	*/
	!$.fn._loadimg && ($.fn._loadimg = function(imgattr){
		if(!$(this).find('img[data-small]').length && $(this).find('img['+imgattr+']').length)	{

			$(this).find('img['+imgattr+']').each(function(i,e){
				
				if($(e).attr(imgattr)!='loaded'){
					$(e).attr('src',$(this).attr(imgattr)).attr(imgattr,'loaded')
				}
			})
		};
		return $(this);
	});
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
	* 设备方向
	*/
	var _getOrient = function (callback){
		var _Orient;
		if (window.orientation == 0 || window.orientation == 180) {
			_Orient = 'Shu'
		}else if (window.orientation == 90 || window.orientation == -90) {
			_Orient = 'Heng'
		};
		if(!callback) return _Orient;
		callback(_Orient);
	};

	$( window ).bind("orientationchange", function( event ) { 
		$('body').removeClass('Heng Shu').addClass(_getOrient())
	}); 

	
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
	var loadParam = {
		"page" : "" ,
		"size" : ""
	}
	var loadAsync = function(url, param, pageSize, dom, callback){
		loadPage++;
		loadParam.page = loadPage ;
		loadPage.size =pageSize ;
		$.extend(param, loadPage);
		$.ajax({
			type:'get',
			url:url,
			data:param,
			success:function(data){
				$(dom).append(data)
				callback && callback()
			},
			error: function(a,b,c){
				loadPage--;
				$.error(c)
			}
		})
	};

		