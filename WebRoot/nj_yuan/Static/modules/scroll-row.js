/*
 * name: scroll-row
 * version: v3.0.1
 * update: 使用size()计数
 * date: 2015-06-18
 */
define('scroll-row',function(require, exports, module) {
	var $ = require('jquery');
	require('easing');
	var def = {
		prev: null,
		next: null,
		wrap: 'ul',
		cell: 'li',
		line: 1,
		duration: 460,
		animate: 'swing',
		auto: true,
		pause: true,
		interval: 5e3,
		callback: function(nowRow) {},
		ext: function(totalRow) {}
	}
	$.fn.scrollrow = function(config) {
		return $(this).each(function(i, e) {
			var $this = $(e),
				opt = $.extend({}, def, config || {}),
				$wrap, $cell, nowRow = 1, _T, lasted, scrollRow, _btnUp, _btnDown;

			//添加左右按钮
			if ($(opt.prev).size() || $(opt.next).size()) {
				_btnUp = $(opt.prev);
				_btnDown = $(opt.next);
			} else {
				$this.append('<a class="arrs arr_prev" /> <a class="arrs arr_next" />');
				_btnUp = $this.children(".arr_prev");
				_btnDown = $this.children(".arr_next");
			};
			$wrap = $this.find(opt.wrap);
			$cell = $wrap.find(opt.cell);
			lineH = $cell.outerHeight(true);
			cols = Math.floor($this.width() / $cell.outerWidth()) ? Math.floor($this.width() / $cell.outerWidth()) : 1;
			rows = Math.floor($this.height() / lineH);
			rowsall = Math.ceil($cell.length / cols);
			line = opt.line > rows ? rows : opt.line;
			upHeight = 0 - line * lineH;
			totalRow = Math.ceil(rowsall / rows);
			//运行条件检测
			if (rowsall * lineH <= $this.height()) {
				_btnUp.addClass('unable');
				_btnDown.addClass('unable');
				opt.ext && opt.ext(totalRow);
				console.log("scroll-row: lines no enough to scroll.");
				return $this;
			};

			scrollRow = function(direct) {
				if ($this.find(':animated').length) return;
				if (direct > 0) {
					//down
					$wrap.stop(1).animate({
						marginTop: upHeight
					}, {
						duration: opt.duration,
						easing: opt.animate,
						complete: function() {
							$wrap.css('marginTop', 0);
							for (i = 1; i <= line; i++) {
								$this.find(opt.cell + ":lt(" + cols + ")").appendTo($wrap);
							}
						}
					});
					nowRow = (nowRow <= 1 ? totalRow : nowRow - 1);
					opt.callback && opt.callback(nowRow);
				} else {
					lasted = $cell.length - cols - 1;
					for (i = 1; i <= line; i++) {
						$this.find(opt.cell + ":gt(" + lasted + ")").show().prependTo($wrap)
					};
					$wrap.stop(1).css('marginTop', upHeight).animate({
						marginTop: 0
					}, {
						duration: opt.duration,
						easing: opt.animate
					});
					nowRow = (nowRow >= totalRow ? 1 : nowRow + 1);
					opt.callback && opt.callback(nowRow);
				}
			};

			if (opt.auto) {
				_T = setInterval(function() {
					scrollRow(1)
				}, opt.interval);
				if (opt.pause) {
					$this.hover(function() {
						clearInterval(_T)
					}, function() {
						_T = setInterval(function() {
							scrollRow(1)
						}, opt.interval)
					})
				}
			};

			_btnUp.click(function(e) {
				e.preventDefault();
				scrollRow(-1)
			});
			_btnDown.click(function(e) {
				e.preventDefault();
				scrollRow(1)
			});

			if (typeof(opt.ext) == 'function') {
				opt.ext(totalRow)
			};

		})
	};
})