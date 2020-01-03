/*
J_slide

v0.92:增加触屏支持和循环滚动，slide效果基于css3,ie9以下降级为toggle
2014-03-06

*/
define(function(require, exports, module) {
	var $ = require('$');
	var base = require('base');
	require('./slide.css');
	require('modules/touch');

	$.fn.slide = function(config) {
		var opt, $this, $b_, t, n = 0,
			n__ = 0, count, $nav, $navs, $p, $n, DelayObj, Delay = false;
		opt = {
			effect: 'slide',
			fadespeed: 480,
			auto: true,
			time: 5e3,
			action: "mouseenter",
			callback: null,
			ext: null,
			arrows: ' '
		};
		$this = $(this);
		opt = $.extend(opt, config || {}, $this.data("opation") || {});
		$b_ = $this.find(".ban_c");
		count = $b_.length;
		if (count <= 1) {
			$b_.show();
			$this.find('.ban_c').css('left',0);
			return;
		};
		if (base.ie6) {
			$b_.each(function() {
				$(this).height(base.getStyle(this, 'height') === "100%" ? $this.height() : base.getStyle(this, 'height'))
			})
		};
		if ($this.find(".ban_nav").length) {
			$nav = $this.find(".ban_nav");
			$nav.show();
		} else {
			$nav = $('<div class="ban_nav"></div>');
			for (i = 0; i < count; i++) {
				$nav.append("<a>" + (i + 1) + "</a>");
			};
			$this.append($nav);
		};
		if (!$this.find('.arrs').length) {
			$this.append('<a class="arrs arr_prev">' + opt.arrows.split(' ')[0] + '</a><a class="arrs arr_next">' + opt.arrows.split(' ')[1] + '</a>');
		};
		$p = $this.find(".arr_prev");
		$n = $this.find(".arr_next");
		if($nav.get(0).nodeName.toLowerCase()==='ul'){
			$navs=$nav.children('li');
			}else{
				$navs=$nav.children('a');
				};
		$navs.on(opt.action, function(event) {
			event.preventDefault();
			event.stopPropagation();
			var index = $(this).index();
			if (index >= count || $(this).hasClass("on")) return;
			$navs.removeAttr('class').eq(index).addClass('on').end().eq(index - 1).addClass("nav_prev").end().eq(index == count - 1 ? 0 : index + 1).addClass("nav_next");
			$b_.attr('class', 'ban_c').eq(index).addClass('active').end().eq(index - 1).addClass("ban_prev").end().eq(index == count - 1 ? 0 : index + 1).addClass("ban_next");
			//prev滚动调整遮盖关系
			if(index<n__){
				$b_.filter('.ban_next').addClass('ban_next_lower');
				};
			n__=index;
			n = index;
			switch (opt.effect) {
			case 'fade':
				$b_.filter(':visible').stop(1, 0).fadeOut(opt.fadespeed+320);
				$b_.eq(n).stop(1, 0).fadeIn(opt.fadespeed);
				break;
			case 'toggle':
				$b_.hide().eq(n).show();
				break;
			};
			if (opt.callback) {
				eval(opt.callback + "($b_,$nav,n)");
			};
		});
		if (opt.auto) {
			t = setInterval(function() {
				showAuto()
			}, opt.time);
			$b_.hover(function() {
				clearInterval(t);
			}, function() {
				t = setInterval(function() {
					showAuto()
				}, opt.time);
			});
		};
		switch (opt.effect) {
		case 'slide':
			$this.addClass('transition');
			$b_.on({
				'swipeleft': function(e) {
					if (n + 1 >= count) return
					$nav.find("a").eq(n + 1).trigger(opt.action)
				},
				'swiperight': function(e) {
					if (!n) return
					$nav.find("a").eq(n - 1).trigger(opt.action)
				},
				'movestart': function(e) {
					if ((e.distX > e.distY && e.distX < -e.distY) || (e.distX < e.distY && e.distX > -e.distY)) {
						e.preventDefault();
						return
					};
					if (opt.auto) {
						clearInterval(t);
					};
					$this.addClass('notransition');
				},
				'move': function(e) {
					var left = 100 * e.distX / $this.width();
					if (e.distX < 0) {
						if ($b_[n + 1]) {
							$b_[n].style.left = left / 2 + '%';
							$b_[n + 1].style.left = (left / 2 + 100) + '%'
						} else {
							$b_[n].style.left = left / 2 + '%'
						}
					};
					if (e.distX > 0) {
						if ($b_[n - 1]) {
							$b_[n].style.left = left /2  + '%';
							$b_[n - 1].style.left = (left / 2 - 100) + '%'
						} else {
							$b_[n].style.left = left / 2 + '%'
						}
					}
				},
				'moveend': function(e) {
					$this.removeClass('notransition');
					$b_[n].style.left = '';
					if ($b_[n + 1]) {
						$b_[n + 1].style.left = ''
					};
					if ($b_[n - 1]) {
						$b_[n - 1].style.left = ''
					};
				}
			})
			break;
		};

		$p.click(function(event) {
			event.preventDefault();
			showPre();
		});
		$n.click(function(event) {
			event.preventDefault();
			showAuto();
		});

		function showAuto() {
			n = n >= count - 1 ? 0 : ++n;
			$navs.eq(n).trigger(opt.action);
		};

		function showPre() {
			n = n <= 0 ? count - 1 : --n;
			$navs.eq(n).trigger(opt.action);
		};
		if (opt.ext) {
			opt.ext(this,$b_,$nav);
		};
		$navs.eq(0).trigger(opt.action)
	};

});