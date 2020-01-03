/*
* name: slide.js
* version: v1.34
* update: 调整高度检测机制，支持按比例设置高度；
* date: 2014-08-22
*/
define(function(require, exports, module) {
	var $ = require('$');
	require('./slide.css');
	require('touch');	

	//css3 位移
	!$.fn._css && ($.fn._css = function(LeftOrRight, number){
		var hasTrans = ( LeftOrRight == 'left' || LeftOrRight == 'right' ) ? true :false,
			css3 = ( !('transition' in document.createElement('div').style) ) ? false : true;
		
		if(css3 && hasTrans){
			$(this).css('transform', 'translateX('+ number +')')
		}else{
			$(this).css(LeftOrRight, number)
		}
		
		return $(this)		
	});
	
	//异步加载区域图片
	!$.fn._loadimg && ($.fn._loadimg = function(imgattr){
		if(!$(this).find('img[data-small]').length && $(this).find('img['+imgattr+']').length)	{

			$(this).find('img['+imgattr+']').each(function(i,e){
				
				if($(e).attr(imgattr)!='loaded'){
					$(e).attr('src',$(this).attr(imgattr)).attr(imgattr,'loaded')
				}
			})
		};
		return $(this);
	});
	
	//main	
	$.fn.slide = function(config) {

		var opt={}, $this = null, $w = null, $b = null,  t = null,  $nav = null, $navs = null, $p = null, $n = null, origin = 0, count = 0, efftct = $.noop(), getNext = $.noop(), getPrev = $.noop(), getNav = $.noop(), width;

		opt = {
			wrap: 'ul', 
    		cell: 'li',  
			effect: 'slide',         //slide | fade | toggle
			speed: 480,
			start:0,
			auto: true,
			pause:true,
			time: 5e3,
			act: "mouseenter",
			prev:null,
			next:null,
			arrows: ' ',
			imgattr:'data-src',
			callback: function(){},
			ext: function(){},
			reload:false
		};
		$this = $(this).addClass('slide');
		$.extend(opt, config || {}, $this.data("config") || {});
		$w = $this.find(opt.wrap).addClass('slide_wrap');
		$b = $w.find(opt.cell).addClass('slide_c');
		width = parseInt($this.width());
		count = $b.length,
		H = $this.outerHeight();
		
		if (count <= 1) {
			opt.ext && opt.ext($this,$b,count);
			return $this;
		};
				
		//获取上一个下一个
		getPrev = function (number,_step) {
			_step = _step ? _step : 1;
			number = number <= 0 ? count - _step : number-_step;
			return number;
		};
		getNext = function (number,_step) {
			_step = _step ? _step : 1;
			number = number >= count - _step ? 0 : number+_step;
			
			return number;
		};
		
		//添加导航
		getNav = function (){
			$nav = $('<div class="slide_nav"></div>');
			
			if ($this.find(".slide_nav").length) {
				$nav.html($this.find(".slide_nav").html());
				$this.find(".slide_nav").remove();
			}else{
				for (i = 0; i < count; i++) {
					$nav.append("<a>" + (i + 1) + "</a>");
				};
			};
			
			$this.append($nav);
		};
		getNav();
		
		//添加左右按钮
		if (opt.prev && opt.next) {
			$p = $(opt.prev);
			$n = $(opt.next);
		} else {
			$this.append('<a class="arrs arr_prev">' + opt.arrows.split(' ')[0] + '</a><a class="arrs arr_next">' + opt.arrows.split(' ')[1] + '</a>');
			$p = $this.find(".arr_prev");
			$n = $this.find(".arr_next");
		};
		
		if($nav.get(0).nodeName.toLowerCase()==='ul'){
			$navs=$nav.children('li');
		}else{
			$navs=$nav.children('a');
		};
		
		//预处理
		$w.css({
				  'height':H
			  });
		$b.css({
				  'position': 'absolute',
				  'height':H
			  });
		switch (opt.effect){

			case 'slide':
			
				$w.css({
					'left': -width + 'px',
					'width': width * 3 +'px'
				});

				$b._css('left', width + 'px').css({
					'width': width + 'px',
					'z-index':'0',
					'display':'none'	
				}).on({
					'swipeleft': function(e) {
						efftct(getNext(origin),1)
					},
					'swiperight': function(e) {
						efftct(getPrev(origin),0)
					},
					'movestart': function(e) {
						
						if ((e.distX > e.distY && e.distX < -e.distY) || (e.distX < e.distY && e.distX > -e.distY)) {
							e.preventDefault();
							return false
						};
						opt.auto && clearInterval(t);

						$this.addClass('ontouch');
					},
					'move': function(e) {
						var left =  e.distX/2 + width;
						$(this)._css('left',left + 'px')
						
						if (e.distX < 0 && $b[origin + 1]) {
							$b.eq(getNext(origin))._loadimg(opt.imgattr).show()._css('left',left + width + 'px')
						};
						if (e.distX > 0 && $b[origin - 1]) {
							$b.eq(getPrev(origin))._loadimg(opt.imgattr).show()._css('left',left - width + 'px')
						}
					},
					'moveend': function(e) {
						$this.removeClass('ontouch');
						
					}
				})	
				
				break;
			
		};
		
		//效果
		efftct = function(current, direct, step,isInit){

			if($this.find(':animated').length) return true;
			
			var _step = step ? step : 1,
				_prev = getPrev(current,_step),
				_next = getNext(current,_step);

			$navs.removeClass('on nav_prev nav_next').eq(current).addClass('on').end().eq(_prev).addClass("nav_prev").end().eq(_next).addClass("nav_next");
			
			$b.removeClass('active slide_prev slide_next').eq(current).addClass('active').end().eq(_prev).addClass("slide_prev").end().eq(_next).addClass("slide_next");
			
			switch (opt.effect) {
				
				case 'fade':
					
					$b.stop(1, 0).filter(':visible').fadeOut(opt.speed).end().eq(current)._loadimg(opt.imgattr).fadeIn(opt.speed * 1.5);
					
					break;

				case 'toggle':
					
					$b.hide().eq(current)._loadimg(opt.imgattr).show();
					
					break;

				case 'slide':
				
					if(direct==void(0)) {
						direct = true	
					};
					
					var _dir = !!direct,
						wrap_move = _dir ? -width * 2 : 0,
						cell_move = _dir ? width * 2 : 0,
						_ori = origin; //存储起始元素，用于动作后处理起始元素
					
					if($b.eq(current).is(':hidden')){
						$b.eq(current)._css('left',cell_move + 'px')._loadimg(opt.imgattr).show();	
					};
					
					if(isInit){
						//初始启动
						$w.css({'left': -width + 'px'});							  
						$b._css('left', width + 'px').eq(current).show().css({ 'z-index':'2' });
						
					}else{
						$b.eq(_ori).show(function(){					
							$w.stop(1).animate({'left': wrap_move + 'px'}, opt.speed, function(){
								$w.css({'left':-width + 'px'});
								
								$b._css('left', width + 'px').eq(_ori).css('z-index','1').hide().end().eq(current).css({ 'z-index':'2' });
							})
						});
					}
					
					break;
					
				};
				
				//更新当前帧
				origin = current;
				
				//保存当前帧数据
				$this.data('play',origin);
	
				//回调
				opt.callback && opt.callback ($this,$b,origin);
	
		}
		
		//导航触发
		$navs.on(opt.act, function(e) {
			e.preventDefault();
			e.stopPropagation();
			var index = $(this).index(), _dir, _step;
			
			if (index >= count || $(this).hasClass("on")) return false;
			
			//初始加载
			if(index === origin){
				origin = count-1;
				_dir = 1;
				efftct(index,_dir);	
				return true	
			};
			
			_dir = index > origin  ? true : false;
			efftct(index,_dir);			
		});				
		
		//按钮触发
		$p.click(function(e) {
			e.preventDefault();
			efftct(getPrev(origin),0);
		});
		$n.click(function(e) {
			e.preventDefault();
			efftct(getNext(origin),1);
		});
		
		//自动播放
		if (opt.auto && opt.pause) {
			t = window.setInterval(function(){$n.click()}, opt.time);
			$b.hover(function() {
				window.clearInterval(t);
			}, function() {
				t = window.setInterval(function(){$n.click()}, opt.time);
				if(opt.reload){
					window.clearInterval(t-1);	
				}
			});
		};
		
		if(opt.auto && !opt.pause){
			t = window.setInterval(function(){$n.click()}, opt.time);
			if(opt.reload){
				window.clearInterval(t-1);	
			}
		};

		//扩展
		opt.ext && opt.ext($this,$b,count);
		
		//开始
		if($this.data('play')){
			$navs.eq($this.data('play')).trigger(opt.act);	
		}else{
			efftct(opt.start, true, 1,true);
		};
		
		//返回自身
		return $this
		
	};
	
});