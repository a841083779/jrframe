$(function() {
	var pageIndex=1;
	var isLoaded = true;
	$('.cat_condition .con_right').on('click', '.con_item',function(){
		var self = $(this);
		var left_con = $('.con_item.all');
		if (left_con.hasClass('on')) {
			left_con.removeClass('on');
		}
		
		/**if(!self.hasClass('on')){
			self.addClass('on');
		}else{
			self.removeClass('on');
		}**/
		self.addClass('on').siblings().removeClass('on');
		//统计选中项
		var selected_str='';
		var all_item = $('.cat_condition').find('.con_item');
		all_item.each(function(){
			if($(this).hasClass('on')){
				selected_str+=$(this).attr('data-id')+"@_@";
			}
		})
		if(selected_str!='' && selected_str.indexOf('@_@')>=0){
			selected_str=selected_str.substring(0,selected_str.length-3);
		}
		//console.log(selected_str);
		pageIndex=1;
		$.ajax({
			    url:'action/ajax.jsp?flag=moreModel&pageIndex='+pageIndex+'&cat='+selected_str,
			    async:false,
			    cache:false,
			    success:function(data){
				    if($.trim(data)!=''){
				    	$('#list').html($.trim(data));
						isLoaded =true;
						
		            }
			    }
		    });
	})
	
	$('.con_item.all').on('click',function(){
		var self = $(this);
		var left_con = $('.cat_condition .con_right').find('.con_item');
		left_con.removeClass('on');
		
		if(!self.hasClass('on')){
			self.addClass('on');
		}
		pageIndex=1;
		$.ajax({
			    url:'action/ajax.jsp?flag=moreModel&pageIndex='+pageIndex,
			    async:false,
			    cache:false,
			    success:function(data){
				    if($.trim(data)!=''){
				    	$('#list').html($.trim(data));
						isLoaded =true;
						
		            }
			    }
		    });
	})

	
	//监听是否到底部
	window.onload = function(){
    window.onscroll = function(){
		console.log('in gundong');
    	//检查垂直滚动条是否到底部
    	//var pageHeight = $('body').height()-$(window).height(),
    	//scrollHeight = document.documentElement.scrollTop;
		var selected_str='';
		var all_item = $('.cat_condition').find('.con_item');
		all_item.each(function(){
			if($(this).hasClass('on')){
				selected_str+=$(this).attr('data-id')+"@_@";
			}
		})
		if(selected_str!='' && selected_str.indexOf('@_@')>=0){
			selected_str=selected_str.substring(0,selected_str.length-3);
		}
		var viewHeight=$(window).height();
		var docHeight=$('.pro_list').height();
		var _scroll=$(window).scrollTop();
		//if(pageHeight-scrollHeight<=20){
		if(viewHeight+_scroll>=docHeight){
			console.log('in 加载');
			if(!isLoaded){
				return false;
			}
			isLoaded = false;
			pageIndex++;
			console.log("---"+pageIndex+"----");
			$.ajax({
			    url:'action/ajax.jsp?flag=moreModel&pageIndex='+pageIndex+'&cat='+selected_str,
			    async:false,
			    cache:false,
			    success:function(data){
				    if($.trim(data)!=''){
				    	$('#list').append($.trim(data));
						isLoaded =true;
						
		            }
			    }
		    });
		}
	}}
	
})