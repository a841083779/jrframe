$(function(){
	$('body').height($(window).height());
	
	/**
	 * 按钮动画
	 */
	var inner = -50,center = 0,outer = 0;
	var btnbiling = setInterval(function(){
		inner++;
		center = inner+50,
		outer = inner+100;
		$('.item_btn').css({
			'background':'radial-gradient(circle,rgba(188,128,254,.9) '+inner+'%,rgba(176,249,245,.9)'+center+'%, rgba(188,128,254,.9) '+outer+'%)'
		})
		if(inner == 100){inner=-50;}
	},20)
	
	/**
	 * 订单查询
	 */
	$('.to_my').on('click',function(){
		$('.mask').animate({'bottom':'0'},500).removeClass('hide');
	})
	$('.close_mask').on('click',function(){
		$('.mask').animate({'bottom':'-100%'},500,function(){
			$(this).removeClass('hide');
		});
	})
	
	
})