/*
scroll-row

v0.9.31
增加ext方法，提供总屏数;callback方法只提供当前屏数
2014-04-15

*/
define(function(require, exports, module) {
   var $ = require('$');

$.fn.scrollrow = function(config) {
	var _default = {
		up: ".arr_up",
		down: ".arr_down",
		line: 1,
		speed: 500,
		timer: 5e3,
		callback: null,
		ext: null
	},
		opt = $.extend(_default, config || {}, $(this).data('config') || {}),
		_btnUp = $(opt.up),
		_btnDown = $(opt.down),
		_this = $(this).find("ul"),
		lineH = _this.find("li").outerHeight(true),
		cols = Math.floor(_this.width() / _this.find("li").outerWidth()) ? Math.floor(_this.width() / _this.find("li").outerWidth()) : 1,
		rows = Math.floor($(this).height() / _this.find("li").outerHeight()),
		rowsall = Math.ceil(_this.find("li").length / cols),
		line = opt.line > rows ? rows : opt.line,
		upHeight = 0 - line * lineH,
		total = Math.ceil(rowsall / rows),
		now = 1,
		_T, lasted, scrollUp, scrollDown;
	if (rowsall * lineH <= $(this).height()) {
		_btnUp.remove();
		_btnDown.remove();
		return
	};
	scrollUp = function() {
		_this.stop(1, 0).animate({
			marginTop: upHeight
		}, opt.speed, function() {
			_this.css('marginTop', 0);
			for (i = 1; i <= line; i++) {
				_this.find("li:lt(" + cols + ")").appendTo(_this)
			}
		});
		if (opt.callback) {
			now = (now <= 1 ? total : now - 1);
			opt.callback(now)
		}
	};
	scrollDown = function() {
		lasted = _this.find("li").length - cols - 1;
		for (i = 1; i <= line; i++) {
			_this.find("li:gt(" + lasted + ")").show().prependTo(_this)
		};
		_this.css({
			marginTop: upHeight
		}).stop(1, 0).animate({
			marginTop: 0
		}, opt.speed);
		if (opt.callback) {
			now = (now >= total ? 1 : now + 1);
			opt.callback(now)
		}
	};
	if (opt.timer) {
		_T = setInterval(function() {
			scrollDown()
		}, opt.timer);
		$(this).hover(function() {
			clearInterval(_T)
		}, function() {
			_T = setInterval(function() {
				scrollDown()
			}, opt.timer)
		});
	};
	_btnUp.click(function() {
		scrollUp()
	});
	_btnDown.click(function() {
		scrollDown()
	});
	if (opt.ext) {
		opt.ext(total)
	};
};

});
