$(function(){
	var root=window.location.protocol+"//"+window.location.host;
	//返回键
	$('.back').on('tap',function(){
		window.history.back();
	})
	//main部分滑动控制
	var windowHeight = $(window).height(),
	footerHeight = window.getComputedStyle(document.getElementsByClassName('footer')[0]).height,
	headerHeight = window.getComputedStyle(document.getElementsByClassName('header')[0]).height,
	navHeight = window.getComputedStyle(document.getElementsByClassName('nav')[0]).height,
	mainHeight = windowHeight - parseFloat(footerHeight) - parseFloat(headerHeight) - parseFloat(navHeight);
	$('.main').css('height',mainHeight+'px');
//	$('#list').css('height',mainHeight+'px');

	
	//消息提醒
	$('body').on('tap','.tip_btn',function(){
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'sendWxMsg' ,
			form_id : $(this).attr("data-id")
		},

		dataType: "json",

		success: function(json){
			$('.msg').html(json.msg);
			
		}
	});
		$('.recieve').removeClass('hide');
		$('.mask').removeClass('hide');
	})
	
	//点击'知道了'关闭
	$('body').on('tap','.know_success',function(){
		$('.recieve').addClass('hide');
		$('.mask').addClass('hide');
	})
	
	//获取状态数
	$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'factory_stateNum' ,
			uid : $('#uid').val()//154 
		},

		dataType: "json",

		success: function(json){
			$('#unfinished_num').html(json.unHandleNum);
			$('#track_num').html(json.inTrackNum);
			$('#deal_num').html(json.dealNum);
			$('#loss_num').html(json.lossNum);
			$('#mark_num').html(json.markNum);
		}
	});
	
	//上拉加载mui
	mui.init({
		pullRefresh: {
			container: '#main',
			up: {
				contentrefresh: '正在加载...',
				callback: pullupRefresh
			}
		}
	});
	/**
	 * 上拉加载具体业务实现
	 */
	var count = 0;
	function pullupRefresh() {
		mui('#main').pullRefresh().endPullupToRefresh(false); //参数为true代表没有更多数据了。(++count > 6)
		var resultAll = $('#list');
		var resultDetail = $('.section');
		
		++count;
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'factory_order_list' ,
			uid : $('#uid').val(),//154
			orderState: 0 ,
			pageNum : count ,
			pageSize : 10
		},

		dataType: "json",

		success: function(json){
			var html='',id='',title='',receiveMan='',orderUser='',createDate='',isTagged='';
			var order=json.result;
			$.each(order, function(idx) {
				id=order[idx]["orderId"];
				title=order[idx]["orderTitle"];
				receiveMan=order[idx]["receiveMan"];
				orderUser=order[idx]["orderUser"];
				createDate=order[idx]["createDate"];
				isTagged=order[idx]["isTagged"];
			
				if(isTagged===1){
					html += '<li class="section fix act">';
				}else{
					html += '<li class="section fix">';
				}
				html += '<div class="info l"><p class="info_title"><span class="star_status dib"><i class="ion">&#xe6cc;</i></span><span>'+title+'</span></p>';
				html += '<p class="charger"><span>负责人：</span><span>'+receiveMan+'</span></p>';
				html += '<p class="tracker"><span>'+orderUser+'</span><span>'+createDate+'</span></p></div>';
				html += '<div class="btns r fix">';
				//html += '<a href="javascript:void(0);" class="dib unacp_btn r"><i class="ion">&#xe731;</i><span>未接受</span></a><br/>';
				html += '<a href="javascript:void(0);" data-id="'+id+'" class="dib tip_btn r">提醒</a>';
				html += '</div></li>';

			});

			resultAll.append(html);
		}
	});
		
		$('.mui-pull-bottom-pocket').remove();
		$('.mui-scrollbar').remove();
	}
	//进页面首次加载一次数据
	pullupRefresh();
})