$(function(){
	/**
	*初始化
	*/
	//留言列表 最新
	$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: "newMessageList",
				uid: $('#openId').val()
			},
			success: function(data) {
				if($.trim(data)!=''){
					$('.com_new').html($.trim(data));
				}else{
					$('.com_new').html('<div class="no_msg">暂无留言</div>');
				}
			}
		});
	//留言列表 热门
	$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: "hotMessageList",
				uid: $('#openId').val()
			},
			success: function(data) {
				if($.trim(data)!=''){
					$('.com_hot').html($.trim(data));
				}else{
					$('.com_hot').html('<div class="no_msg">暂无留言</div>');
				}
			}
		});
	
	/**
	 * 按钮动画
	 */
	var inner = -50,center = 0,outer = 0;
	var btnbiling = setInterval(function(){
		inner++;
		center = inner+50,
		outer = inner+100;
		$('.send_btn').css({
			'background':'radial-gradient(circle,rgba(188,128,254,.9) '+inner+'%,rgba(176,249,245,.9)'+center+'%, rgba(188,128,254,.9) '+outer+'%)'
		})
		if(inner == 100){inner=-50;}
	},20)
	
	/**
	 * tab切换
	 */
	 var thisItem = 0,
	 bodyHei=0;
	$('.com_tab').on('click','a',function(){
		$(this).addClass('act').siblings().removeClass('act');
		$('.com_page').eq($(this).index()).removeClass('hide').siblings().addClass('hide');
		thisItem = $(this).index();
		bodyHei = $('body').height()-$(window).height()-$('.com_tab').height();
	})
	/**
	 * 提示框 开启/关闭
	 */
	$('.close_it').on('click',function(){
		$(this).parents('.tip_mask').fadeOut(function(){
			$(this).addClass('hide');
		});
	})
	

	//留言提交
	$('.send_btn').on('click',function(){
		if($("#content").val()==''){
				$('.el').html('留言内容不能为空！');
				$('.tip_mask').fadeIn().removeClass('hide');
				return false;
		}
		$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: "saveMessage",
				nickName:$('#nickName').val(),
				headImg:$('#headImg').val(),
				openId:$('#openId').val(),
				content:$('#content').val()
			},
			success: function(data) {
				if($.trim(data)=='success'){
					//评论内容置空
					$('#content').val('');
					//刷新两个评论列表
					//留言列表 最新
					$.ajax({
							url: 'action/ajax.jsp',
							data: {
								flag: "newMessageList",
								uid: $('#openId').val()
							},
							success: function(data) {
								if($.trim(data)!=''){
									$('.com_new').html($.trim(data));
								}else{
									$('.com_new').html('<div class="no_msg">暂无留言</div>');
								}
							}
						});
					//留言列表 热门
					$.ajax({
							url: 'action/ajax.jsp',
							data: {
								flag: "hotMessageList",
								uid: $('#openId').val()
							},
							success: function(data) {
								if($.trim(data)!=''){
									$('.com_hot').html($.trim(data));
								}else{
									$('.com_hot').html('<div class="no_msg">暂无留言</div>');
								}
							}
						});
				}
			}
		});	
		
	})
	//留言点赞
	/**
	 * 点赞
	 */
	$('.com_page').on('click','.com_good',function(){
		var messageId = $(this).data('id');
		var that = $(this);
		if(that.hasClass('on')){
			$.ajax({
				url : 'action/ajax.jsp',
				data : {
					flag : 'digMessage',
					uid : $('#openId').val(),
					messageId : messageId
				},
				success : function(data){
					if($.trim(data)=='success'){
						that.removeClass('on');
						that.find('p').html(parseInt(that.find('p').html())+1);
						//赞完 刷新留言列表
						$.ajax({
							url: 'action/ajax.jsp',
							data: {
								flag: "newMessageList",
								uid: $('#openId').val()
							},
							success: function(data) {
								if($.trim(data)!=''){
									$('.com_new').html($.trim(data));
								}else{
									$('.com_new').html('<div class="no_msg">暂无留言</div>');
								}
							}
						});
						$.ajax({
							url: 'action/ajax.jsp',
							data: {
								flag: "hotMessageList",
								uid: $('#openId').val()
							},
							success: function(data) {
								if($.trim(data)!=''){
									$('.com_hot').html($.trim(data));
								}else{
									$('.com_hot').html('<div class="no_msg">暂无留言</div>');
								}
							}
						});
					}else if($.trim(data)=='repeat'){
						$('.el').html('您已经赞过这条留言了！');
						$('.tip_mask').fadeIn().removeClass('hide');
					}else{
						$('.el').html('操作失败！');
						$('.tip_mask').fadeIn().removeClass('hide');
					}
				}
			});
			
		}else{
			$('.el').html('您已经赞过这条留言了！');
			$('.tip_mask').fadeIn().removeClass('hide');
		}
	})
	
	
	
})
