/*
 * name: tip.js
 * version: v0.1
 * update: 
 * date: 2014-09-26
 */

	$.fn.tip = function(tip,config){
		var opts = {
			act:'mouseenter',		// click | mouseenter
			place:'left-out',		// left | top | right | bottom
			callback:function(){},
			ext:function(){}
		},
		$this = $(this),
		wrap = $('<div class="tip-box" id="tip-box">\
					<div class="tip-content" id="tip-content">\
					</div>\
				</div>'),
		tipLeft,
		tipTop,
		place,
		mouseleave,
		show;
	
		$.extend(opts, config || {}, $this.data('config') || {});
		place = opts.place.split('-')

		//准备容器
		!$('#tip-box').length && $('body').append(wrap);
		
		show = function(){
			//填充内容
			if(typeof(tip)==='string'){
				$('#tip-content').empty().append(tip);
			}else if($(tip).length){
				$('#tip-box').empty().append($(tip))	
			}
			//居中偏移量
			var _offX = $('#tip-box').outerWidth()>$this.outerWidth() ? -Math.abs($this.outerWidth()-$('#tip-box').outerWidth())/2 : Math.abs($this.outerWidth()-$('#tip-box').outerWidth())/2,
				_offY = $('#tip-box').outerHeight()>$this.outerHeight() ? -Math.abs($this.outerHeight()-$('#tip-box').outerHeight())/2 : Math.abs($this.outerHeight()-$('#tip-box').outerHeight())/2;
			//计算方位
			switch (place[0]){
				case 'top':
					tipLeft = $this.offset().left + _offX;
					tipTop = $this.offset().top - $('#tip-box').outerHeight();
					if(place[1]==='in'){
						tipTop = tipTop + $this.outerHeight()
					}
					break;
				case 'bottom':
					tipLeft = $this.offset().left +_offX;
					tipTop = $this.offset().top;
					if(place[1]==='out'){
						tipTop = tipTop + $this.outerHeight();
					}
					break;
				case 'right':
					tipLeft = $this.offset().left;
					tipTop = $this.offset().top + _offY;
					if(place[1]==='out'){
						tipLeft = tipLeft + $this.outerWidth()
					}
					break;
				default:
					tipLeft = $this.offset().left - $('#tip-box').outerWidth();
					tipTop = $this.offset().top + _offY;
					if(place[1]==='in'){
						tipLeft = tipLeft + $this.outerWidth()
					}
			}
			
			
			//显示
			$('#tip-box').css('left',tipLeft).css('top',tipTop).show();
			
			//回调
			opts.callback && opts.callback($this)
		};
				
		if(opts.act==='mouseenter'){
			$this.on('mouseenter',function(){
				show();
			})
			
			mouseleave = function(){
				$(this).on('mouseleave',function(){
					$('#tip-box').hide()	
				})
				
			};
			
			if(place[1]==='in'){
				mouseleave.call($('#tip-box').get(0))	
			}else{
				mouseleave.call($this.get(0))
			};
			
		}else if(opts.act==='click'){
			$('body').on('click',function(e){
				if($this.is(e.target)){
					e.preventDefault();
					setTimeout(function(){
						show()	
					})
				}else{
					$('#tip-box').hide()
				}
			})
		}
				
		opts.ext && opts.ext($this);
		
		return $this;
	}
