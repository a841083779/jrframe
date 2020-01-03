/*
* name: scroll.js
* version: v1.28
* update: 不可用时按钮添加unable
* data: 2014-10-15
*/
	
	$.fn.scroll = function(config) {
		var opt = {
				direct:'left', // 自动播放方向，可选left | right
				mode: '',      // 特殊模式，可选 hero(全屏三图滚动) | unloop（不循环）
				num: 99,       // 显示个数
				auto: true,    // 自动播放
				time: 5e3,     // 自动播放间隔
				speed: 256,    // 滚动速度
				step: 1,       // 每次滚动个数
				wrap: 'ul',    // 滚动包裹元素
				cell: 'li',    // 滚动元素
				prev: null,    // 向左按钮，默认添加 '.arr_prev'
				next: null,    // 向右按钮，默认添加 '.arr_next' 
				callback:function(){},   // 回调 @param (nowStep)
				ext: function(){}        // 扩展 @param (this, showNumber, allStep)
			},
			$this = $(this).addClass('slide'),
			cells = $this.find(opt.wrap).addClass('slide_wrap').find(opt.cell).addClass('slide_c').width($this.find(opt.cell).width()),
			_cellWidth=cells.outerWidth(true),
			_max = Math.floor($this.width() / _cellWidth),
			showNumber = opt.num > _max ? _max : opt.num,
			_marginRight = (showNumber === 1) ? $this.width() - _cellWidth : (Math.floor(($this.width() - _cellWidth * showNumber) / (showNumber - 1) * 10) / 10),
			_cellOuterWidth = _cellWidth + _marginRight,
			_wrapLeft = 0,
			_totalwidth,
			scroll,
			allStep,
			nowStep = 1, 
			$prev, 
			$next, 
			t;
			
		$.extend(opt, config || {}, $this.data('config') || {});
		
				
		//添加按钮
		if ($(opt.prev).length && $(opt.next).length) {
			$prev = $(opt.prev);
			$next = $(opt.next);
		} else {
			$this.append(function(i,h){
				$(h).find(opt.prev).remove().find(opt.next).remove();
				return '<a href="###" class="arrs arr_prev" /><a href="###" class="arrs arr_next" />'
			});
			$prev = $this.children('.arr_prev');
			$next = $this.children('.arr_next');
		};
		
		//预处理
		switch (opt.mode){
			case 'unloop' :
				_totalwidth = _cellOuterWidth * cells.length;
				break;
			case 'hero' :
				opt.step = 1;
				showNumber = 3;
				_marginRight = 0;
				_cellOuterWidth = _cellWidth;
				_wrapLeft = ($this.width()-_cellWidth * 3)/2;
				break;
			default :
				_totalwidth = _cellOuterWidth * (showNumber + opt.step);
		}
		
		cells.css('margin-right', _marginRight).each(function(i,e){
			i>=showNumber && (opt.mode !== 'unloop') && $(e).hide()
		});

		$this.children(opt.wrap).css({
			'left':_wrapLeft,
			'width':_totalwidth
		});
					
		//运行条件检测
		if(cells.length < showNumber + opt.step){ 
			$prev.addClass('unable');
			$next.addClass('unable');
			opt.ext && opt.ext($this, showNumber, allStep);
			if(window.console){
				console.log('scroll.js: element["'+$this.attr('class')+'"] cannot scroll.')
			}
			return $this;
		};

		allStep = Math.ceil((cells.length)/opt.step);
			
		//@{步长,不循环}
		scroll = function(i,unloop) { 
			if(!!unloop){
				// 不循环
				$this.children(opt.wrap).stop(1).animate({
					left : (i-nowStep) * _cellOuterWidth		
				},opt.speed)
			}else{
				//循环
				if(i>0){
					for(var o = 0; o<i; o++){
						$this.find(opt.wrap).find(opt.cell).eq(showNumber+o).show()
					};
					
					$this.children(opt.wrap).stop(1).animate({
						left : -_cellOuterWidth * i	+ _wrapLeft			
					}, opt.speed,function(){
						for(var o = 0; o<Math.abs(i); o++){
							  $this.find(opt.wrap).find(opt.cell).eq(0).hide().appendTo($this.children(opt.wrap))
						  };
						$this.children(opt.wrap).css('left',_wrapLeft)
					});
				}else if(i<0){
					for(var o = 0; o<Math.abs(i); o++){
						$this.find(opt.wrap).find(opt.cell).eq(-1).show().prependTo($this.children(opt.wrap))
					};
	
					$this.children(opt.wrap).css('left',_cellOuterWidth * i + _wrapLeft).stop(1).animate({
						left : _wrapLeft			
					}, opt.speed,function(){
						for(var o = 0; o<Math.abs(i); o++){
							$this.find(opt.wrap).find(opt.cell).eq(showNumber+o).hide()
						};
						
					})
				};
			
			}
		
			opt.callback && opt.callback(nowStep);
			
		};
		
		//绑定按钮事件
		$next.unbind().on('click',function(event) {
			event.preventDefault();
			if($this.find(':animated').length ) return true;				
			
			if(opt.mode=='unloop'){		
				cells.length - showNumber - nowStep >= 0 ? ++nowStep : nowStep = 1;
				scroll(opt.step,true);
			}else{
				nowStep = (nowStep==-1) ? 1 : (nowStep >= allStep-1 ? -1 : ++nowStep);
				scroll(opt.step);
			}
		});
		
		$prev.unbind().on('click',function(event) {
			event.preventDefault();
			if($this.find(':animated').length ) return true;

			if(opt.mode=='unloop'){
				nowStep = (nowStep == 1) ? cells.length - showNumber + 1 : --nowStep;
				scroll(opt.step,true);
			}else{
				nowStep = (nowStep==1) ? -1 : (nowStep <= 1-allStep ? 1 : --nowStep); 
				scroll(-opt.step);
			}
		});
		
		//执行扩展
		opt.ext && opt.ext($this, showNumber, allStep);		
		
		//自动播放
		if (opt.auto) {
			t = window.setInterval(function() {
				((opt.direct == 'left') ? $next : $prev).trigger('click');
			}, opt.time);
			
			$this.hover(function() {
				window.clearInterval(t);
			}, function() {
				window.clearInterval(t);
				t = window.setInterval(function() {
					((opt.direct == 'left') ? $next : $prev).trigger('click')
				}, opt.time)

			})
		};
		
		//返回自身
		return $this
	};