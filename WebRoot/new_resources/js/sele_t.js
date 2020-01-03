/*
 * name: select.js
 * version: v1.5.0
 * update: 支持基于数据创建
 * date: 2015-01-20
 */

	var Counter = (function() {
		var count = 0;
		return function() {
			return ++count;
		}
	})();
	$.fn.sele = function(config) {
		var opt = {
				data:null,
				val: '._val',
				option: '._option',
				max: 50,
				act: "click", 					// click | mouseenter
				checked: undefined, 			// click item with the "data-val"
				checkDefault: undefined, 			// show item with the "data-val"
				callback: function(a, b) {} 	// @param(_val, _text)
			},
			$this = $(this),
			hidemenu,
			_data;
		$.extend(opt, config || {});
		hidemenu = function() {
			setTimeout(function() {
				$this.removeClass('on').find(opt.option).fadeOut(128);
			}, 80)
		};
		// 从数据初始化
		if($.isArray(opt.data) && opt.data.length){
				_data = opt.data,
				_options = '',
				_startValue = -1;
			$this.empty().append('<div class="'+opt.val.split('.')[1]+'"/>')
				 .append('<div class="'+opt.option.split('.')[1]+'"/>');
			for(var i=0;i<_data.length;i++){
				var value=_data[i].value ? _data[i].value : _startValue++;
				var text = _data[i].option;
				var checkDefault = !!_data[i].checkDefault;
				var checked = !!_data[i].checked;
				var ignore = !!_data[i].ignore ? ' data-ignore="true" ' : '';
				if(checked && !opt.checked){
					opt.checked = value;
				}else if(checkDefault && !opt.checkDefault){
					opt.checkDefault = value;
				}; 
				_options+='<a href="#"'+ignore+' data-val="'+value+'">'+text+'</a>';		
			};

			$this.find(opt.option).html(_options);
		}

		//层级处理
		opt.max > 1 && $this.css('z-index', opt.max - Counter());
		//绑定事件			
		$this.addClass('select').on(opt.act, function(e) {
				e.stopPropagation();
				if ($this.find(opt.option + ':visible').length) {
					hidemenu();
				} else {
					$this.addClass('on').find(opt.option).fadeIn(128);
				}
			}).on('click', opt.option + ' a', function(e) {
				e.stopPropagation();
				if (!$(this).attr('target')) {
					e.preventDefault();
					var _val = $(this).data('val'),
						_text = $(this).text();
					if ($this.find(opt.val + ' span').length) {
						$this.find(opt.val + ' span').eq(0).text(_text);
					} else {
						$this.find(opt.val).text(_text);
					};
					
					hidemenu();

					if(!$(this).data('ignore')){
						opt.callback(_val, _text);
					}
					
				};
			})
			//关闭事件
		if (opt.act == "mouseenter") {
			$this.on("mouseleave", function() {
				hidemenu();
			});
		} else if (opt.act == 'click') {
			$(document).mouseup(function(e) {
				if (!$this.is(e.target) && $this.has(e.target).length === 0) {
					hidemenu();
				}
			})
		}
		// 默认显示
		if ($this.data('default') !== void(0) || opt.checkDefault !== void(0)) {
			var _val = ($this.data('default') || opt.checkDefault);
			$this.find(opt.option + ' a').each(function(i, e) {
				if ($(e).data('val') == _val) {
					var _text = $(e).text();
					if ($this.find(opt.val + ' span').length) {
						$this.find(opt.val + ' span').eq(0).text(_text);
					} else {
						$this.find(opt.val).text(_text);
					};
					return;
				}
			})
		}else if(_data){
			var _text = $this.find(opt.option + ' a').eq(0).text();
			if ($this.find(opt.val + ' span').length) {
				$this.find(opt.val + ' span').eq(0).text(_text);
			} else {
				$this.find(opt.val).text(_text);
			};
		}
		// 默认选择
		if ($this.data('checked') !== void(0) || opt.checked !== void(0)) {
			var _val = ($this.data('checked') || opt.checked);
			$this.find(opt.option + ' a').each(function(i, e) {
				if ($(e).data('val') == _val) {
					$(e).trigger('click');
					return;
				}
			})
		}

		// 返回自身
		return $this;
	}
