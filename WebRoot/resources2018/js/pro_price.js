$(function(){
	/**
	 * 省市区联动
	 */
	
	$('.addr_l1').on('click','a',function(){
		$(this).addClass('on').siblings().removeClass('on');
		if($(this).index()==0){
			$('.addr_box').addClass('hide');
		}else{
			$('.addr_box').removeClass('hide');
		}
	})
	$('.addr_l2').on('click','a',function(){
		$(this).addClass('on').siblings().removeClass('on');
		if($(this).index()==0){
			$('.addr_l3').addClass('hide');
		}else{
			$('.addr_l3').removeClass('hide');
		}
	})
	$('.addr_l3').on('click','a',function(){
		$(this).addClass('on').siblings().removeClass('on');
	})
	
})
