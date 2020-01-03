/*
 * name: base
 * version: 2.3.0
 * update: 区分延迟渲染和按需渲染
 * date: 2015-06-25
 */
define('base', function(require, exports, module) {
	var $ = require('jquery');

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
				expires = '; expires=' + date.toUTCString();
				// use expires attribute, max-age is not supported by IE
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
	 * 延迟渲染
	 */
	var _push = function(dom, fn) {
		if (!$(dom).length) return false;

		function topush(_dom, _fn) {
			$(_dom).each(function(i, e) {
				if($(e).hasClass('pushed') || !$(e).children('textarea').length) return;
				if ($(e).children('textarea').data('url')) {
					$.ajax({
						url: $(e).children('textarea').data('url'),
						success: function(data) {
							$(e).html(data).addClass('pushed');
							typeof(_fn) === 'function' && _fn(e);
						}
					})
				} else {
					var _html = $(e).children('textarea').val();
					$(e).html(_html).addClass('pushed');
					typeof(_fn) === 'function' && _fn(e);
				}
			})
		}
		if (fn == void 0) {
			if (typeof(dom) !== 'function') {
				topush(dom, fn);
			} else {
				fn = dom;
				dom = '.topush';
				topush(dom, fn);
			}
		} else {
			topush(dom, fn);
		}
	};
	/*
	 * 按需渲染
	 */
	var _scanpush = function() {
		$(function(){
			var typeCatch = _getType();
			if (typeCatch == 'Pc') {
				_push('.PcPush', function() {
					$('body').trigger('PcPush');
				})
			} else {
				_push('.UnpcPush', function() {
					$('body').trigger('UnpcPush');
				})
			}
			if (typeCatch == 'Mobile') {
				_push('.MobilePush', function() {
					$('body').trigger('MobilePush');
				})
			} else {
				_push('.UnmobilePush', function() {
					$('body').trigger('UnmobilePush');
				})
			}
		})
	}

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
		if (!callback) return _Orient;
		callback(_Orient);
	};

	$(window).bind("orientationchange", function(event) {
		$('body').removeClass('Heng Shu').addClass(_getOrient())
	});

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
	 * 异步加载
	 */
	var loadPage = -1,
		loadParam = {},
		_loadAsync = function(url, pageSize, param, callback) {
			loadPage++;
			loadParam.page = loadPage;
			loadParam.size = pageSize;
			$.extend(param, loadParam);
			$.ajax({
				type: 'get',
				url: url,
				data: param,
				success: function(data) {
					callback && callback(data);
				},
				error: function(a, b, c) {
					loadPage--;
					console.warn(c);
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
	_browser.isMobile = !!userAgent.match(/(iphone|ipod|ipad|android|blackberry|bb10|windows phone|tizen|bada)/);
	_browser.isIE6 = (!-[1, ] && !window.XMLHttpRequest);
	_browser.ie = /msie\s*(\d+)\./.exec(userAgent) ? /msie\s*(\d+)\./.exec(userAgent)[1] : 0;
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
	 * jquery.placeholder
	 * http://mths.be/placeholder v2.1.1 by @mathias 
	 */
	(function() {
		var isOperaMini = Object.prototype.toString.call(window.operamini) == '[object OperaMini]';
		var isInputSupported = 'placeholder' in document.createElement('input') && !isOperaMini;
		var isTextareaSupported = 'placeholder' in document.createElement('textarea') && !isOperaMini;
		var valHooks = $.valHooks;
		var propHooks = $.propHooks;
		var hooks;
		var placeholder;
		if (isInputSupported && isTextareaSupported) {
			placeholder = $.fn.placeholder = function() {
				return this
			};
			placeholder.input = placeholder.textarea = true
		} else {
			var settings = {};
			placeholder = $.fn.placeholder = function(options) {
				var defaults = {
					customClass: 'placeholder'
				};
				settings = $.extend({}, defaults, options);
				var $this = this;
				$this.filter((isInputSupported ? 'textarea' : ':input') + '[placeholder]').not('.' + settings.customClass).bind({
					'focus.placeholder': clearPlaceholder,
					'blur.placeholder': setPlaceholder
				}).data('placeholder-enabled', true).trigger('blur.placeholder');
				return $this
			};
			placeholder.input = isInputSupported;
			placeholder.textarea = isTextareaSupported;
			hooks = {
				'get': function(element) {
					var $element = $(element);
					var $passwordInput = $element.data('placeholder-password');
					if ($passwordInput) {
						return $passwordInput[0].value
					}
					return $element.data('placeholder-enabled') && $element.hasClass(settings.customClass) ? '' : element.value
				},
				'set': function(element, value) {
					var $element = $(element);
					var $passwordInput = $element.data('placeholder-password');
					if ($passwordInput) {
						return $passwordInput[0].value = value
					}
					if (!$element.data('placeholder-enabled')) {
						return element.value = value
					}
					if (value === '') {
						element.value = value;
						if (element != safeActiveElement()) {
							setPlaceholder.call(element)
						}
					} else if ($element.hasClass(settings.customClass)) {
						clearPlaceholder.call(element, true, value) || (element.value = value)
					} else {
						element.value = value
					}
					return $element
				}
			};
			if (!isInputSupported) {
				valHooks.input = hooks;
				propHooks.value = hooks
			}
			if (!isTextareaSupported) {
				valHooks.textarea = hooks;
				propHooks.value = hooks
			}
			$(function() {
				$(document).delegate('form', 'submit.placeholder', function() {
					var $inputs = $('.' + settings.customClass, this).each(clearPlaceholder);
					setTimeout(function() {
						$inputs.each(setPlaceholder)
					}, 10)
				})
			});
			$(window).bind('beforeunload.placeholder', function() {
				$('.' + settings.customClass).each(function() {
					this.value = ''
				})
			})
		}

		function args(elem) {
			var newAttrs = {};
			var rinlinejQuery = /^jQuery\d+$/;
			$.each(elem.attributes, function(i, attr) {
				if (attr.specified && !rinlinejQuery.test(attr.name)) {
					newAttrs[attr.name] = attr.value
				}
			});
			return newAttrs
		}

		function clearPlaceholder(event, value) {
			var input = this;
			var $input = $(input);
			if (input.value == $input.attr('placeholder') && $input.hasClass(settings.customClass)) {
				if ($input.data('placeholder-password')) {
					$input = $input.hide().nextAll('input[type="password"]:first').show().attr('id', $input.removeAttr('id').data('placeholder-id'));
					if (event === true) {
						return $input[0].value = value
					}
					$input.focus()
				} else {
					input.value = '';
					$input.removeClass(settings.customClass);
					input == safeActiveElement() && input.select()
				}
			}
		}

		function setPlaceholder() {
			var $replacement;
			var input = this;
			var $input = $(input);
			var id = this.id;
			if (input.value === '') {
				if (input.type === 'password') {
					if (!$input.data('placeholder-textinput')) {
						try {
							$replacement = $input.clone().attr({
								'type': 'text'
							})
						} catch (e) {
							$replacement = $('<input>').attr($.extend(args(this), {
								'type': 'text'
							}))
						}
						$replacement.removeAttr('name').data({
							'placeholder-password': $input,
							'placeholder-id': id
						}).bind('focus.placeholder', clearPlaceholder);
						$input.data({
							'placeholder-textinput': $replacement,
							'placeholder-id': id
						}).before($replacement)
					}
					$input = $input.removeAttr('id').hide().prevAll('input[type="text"]:first').attr('id', id).show()
				}
				$input.addClass(settings.customClass);
				$input[0].value = $input.attr('placeholder')
			} else {
				$input.removeClass(settings.customClass)
			}
		}

		function safeActiveElement() {
			try {
				return document.activeElement
			} catch (exception) {}
		}
	})()


	/*
	 * 模块库内部方法
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
				$(this).css('transform', theTrans + '(' + number + ')');
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
		var lazyImg = $(this).find('img[' + imgattr + ']');
		if (lazyImg.length) {
			lazyImg.each(function(i, e) {
				if ($(e).attr(imgattr) != 'loaded') {
					$(e).attr('src', $(this).attr(imgattr)).attr(imgattr, 'loaded')
				}
			})
		};
		return $(this);
	});

	/*
	 * 输出
	 */
	module.exports = {
		browser: _browser,
		getStyle: function(elem, attr) {
			if (elem.currentStyle) {
				return elem.currentStyle[attr];
			} else if (document.defaultView && document.defaultView.getComputedStyle) {
				attr = attr.replace(/([A-Z])/g, '-$1').toLowerCase();
				return document.defaultView.getComputedStyle(elem, null).getPropertyValue(attr);
			} else {
				return null;
			}
		},
		getType: _getType,
		resImg: _resImg,
		getOrient: _getOrient,
		topush: _push,
		scanpush: _scanpush,
		toload: _loadAsync,
		throttle: _throttle,
		getUrlParam: _urlParam
	}

});