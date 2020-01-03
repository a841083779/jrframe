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
			flag : 'personnel_province_list' ,
			uid : $('#uid').val()// 
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
	
	//星标操作
	$('body').on('tap','.star_status',function(){
		var flag = "";
		var li_class=$(this).closest('li').attr("class");

		if(li_class.indexOf("act") < 0){//标记星标
			flag = "personnel_doTag";
		}else{//取消星标
			flag = "personnel_cancelTag";
		}

		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : flag ,
			form_id : $(this).attr("data-id")
		},

		dataType: "json",

		success: function(json){
			$('.msg').html(json.msg);
			if(json.data==='true'){
				if(li_class.indexOf("act") < 0){
					$(this).closest('li').addClass('act');
				}else{
					$(this).closest('li').removeClass('act');
				}
			}
			
		}
	});
		$('.recieve').removeClass('hide');
		$('.mask').removeClass('hide');
	})
	//点击'知道了'关闭
	//$('body').on('tap','.know_success',function(){
	//	$('.recieve').addClass('hide');
	//	$('.mask').addClass('hide');
	//})
	
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
			flag : 'personnel_tagged_list' ,
			uid : $('#uid').val(),//476 
			trackState: $('#orderState').val(),
			province: $('#province').val(),
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
				html += '<div class="info fix"><div class="info_main l">';
				html += '<p class="info_title"><span class="star_status dib" data-id="'+id+'"><i class="ion">&#xe6cc;</i></span><a href="order_detail_edit.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&province='+$('#province_items').find('input:checked').data('value')+'&orderState='+$('#status_items').find('input:checked').data('value')+'"><span>'+title+'</span></a></p>';
				html += '<a href="order_detail_edit.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&province='+$('#province_items').find('input:checked').data('value')+'&orderState='+$('#status_items').find('input:checked').data('value')+'"><p class="per_info"><span class="name">'+orderUser+'</span><span class="date">'+createDate+'</span></p></a></div>';
				html += '<a href="tel:'+contactTel+'" class="tel r"><i class="ion">&#xe611;</i></a></div>';
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
			flag : 'personnel_tagged_list' ,
			uid : $('#uid').val(),//476 
			trackState: $('#orderState').val(),
			province: $('#province').val(),
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
				html += '<div class="info fix"><div class="info_main l">';
				html += '<p class="info_title"><span class="star_status dib" data-id="'+id+'"><i class="ion">&#xe6cc;</i></span><a href="order_detail_edit.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&province='+$('#province_items').find('input:checked').data('value')+'&orderState='+$('#status_items').find('input:checked').data('value')+'"><span>'+title+'</span></a></p>';
				html += '<a href="order_detail_edit.jsp?id='+id+'&source='+source+'&ywId='+$('#uid').val()+'&province='+$('#province_items').find('input:checked').data('value')+'&orderState='+$('#status_items').find('input:checked').data('value')+'"><p class="per_info"><span class="name">'+orderUser+'</span><span class="date">'+createDate+'</span></p></a></div>';
				html += '<a href="tel:'+contactTel+'" class="tel r"><i class="ion">&#xe611;</i></a></div>';
				html += '</li>';
				
				
			});

			$('#list').html(html);
		}
	});
		
	}
	mui('body').on('tap','a',function(){document.location.href=this.href;});
	mui('body').on('tap','.know_success',function(){
		$('.recieve').addClass('hide');
		$('.mask').addClass('hide');
		location.reload();
	});
})