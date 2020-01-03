//搜索框输入状态
$.fn.inputholder=function(){
	var dval=$(this).val();
	$(this).focus(function(){
		$(this).val('').addClass('focous');
		}).blur(function(){
		if($(this).val()==''){
			$(this).val(dval).removeClass('focous');
			}
		});
	};
var inputholder=$('.inputholder');
if(inputholder.length){
	inputholder.each(function() {
      $(this).inputholder()
   })
};
//下拉
$.fn.sele=function() {
	var ev=($(this).data('sele')?$(this).data('sele').act:'mouseenter').split(" ");
	$(this).bind(ev[0],function(){sele_show(this,ev[0])}).bind('mouseleave',function(){sele_hide(this)});
	function sele_show(me,evt){
		$(me).find('.sele_').stop(1,0).show().children('a').click(function(event){
			event.stopPropagation();
			if(!$(this).attr('target')){
				event.preventDefault();
				if($(me).find('.btn').length){
					$(me).find('.btn').attr('href',$(this).attr('href'))
				};
				$(this).parent().hide().parents('.sele').find('span').text($(this).text());
			}
		})
	};
	function sele_hide(me){
		$(me).find('.sele_').stop(1,0).hide()
	};
};
var $sele=$('.sele');
$sele.each(function(i) {$(this).css('z-index',$sele.length-i).sele()});
//
$.fn.smartFloat = function() {
var position = function(element) {
	var 
	top = element.offset().top;
	$(window).scroll(function() {
		var scrolls = $(this).scrollTop();
		if (scrolls > top) {
			element.addClass('sg-fix');	
		}else {
			element.removeClass('sg-fix');	
			element.removeAttr('style');
		}
	});
};
return $(this).each(function() {
	position($(this));						 
});
};
$(".sideGuide").smartFloat();
//
(function($){
 $.extend($.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            $('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var $target = $(this.hash);
     $target = $target.length && $target || $('[name=' + this.hash.slice(1) + ']');
                    if ($target.length) {
                        if (to == 1) {
                            $('html,body').animate({
                                scrollTop: $target.offset().top
                            }, time);
                        }
                        else if(to==2){
                            $('html,body').animate({
                                scrollLeft: $target.offset().left
                            }, time);
                        }else{
alert('argument error');
  }
                        return false;
                    }
                }
            });
  }
 });
})($);

$(".brands,.sideGuide").scrollTo(700)
