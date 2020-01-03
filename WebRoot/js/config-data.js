/*
 * 	@author: ht
 * 	@version 1.0
 * 	@date 2017-05-10
*/
;
(function($){
	
	var defaults = {
		ID : '',
		filePath : '',  // 小图路径：本地
		imgFormat : '.png',  // 图片格式
		len : 50, // 张数配置
		scroll: true, //滚动发滚轮自动旋转
		playSpeed : 400,  // 播放速度
		autoplay : true, // 是否自动播放
		delay : 3 // 不操作后开始自传
		};
	
	$.fn.show360 = function(options, undefined){
		
		var opts = $.extend({}, defaults, options, undefined);
		
		obj = $(this);
		
		var timer = null;
		var isLoaded = false; //判断图片是否加载完成
		var crl = null;
		
		var show = {
			init : function (){
				this.create();
				this.crlFn();
				
				if(opts.autoplay){
					this.play();
				    this.stop();
					}
				},
			create : function (){
				var html = '';
				html += '<div id=\"circlr-' + opts.ID + '\" class=\"img-wrap\" style=\"cursor:move;\"><\/div>';
				html += '<div class=\"rotate-tip\"><\/div>';
				html += '<div id=\"loading-' + opts.ID + '\" style=\"position:absolute; left:0; top:0; width:100%; height:100%; background-color:rgba(0,0,0,0.8);\">';
				html += '<div id=\"effect_4\">';
				html += '<div class=\"loading-center\">';
				html += '<div class=\"loading-center-absolute\">';
				html += '<div class=\"object object_one\"><\/div>';
				html += '<div class=\"object object_two\"><\/div>';
				html += '<div class=\"object object_three\"><\/div>';
				html += '<div class=\"object object_four\"><\/div>';
				html += '<\/div>';
				html += '<\/div>';
				html += '<\/div>';
				html += '<\/div>';
				
				obj.html(html);
				
				var step = 0;
				var imgList = '';
				
				for(var i = 0; i < opts.len; i ++){
					imgList += '<img data-src=\"' + opts.filePath + 'pro_' + i + opts.imgFormat + '\" \/>';
					}
				
				$('.img-wrap').html(imgList);
				},
			crlFn : function(){
				crl = circlr('circlr-' + opts.ID, {
					scroll: opts.scroll,
					loader: 'loading-' + opts.ID,
					autoplay : opts.autoplay,
					playSpeed: opts.playSpeed
					});
				},
			play : function(){
				$('#circlr-' + opts.ID).on('touchend || mouseup', function() {
					timer = setTimeout(function (){
						crl.play();
						}, opts.delay * 1000);
				    });
				},
			stop : function(){
				$('#circlr-' + opts.ID).on('touchstart || mousedown', function() {
					if(timer !== null){
						clearTimeout(timer);
						timer = null;
						}
					crl.stop();
				    });
				}
			};
		
		return show.init();
		};
	})(jQuery);