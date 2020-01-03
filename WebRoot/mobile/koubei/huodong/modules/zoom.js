/*
* name: zoom
* version: v1.0
* update: 解决chrome图片尺寸预取不准问题
* date: 2014-08-26
*/
define(function(require, exports, module) {
	var $ = require('$');
	require('./zoom.css');
	require('img-loaded');
	
	function MouseEvent(e) {this.x = e.pageX;this.y = e.pageY;};
	
	$.fn.zoom = function(config) {
		var $this = $(this)
		$this.imagesLoaded(function(){
				
			var opt = {
					zoomWidth: $this.width(),
					zoomHeight: $this.height(),
					offset: 10,
					position: "right",
					preload: true
				},
				imageLeft,imageTop,imageWidth,imageHeight,bigimage,noalt;
				
			$.extend(opt, config || {}, $this.data('config') || {} );
			if($this.css('position')!=='absolute' || $this.css('position')!=='fixed') {
				$this.css('position','relative')
			};
			
			$this.hover(function() {
				//mouseenter
				imageLeft = $this.offset().left,
				imageTop = $this.offset().top,
				imageWidth = $this.find('img').get(0).offsetWidth,
				imageHeight = $this.find('img').get(0).offsetHeight,
				bigimage = $this.find("img").attr("zoom") ? $this.find("img").attr("zoom") :$this.find("img").attr("src");
				noalt =$this.find("img").attr("alt");
				$this.find("img").attr("alt", '');
				if (!$("div.zoomdiv").length) {
					$this.append("<div class='jqZoomPup'>&nbsp;</div>");
					$('body').append("<div class='zoomdiv'><img class='bigimg' src='" + bigimage + "'/></div>");
				};
				if (opt.position == "right") {
					if (imageLeft + imageWidth + opt.offset + opt.zoomWidth > screen.width) {
						leftpos = imageLeft - opt.offset - opt.zoomWidth;
					} else {
						leftpos = imageLeft + imageWidth + opt.offset;
					}
				} else {
					leftpos = imageLeft - opt.zoomWidth - opt.offset;
					if (leftpos < 0) {
						leftpos = imageLeft + imageWidth + opt.offset;
					}
				};
				$("div.zoomdiv").css({
					top: imageTop,
					left: leftpos,
					width:opt.zoomWidth,
					height:opt.zoomHeight
				});
				$('body').mousemove(function(e) {
					mouse = new MouseEvent(e);
					var bigwidth = $(".bigimg").width(),
						 bigheight = $(".bigimg").height(),
						 scalex = (bigwidth / imageWidth),
						 scaley = (bigheight / imageHeight),
						 xpos = (mouse.x - $("div.jqZoomPup").width() / 2 < imageLeft) ? 0 : (mouse.x + $("div.jqZoomPup").width() / 2 > imageWidth + imageLeft) ? (imageWidth - $("div.jqZoomPup").width() - 2) : mouse.x - $("div.jqZoomPup").width() / 2 - imageLeft,
						 ypos = (mouse.y - $("div.jqZoomPup").height() / 2 < imageTop) ? 0 : (mouse.y + $("div.jqZoomPup").height() / 2 > imageHeight + imageTop) ? (imageHeight - $("div.jqZoomPup").height() - 2) : mouse.y - $("div.jqZoomPup").height() / 2 - imageTop;
					$("div.jqZoomPup").css({
						width:(opt.zoomWidth) /scalex,
						height:(opt.zoomHeight) / scaley,
						top: ypos,
						left: xpos
					});
					$("div.zoomdiv").scrollTop(ypos * scaley).scrollLeft(xpos * scalex);
				});
			}, function() {
				//mouseleave
				$this.find("img").attr("alt", noalt);
				$('body').unbind("mousemove");
				$("div.jqZoomPup").remove();
				$("div.zoomdiv").remove();
			});
			if (opt.preload && $this.find("img").attr("zoom")) {
				var imagetopreload = $this.find("img").attr("zoom");
				$('body').append($('<div class="jqPreload" style="display:none"><img src="' + imagetopreload + '" /></div>'));
			}
		})

	};
		
});
