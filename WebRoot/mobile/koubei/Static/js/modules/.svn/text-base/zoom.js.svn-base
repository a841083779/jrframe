/*
Zoom

v.09 
2014-01-05
改进：大图预加载

*/
define(function(require, exports, module) {
   var $ = require('$');
	require('zoom.css');
	
	$.fn.zoom = function(config) {
		var settings = {
				zoomWidth: $(this).width(),
				zoomHeight: $(this).height(),
				offset: 10,
				position: "right",
				preload: true
			},
			imageLeft,imageTop,imageWidth,imageHeight,bigimage,noalt;
		$.extend(settings, config || {}, $(this).data('config') || {} );
		if($(this).css('position')==='static') {$(this).css('position','relative')};
		
		$(this).hover(function() {
			imageLeft = $(this).offset().left,
			imageTop = $(this).offset().top,
			imageWidth = $(this).find('img').get(0).offsetWidth,
			imageHeight = $(this).find('img').get(0).offsetHeight,
			bigimage = $(this).find("img").attr("zoom") ? $(this).find("img").attr("zoom") :$(this).find("img").attr("src");
			noalt =$(this).find("img").attr("alt");
			$(this).find("img").attr("alt", '');
			if (!$("div.zoomdiv").length) {
				$(this).append("<div class='jqZoomPup'>&nbsp;</div>");
				$('body').append("<div class='zoomdiv'><img class='bigimg' src='" + bigimage + "'/></div>");
			};
			if (settings.position == "right") {
				if (imageLeft + imageWidth + settings.offset + settings.zoomWidth > screen.width) {
					leftpos = imageLeft - settings.offset - settings.zoomWidth;
				} else {
					leftpos = imageLeft + imageWidth + settings.offset;
				}
			} else {
				leftpos = imageLeft - settings.zoomWidth - settings.offset;
				if (leftpos < 0) {
					leftpos = imageLeft + imageWidth + settings.offset;
				}
			};
			$("div.zoomdiv").css({
				top: imageTop,
				left: leftpos,
				width:settings.zoomWidth,
				height:settings.zoomHeight
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
					width:(settings.zoomWidth) /scalex,
					height:(settings.zoomHeight) / scaley,
					top: ypos,
					left: xpos
				});
				$("div.zoomdiv").scrollTop(ypos * scaley).scrollLeft(xpos * scalex);
			});
		}, function() {
			$(this).find("img").attr("alt", noalt);
			$('body').unbind("mousemove");
			$("div.jqZoomPup").remove();
			$("div.zoomdiv").remove();
		});
		if (settings.preload && $(this).find("img").attr("zoom")) {
			var imagetopreload = $(this).find("img").attr("zoom");
			var content = $('<div class="jqPreload" style="display:none"><img src="' + imagetopreload + '" /></div>');
			$('body').append(content);
		}
	};
	function MouseEvent(e) {this.x = e.pageX;this.y = e.pageY;};
		
});
