/**
 * 
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	var com=require('./common');
	//
	console.log('about.js')
	
	//优买团
	$('.tuanList .tuanBox:first').stop().animate({width:519},'fast');
	$('.tuanList .tuanBox').mouseenter(function(){
		$(this).stop().animate({width:519},'fast').siblings().stop().animate({width:227},'fast');
	});
	//优惠活动按钮
	$('body').on('mouseenter','.tuan_main_list li',function(){
	     $(this).find('.dinggou').attr('src','/images/dinggou2.png')
	})
	$('body').on('mouseleave','.tuan_main_list li',function(){
	     $(this).find('.dinggou').attr('src','/images/dinggou1.png')
	})
	/*
	$('.tuan_main_list li').mouseenter(function(){
	    $(this).find('.dinggou').attr('src','/images/dinggou2.png')
	})
	$('.tuan_main_list li').mouseleave(function(){
	    $(this).find('.dinggou').attr('src','/images/dinggou1.png')
	})
	*/
	
	
jQuery("#tuan_form").Validform({
	tiptype:3,
	ajaxPost:true ,
	beforeSubmit:setUpdated,
	callback:function(data){
		if(data!=null && data!=""){
			alert("提交成功！");
			if(data.status=="y"){
				jQuery("#input:not(:hidden),textarea").val("") ;
				setTimeout("window.location.reload();",2000)
			}
		}
	}
}) ;

function setUpdated(){
	var tuan = jQuery.cookies.get("tuan_online");
	if(tuan==null || tuan == ""){  
		expireDate = new Date();
		expireDate.setTime( expireDate.getTime() + ( 60 * 1000 ) );
		jQuery.cookies.set("tuan_online","one",{expiresAt:expireDate});
		return true;
	}else{
		alert("请勿重复提交！");
		return false;	
	}
}


	var win=$(window),sTimer,
		container =$('#tuan_list');
	win.scroll(function scrollHandler(){
		clearTimeout(sTimer);
		sTimer = setTimeout(function(){
			if(win.loaded == 1){win.unbind("scroll", scrollHandler);}
			var t=win.scrollTop(),
			h=win.height(),
			t1= container.offset().top, 
			h1= container.outerHeight(true) ;
			if(t+h >= t1+h1){
				getList(4)
				}
		},100);
	});
	
	function getList(n){
		base.toload('/action/ajax.jsp?flag=tuan_list', 4, {"dataType":"html","item":"001"}, function(data){ 
		  $('#tuan_list').append(data);
		});
	};
	
	/*
	$('#load_more').click(function(e){
		e.preventDefault();
		getList();
	})
    */
		
})

