//大图列表模式互换
$('.modeSwitch').click(function(){
	var prolist = $('.mainList');
	if(prolist.hasClass('listMode')){
		prolist.addClass('picMode').removeClass('listMode');
		$(this).removeClass('switch_on').attr('title','点击切换到列表模式');
	}else{
		prolist.removeClass('picMode').addClass('listMode');
		$(this).addClass('switch_on').attr('title','点击切换到大图模式');
		$('.mainList').find('.pmh').removeAttr('style');
	}
	//$('html,body').stop(1,0).animate({scrollTop:$('.filterBox').offset().top},1);
});

$('.cont_right').on('mouseenter','.picMode li',function(){
	$(this).addClass('hover').find('.pmh').stop().animate({height:50},'fast');
}).on('mouseleave','.picMode li',function(){
	$(this).removeClass('hover').find('.pmh').stop().animate({height:0},'fast');
})

		


