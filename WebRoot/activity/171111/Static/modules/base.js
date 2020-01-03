/*
 * name: base
 * version: 2.13.3
 * update: browser.ie对于非ie浏览器返回Infinity
 * date: 2016-04-30
 */
define('base', function(require, exports, module) {
	'use strict';
	var $ = require('jquery');


	/*
	 * 设备识别
	 */
	var _getType = function(callback) {
		var _Type = 'Pc';
		if (window.getComputedStyle) {
			var bodyMark = window.getComputedStyle(document.body, ":after").getPropertyValue("content");
			_Type = /Mobile/.test(bodyMark) ? 'Mobile' : (/Pad/.test(bodyMark) ? 'Pad' : 'Pc');
		};
		if (!callback) return _Type;
		callback(_Type);
	};

	/*
	 * 设备方向
	 */
	var _getOrient = function(callback) {
		var _Orient;
		if (window.orientation == 0 || window.orientation == 180) {
			_Orient = 'Shu'
		} else if (window.orientation == 90 || window.orientation == -90) {
			_Orient = 'Heng'
		};
		if (_Orient === void(0)) {
			_Orient = $(window).width() > $(window).height() ? 'Heng' : 'Shu';
		}
		if(typeof(callback)==='function'){
			callback(_Orient);
			$(window).bind("orientationchange", function(event) {
				callback(_getOrient());
			});
		}
		return _Orient;
	};

	/*
	 * 响应图片
	 */
	var ready = require('img-ready');
	var _resImg = function(bigSrc) {
		bigSrc = bigSrc ? bigSrc : 'data-src';
		_getType(function(type) {
			if (!/Mobile/.test(type)) {
				$('img[' + bigSrc + ']').each(function(i, e) {
					$(e).attr('src', $(e).attr(bigSrc));
					ready($(e).attr('src'), function() {},
						function(width, height) {
							$(e).removeAttr(bigSrc);
						}
					)
				})
			}
		})
	};

	/*
	 * 函数节流
	 * @method: 函数体; @delay: 过滤执行间隔; @duration: 至少执行一次的间隔
	 */
	var _throttle = function throttle(method, delay, duration) {
		var timer = null,
			begin = new Date();
		delay = delay ? delay : 64;
		duration = duration ? duration : 640;
		return function() {
			var context = this,
				args = arguments,
				current = new Date();;
			clearTimeout(timer);
			if (current - begin >= duration) {
				method.apply(context, args);
				begin = current;
			} else {
				timer = setTimeout(function() {
					method.apply(context, args);
				}, delay);
			}
		}
	};

	/*
	 * 获取url参数
	 * @name：要获取的键；@search：可选，url
	 */
	var _urlParam = function getQueryString(name, url) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var s = url ? (url.split('?')[1] ? url.split('?')[1] : '') : window.location.search.substr(1);
		var r = s.match(reg);
		if (r != null) {
			return decodeURI(r[2]);
		}
		return null;
	}

	/*
	 * 浏览器
	 */
	var userAgent = navigator.userAgent.toLowerCase(),
		_browser = {};
	_browser.isMobile = !!userAgent.match(/(iphone|ipod|ipad|android|blackberry|bb10|windows phone|tizen|bada)/) && _getType()!=="Pc";
	_browser.ie = /msie\s*(\d+)\./.exec(userAgent) ? /msie\s*(\d+)\./.exec(userAgent)[1] : Infinity;
	_browser.platform = navigator.platform;
	_browser.agent = userAgent;
	_browser.support3d = (function() {
		var el = document.createElement('p'),
			has3d,
			transforms = {
				'webkitTransform': '-webkit-transform',
				'OTransform': '-o-transform',
				'msTransform': '-ms-transform',
				'MozTransform': '-moz-transform',
				'transform': 'transform'
			};
		// Add it to the body to get the computed style.
		document.body.insertBefore(el, null);
		for (var t in transforms) {
			if (el.style[t] !== undefined) {
				el.style[t] = "translate3d(1px,1px,1px)";
				has3d = window.getComputedStyle(el).getPropertyValue(transforms[t]);
			}
		}
		document.body.removeChild(el);
		return (has3d !== undefined && has3d.length > 0 && has3d !== "none");
	})();

	/*
	 * 内部方法
	 */
	// 兼容css3位移
	!$.fn._css && ($.fn._css = function(LeftOrTop, number) {
		var hasTrans = (LeftOrTop == 'left' || LeftOrTop == 'top') ? true : false,
			canTrans = _browser.support3d,
			theTrans = LeftOrTop == 'left' ? 'translateX' : 'translateY',
			matrixPosi = hasTrans ? (LeftOrTop == 'left' ? 4 : 5) : null;
		if (number != void(0)) {
			//赋值
			if (canTrans && hasTrans) {
				number = parseFloat(number) + 'px';
				$(this).css('transform', 'translateZ(0) ' + theTrans + '(' + number + ')');
			} else {
				$(this).css(LeftOrTop, number);
			}
			return $(this)
		} else {
			//取值
			if (canTrans && hasTrans && $(this).css('transform') !== 'none') {
				var transData = $(this).css('transform').match(/\((.*\,?\s?){6}\)$/)[0].substr(1).split(',');
				return parseFloat(transData[matrixPosi]);
			} else {
				return $(this).css(LeftOrTop)
			}
		}
	});
	// 加载指定属性的图片
	!$.fn._loadimg && ($.fn._loadimg = function(imgattr) {
		var $this = $(this),
			lazyImg;
		if (!imgattr) {
			return $this;
		};
		if ($this.attr(imgattr)) {
			lazyImg = $this;
		} else if ($(this).find('img[' + imgattr + ']').length) {
			lazyImg = $(this).find('img[' + imgattr + ']');
		} else {
			return $this;
		};
		if (lazyImg.length) {
			var _theSrc;
			lazyImg.each(function(i, e) {
				_theSrc = $.trim($(e).attr(imgattr));
				if (_theSrc && _theSrc != 'loaded') {
					if (e.tagName.toLowerCase() === 'img') {
						$(e).attr('src', _theSrc).attr(imgattr, 'loaded').addClass('loaded');
					} else {
						$(e).css("background-image", "url(" + _theSrc + ")").attr(imgattr, 'loaded').addClass('loaded');
					}
				}
			});
			_theSrc = null;
		};
		return $(this);
	});
	//getScript
	var _getScript = function(road, callback, option) {
		if (road && road.split || ($.isArray(road) && road.length)) {
			var def = {
					css: false,
					jquery: false,
					rely: false
				},
				opt = $.extend({}, def, option || {}),
				loadScript = function(road, hold){
					/*
					@road:请求url
					@hold:是否阻断默认回调，为function将阻断默认回调并执行自身
					*/
					var file = seajs.resolve(road),
						headNode = document.getElementsByTagName('head')[0],
						script = document.createElement("script"),
						scriptError = function(xhr, settings, exception){
							headNode.removeChild(script);
							script = document.createElement("script");
							console.warn('getScript:加载失败，正在重试~')
							load(function(){
								console.warn('getScript:加载失败了!');
							});
						},
						scriptOnload = function(data, status) {
							if(!data){
								data = status = null
							}
							if(hold && typeof(hold)==='function'){
								hold();
							}else if(typeof(callback) === 'function'){
								if(data){
									callback(data, status);
								}else{
									callback();
								}
								
							}
						},
						load = function(errorCallback){
							//$.getScript(file).done(scriptOnload).fail(errorCallback || scriptError);
							var errorCallback = errorCallback || scriptError;
							if (opt.jquery) {
								window.$ = $;
								window.jQuery = $;
							};
							script.type = "text/javascript";
		                    script.onload = scriptOnload
		                    script.onerror = errorCallback;
		                    script.src = file;
		                    headNode.appendChild(script);
						};
					if(opt.css){
						var cssfile = '', 
							_css;
						if(opt.css.split){
							cssfile = opt.css;
						}else{
							cssfile = file.replace(/\.js$/,".css");
						};
						_css = document.createElement('link');
						_css.rel = "stylesheet";
						_css.onerror = function(e){
							headNode.removeChild(_css);
							cssfile = null;
							_css = null;
							return null;
						};
						_css.href = cssfile;
						headNode.appendChild(_css);
						headNode = cssfile = _css = null;
					};
					load();
				};
			if(road.split){
				loadScript(road);
			}else if(road.length){
				var scriptsLength = road.length,
					scriptsCount = 0;
				if(opt.rely){
					//线性依赖
					var getNext = function(isLast){
							var hold;
							if(!isLast){
								hold = function(){
									scriptsCount++;
									getNext(scriptsLength>scriptsCount);
								}
							}
							loadScript(road[scriptsCount], hold);
						}
					getNext();
				}else{
					//同时发起
					var scriptRoad;
					while(scriptsCount<scriptsLength){
						scriptRoad = road[scriptsCount];
						scriptsCount++;
						loadScript(scriptRoad, scriptsLength>scriptsCount);
					}
				}
			}
		}
	};

	/*
	 * 输出
	 */
	module.exports = {
		browser: _browser,
		getType: _getType,
		resImg: _resImg,
		getOrient: _getOrient,
		throttle: _throttle,
		getUrlParam: _urlParam
	}

});