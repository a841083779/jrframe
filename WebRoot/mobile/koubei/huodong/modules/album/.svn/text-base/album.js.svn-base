/*
* name: album.js
* version: v0.19
* update: 修复起始元素检测bug
* date: 2014-08-27
*/
define(function(require, exports, module) {
	var $ = require('$');
	require('./album.css');
	
	$.fn.album = function(config){
		var albumList = $(this),
			opt = {
				wrap: 'ul', 
				cell: 'li',  
				type: 1,                 //1:上一张下一张箭头, 2:上一张下一张预览, 3:
				effect: 'slide',         //slide, fade, toggle
				speed: 480
			};
			
		$.extend(opt, config || {}, albumList.data("config") || {});
		
		thisClass = '.' + $(this).attr('class').split(' ').join('.') + ' ';

		require.async('slide',function(){
			albumList.on('click', opt.cell ,function(e){
				e.preventDefault();
				var _slide = albumList.clone();
				var winheight = $(window).height();
				var _start = $(this).index(thisClass + opt.cell);
				
				//预处理
				switch (opt.type){
					case 1:
						var _bar = $('<div class="album_btns_bar">\
										  <div class="album_btns album_prev"></div>\
										  <div class="album_btns album_next"></div>\
										  <div class="album_btns album_close"></div>\
									  </div>');

						_slide.append(_bar).attr('class','album_ordinary').css({
							'height':winheight + 1 + 'px',
							'line-height':winheight-30+'px'
						}).find(opt.wrap).attr('class','album_wrap').find(opt.cell).attr('class','album_cell').each(function(i,e){
							var img = $(e).find('img').attr('src'),
								title = $(e).find('._title').length ? $(e).find('._title').text() : false,
								html = '<img src="'+img+'" >' + (title ? '<p>'+ title +'</p>' : '' );
							
							$(e).html(html);
							
						});
						break;
						
					case 2:
						var _nav = $('<div class="slide_nav" />'),
							_page = $('<div class="album_pages">\
											<span class="album_page_now" />\
											/\
											<span class="album_page_all" />\
										</div>\
										<div class="album_btns album_close" />');
						
						_slide.append(_nav).attr('class','album_ordinary album_preview').css({
							'height':winheight + 1 + 'px',
							'line-height':winheight-30+'px'
						}).find(opt.wrap).attr('class','album_wrap').find(opt.cell).attr('class','album_cell').each(function(i,e){
							var img = $(e).find('img').attr('src'),
								title = $(e).find('._title').length ? $(e).find('._title').text() : false,
								html = '<img src="'+img+'" >' + (title ? '<p>'+ title +'</p>' : '' );
							
							$(e).html(html);
							_slide.find('.slide_nav').append('<a><img src="'+img+'" ></a>');
						});
						_slide.append(_page);
						break;
					
					case 3:
						console.log('还没有3')
						break;
						
				};
				
				_slide.css('top','-102%').appendTo('body').slide({
					act:'click',
					wrap:'.album_wrap',
					cell:'.album_cell',
					effect:opt.effect,
					speed:opt.speed,
					prev:'.album_prev',
					next:'.album_next',
					start:_start,
					auto:false,
					callback:function(o,b,now){
						if(o.find('.album_page_now').length){
							o.find('.album_page_now').text(now+1)	
						}
					},
					ext:function(o,b,count){
						o.find('.album_close').on('click',function(){
							o.animate({top:'-102%'},256,function(){
								o.remove()	
							});	
						});
						if(o.find('.album_page_all').length){
							o.find('.album_page_all').text(count)	
						}
					}
				}).animate({top:'0'},521)
			})
		})
	};



})
