$(function(){
	var root=window.location.protocol+"//"+window.location.host;
	//返回键
	$('.back').on('tap',function(){
		window.history.back();
	})
	//main部分滑动控制
	var windowHeight = $(window).height(),
	headerHeight = window.getComputedStyle(document.getElementsByClassName('header')[0]).height,
	mainHeight = windowHeight - parseFloat(headerHeight);
	$('.main').css('height',mainHeight+'px');

	//状态选择弹窗
	$('.choose_btn').on('tap',function(){
		$('.mask').removeClass('hide');
		$('.status_choose').removeClass('hide');
	})
	//状态选择弹窗关闭
	$('body').on('tap','.close_btn',function(){
		$('.mask').addClass('hide');
		$('.status_choose').addClass('hide');
	})
	//状态选择 弹窗内点选提交
	$('body').on('tap','.cho_confirm',function(){
		var op = $('.cho_items').find('input:checked');
		if(!op.length){
			mui.toast('请选择状态！');
			return false;
		}
		console.log(op.data('value'));
		if(op.data('value')=='102009'){
			$('#lossReason').removeClass('hide');
		}
		$('#orderState').val(op.data('value'));
		$('.choose_btn').find('span').text(op.parent().find('label').html());
		$('.mask').addClass('hide');
		$('.status_choose').addClass('hide');
	})
	
	//流失原因选择 弹窗
	$('.loss_btn').on('tap',function(){
		$('.loss_mask').removeClass('hide');
		$('.loss_choose').removeClass('hide');
	})
	//流失原因选择 弹窗关闭
	$('body').on('tap','.loss_close_btn',function(){
		$('.loss_mask').addClass('hide');
		$('.loss_choose').addClass('hide');
	})
	//流失原因选择 弹窗内点选提交
	$('body').on('tap','.loss_confirm',function(){
		var op = $('.loss_items').find('input:checked');
		if(!op.length){
			mui.toast('请选择状态！');
			return false;
		}
		console.log(op.data('value'));
		if(op.data('value')=='103001'){
			$('#lossBrand').removeClass('hide');
		}
		$('#lostReason').val(op.data('value'));
		$('.loss_btn').find('span').text(op.parent().find('label').html());
		$('.loss_mask').addClass('hide');
		$('.loss_choose').addClass('hide');
	})
	
	
	//订单信息读取
	$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'order_detail' ,
			form_id : $('#orderId').val() 
		},

		dataType: "json",

		success: function(json){
			var html='',receiveDate='',orderStatename='';
			
			if(json.result.orderState=='102009'){
				$('#lossReason').removeClass('hide');
			}
			if(json.result.runOffFlag=='103001'){
				$('#lossBrand').removeClass('hide');
			}

			$('#createDate').html(json.result.createDate);
			$('#orderTitle').html(json.result.orderTitle);
			$('#orderUser').html(json.result.orderUser);
			$('#contactAddress').html(json.result.contactAddress);
			$('#contactTel').html(json.result.contactTel);
			$('#contactTel').parent().attr('href','tel:'+json.result.contactTel); 
			$('#orderStatename').html(json.result.orderStatename);
			$('#appRemark').val(json.result.appRemark);
			$('#brand').val(json.result.brand);
			$('#orderState').val(json.result.orderState);
			$('#lostReason').val(json.result.runOffFlag);

			//遍历订单状态
			$("input[name='status']").each(function(){
				if(json.result.orderState==$(this).data('value')){
					$(this).prop("checked",true);
					$('.choose_btn').find('span').text($(this).parent().find('label').html());
				}
			});
			//遍历流失原因
			$("input[name='reason']").each(function(){
				if(json.result.runOffFlag==$(this).data('value')){
					$(this).prop("checked",true);
					$('.loss_btn').find('span').text($(this).parent().find('label').html());
				}
			});
			
			var record=json.result.recordList;
			$.each(record, function(idx) {
				receiveDate=record[idx]["receiveDate"];
				orderStatename=record[idx]["orderStatename"];
			
				html += '<div class="step fix">';	
				html += '<div class="step_time l"><p class="date">'+receiveDate+'</p></div>';
				html += '<div class="point l"><i class="ion">&#xe830;</i></div>';
				html += '<div class="step_msg l pr">'+orderStatename+'</div>';
				html += '</div>';	


			});
				
			$('.status_img').append(html);
			//跟踪状态中间线长度控制
			var stepLength = $('.step').length,
			topPo =  $('.step').eq(0).offset().top,
			bottomPo =  $('.step').eq(stepLength-1).offset().top,
			lineHeight = bottomPo - topPo;
			$('.line').css('height',lineHeight+'px');
		}
	});
	
	//订单提交
	$('body').on('tap','.subBtn',function(){
		$.ajax({

		type: "GET",

		url: root + "/tools/mobileInterface.jsp",

		data : {
			flag : 'personnel_order_detail' ,
			form_id : $('#orderId').val() ,
			orderState : $('#orderState').val(),
			lostReason : $('#lostReason').val(),
			brand : $('#brand').val(),
			appRemark : $('#appRemark').val()
		},

		dataType: "json",

		success: function(json){
			alert(json.msg);
			location.reload();
		}
	});
	})
})