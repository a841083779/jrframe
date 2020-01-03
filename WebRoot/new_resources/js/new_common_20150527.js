$.fn.inputholder=function(){
	var dval=$(this).val();
	$(this).focus(function(){
		$(this).val('').addClass('focus');
		}).blur(function(){
		if($(this).val()==''){
			$(this).val(dval).removeClass('focus');
			}
		});
	};
var inputholder=$('.inputholder');
if(inputholder.length){
	inputholder.each(function() {
      $(this).inputholder()
   })
};
$('.imgEff').find('img').hover(function(){
	$(this).stop(1,1).animate({opacity:0.7},160);
},function(){
	$(this).stop(1,1).animate({opacity:1},160);
});

//全部分类
$("a.CloseAllBtn").click(function(){
	$(".nav_proCate").removeClass("bigBtnCur");
	return false;
});

$(".nav_proCate").children('.n').click(function(){
	   var par = $(this).parent();
	   var cls = par.attr("class");
	   if(cls.indexOf("bigBtnCur")!=-1){
		   par.removeClass("bigBtnCur");
	   }else{
		   par.addClass("bigBtnCur");
	   }
 });


//topbar layer
$('.j_mobile,.j_service,.j_siteNav').mouseenter(function(){
	$(this).addClass('j_hover');
}).mouseleave(function(){
	$(this).removeClass('j_hover');
});
$('.j_proNav').mouseenter(function(){
	$(this).addClass('j_proNav_hover');
}).mouseleave(function(){
	$(this).removeClass('j_proNav_hover');
});

//选项卡
$.fn.tab=function(){
	var $key=$(this).find('.j_tab_key'),
		 $val=$(this).find('.j_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.j_tab').each(function() { $(this).tab()});
$.fn.tab=function(){
	var $key=$(this).find('.t_tab_key'),
		 $val=$(this).find('.t_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.t_tab').each(function() { $(this).tab()});



/*top搜索*/
if($('.txd_pssele').length!=0){
	$('.txd_pssele').sele({
		act: "click",               // 触发下拉动作，可选 click | mouseenter
		callback: function(value, text) {  // 选中下拉a标签的回调，@param(_val, _text)
		  //alert('选中了value：'+value+'，text：'+text)
		}
	});
}

/*登陆记住密码start*/
var arr = document.cookie.split(";"); 
var menber_name='';
var member_pass=''; 
for(var i=0,len=arr.length;i<len;i++){  
        var item = arr[i].split("="); 
       if(item[0].indexOf('memberInfo')!='-1'){
	      var member_info=$.trim(item[1].split(","));
		  var members=member_info.split("%40%40%40");
		  menber_name=members[0];
		  member_pass=members[1];
	   }
    }  
	if(menber_name!=''&&member_pass!=''){
	  $("#login_username").val(menber_name);
	  $("#login_password").val(member_pass);
	  $('#rememberPass').attr("checked","checked");
	  $('#rememberPass').val("1");
	  }
var backUrl = '';
jQuery(function(){
	jQuery("#rememberPass").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
		  $('#rememberPass').val("1");
		}else{
		  $('#rememberPass').val("0");
		  
		}
	});
})
/*登陆记住密码end*/
/*登陆start*/
function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#login_username").val())+'&p='+encodeURI(jQuery("#login_password").val())+'&l='+encodeURI(jQuery("#rememberPass").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout(function(){
	 	 	       parent.window.location.reload();
	 	        },1000) ;
				
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}
/*登陆end*/

