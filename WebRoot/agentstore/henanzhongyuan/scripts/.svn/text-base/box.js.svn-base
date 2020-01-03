/*
 * box (from zhangxinxu)
 */
define(function(require, exports, module) {
	var $ = require('$');
	require('./box.css');

	var Language = [{
		close: "关闭",
		confirm: "确认",
		cancel: "取消",
		loading: "加载中...",
		error: "加载出了点问题"
	}, {
		close: "close",
		confirm: "confirm",
		cancel: "cancel",
		loading: "loading...",
		error: "something is wrong"
	}];
	var boxDefault = {
		title: "对话框",
		shut: "×",
		index: 99,
		opacity: 0.5,
		width: "auto",
		height: "auto",
		bar: true,           //是否显示标题栏
		
		bg: true,            //是否显示半透明背景
		
		btnclose: true,      //是否显示关闭按钮
		
		fix: true,           //是否弹出框固定在页面上
		
		bgclose: true,       //是否点击半透明背景隐藏弹出框
		
		drag: false,         //是否可拖拽
		
		ajaxTagA: true,      //是否a标签默认Ajax操作
		
		protect: "auto",     //保护装载的内容
		
		onshow: $.noop,      //弹窗显示后触发事件
		
		onclose: $.noop,     //弹窗关闭后触发事件
		
		delay: 0,            //弹窗打开后关闭的时间, 0和负值不触发
		
		style: null,         //附加样式
		
		lang: 0 //语言选择，0：中文 1:英文
	};
	$.fn.box = function(options) {
		var s = $.extend({}, boxDefault, options || {});
		var WRAP = '<div id="boxBlank" onselectstart="return false;"></div>' + '<div class="wrap_out" id="wrapOut">' + '<div class="wrap_in" id="wrapIn">' + '<div id="wrapBar" class="wrap_bar" onselectstart="return false;">' + '<h4 id="wrapTitle" class="wrap_title"></h4>' + '<div class="wrap_close"><a href="javasctipt:" id="wrapClose" title="' + Language[s.lang].close + '"></a></div>' + '</div>' + '<div class="wrap_body" id="wrapBody"></div>' + '</div>' + '</div>';
		if (s.style) {
			var style_ext = '<link href="' + s.style + '" rel="stylesheet" />';
			$('head').append($(style_ext));
		};
		return this.each(function() {
			var node = this.nodeName.toLowerCase();
			if (node === "a" && s.ajaxTagA) {
				$(this).click(function() {
					var href = $.trim($(this).attr("href"));
					if (href && href.indexOf("javascript:") != 0) {
						if (href.indexOf('#') === 0) {
							$.box($(href), options);
						} else {
							//加载图片
							$.box.loading();
							var myImg = new Image(),
								element;
							myImg.onload = function() {
								var w = myImg.width,
									h = myImg.height;
								if (w > 0) {
									var element = $('<img src="' + href + '" width="' + w + '" height="' + h + '" />');
									options.protect = false;
									$.box(element, options);
								}
							};
							myImg.onerror = function() {
								//显示加载图片失败
								$.box.ajax(href, {}, options);
							};
							myImg.src = href;
						}
					};
					return false;
				});
			} else {
				$.box($(this), options);
			}
		});
	};
	$.box = function(elements, options) {
		if (!elements) {
			return;
		};
		var s = $.extend({}, boxDefault, options || {});
		var WRAP = '<div id="boxBlank" onselectstart="return false;"></div>' + '<div class="wrap_out" id="wrapOut">' + '<div class="wrap_in" id="wrapIn">' + '<div id="wrapBar" class="wrap_bar" onselectstart="return false;">' + '<h4 id="wrapTitle" class="wrap_title"></h4>' + '<div class="wrap_close"><a href="javasctipt:" id="wrapClose" title="' + Language[s.lang].close + '"></a></div>' + '</div>' + '<div class="wrap_body" id="wrapBody"></div>' + '</div>' + '</div>';
		if (s.style) {
			var style_ext = '<link href="' + Static + '/css/' + s.style + '" rel="stylesheet" />';
			$('head').append($(style_ext));
		};
		//弹框的显示
		var eleOut = $("#wrapOut"),
			eleBlank = $("#boxBlank");
		if (eleOut.size()) {
			eleOut.show();
			eleBlank[s.bg ? "show" : "hide"]();
		} else {
			$("body").append(WRAP);
		};
		if (typeof(elements) === "object") {
			elements.show();
		} else {
			elements = $(elements);
		};
		//一些元素对象
		$.o = {
			s: s,
			ele: elements,
			bg: eleBlank.size() ? eleBlank : $("#boxBlank"),
			out: eleOut.size() ? eleOut : $("#wrapOut"),
			tit: $("#wrapTitle"),
			bar: $("#wrapBar"),
			clo: $("#wrapClose"),
			bd: $("#wrapBody")
		};
		// 标题以及关闭内容
		$.o.tit.html(s.title);
		$.o.clo.html(s.shut);
		//装载元素
		$.o.bd.empty().append(elements);
		if ($.isFunction(s.onshow)) {
			s.onshow();
		};
		//尺寸
		$.box.setSize();
		//定位
		$.box.setPosition();

		if (s.fix) {
			$.box.setFixed();
		};
		if (s.drag) {
			$.box.drag();
		} else {
			$(window).resize(function() {
				$.box.setPosition();
			});
		};
		if (!s.bar) {
			$.box.barHide();
		} else {
			$.box.barShow();
		};
		if (!s.bg) {
			$.box.bgHide();
		} else {
			$.box.bgShow();
		};
		if (!s.btnclose) {
			$.box.closeBtnHide();
		} else {
			$.o.clo.click(function() {
				$.box.hide();
				return false;
			});
		};
		if (s.bgclose) {
			$.box.bgClickable();
		};
		if (s.delay > 0) {
			setTimeout($.box.hide, s.delay);
		};
	};
	$.extend($.box, {
		setSize: function() {
			if (!$.o.bd.size() || !$.o.ele.size() || !$.o.bd.size()) {
				return;
			}
			//主体内容的尺寸
			$.o.out.css({
				"width": $.o.s.width,
				"height:": $.o.s.height
			});
			return $.o.out;
		},
		setPosition: function(flag) {
			flag = flag || false;
			if (!$.o.bg.size() || !$.o.ele.size() || !$.o.out.size()) {
				return;
			}
			var w = $(window).width(),
				h = $(window).height(),
				st = $(window).scrollTop(),
				ph = $("body").height();
			if (ph < h) {
				ph = h;
			}
			$.o.bg.width(w).height(ph).css("opacity", $.o.s.opacity);
			//主体内容的位置
			//获取当前主体元素的尺寸
			var xh = $.o.out.outerHeight(),
				xw = $.o.out.outerWidth();
			var t = st + (h - xh) / 2,
				l = (w - xw) / 2;
			if ($.o.s.fix && window.XMLHttpRequest) {
				t = (h - xh) / 2;
			};
			if (flag === true) {
				$.o.out.animate({
					top: t,
					left: l
				});
			} else {
				$.o.out.css({
					top: t,
					left: l,
					zIndex: $.o.s.index
				});
			};
			return $.o.out;
		},
		//定位
		setFixed: function() {
			if (!$.o.out || !$.o.out.size()) {
				return;
			};
			if (window.XMLHttpRequest) {
				$.box.setPosition().css({
					position: "fixed"
				});
			} else {
				$(window).scroll(function() {
					$.box.setPosition();
				});
			};
			return $.o.out;
		},
		//背景可点击
		bgClickable: function() {
			if ($.o.bg && $.o.bg.size()) {
				$.o.bg.click(function() {
					$.box.hide();
				});
			}
		},
		//背景隐藏
		bgHide: function() {
			if ($.o.bg && $.o.bg.size()) {
				$.o.bg.hide();
			}
		},
		//背景层显示
		bgShow: function() {
			if ($.o.bg && $.o.bg.size()) {
				$.o.bg.show();
			} else {
				$('<div id="boxBlank"></div>').prependTo("body");
			}
		},
		//标题栏隐藏
		barHide: function() {
			if ($.o.bar && $.o.bar.size()) {
				$.o.bar.hide();
			}
		},
		//标题栏显示
		barShow: function() {
			if ($.o.bar && $.o.bar.size()) {
				$.o.bar.show();
			}
		},
		//关闭按钮隐藏
		closeBtnHide: function() {
			if ($.o.clo && $.o.clo.size()) {
				$.o.clo.hide();
			}
		},
		//弹框隐藏
		hide: function() {
			if ($.o.ele && $.o.out.size() && $.o.out.css("display") !== "none") {
				$.o.out.fadeOut(function() {
					$(this).remove()
				});
				if ($.o.s.protect && (!$.o.ele.hasClass("wrap_remind") || $.o.ele.attr("id"))) {
					$.o.ele.hide().appendTo($("body"));
				};
				if ($.isFunction($.o.s.onclose)) {
					$.o.s.onclose();
				};
				if ($.o.bg.size()) {
					$.o.bg.fadeOut("fast", function() {
						$(this).remove();
					});
				}
			}
			return false;
		},
		//拖拽
		drag: function() {
			if (!$.o.out.size() || !$.o.bar.size()) {
				$(document).unbind("mouseover").unbind("mouseup");
				return;
			};
			var bar = $.o.bar,
				out = $.o.out;
			var drag = false;
			var currentX = 0,
				currentY = 0,
				posX = out.css("left"),
				posY = out.css("top");
			bar.mousedown(function(e) {
				drag = true;
				currentX = e.pageX;
				currentY = e.pageY;
			}).css("cursor", "move");
			$(document).mousemove(function(e) {
				if (drag) {
					var nowX = e.pageX,
						nowY = e.pageY;
					var disX = nowX - currentX,
						disY = nowY - currentY;
					out.css("left", parseInt(posX) + disX).css("top", parseInt(posY) + disY);
				}
			});
			$(document).mouseup(function() {
				drag = false;
				posX = out.css("left");
				posY = out.css("top");
			});
		},
		//预载
		loading: function() {
			var s = $.extend({}, boxDefault, options || {});
			var element = $('<div class="wrap_remind">' + Language[s.lang].loading + '</div>');
			$.box(element, {
				bar: false
			});
		},
		//confirm询问
		confirm: function(message, sureCall, cancelCall, options) {
			var s = $.extend({}, boxDefault, options || {});
			var element = $('<div class="wrap_remind">' + message + '<p><button id="SureBtn" class="submit_btn">' + Language[s.lang].confirm + '</button>&nbsp;&nbsp;<button id="CancelBtn" class="cancel_btn">' + Language[s.lang].cancel + '</button></p></div>');
			$.box(element, options);
			//回调方法
			$("#SureBtn").click(function() {
				if ($.isFunction(sureCall)) {
					sureCall.call(this);
				}
			});
			$("#CancelBtn").click(function() {
				if (cancelCall && $.isFunction(cancelCall)) {
					cancelCall.call(this);
				};
				$.box.hide();
			});
		},
		//alert提醒
		alert: function(message, callback, options) {
			var s = $.extend({}, boxDefault, options || {});
			var element = $('<div class="wrap_remind">' + message + '<p><button id="SubmitBtn" class="submit_btn">' + Language[s.lang].confirm + '</button</p></div>');
			$.box(element, options);
			$("#SubmitBtn").click(function() {
				//回调方法
				if (callback && $.isFunction(callback)) {
					callback.call(this);
				};
				$.box.hide();
			});
		},
		//uri Ajax方法
		ajax: function(uri, params, options) {
			var s = $.extend({}, boxDefault, options || {});
			if (uri) {
				$.box.loading();
				options = options || {};
				options.protect = false;
				$.ajax({
					url: uri,
					data: params || {},
					success: function(html, other) {
						$.box(html, options);
					},
					error: function() {
						$.box.alert(Language[s.lang].error);
					}
				});
			}
		}
	});

});