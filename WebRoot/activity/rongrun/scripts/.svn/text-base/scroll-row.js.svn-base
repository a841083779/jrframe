/*
scroll-row

v0.9.2
1,调整参数覆盖顺序：data>config>default
2014-02-27

*/
(function(window){
$.fn.scrollrow = function(config) {
	var defaults = {
		up: "#btn1",
		down: "#btn2",
		line: 1,
		speed: 500,
		timer: 3000
	},
		opt = $.extend(defaults, config || {}, $(this).data('config') || {}),
		_btnUp = $(opt.up),
		_btnDown = $(opt.down),
		_T, _this = $(this).find("ul"),
		lineH = _this.find("li").outerHeight(true),
		cols = Math.floor(_this.width() / _this.find("li").outerWidth()),
		lasted, upHeight = 0 - opt.line * lineH;
	if (Math.ceil(_this.find("li").length / cols) * lineH <= $(this).height()) {
		_btnUp.remove();
		_btnDown.remove();
		return
	};

	function scrollUp() {
		_this.stop(1, 0).animate({
			marginTop: upHeight
		}, opt.speed, function() {
			_this.css('marginTop', 0);
			for (i = 1; i <= opt.line; i++) {
				_this.find("li:lt(" + cols + ")").appendTo(_this)
			}
		})
	};

	function scrollDown() {
		lasted = _this.find("li").length - cols - 1;
		for (i = 1; i <= opt.line; i++) {
			_this.find("li:gt(" + lasted + ")").show().prependTo(_this)
		};
		_this.css({
			marginTop: upHeight
		}).stop(1, 0).animate({
			marginTop: 0
		}, opt.speed)
	};
	if (opt.timer) {
		_T = setInterval(function() {
			scrollUp()
		}, opt.timer);
		$(this).hover(function() {
			clearInterval(_T)
		}, function() {
			_T = setInterval(function() {
				scrollUp()
			}, opt.timer)
		});
		_btnUp.parent().hover(function() {
			clearInterval(_T)
		}, function() {
			_T = setInterval(function() {
				scrollUp()
			}, opt.timer)
		})
	};
	_btnUp.click(function() {
		scrollUp()
	});
	_btnDown.click(function() {
		scrollDown()
	})
};
$('.scrollrow').each(function() {
	$(this).scrollrow()
});
})(window);

