/*
 * name: box.js
 * version: v3.3.1
 * update: 替换图标
 * date: 2015-06-30
 * base on: zhangxinxu
 */
define('box',function(require, exports, module) {
	seajs.importStyle('.wrap_close a,.wrap_close a:hover{text-decoration:none}.wrap_close a,.wrap_msg_clo{text-align:center;cursor:pointer}#boxBlank{position:fixed;z-index:99;left:0;top:0;width:100%;height:0;background:#000}.wrap_out{position:absolute;z-index:100;top:-999px;border-radius:4px;overflow:hidden;max-width:100%;-webkit-transition:opacity .3s linear,top .3s ease-out;transition:opacity .3s linear,top .3s ease-out}.wrap_out_drag{-webkit-transition:none;transition:none}.wrap_hide{opacity:0!important;top:-20%!important}.wrap_bar{background:#434343;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}.wrap_title{line-height:30px;padding-left:10px;margin:0;font-weight:400;font-size:15px;color:#fff}.wrap_close{position:relative}.wrap_close a{width:20px;height:20px;margin-top:-26px;color:#fff;font:700 1.5em/20px Tahoma;position:absolute;right:6px}.wrap_body{background:#fff}.wrap_remind{padding:30px 40px 20px;min-width:10em}.wrap_foot{padding:0 40px 20px;text-align:center}.wrap_msg{position:relative;width:500px;max-width:100%}.wrap_msg_cont{padding:15px 40px 15px 15px;line-height:22px}.wrap_msg_clo{position:absolute;width:30px;height:50px;line-height:50px;right:0;top:0}.wrap_msg_clo .ion{margin:0;font-size:16px}.wrap_msg_clo:hover{opacity:.8}'
		,module.uri)
	var $ = require('jquery'),
		Language = [{
			close: "关闭",
			confirm: "确认",
			cancel: "取消",
			loading: "加载中...",
			error: "加载出了点问题"
		}, {
			close: "close",
			confirm: "confirm",
			cancel: "cancel",
			loading: "loading...",
			error: "something is wrong"
		}],
		def = {
			title: "对话框",
			oktext: null,
			canceltext: null,
			shut: "×",
			index: 99,
			opacity: 0.5,
			width: "auto",
			height: "auto",
			layout:true,			//是否包含弹出框
			extclass:null,			//附加class
			bar: true,				//是否显示标题栏
			bg: true,				//是否显示半透明背景
			btnclose: true,			//是否显示关闭按钮
			fix: true,				//是否弹出框固定在页面上
			bgclose: true,			//是否点击半透明背景隐藏弹出框
			drag: false,			//是否可拖拽
			protect: false,			//保护装载的内容
			onshow: $.noop,			//弹窗显示后触发事件
			onclose: $.noop,		//弹窗关闭后触发事件
			delay: 0,				//弹窗打开后关闭的时间, 0和负值不触发
			lang: 0,				//语言选择，0：中文 1:英文,
			color:"info"			//msg方法情景色，info，primary，success，warning，danger
		};
	//全局修改默认配置
	if(window.boxGlobal){
		$.extend(def,window.boxGlobal);
	}

	$.box = function(elements, options) {
		if (!elements) {
			return console.log('no elements to $.box');
		};

		var s = $.extend({}, def, options || {}),
			extclass = '',
			boxID = 'boxID'+parseInt(Math.random()*1e5),
			WRAP,
			$o,
			eleOut,
			eleBlank = $("#boxBlank").length ? $('#boxBlank') : 
				$('<div id="boxBlank" onselectstart="return false" />').appendTo('body');

		if(s.extclass && /^\w*$/.test(s.extclass)){
			extclass =  s.extclass;
		}

		if (typeof(elements)==='object' && elements.size() ) {
			//现有dom
			elements.show();
			if(!s.bridge){
				s.protect = true;
			}
		} else if($.parseHTML($.trim(elements+''))[0].nodeType===1){
			//dom字符串
			elements = $(elements);
		}else{
			//纯字符串
			elements = $('<div class="wrap_remind">'+elements+'</div>');
			s.layout || (elements.css('min-width','0'));
		};

		WRAP = s.layout ?
			 '<div data-protect="'+s.protect+'" class="'+extclass+' wrap_out '+boxID+'">' + 
				 '<div class="wrap_in">' + 
					 '<div class="wrap_bar" onselectstart="return false;">' + 
						 '<h4 class="wrap_title"></h4>' + 
						 '<div class="wrap_close">'+
						 	'<a href="javasctipt:" title="' + Language[s.lang].close + '"></a>'+
						 '</div>' + 
					 '</div>' + 
					 '<div class="wrap_body"></div>' + 
				 '</div>' + 
			'</div>'
			:
			'<div class="'+extclass+' wrap_out '+boxID+'" />';
		
		eleOut = $(WRAP).attr('box-ui-bg',!!s.bg).appendTo('body');

		$o = {
			s: s,
			ele: elements,
			bg: eleBlank,
			out: eleOut,
			tit: eleOut.find(".wrap_title"),
			bar: eleOut.find(".wrap_bar"),
			clo: eleOut.find(".wrap_close a"),
			bd: s.layout ? eleOut.find(".wrap_body") : eleOut
		};
		$o.tit.html(s.title);
		$o.clo.html(s.shut);
		$o.bd.append(elements);
		if ($.isFunction(s.onshow)) {
			s.onshow();
		};
		$.box.setSize($o);
		$.box.setPosition($o);

		if (s.fix) {
			$.box.setFixed($o);
		};
		if (s.drag) {
			setTimeout(function(){
				$.box.drag($o);
			},1e3)
		} else {
			$(window).resize(function() {
				$.box.setPosition($o);
			});
		};
		if (!s.bar) {
			$.box.barHide($o);
		} else {
			$.box.barShow($o);
		};
		if (!s.bg) {
			$.box.bgHide($o);
		} else {
			$.box.bgShow($o);
		};
		if (!s.btnclose) {
			$.box.closeBtnHide($o);
		} else {
			$o.clo.click(function() {
				$.box.hide($o);
				return false;
			});
		};
		$.box.bgClickable(s.bgclose,$o);
		if (s.delay > 0) {
			setTimeout(function(){
				$.box.hide($o);
			}, s.delay);
		};

		//返回box元素
		return $o;
	};
	$.extend($.box, {
		setSize: function($o) {
			if (!$o.bd.size() || !$o.ele.size() ) {
				return;
			}
			$o.out.css({
				"width": $o.s.width,
				"height": $o.s.height
			});
			return $o.out;
		},
		setPosition: function($o) {
			if (!$o.bg.size() || !$o.ele.size() || !$o.out.size()) {
				return;
			}
			var w = $(window).width(),
				h = $(window).height(),
				st = $(window).scrollTop(),
				ph = $("body").height();
			if (ph < h) {
				ph = h;
			}
			$o.bg.width(w).height(ph).css("opacity", $o.s.opacity);
			var xh = $o.out.outerHeight(),
				xw = $o.out.outerWidth();
			var t = st + (h - xh) / 2,
				l = (w - xw) / 2;
			if ($o.s.fix && window.XMLHttpRequest) {
				t = (h - xh) / 2;
			};
			if($o.s.top!=void(0)){
				t = $o.s.top;
			}
			$o.out.css({
				top: t,
				left: l,
				zIndex: $o.s.index
			});

			return $o.out;
		},
		setFixed: function($o) {
			if (!$o.out || !$o.out.size()) {
				return;
			};
			if (window.XMLHttpRequest) {
				$.box.setPosition($o).css({
					position: "fixed"
				});
			} else {
				$(window).scroll(function() {
					$.box.setPosition($o);
				});
			};
			return $o.out;
		},
		bgClickable: function(bool, $o) {
			$o.bg.click(function() {
				if(bool){
					$.box.hide($o);
				}
			});
		},
		bgHide: function($o) {
			if ($o.bg && !$('.wrap_out[box-ui-bg=true]').length) {
				$o.bg.hide();
			}
		},
		bgShow: function($o) {
			$o.bg.show();
		},
		barHide: function($o) {
			if ($o.bar && $o.bar.size()) {
				$o.bar.hide();
			}
		},
		barShow: function($o) {
			if ($o.bar && $o.bar.size()) {
				$o.bar.show();
			}
		},
		closeBtnHide: function($o) {
			if ($o.clo && $o.clo.size()) {
				$o.clo.hide();
			}
		},
		hide: function($o) {
			if($o==void(0)){
				$('.wrap_out').each(function(i,e){
					var _this = $(e);
					_this.stop().animate({top:'-999px'},320,function() {
						if (_this.data('protect')) {
							_this.find('.wrap_body').children().hide().appendTo($("body"));
						};
						setTimeout(function(){
							_this.remove();
							if (!$('.wrap_out[box-ui-bg=true]').length) {
								$('#boxBlank').hide();
							};
						},320)
					})
				});
				return;
			}

			if ($o.ele && $o.out.size() && $o.out.css("display") !== "none") {
				$o.out.stop().animate({top:'-999px'},320,function() {
					if ($o.s.protect) {
						$o.ele.hide().appendTo($("body"));
					};
					setTimeout(function(){
						$o.out.remove();
						if (!$('.wrap_out[box-ui-bg=true]').length) {
							$o.bg.hide();
						};
						if ($.isFunction($o.s.onclose)) {
							$o.s.onclose();
						};
					},320)
					
				});
				
			}
			return false;
		},
		drag: function($o) {
			if (!$o.out.size() || !$o.bar.size()) {
				$(document).unbind("mouseover").unbind("mouseup");
				return;
			};
			var bar = $o.bar,
				out = $o.out;
			var drag = false;
			var currentX = 0,
				currentY = 0,
				posX = out.css("left"),
				posY = out.css("top");
			console.log(posY)
			bar.mousedown(function(e) {

				drag = true;
				currentX = e.pageX;
				currentY = e.pageY;
				out.addClass('wrap_out_drag');
			}).css("cursor", "move");
			$(document).mousemove(function(e) {
				if (drag) {
					var nowX = e.pageX,
						nowY = e.pageY;
					var disX = nowX - currentX,
						disY = nowY - currentY;
						console.log(disY)
					out.css("left", parseInt(posX) + disX).css("top", parseInt(posY) + disY);
				}
			});
			$(document).mouseup(function() {
				drag = false;
				posX = out.css("left");
				posY = out.css("top");
				$o.out.removeClass('wrap_out_drag');
			});
		},
		loading: function(s) {
			var element = $('<div class="wrap_remind">' + Language[s.lang].loading + '</div>');
			return $.box(element, {
				bar: false
			});
		},
		confirm: function(message, sureCall, cancelCall, options) {
			var s = $.extend({}, def, options || {});
			s.bridge = true;
			var element = $('<div class="wrap_remind">' + message + '</div>'
				+ '<div class="wrap_foot"><button class="btn btn-primary boxconfirm">' 
				+ (s.oktext ? s.oktext : Language[s.lang].confirm) + '</button><button class="btn btn-default boxcancel">' 
				+ (s.canceltext ? s.canceltext : Language[s.lang].cancel) + '</button></div>');
			var _o = $.box(element, s);
			_o.out.find(".boxconfirm").click(function() {
				if ($.isFunction(sureCall)) {
					sureCall.call(this);
				}
			});
			_o.out.find(".boxcancel").click(function() {
				if (cancelCall && $.isFunction(cancelCall)) {
					cancelCall.call(this);
				};
				$.box.hide(_o);
			});
			return _o;
		},
		alert: function(message, callback, options) {
			var s = $.extend({}, def, options || {});
			s.bridge = true;
			var element = $('<div class="wrap_remind">' + message + '</div>'
				+ '<div class="wrap_foot"><button class="btn btn-primary boxconfirm">' 
				+ (s.oktext ? s.oktext : Language[s.lang].confirm) + '</button></div>');
			var _o = $.box(element, s);
			_o.out.find(".boxconfirm").click(function() {
				if (callback && $.isFunction(callback)) {
					callback.call(this);
				};
				$.box.hide(_o);
			});
			return _o;
		},
		msg: function(message, options) {
			var s = $.extend({}, def, options || {});
			s.top = 0;
			s.layout = false;
			s.bg = false;
			s.bridge = true;
			var element = $('<div class="wrap_msg"><div class="wrap_msg_cont bg-'+s.color
				+'">' + message
				+'</div><div class="wrap_msg_clo"><i class="ion">&#xe6c9;</i></div></div>');
			var _o = $.box(element, s);
			_o.out.find(".wrap_msg_clo").click(function() {
				$.box.hide(_o);
			});
			return _o;
		},
		ajax: function(uri, params, options) {
			var s = $.extend({}, def, options || {});
			if (uri) {
				var _loading = $.box.loading(s);
				options = options || {};
				options.protect = false;
				$.ajax({
					url: uri,
					data: params || {},
					success: function(html, other) {
						_loading.out.remove();
						$.box(html, options);
					},
					error: function() {
						$.box.alert(Language[s.lang].error);
					}
				});
			}
		},
		ifram: function(uri, params, options) {
			var s = $.extend({}, def, options || {});
			if (uri) {
				var html;
				options = options || {};
				options.protect = false;
				params = params || {};
				html = '<iframe name="'+ (params.name || '') +'" src="'+ uri +'" width="'
				+ (params.width || 640) +'" height="'+ (params.height || 480) +'" frameborder="0"></iframe>';
				return $.box(html, options);
			}
		}
	})
})