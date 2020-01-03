/*
* name: select.js
* version: v1.1
* update: 修复层级处理bug
* date: 2014-08-18
*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./sele_bg.css');
	
	var Counter=(function(){           
			var count=0;  		  
			return function(){            
				return ++count;  
			}  
		})();
			
	$.fn.sele=function(config) {
		var opt={
				max:99,
				act:"click",              // mouseenter
				callback:function(a, b){} // @param(_val, _text)
			 },
			 this_=this,
			 hidemenu=function(){
				setTimeout(function(){
					$(this_).removeClass('on').find('._option').fadeOut(128);
				  },100);
				  $('.optbg_1').hide();
			  };
			
		$.extend(opt, config || {}, $(this).data('config') || {});

		//层级处理
		opt.max>1 && $(this_).css('z-index',opt.max-Counter());

		//open			
		$(this_).addClass('select').on(opt.act,function(e){
			e.stopPropagation();
			if($(this_).find('._option:visible').length){
				if($(this_).attr('id')=='optbg_1'){
					$(this_).css('z-index','99');
				}
				if($(this_).attr('id')=='optbg_2'){
					$(this_).css('z-index','88');
				}
				if($(this_).attr('id')=='optbg_3'){
					$(this_).css('z-index','77');
				}
				hidemenu();
			}else{
				if($(this_).attr('id')=='optbg_1'){
					$(this_).css('z-index','201');
					$('.optbg_1').css('z-index','200');
				}
				if($(this_).attr('id')=='optbg_2'){
					$(this_).css('z-index','201');
					$('.optbg_1').css('z-index','200');
				}
				if($(this_).attr('id')=='optbg_3'){
					$(this_).css('z-index','201');
					$('.optbg_1').css('z-index','200');
				}
				$('.optbg_1').show();
				$(this_).addClass('on').find('._option').fadeIn(128);
			}
		}).on('click','._option a',function(e){
		  e.stopPropagation();
		  if(!$(this).attr('target')){
			  e.preventDefault();
			  var _val=$(this).data('val') ? $(this).data('val') : $(this).text(), _text=$(this).text();
			  $(this_).find('._val span').text(_text);
			  hidemenu();
			  //执行回调
			  opt.callback(_val, _text)
			};
		});
		
		//close
		if(opt.act=="mouseenter"){
			$(this_).on("mouseleave", function(){
				hidemenu();
				if($(this_).attr('id')=='optbg_1'){
					$(this_).css('z-index','99');
				}
				if($(this_).attr('id')=='optbg_2'){
					$(this_).css('z-index','88');
				}
				if($(this_).attr('id')=='optbg_3'){
					$(this_).css('z-index','77');
				}
			});
		}else if(opt.act=='click'){
			$(document).mouseup(function(e){
			  if(!$(this_).is(e.target) && $(this_).has(e.target).length === 0){ 
				hidemenu();
				if($(this_).attr('id')=='optbg_1'){
					$(this_).css('z-index','99');
				}
				if($(this_).attr('id')=='optbg_2'){
					$(this_).css('z-index','88');
				}
				if($(this_).attr('id')=='optbg_3'){
					$(this_).css('z-index','77');
				}
			  }
			})
		};
		
		//返回自身
		return $(this_)
	};
		
	
});