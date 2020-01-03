/*
* name: tab.js
* version: v1.2
* update: 修复tab_t筛选bug
* date: 2014-08-15
*/
define(function(require, exports, module) {
	var $ = require('$');
	require('./tab.css');
	
	$.fn.tab = function(config) {
		var opt = {
				width_auto: false,        //选项卡自适应宽度
				posi_auto: true,          //是否计算left定位值，关闭后可以样式控制
				left: 0,                  //第一个选项卡距左起始位置
				auto:false,               //是否自动播放，默认否
				time:5e3,                 //自动播放间隔，默认5s
				start:0,                  //初始显示，默认第一个
				margin: 0,                //选项卡间距
				act: 'click',             //触发动作
				callback: function(){} ,  //回调方法 @param ($this,$tab_t,index) : 当前对象，选项卡标签，当前帧序号
				ext: function(){}         //扩展方法 @param ($this,$tab_t,opts) : 当前对象，选项卡标签，配置
			},
			$this = $(this),
			$tab_t = $this.find('.tab_t'),
			$tab_c = $this.find('.tab_c'),
			toggletab = function (i) {
				$tab_t.eq(i).addClass('tab_t_cur').siblings().removeClass('tab_t_cur');
				$tab_c.eq(i).addClass('tab_c_cur').siblings().removeClass('tab_c_cur');
			},
			tab_t_collect = (' '+$this.attr('class')).split(' '),
			tiemout;
		
		tab_t_collect = tab_t_collect.join('.') + ' .tab_t';
			
		$.extend(opt, config || {}, $this.data('config') || {});
		
		$this.addClass('tab');

		if (opt.width_auto) {
			$tab_t.width(1 / $tab_t.length * 100 + '%')
		};	
			
		tiemout = (opt.act === 'mouseover') ? 150 : 0;
		
		$tab_t.each(function(i,e) {
			
			if(opt.posi_auto){
				var leftPx = 0;
				for (var _i = 0;_i<i; _i++){
					leftPx+=parseFloat($tab_t.eq(_i).outerWidth(true))
				}
				
				$(e).css({'left': opt.width_auto ? 1 / $tab_t.length * 100 * i + '%' : leftPx + opt.left + opt.margin * i
				})
			};

			if (!i) {
				$(e).addClass('first');
			};
			
		}).on(opt.act, function(event) {
			
			var index = $(this).index(tab_t_collect),
				_timeout,
				_last;
				
			if (event.timeStamp) {
				_last = event.timeStamp;
				_timeout=setTimeout(function() {
					if (_last - event.timeStamp == 0) {
						toggletab(index)
					}
				}, tiemout)
			} else {
				toggletab(index)
			};
			//回调
			opt.callback($this,$tab_t,index)
		})
		
		//容错
		if($tab_t.length<=1){
			opt.ext($this,$tab_t,opt);
			$tab_t.eq(opt.start).trigger(opt.act);
			return $this;
		};
			
		//扩展
		opt.ext($this,$tab_t,opt);
		
		//启动
		$tab_t.eq(opt.start).trigger(opt.act);
		
		//自动播放
		if(opt.auto){
			var i = opt.start;
			var auto = function(){
								
				i = i >= $tab_t.length - 1 ? 0 : ++i;

				$tab_t.eq(i).trigger(opt.act);
			},
			t = window.setInterval(function(){auto()},opt.time);

			$tab_c.hover(function(){
				window.clearInterval(t)	
			},function(){
				t = window.setInterval(function(){auto()},opt.time);
			});
		};
		
		//返回自身
		return $this;
	};

})