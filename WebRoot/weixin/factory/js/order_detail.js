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
			$('#runOffFlagname').html(json.result.runOffFlagname);
			$('#agentName').html(json.result.agentName);
			$('#brand').html(json.result.brand);
			$('#appRemark').html(json.result.appRemark);
			
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
})