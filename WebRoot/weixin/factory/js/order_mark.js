$(function(){
	var root=window.location.protocol+"//"+window.location.host;
	var source=location.pathname;
	//返回键
	$('.back').on('tap',function(){
		window.history.back();
	})
	//main部分滑动控制
	var windowHeight = $(window).height(),
	footerHeight = window.getComputedStyle(document.getElementsByClassName('footer')[0]).height,
	headerHeight = window.getComputedStyle(document.getElementsByClassName('header')[0]).height,
	navHeight = window.getComputedStyle(document.getElementsByClassName('nav')[0]).height,
	statusHeight = window.getComputedStyle(document.getElementsByClassName('track_status')[0]).height,
	mainHeight = windowHeight - parseFloat(footerHeight) - parseFloat(headerHeight) - parseFloat(navHeight) - parseFloat(statusHeight);
	$('.main').css('height',mainHeight+'px');
	
	//初始化状态
	if($('#orderState').val()!=''){//状态选择
		$('.ts_pro').find('span').text($('#status_items').find('input:checked').parent().find('label').html());
	}
	
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
	
	//状态选择弹窗
	$('.ts_pro').on('tap',function(){
		$('.mask').removeClass('hide');
		$('.status_choose').removeClass('hide');
	})
	//弹窗关闭
	$('body').on('tap','.close_btn',function(){
		$('.mask').addClass('hide');
		$('.status_choose').addClass('hide');
	})
	//弹窗内点选提交
	$('body').on('tap','.cho_confirm',function(){
		var op = $('#status_items').find('input:checked');
		if(!op.length){
			mui.toast('请选择状态！');
			return false;
		}
		console.log(op.data('value'));
		$('#orderState').val($('#status_items').find('input:checked').attr('data-value'));
		Initialization();
		$('.ts_pro').find('span').text(op.parent().find('label').html());
		$('.mask').addClass('hide');
		$('.status_choose').addClass('hide');
	})
	
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
	var count = 1;
	function pullupRefresh() {
		mui('#main').pullRefresh().endPullupToRefresh(false); //参数为true代表没有更多数据了。
		var resultAll = $('#list');
		var resultDetail = $('.section');
		
		++count;
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'factory_tagged_list' ,
			uid : $('#uid').val(),//154
			trackState: $('#orderState').val(),
			pageNum : count ,
			pageSize : 10
		},

		dataType: "json",

		success: function(json){
			var html='',id='',title='',receiveMan='',orderUser='',createDate='',isTagged='',recordDate='',orderStatename='',contactTel='';
			var order=json.result;
			$.each(order, function(idx) {
				id=order[idx]["orderId"];
				title=order[idx]["orderTitle"];
				receiveMan=order[idx]["receiveMan"];
				orderUser=order[idx]["orderUser"];
				createDate=order[idx]["createDate"];
				isTagged=order[idx]["isTagged"];
				recordDate=order[idx]["recordDate"];
				orderStatename=order[idx]["orderStatename"];
				contactTel=order[idx]["contactTel"];
				
				if(isTagged===1){
					html += '<li class="section act">';
				}else{
					html += '<li class="section">';
				}
				html += '<div class="info fix"><a href="order_detail.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&orderState='+$('#status_items').find('input:checked').data('value')+'"><div class="info_main l">';
				html += '<p class="info_title"><span class="star_status dib"><i class="ion">&#xe6cc;</i></span><span>'+title+'</span></p>';
				html += '<p class="per_info"><span class="name">'+orderUser+'</span><span class="date">'+createDate+'</span></p></div></a>';
				html += '<a href="tel:'+contactTel+'" class="tel r"><i class="ion">&#xe611;</i></a></div>';
				html += '<div class="newest_track fix"><p class="l track_title">最近跟踪记录</p><div class="l track_info">';
				html += '<p class="track_name"><i class="ion">&#xe623;</i><span>跟踪人：</span><span>'+receiveMan+'</span></p>';
				html += '<p class="track_time"><i class="ion">&#xe656;</i><span>'+recordDate+'</span></p></div>';
				html += '<a href="order_detail.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&orderState='+$('#status_items').find('input:checked').data('value')+'" class="r confirm_btn">'+orderStatename+'</a></div>';
				html += '</li>';
				
				
			});

			resultAll.append(html);
		}
	});
		$('.mui-pull-bottom-pocket').remove();
		$('.mui-scrollbar').remove();
	}
	//进页面首次加载一次数据
	Initialization();
	function Initialization() {
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'factory_tagged_list' ,
			uid : $('#uid').val(),//154
			trackState: $('#orderState').val(),
			pageNum : 1 ,
			pageSize : 10
		},

		dataType: "json",

		success: function(json){
			var html='',id='',title='',receiveMan='',orderUser='',createDate='',isTagged='',recordDate='',orderStatename='',contactTel='';
			var order=json.result;
			$.each(order, function(idx) {
				id=order[idx]["orderId"];
				title=order[idx]["orderTitle"];
				receiveMan=order[idx]["receiveMan"];
				orderUser=order[idx]["orderUser"];
				createDate=order[idx]["createDate"];
				isTagged=order[idx]["isTagged"];
				recordDate=order[idx]["recordDate"];
				orderStatename=order[idx]["orderStatename"];
				contactTel=order[idx]["contactTel"];
				
				if(isTagged===1){
					html += '<li class="section act">';
				}else{
					html += '<li class="section">';
				}
				html += '<div class="info fix"><a href="order_detail.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&orderState='+$('#status_items').find('input:checked').data('value')+'"><div class="info_main l">';
				html += '<p class="info_title"><span class="star_status dib"><i class="ion">&#xe6cc;</i></span><span>'+title+'</span></p>';
				html += '<p class="per_info"><span class="name">'+orderUser+'</span><span class="date">'+createDate+'</span></p></div></a>';
				html += '<a href="tel:'+contactTel+'" class="tel r"><i class="ion">&#xe611;</i></a></div>';
				html += '<div class="newest_track fix"><p class="l track_title">最近跟踪记录</p><div class="l track_info">';
				html += '<p class="track_name"><i class="ion">&#xe623;</i><span>跟踪人：</span><span>'+receiveMan+'</span></p>';
				html += '<p class="track_time"><i class="ion">&#xe656;</i><span>'+recordDate+'</span></p></div>';
				html += '<a href="order_detail.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&orderState='+$('#status_items').find('input:checked').data('value')+'" class="r confirm_btn">'+orderStatename+'</a></div>';
				html += '</li>';
				
				
			});

			$('#list').html(html);
		}
	});
		
	}
	mui('body').on('tap','a',function(){document.location.href=this.href;});
})