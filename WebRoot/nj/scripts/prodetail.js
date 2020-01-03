//详细页大数据
jQuery(function(){
if (window.jereiReceiver) {
var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
_jrTracker.setCustomProperty("product", [$("#zd_product_id").val(),$("#zd_factoryname").val()+$("#zd_product_name").val()+$("#zd_cataname").val(),$("#zd_catanum").val(),$("#zd_factoryid").val()]);
_jrTracker.track();
}

}) ;


jQuery(document).ready(function(){
	jQuery(".select-con a.more").click(function(){
		jQuery(this).prev("span").slideToggle(1)
		.siblings(".more-con:visible").slideUp(1);
		jQuery(this).toggleClass("active");
		jQuery(this).siblings(".active").removeClass("active");
	});
});

jQuery(function(){
	jQuery("#closebtn").click(function(){
		jQuery("#closebtn").css("display","none");
		jQuery("#cmpContainer").css("display","none");
		jQuery("#openbtn").css("display","block");
		jQuery("#divShowCarCompare").css("width", "23px");
		$.cookies.set("compareOpenFlag", "close");
	});
	jQuery("#openbtn").click(function(){
		jQuery("#closebtn").css("display","block");
		jQuery("#cmpContainer").css("display","block");
		jQuery("#openbtn").css("display","none");
		jQuery("#divShowCarCompare").css("width", "310px");
		$.cookies.set("compareOpenFlag", "open");
	});
	jQuery("span.sh_cli a").click(function(){
		jQuery(".fipop_cont").css("display","block");
	});
	jQuery("#clearbtn").click(function(){
		jQuery(".fipop_cont").css("display","none");
	});
	
	jQuery(window).scroll(function () {
        if (jQuery("#paraTipInfo").size() > 0) {
            var st = jQuery(window).scrollTop(), sth = st + jQuery(window).height();
            var post = jQuery("#paraTipInfo").offset().top;
            var posb = post + jQuery("#paraTipInfo").height();
            var teltop = jQuery("#detailsInfo").offset().top + document.getElementById("detailsInfo").offsetHeight;
            if ((post > st && post < sth) || (posb > st && posb < sth)) {
                jQuery(".contecttelephonbottom").hide();
            } else {
                if (st > teltop) {
                    jQuery(".contecttelephonbottom").show();
                } else {
                    jQuery(".contecttelephonbottom").hide();
                }
            }
        }
    });
  })


 function submitYN(event) {
	var factoryname=$("#zd_factoryname").val(); 
	var pro_id=jQuery("#zd_product_id").val();
	if (window.jereiReceiver) { 
    var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
    //_jrTracker.track(); 
	_jrTracker.trackFmSubmit("详细页询价单",pro_id); 
	_jrTracker.trackEvent("询价", "提交询价", factoryname, 1); 
    }
	var mobile_phone_reg = /^1[3458][0-9]\d{8}$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	if(jQuery("#zd_city").val()==''){
			jQuery.jBox.tip("选择城市") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}

	var other_message="";
	var other_list=document.getElementsByName("other_message");
        var objarray=other_list.length;
        for (i=0;i<objarray;i++){
            if(other_list[i].checked == true){
                other_message+=other_list[i].value+",";
            }
     }
	jQuery.ajax({
		url : '/nj/action/ajax.jsp',
		async : false,
					type : 'post',
					data : {
						flag : 'get_city_name',
						city : jQuery("#zd_city").val()
					},
					success : function(data){
							jQuery("#zd_city").val(city= $.trim(data)) ;
					}
	});

	  jQuery("#theform").ajaxSubmit({
	 	type:'post',
	    url:'/nj/action/detail_order_save.jsp' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='rand'){
			    jQuery.jBox.tip("您提交的过于频繁，请稍后再试!") ;
			}else{
			    jQuery.jBox.tip("您的询价信息已成功提交，我们将及时联系您进行报价！!") ;
                if (window.jereiReceiver) { 
	            var pro_id=jQuery("#zd_product_id").val();
                var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
            //    _jrTracker.track(); 
	            _jrTracker.trackFmFinish("详细页询价单",pro_id); 
                }
	    	SetCookie("order_name",jQuery("#zd_name").val()) ;
		    SetCookie("order_phone",jQuery("#zd_mobile_phone").val()) ;
	    	jQuery("#rand").val("") ;
	        setTimeout("window.location.reload()",1000);
            }
	    }
	 }) ;
   return false ;
}

 


	//询价城市选择
	$.fn.tab=function(){
		var $key=$(this).find('.city_key'),
			 $val=$(this).find('.city_val');
		$key.first().addClass('cur');
		$val.first().show();
		$key.each(function(index){
			$(this).click(function(event){
				event.preventDefault();
				$(this).addClass('cur').siblings().removeClass('cur');
				$val.hide().eq(index).show();
				})
			})
		};
	$('.citybox_tab').each(function() { $(this).tab()});
	
	$('.cityboxbtn').click(function(e) {
		$(this).addClass('cityboxbtn_on');
		$('.citybox').show();
	});
	
	$('.city_val_01 .cityshow span').click(function(e) {
		var pro_id=jQuery("#zd_product_id").val();
		var prov = $(this).data('province');
		var prov_noe=prov.split('***');
		var area_id=prov_noe[1];
		$('#zd_province').val(prov_noe[0]);/*省份*/
		$('.city_key_01').html(prov_noe[0]);
		$('.city_key_01').removeClass('cur');
		$('.city_key_02').addClass('cur');
		$('.city_val_01').hide();
		$('.city_val_02').show();
		jQuery.ajax({
					url : '/tools/ajax_city.jsp',
					async : false,
					type : 'post',
					data : {
						flag : 'get_city_new',
						p : area_id
					},
					success : function(data){
						$("#zd_citys").html($.trim(data));	
						$('#zd_citys span').click(function(e) {
								var city = $(this).data('city');
								$('#zd_city').val(city);/*城市*/
								$('.city_key_02').html(city);
								var prov = $('.city_key_01').html();
								$('.city_key_02').removeClass('cur');
								$('.city_key_01').addClass('cur');
								$('.city_val_02').hide();
								$('.city_val_01').show();
								$('.cityboxbtn .tadd_p').html(prov);
								$('.cityboxbtn .tadd_c').html(city);
								$('.citybox').hide();
								$('.cityboxbtn').removeClass('cityboxbtn_on');
						});
					}
				});
		//大数据相关事件
		if (window.jereiReceiver) { 
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		 _jrTracker.trackFmTry("详细页询价单",pro_id,"省市",$("#zd_province").val()+$("#zd_city").val()) ;
        }
	});
	
	
	$('.city_close').click(function(e) {
		$('.citybox').hide();
		$('.cityboxbtn').removeClass('cityboxbtn_on');
	});
	
	//大数据相关事件
	$('#zd_name').focus(function(e) {
		if (window.jereiReceiver) { 
		var pro_id=jQuery("#zd_product_id").val();
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 

	    _jrTracker.trackFmTry("详细页询价单",pro_id,"姓名") ;
        }
	});
	$('#zd_name').blur(function(e) {
		if (window.jereiReceiver) { 
		var pro_id=jQuery("#zd_product_id").val();
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		 _jrTracker.trackFmFill("详细页询价单",pro_id,"姓名",$("#zd_name").val()) ;
        }
	});
	$('#zd_mobile_phone').focus(function(e) {
		if (window.jereiReceiver) { 
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		var pro_id=jQuery("#zd_product_id").val();
				console.log("打印:"+pro_id);
	    _jrTracker.trackFmTry("详细页询价单",pro_id,"电话") ;
        }
	});
	$('#zd_mobile_phone').blur(function(e) {
		if (window.jereiReceiver) { 
		var pro_id=jQuery("#zd_product_id").val();
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		 _jrTracker.trackFmFill("详细页询价单",pro_id,"电话",$("#zd_mobile_phone").val()) ;
        }
	});
	

	
    $('#jclose').click(function(e) {
		if (window.jereiReceiver) { 
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
	      _jrTracker.trackEvent("询价", "关闭询价", $("#zd_factoryname").val(), 1); 
        }
	});
		

	//右侧弹出询价框
	function submitYNS(event) {
	var factoryname=$("#jr_factoryname").val(); 
	var pro_id=jQuery("#jr_product_id").val();
	if (window.jereiReceiver) { 
    var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
    //_jrTracker.track(); 
	_jrTracker.trackFmSubmit("详细页询价单",pro_id); 
	_jrTracker.trackEvent("询价", "提交询价", factoryname, 1); 
    }
	 
	var mobile_phone_reg = /^1[34578][0-9]\d{8}$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#jr_name").val() || jQuery("#jr_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#jr_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#jr_mobile_phone").val() || jQuery("#jr_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#jr_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#jr_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#jr_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#jr_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#jr_mobile_phone").focus();
			jQuery("#jr_mobile_phone").select(); 
		},
		10);
		return false;
	}

	if(jQuery("#jr_city").val()==''||jQuery("#jr_city").val().indexOf("选择")>=0){
			jQuery.jBox.tip("请选择城市") ;
			jQuery("#jr_city").focus() ;
		     return false ;
	}


	jQuery("#theform_right").ajaxSubmit({
	 	type:'post',
	    url:'/nj/action/save.jsp' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='rand'){
			    jQuery.jBox.tip("您提交的过于频繁，请稍后再试!") ;
			}else{
			   jQuery.jBox.tip("您的询价信息已成功提交，我们将及时联系您进行报价！!") ;
            if (window.jereiReceiver) { 
	            var pro_id=jQuery("#jr_product_id").val();
                var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
                //_jrTracker.track(); 
	            _jrTracker.trackFmFinish("详细页询价单",pro_id); 
            }
	    	SetCookie("order_name",jQuery("#jr_name").val()) ;
		    SetCookie("order_phone",jQuery("#jr_mobile_phone").val()) ;
	    	jQuery("#rand").val("") ;
	        setTimeout("window.location.reload()",1000);
            }
	    }
	 }) ;
     return false ;
     }