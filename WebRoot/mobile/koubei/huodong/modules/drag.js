/*
 * drag v0.2
 * 修复bug，增加回调
 * 2014-05-23
 */
define(function(require, exports, module) {
   var $ = require('$');
	
	$.fn.drag=function(config){
	var _this=this,ox,oy,mx,my,fw,fh,
		 ow=$(_this).outerWidth(),
		 oh=$(_this).outerHeight(),
		 defaults={
			 wrap:null,
			 callback:function(){}
			},
		opt=$.extend(defaults,config || {}, $(_this).data('config') || {});
		
		if(opt.wrap!==null){
			fw=$(opt.wrap).width();
			fh=$(opt.wrap).height();
		}else{
			if($(_this).parent().is('body')){
				fw=$(window).width();
				fh=$(window).height();	
			}else{
				fw=$(_this).parent().width();
				fh=$(_this).parent().height();
			};
		};

	_this.on({
		"mousedown":function(e){
			ox=parseInt($(_this).css('left'));
			oy=parseInt($(_this).css('top'));
			mx=e.clientX;
			my=e.clientY;
			$(document).on('mousemove',function(e){
				var rx=parseInt(ox-mx+e.clientX),
					 ry=parseInt(oy-my+e.clientY);
				//横向
				if((rx<0 && fw>ow) || (rx>0 && fw<ow)){
					_this.css('left',0);
				}else if((rx>0 && rx>(fw-ow)) || (rx<0 && rx<(fw-ow))){
					_this.css('left',fw-ow);
				}else{
					_this.css('left',rx);
				};
				//纵向
				if((ry<0 && fw>ow) || (ry>0 && fw<ow)){
					_this.css('top',0);
				}else if((ry>0 && ry>(fh-oh)) || (ry<0 && ry<(fh-oh))){
					
					_this.css('top',fh-oh);
				}else{
					_this.css('top',ry);
				};

			}).on('mouseup',function(){
				$(this).unbind('mousemove');
				opt.callback(_this)
			});
		},
		"mouseup":function(){
			$(this).unbind('mousemove');
			}
		});
		
		return $(_this)
	}
		
});