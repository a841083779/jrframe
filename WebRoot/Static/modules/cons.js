/*
 * name: ContinuedScroll.js
 * version: v2.0.0
 * update: 内嵌style
 * date: 2015-05-09
 */
define('cons',function(require, exports, module) {
	var $ = require('jquery');
	seajs.importStyle('.conscroll{position:relative;overflow:hidden}.conscroll ul{position:absolute;left:0;top:0}.conscroll .arrs{cursor:pointer}',
		module.uri)
	var def = {
		speed: 4,
		dir: true, //true横向 false竖向
		prev: '',
		next: ''
	};
	$.fn.conScroll = function(config) {
		return $(this).each(function(i, e) {
			var _this = $(e).addClass('conscroll').fadeIn(480),
				Ul = _this.find('ul'),
				Li = Ul.find('li'),
				opt = $.extend({}, def, config || {}, _this.data('config') || {}),
				_liTotal = 0,
				_ulTotal = 0,
				BtnL, BtnR, _dir, _T, _line;

			if (opt.prev && opt.next) {
				BtnL = $(opt.prev);
				BtnR = $(opt.next);
			} else {
				BtnL = $('<a href="###" class="arrs arr_prev" />');
				BtnR = $('<a href="###" class="arrs arr_next" />');
				_this.append(BtnL).append(BtnR);
			};
			if (opt.dir) {
				_line = Math.floor(_this.height() / Li.height());
				_ulTotal = _this.width();
				for (var i = 0; i < Li.length; i++) {
					_liTotal += Li.eq(i).outerWidth(true);

				}
			} else {
				_line = Math.floor(_this.width() / Li.width());
				_ulTotal = _this.height();
				for (var i = 0; i < Li.length; i++) {
					_liTotal += Li.eq(i).outerHeight(true);

				}
			};
			_line = _line > 1 ? _line : 1;
			_liTotal = _liTotal / _line;

			if (_liTotal < _ulTotal) return;
			Ul.append(Ul.html());
			if (opt.dir) {
				_dir = "left";
				Ul.width(_liTotal * 2).height('100%');
			} else {
				_dir = "top";
				Ul.height(_liTotal * 2).width('100%');
			};

			function goRoll() {
				_T = setInterval(function() {
					Ul.css(_dir, parseInt(Ul.css(_dir)) - opt.speed + 'px');

					if (parseInt(Ul.css(_dir)) <= -parseInt(_liTotal)) {
						Ul.css(_dir, 0)
					} else if (parseInt(Ul.css(_dir)) >= 0) {
						Ul.css(_dir, -parseInt(_liTotal))
					}
				}, 48)
			};
			Ul.hover(function() {
				clearInterval(_T)
			}, function() {
				goRoll()
			});
			BtnL.mouseover(function() {
				opt.speed = -Math.abs(opt.speed)
			});
			BtnR.mouseover(function() {
				opt.speed = Math.abs(opt.speed)
			});
			goRoll();
		})
	}
})