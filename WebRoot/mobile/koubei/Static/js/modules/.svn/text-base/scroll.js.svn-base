/*
J_scroll

v0.91
支持响应式
2014-03-19

*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./scroll.css');
	
$.fn.scroll=function(config){
	var defaults = {
		num: 5,
		auto: true,
		time: 4e3,
		speed: 300,
		step: 1,
		node: 'li',
		fn: $.noop()
	},
		this_ = this,
		opts = $.extend({}, defaults, config || {}, this_.data('config') || {}),
		$i = 0,
		$n = this_.find(opts.node).length,
		$max, $shown, $margin_r, $aWid, $T_pre, $T_nex, $timer, ani = $.noop();
	if (!this_.parent().find('.s_prev').length) {
		this_.before($('<i class="s_prev" onselectstart="return false">&lt;</i>')).after('<i class="s_next" onselectstart="return false">&gt;</i>');
	};
	$T_pre = this_.parent().find('.s_prev');
	$T_nex = this_.parent().find('.s_next');
	if (opts.auto) {
		$timer = setInterval(function() {
			$T_nex.click()
		}, opts.time);
		this_.hover(function() {
			clearInterval($timer)
		}, function() {
			$timer = setInterval(function() {
				$T_nex.click()
			}, opts.time)
		})
	};
	
	function init(this_) {
		$max = Math.floor($(this_).width() / $(this_).find(opts.node).outerWidth());
		$shown = opts.num > $max ? $max : opts.num;
		$margin_r = $shown === 1 ? $(this_).width() - $(this_).find(opts.node).outerWidth() : Math.floor(($(this_).width() - $(this_).find(opts.node).outerWidth() * $shown) / ($shown - 1) * 100) / 100;
		$aWid = $(this_).find(opts.node).outerWidth() + $margin_r;
		ani = function($i_) {
			$(this_).children('.gallery').stop().animate({
				marginLeft: -$aWid * $i_
			}, opts.speed);
		};
		$(this_).find(opts.node).css('margin-right', $margin_r);
		$T_nex.click(function(event) {
			event.preventDefault();
			$i = $n - $i - $shown >= opts.step ? $i + opts.step : ($n - $i - $shown === 0 ? 0 : $n - $shown);
			ani($i);
		});
		$T_pre.click(function(event) {
			event.preventDefault();
			$i = $i >= opts.step ? $i - opts.step : ($i === 0 ? $n - $shown : 0);
			ani($i);
		});
	};

	init(this_);
	$(window).resize(function() {
		init(this_)
	});

	if (opts.fn) {
		eval(opts.fn + "($(this),$max,opts,$T_pre,$T_nex,ani)")
	}
};

});