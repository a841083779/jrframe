$(function(){
	var root=window.location.protocol+"//"+window.location.host;
	var source=location.pathname+location.search;
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
	//接收
	$('body').on('tap','.unacp_btn',function(){
		var formId=$(this).attr("data-id");
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'personnel_order_receive' ,
			form_id : formId
		},

		dataType: "json",

		success: function(json){
			if($.trim(json.data)=='true'){
				location.replace('/weixin/personnel/order_detail_edit.jsp?id='+formId+'&source='+source);
			}else{
				$('.msg').html(json.msg);
				$('.recieve').removeClass('hide');
				$('.mask').removeClass('hide');
			}	
		}
	});
	})
	//点击'知道了'关闭
	$('body').on('tap','.know_success',function(){
		$('.recieve').addClass('hide');
		$('.mask').addClass('hide');
		location.reload();
	})
	
	//获取状态数
	$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'personnel_stateNum' ,
			uid : $('#uid').val()//476  
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
			flag : 'personnel_order_list' ,
			uid : $('#uid').val(),//476 
			orderState: 0 ,
			trackState: 102002,
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
					html += '<li class="section fix act"><div class="info l">';
				}else{
					html += '<li class="section fix"><div class="info l">';
				}
				html += '<p class="info_title"><span class="star_status dib"><i class="ion">&#xe6cc;</i></span><span>'+title+'</span></p>';
				//html += '<p class="charger"><span>负责人：</span><span>'+receiveMan+'</span></p>';
				html += '<p class="tracker"><span>'+orderUser+'</span><span>'+createDate+'</span></p></div>';
				html += '<div class="btns r fix">';
				html += '<a class="dib unacp_btn r" data-id="'+id+'"><i class="ion">&#xe731;</i><span>未接收</span></a>';
				//html += '<br/><a href="javascript:void(0);" class="dib tip_btn r">提醒</a>';
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