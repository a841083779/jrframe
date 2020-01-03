/*
 * name: box.js
 * version: v1.0
 * update: 功能精简，保留$.box.xxx，去掉ele.box()
 * date: 2014-08-14
 * author: zhangxinxu
 */
define(function(require, exports, module) {
	require('./box.css');
	var $ = require('$'),
	Language = [{
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
	}],
	boxDefault = {
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
		lang: 0              //语言选择，0：中文 1:英文
	};

	$.box = function(elements, options) {
		if (!elements) {
			return;
		};
		var s = $.extend({}, boxDefault, options || {});
		var WRAP = '<div id="boxBlank" onselectstart="return false;"></div>' + '<div class="wrap_out" id="wrapOut">' + '<div class="wrap_in" id="wrapIn">' + '<div id="wrapBar" class="wrap_bar" onselectstart="return false;">' + '<h4 id="wrapTitle" class="wrap_title"></h4>' + '<div class="wrap_close"><a href="javasctipt:" id="wrapClose" title="' + Language[s.lang].close + '"></a></div>' + '</div>' + '<div class="wrap_body" id="wrapBody"></div>' + '</div>' + '</div>';
		if (s.style) {
			var head = document.head || document.getElementsByTagName("head")[0] || document.documentElement;
			var cssnode = document.createElement("link" );
			cssnode.rel = "stylesheet";
			cssnode.href = s.style;
			head.appendChild(cssnode);
		};
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
		$.o.tit.html(s.title);
		$.o.clo.html(s.shut);
		$.o.bd.empty().append(elements);
		if ($.isFunction(s.onshow)) {
			s.onshow();
		};
		$.box.setSize();
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
		bgClickable: function() {
			if ($.o.bg && $.o.bg.size()) {
				$.o.bg.click(function() {
					$.box.hide();
				});
			}
		},
		bgHide: function() {
			if ($.o.bg && $.o.bg.size()) {
				$.o.bg.hide();
			}
		},
		bgShow: function() {
			if ($.o.bg && $.o.bg.size()) {
				$.o.bg.show();
			} else {
				$('<div id="boxBlank"></div>').prependTo("body");
			}
		},
		barHide: function() {
			if ($.o.bar && $.o.bar.size()) {
				$.o.bar.hide();
			}
		},
		barShow: function() {
			if ($.o.bar && $.o.bar.size()) {
				$.o.bar.show();
			}
		},
		closeBtnHide: function() {
			if ($.o.clo && $.o.clo.size()) {
				$.o.clo.hide();
			}
		},
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
		loading: function() {
			var s = $.extend({}, boxDefault, options || {});
			var element = $('<div class="wrap_remind">' + Language[s.lang].loading + '</div>');
			$.box(element, {
				bar: false
			});
		},
		confirm: function(message, sureCall, cancelCall, options) {
			var s = $.extend({}, boxDefault, options || {});
			var element = $('<div class="wrap_remind">' + message + '<p><button id="SureBtn" class="submit_btn">' + Language[s.lang].confirm + '</button>&nbsp;&nbsp;<button id="CancelBtn" class="cancel_btn">' + Language[s.lang].cancel + '</button></p></div>');
			$.box(element, options);
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
		alert: function(message, callback, options) {
			var s = $.extend({}, boxDefault, options || {});
			var element = $('<div class="wrap_remind">' + message + '<p><button id="SubmitBtn" class="submit_btn">' + Language[s.lang].confirm + '</button</p></div>');
			$.box(element, options);
			$("#SubmitBtn").click(function() {
				if (callback && $.isFunction(callback)) {
					callback.call(this);
				};
				$.box.hide();
			});
		},
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