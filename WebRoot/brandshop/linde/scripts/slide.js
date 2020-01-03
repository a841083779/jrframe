//**判断ie6
var ie6 = !-[1,] && !window.XMLHttpRequest; 
//**取得css属性值
function getStyle(elem,attr){if(elem.currentStyle){return elem.currentStyle[attr]}else if(document.defaultView&&document.defaultView.getComputedStyle){attr=attr.replace(/([A-Z])/g,'-$1').toLowerCase();return document.defaultView.getComputedStyle(elem,null).getPropertyValue(attr)}else{return null}};

(function(window){
	$.fn.slide = function(config) {
		 var opts, $this, $b_, t, n = 0, count, $nav, $p, $n, DelayObj, Delay = false;
		 opts = {
			  fade:true,
			  fadespeed:500,
			  auto:true,
			  time:5e3,
			  action:"mouseenter",
			  fn:null
		 };
		 $this = $(this);
		 opt = $.extend(opts, config || {}, $this.data("config") || {});
		 $b_ = $this.find(".ban_c");
		 count = $b_.length;
		 if (count <= 1) return;
		 if (ie6) {
			 $b_.each(function() {
         	$(this).height(getStyle(this,'height')==="100%" ? $this.height() : getStyle(this,'height'))
			 })
		 };
		 if ($this.find(".ban_nav").length) {
			  $nav = $this.find(".ban_nav");
			  $nav.show();
		 } else {
			  $nav = $('<div class="ban_nav"></div>');
			  for (i = 0; i < count; i++) {
					$nav.append("<a>" + (i + 1) + "</a>");
			  };
			  $this.append($nav);
		 };
		 if (!$this.find('.Left').length) {
			 $this.append('<a class="btn Left"></a><a class="btn Right"></a>');
			 };
		 $p = $this.find(".Left");
		 $n = $this.find(".Right");
		 $nav.find("a").on(opts.action, function(event) {
				event.preventDefault();event.stopPropagation();
				var index=$(this).index();
				if (index >= count || $(this).hasClass("on")) return;
				$nav.find("a").removeAttr('class').eq(index).addClass('on').end().eq(index - 1).addClass("ban_prev").end().eq(index == count - 1 ? 0 :index + 1).addClass("ban_next");
				if (opts.fade) {
					 $b_.stop(1, 1).fadeOut(opts.fadespeed).eq(index).fadeIn(opts.fadespeed);
				} else {
					 $b_.hide().eq(index).show();
				};
				n = index;
		  });
		 if (opts.auto) {
			  t = setInterval(function() {showAuto()}, opts.time);
			  $this.hover(function() {
					clearInterval(t);
			  }, function() {
					t = setInterval(function() { showAuto()}, opts.time);
			  })
		 };
		 $p.click(function(event) { event.preventDefault(); showPre();});
		 $n.click(function(event) { event.preventDefault(); showAuto();});
		 function showAuto() {
			  n = n >= count - 1 ? 0 :++n;
			  $nav.find("a").eq(n).trigger(opts.action);
		 };
		 function showPre() {
			  n = n <= 0 ? count - 1 :--n;
			  $nav.find("a").eq(n).trigger(opts.action);
		 };
		 if (opts.fn) {
			  eval(opts.fn + "(this,$b_,$nav)");
		 };
		 $nav.find("a").eq(0).trigger(opts.action)
	};
	$(".slide").each(function() {$(this).slide()});	
})(window);