// JavaScript Document

//平滑滚动
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
$(function(){
  $(".nav_scroll").scrollTo(700);
});

//选项卡
$.fn.tab=function(){
	var $key=$(this).find('.tab_key'),
		 $val=$(this).find('.tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).click(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.kbpic_tab').each(function() { $(this).tab()});


var a=$('body').height();
$('.upimg_bg').height(a);