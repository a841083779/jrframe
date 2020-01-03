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
	mainHeight = windowHeight - parseFloat(footerHeight) - parseFloat(headerHeight) - parseFloat(navHeight);
	$('.main').css('height',mainHeight+'px');
//	$('#list').css('height',mainHeight+'px');
	//接收
	$('body').on('tap','.unacp_btn',function(){
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
			flag : 'agent_stateNum' ,
			uid : $('#uid').val()//12626 
		},

		dataType: "json",

		success: function(json){
			$('#unfinished_num').html(json.unHandleNum);
			$('#track_num').html(json.inTrackNum);
			$('#deal_num').html(json.dealNum);
			$('#loss_num').html(json.lossNum);
			$('#mark_num').html(json.markNum);
			if(parseInt(json.provinceNum)<2){
				$('#track_province').addClass('hide');
			}
		}
	});
	
	//获取负责订单区域
	$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'agent_province_list' ,
			uid : $('#uid').val()//12626  
		},

		dataType: "json",

		success: function(json){
			var provinces=json.result;	
			var html='<div class="item"><input type="radio" name="province" data-value="" checked="checked"/><label>全部</label></div>';
			$.each(provinces, function(idx) {
				html += '<div class="item"><input type="radio" name="province" data-value="'+provinces[idx]+'" /><label>'+provinces[idx]+'</label></div>';
			})
			$('#province_items').html(html);
			
			if($('#province').val()!=''){//区域选择
				$("#province_items .item").find("input[name='province']").each(function(){
					if($('#province').val()==$(this).attr("data-value")){
						$(this).prop("checked", "checked");
					}
				});
				$('.ts_province').find('span').text($('#province_items').find('input:checked').parent().find('label').html());
			}
		}
	});
	
	//订单区域选择弹窗
	//状态选择弹窗
	$('.ts_province').on('tap',function(){
		$('.mask').removeClass('hide');
		$('.province_choose').removeClass('hide');
	})
	//弹窗关闭
	$('body').on('tap','.close_btn_province',function(){
		$('.mask').addClass('hide');
		$('.province_choose').addClass('hide');
	})
	//弹窗内点选提交
	$('body').on('tap','.cho_confirm_province',function(){
		var op = $('#province_items').find('input:checked');
		if(!op.length){
			mui.toast('请选择区域！');
			return false;
		}
		console.log(op.data('value'));
		$('#province').val($('#province_items').find('input:checked').attr('data-value'));
		Initialization();
		$('.ts_province').find('span').text(op.parent().find('label').html());
		$('.mask').addClass('hide');
		$('.province_choose').addClass('hide');
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
		mui('#main').pullRefresh().endPullupToRefresh(false); //参数为true代表没有更多数据了。(++count > 6)
		var resultAll = $('#list');
		var resultDetail = $('.section');
		
		++count;
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'agent_order_list' ,
			uid : $('#uid').val(),//12626 
			orderState: -1 ,
			province: $('#province').val(),
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
				html += '<a href="order_detail.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&province='+$('#province_items').find('input:checked').data('value')+'"><div class="info l"><p class="info_title"><span class="star_status dib"><i class="ion">&#xe6cc;</i></span><span>'+title+'</span></p>';
				html += '<p class="charger"><span>负责人：</span><span>'+receiveMan+'</span></p>';
				html += '<p class="tracker"><span>'+orderUser+'</span><span>'+createDate+'</span></p></div></a>';
				html += '<div class="btns r fix">';
				html += '</div></li>';

			});

			resultAll.append(html);
		}
	});
		
		$('.mui-pull-bottom-pocket').remove();
		$('.mui-scrollbar').remove();
	}
	//进页面首次加载一次数据
	Initialization();
	function Initialization(){
		$.ajax({

			type: "GET",

			url: root + "/tools/mobileInterface.jsp",

			data : {
				flag : 'agent_order_list' ,
				uid : $('#uid').val(),//12626 
				orderState: -1 ,
				province: $('#province').val(),
				pageNum : 1 ,
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
					html += '<a href="order_detail.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&province='+$('#province_items').find('input:checked').data('value')+'"><div class="info l"><p class="info_title"><span class="star_status dib"><i class="ion">&#xe6cc;</i></span><span>'+title+'</span></p>';
					html += '<p class="charger"><span>负责人：</span><span>'+receiveMan+'</span></p>';
					html += '<p class="tracker"><span>'+orderUser+'</span><span>'+createDate+'</span></p></div></a>';
					html += '<div class="btns r fix">';
					html += '</div></li>';

				});

				$('#list').html(html);
			}
		});
	}
	mui('body').on('tap','a',function(){document.location.href=this.href;});
})