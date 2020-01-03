/**
 * index
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	require('./common');
	  
  	require('tab');
  	$('.pro_detail').tab({
  		posi_auto:false
  	});

  	
  	// banner活动日期计算
 	(function(){
		var actDate; // 活动日期
		var tempFullDate = new Date();
		var days; // 活动日期差
		// 计算日期差
		/**
		 * 计算日期差
		 * example: input startDate: new Date('2017/09/25'),endDate: new Date('2017/09/26'); output 1
		 * @param {Date} startDate 开始日期
		 * @param {Date} endDate   结束日期
		 * return {number}         日期差（单位：天）
		 */
		function GetDateDiff(startDate,endDate)  
		{  
		    var startTime = startDate.getTime();     
		    var endTime = endDate.getTime();     
		    return Math.abs((startTime - endTime))/(1000*60*60*24);
		}
		// 渲染倒计时数字
		$('.count_down').each(function(){
			actDate = new Date($(this).data('date'));
			days =Math.ceil(GetDateDiff(tempFullDate,actDate));
			$(this).find('.num').eq(0).addClass('num' + parseInt(days / 10, 10));
			$(this).find('.num').eq(1).addClass('num' + (parseInt(days % 10, 10)));
		
		});
 	})();
 	// banner活动日期计算 end

 	setTimeout(function(){
 		$('.count_down').find('.num').removeClass('move');
 	},1000);

 	//活动名单滚动
 	require.async('marquee',function(){
 	  $('.name_list').marquee({
 	  	duration:8000
 	  });
 	});

 	//video
	require('box');
	require('video');
	if (base.getType() == 'Pc') {
		var video_width = 960;
		var video_height = 540;
		var scroll_step = 3;
	}else{
		var video_width = 380;
		var video_height = 260;
		var scroll_step = 3;
	}
	
	$('.video_box').click(function(event) {
		if($.trim($(this).data('v'))){
			var tmp=$(this).data('v');
			var _title=$(this).find('.video_title').text();
			$.box.ifram(tmp,{
				name: "_title", //ifram name，默认空（不是弹窗标题）
				width: video_width, //iframe宽，默认640
				height: video_height //iframe高，默认480
			},{title:_title})
		}

	});
 	
 	//tab跟随
 	$(window).scroll(function(event) {
 		if ($(window).scrollTop()>$('.tab_hd').offset().top) {
 			$('.tab_hd').addClass('cur');
 		}else{
 			$('.tab_hd').removeClass('cur');
 		}
 	});

 	require('owlCarousel');
 	$('.part6_owl').owlCarousel({
 		items:1,
 		smartSpeed:800,
 		nav:true,
 		navText:['<i class="ion prev">&#xe7b7;</i>','<i class="ion next">&#xe7b9;</i>']
 	})
	
	/**$.ajax({
                type:"post",
                url:"action/ajax.jsp",
                data:{
					flag:"rankList"
				},
                success:function(rs){
                    if($.trim(rs)!=''){
						$(".name_list").html($.trim(rs));
                    }else{
						$(".name_list").html("暂无信息！");
                    }
                }
            });
**/
    
})

