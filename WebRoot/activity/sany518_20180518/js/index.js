$(function(){
	
	/**
	 * 最新预定轮播
	 */
	var namesLen = $('.roll_in').find('p').length,
	namesHeight = $('.roll_main').height(),
	rollIn = $('.roll_in').height(),
	diff = namesHeight-rollIn,
	count = 0;
	if(namesLen>8){
		$('.roll_in').css('height','1.44rem')
		setInterval(function(){
			$('.roll_main').css('margin-top','-'+count+'px');
			count++;
			if(count==diff){count=0;}
		},70)
	}
	
	$.ajax({
                type:"post",
                url:"action/ajax.jsp",
                data:{
					flag:"rankList"
				},
                success:function(rs){
                    if($.trim(rs)!=''){
						$(".roll_main").html($.trim(rs));
                    }else{
						$(".roll_main").html("暂无信息！");
                    }
                }
            });
	
})