
	$.ajax({
			url:'/tools/ajax.jsp',
			data:{
				flag:'proView',
				proId:$('#zd_product_id').val()
			},
			success:function(data){
				
			}
		});
 
//对比
var viewWidth=document.documentElement.clientWidth;
showCookie();
isCompared(); 
function compareEqupment(id){
	var count = $("#cmpContent li").length;
	if(count>=4){
		alert("只能四款机型进行对比！");
		$.cookies.set("compareOpenFlag", "close");//设置flag

	}else{
		addShowNew(id);
	}
}

function clearAllCompare(){
	$("#cmpContent li").each(function(){
    	$(this).remove();
		var id =  $(this).attr("id").replace("comp_","");
		delIsCompared(id);
	}); 
	$.cookies.set('compareArr',"");
	//$.cookies.set("compareOpenFlag", "close");//设置flag
	//closeCompare();//关闭对比框
}

function removeOne(id){
	removeShow(id); 
	delCookie(id);
	//$.cookies.set("compareOpenFlag", "close");//设置flag
}

function addCookie(id){
	var compareStr = $.cookies.get('compareArr');
	$.cookies.set("compareOpenFlag", "open");//设置flag
	if(typeof(compareStr)!=undefined && compareStr!=null  && compareStr!="null" && compareStr.length>2){
		if(compareStr.indexOf(id)<0){
			openCompare();//展开对比框
			compareStr +=","+id;
			addIsCompared(id);
		}
	}else{
			openCompare();//展开对比框
			compareStr +=","+id;
			addIsCompared(id);
	
	}
	$.cookies.set('compareArr',compareStr);
}

/*
    $('#xjbox').mouseleave(function(){
        $('#xjbox').css('display','none');
    });   
	$('#divShowCarCompare').mouseleave(function(){
        $('#divShowCarCompare').css('display','none');   
    });
*/


function delCookie(id){
	var compareStr = $.cookies.get('compareArr');
	compareStr = compareStr.replace(","+id,"");	
	$.cookies.set('compareArr',compareStr);
	delIsCompared(id);
	if($("#cmpContent li").length<1){
		//closeCompare();//关闭对比框
	}
}
function showCookie(){
	var compareStr = $.cookies.get('compareArr');
	if(typeof(compareStr)!="undefined" && compareStr!="undefined" && compareStr!=null && compareStr!="null" && compareStr.length>1){
		//alert("123");
		openCompare();//展开对比框
		var arr = compareStr.split(",");
		var length = arr.length>4?4:arr.length;
		for(var i=1;i<length;i++){
			//alert("1");
			addShow(arr[i]);
		}
	}else{
		closeCompare();//关闭对比框
	}
}

function addShow(id){
	var url = "/action/ajax.jsp";
	jQuery.ajax({
			url : url,
			data : {
				flag : 'compareShow',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#cmpContent").append(data);
					}
			}
		});
}
function addShowNew(id){
	var compareStr = $.cookies.get('compareArr');
	if(typeof(compareStr)!=undefined && compareStr!=null  && compareStr!="null"){
	if(compareStr.indexOf(id)<0){
	var url = "/action/ajax.jsp";
	jQuery.ajax({
		url : url,
		data : {
			flag : 'compareShow',
			equiId : id
		},
		success : function(data) {
			if($.trim(data)!=""){
			    $("#cmpContent").append(data);
			    addCookie(id);
			    //alert("111");
			    if($('#xjbox').css('display','block')){
		            $('#xjbox').css('display','none');
		            $('#xjbox').css('right','-600px');
	            }
				$(".fipop_cont").css("display", "block");
		        $("#cmpContainer").css("display", "block");
		        $("#closebtn").css("display", "block");
	            $('.fiopen').css('display','none');
	            $('#divShowCarCompare').css('display','block');
				$('#divShowCarCompare').css('width',function(){ return (viewWidth-1200)/2+285;});
	            //startMove(oCom_wrap,{right:0});
	            $('#divShowCarCompare').css('position','fixed');			
			}else{

			}
		}
	});
	}else{             
	    $(".fipop_cont").css("display", "block");
		$("#cmpContainer").css("display", "block");
		$("#closebtn").css("display", "block");
		$("#openbtn").css("display", "none");
		$('#divShowCarCompare').css('width',function(){ return (viewWidth-1200)/2+285;});
		if($('#xjbox').css('display','block')){
				$('#xjbox').css('display','none');
				$('#xjbox').css('right','-600px');
			}
	    $('.fiopen').css('display','none');
	    $('#divShowCarCompare').css('display','block');
	    //startMove(oCom_wrap,{right:0});
	    $('#divShowCarCompare').css('position','fixed');
	}
	}else{
		var url = "/action/ajax.jsp";
	    jQuery.ajax({
			url : url,
			data : {
				flag : 'compareShow',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#cmpContent").append(data);
						addCookie(id);
					}else{
					
					}
			}
		});
	}
}
function removeShow(id){
	$("#comp_"+id).remove();
}
// 展开对比框
function openCompare() {
	var openFlag = $.cookies.get('compareOpenFlag');
	if(openFlag=="open"){
		if($('#xjbox').css('display','block')){
				$('#xjbox').css('display','none');
				$('#xjbox').css('right','-600px');
			}
		jQuery(".fipop_cont").css("display", "block");
		$("#cmpContainer").css("display", "block");
		$("#openbtn").css("display", "none");
		$("#closebtn").css("display", "block");
		$('.fiopen').css('display','none');
		$('#divShowCarCompare').css('display','block');
		$('#divShowCarCompare').css('width',function(){ return (viewWidth-1200)/2+285;});
		//startMove(oCom_wrap,{right:0});	
		$('#divShowCarCompare').css('position','fixed');
	}else{
		closeCompare();
	}
}
// 关闭对比框
function closeCompare() {
	jQuery(".fipop_cont").css("display", "block");
	$("#cmpContainer").css("display", "none");
	$("#openbtn").css("display", "block");
	$("#closebtn").css("display", "none");
	$("#divShowCarCompare").css("width", "23px");
}

//已加入对比
function isCompared(){
	$("#openbtn").css("display", "block");
	$("#cmpContent li").each(function(){
		var idStr =  $(this).attr("id").replace("comp_","");
		$("#Car"+idStr).removeClass("sh_cli");
		$("#Car"+idStr).addClass("sh_cot");
		$("#a_"+idStr).text("已对比");
	}); 
	$("#divShowCarCompare").css("width", "0px");
	$("#divShowCarCompare").css("display", "none");
}
// 加入对比
function addIsCompared(id) {
	$("#Car" + id).addClass("dbcur");
	$("#Car" + id).html('<a class="db-btn" href="javascript:void(0);" id="a_'+id+'">已对比</a>');

}
// 删除对比
function delIsCompared(id) {
	$("#Car" + id).removeClass("dbcur");
	$("#Car" + id).html('<a class="db-btn" href="javascript:void(0);" id="a_'+id+'" onclick=compareEqupment("'+id+'");>加入对比</a>');
}﻿﻿

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
		$('#divShowCarCompare').css('width',function(){ return (viewWidth-1200)/2+285;});
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
function submitCompare(){
	var compareStr = $.cookies.get('compareArr');
	compareStr = compareStr.replace("undefined","");
	var ids = compareStr.replace(",","");
	if((ids.split(",")).length>=2){
		ids= ids.replace("null","");
		window.open("/compares/index.jsp?pids="+ids);
	}else{
		alert("最少需要两款机型进行对比");
	}
 }

 function submitYN(event) {
	var factoryname=$("#zd_factoryname").val(); 
	var pro_id=jQuery("#zd_product_id").val();
	var mobile_phone_reg = /^1[3456789][0-9]\d{8}$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		alert("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		alert("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	if(jQuery("#zd_city").val()==''){
			alert("选择城市") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}
	/*
 	if($.trim($("#zd_buy_time").val()) == ""){
 		$.jBox.tip("请选择预计购买时间！");
 		$("#zd_buy_time").focus();
 		return false;
 	}
	if (null == jQuery("#zd_buy_type").val() || jQuery("#zd_buy_type").val().length == 0) {
		jQuery.jBox.tip("请输入您的付款方式!");
		setTimeout(function() {
			jQuery("#zd_buy_type").focus();
		},
		0);
		return false;
	}
	*/
	var other_message="";
	var other_list=document.getElementsByName("other_message");
        var objarray=other_list.length;
        for (i=0;i<objarray;i++){
            if(other_list[i].checked == true){
                other_message+=other_list[i].value+",";
            }
     }
	jQuery.ajax({
		url : '/action/ajax.jsp',
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
    jQuery("#zd_other_message").val(other_message) ;
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	  jQuery("#theform").ajaxSubmit({
	 	type:'post',
	    url:'/action/detail_order_save.jsp' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='rand'){
			    alert("您提交的过于频繁，请稍后再试!") ;
			}else{
			    alert("您的询价信息已成功提交，我们将及时联系您进行报价！!") ;
 
	    	$.cookies.set("order_name",jQuery("#zd_name").val()) ;
		    $.cookies.set("order_phone",jQuery("#zd_mobile_phone").val()) ;
	    	jQuery("#rand").val("") ;
	        //setTimeout("window.location.reload()",1000);
			jQuery("#zd_name").val("");
			jQuery("#zd_mobile_phone").val("");
			jQuery("#zd_province").val("");
			jQuery("#zd_city").val("");
            }
	    }
	 }) ;
   return false ;
}


 function submitYN(event) {
	var factoryname=$("#zd_factoryname").val(); 
	var pro_id=jQuery("#zd_product_id").val();
	var mobile_phone_reg = /^1[3456789][0-9]\d{8}$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		alert("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		alert("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	if(jQuery("#zd_city").val()==''){
	 
	}
	/*
 	if($.trim($("#zd_buy_time").val()) == ""){
 		$.jBox.tip("请选择预计购买时间！");
 		$("#zd_buy_time").focus();
 		return false;
 	}
	if (null == jQuery("#zd_buy_type").val() || jQuery("#zd_buy_type").val().length == 0) {
		jQuery.jBox.tip("请输入您的付款方式!");
		setTimeout(function() {
			jQuery("#zd_buy_type").focus();
		},
		0);
		return false;
	}
	*/
	var other_message="";
	var other_list=document.getElementsByName("other_message");
        var objarray=other_list.length;
        for (i=0;i<objarray;i++){
            if(other_list[i].checked == true){
                other_message+=other_list[i].value+",";
            }
     }
	jQuery.ajax({
		url : '/action/ajax.jsp',
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
    jQuery("#zd_other_message").val(other_message) ;
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	  jQuery("#theform").ajaxSubmit({
	 	type:'post',
	    url:'/action/detail_order_save.jsp' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='rand'){
			    alert("您提交的过于频繁，请稍后再试!") ;
			}else{
			    alert("您的询价信息已成功提交，我们将及时联系您进行报价！!") ;
 
	    	$.cookies.set("order_name",jQuery("#zd_name").val()) ;
		    $.cookies.set("order_phone",jQuery("#zd_mobile_phone").val()) ;
	    	jQuery("#rand").val("") ;
	        //setTimeout("window.location.reload()",1000);
			jQuery("#zd_name").val("");
			jQuery("#zd_mobile_phone").val("");
			jQuery("#zd_province").val("");
			jQuery("#zd_city").val("");
            }
	    }
	 }) ;
   return false ;
}


   
   
    function inquiryMul(event) {
	var factoryname=$("#zd_factoryname").val(); 
	var pro_id=jQuery("#zd_product_id").val();
	var mobile_phone_reg = /^1[3456789][0-9]\d{8}$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#uname").val() || jQuery("#uname").val().length == 0) {
		alert("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#uname").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#uphone").val() || jQuery("#uphone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#uphone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#uphone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#uphone').attr("value"))&&!connect_reg.test(jQuery('#uphone').attr("value")))) {
		alert("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#uphone").focus();
			jQuery("#uphone").select(); 
		},
		10);
		return false;
	}
	if(jQuery("#zd_city").val()==''){
	 
	}
	/*
 	if($.trim($("#zd_buy_time").val()) == ""){
 		$.jBox.tip("请选择预计购买时间！");
 		$("#zd_buy_time").focus();
 		return false;
 	}
	if (null == jQuery("#zd_buy_type").val() || jQuery("#zd_buy_type").val().length == 0) {
		jQuery.jBox.tip("请输入您的付款方式!");
		setTimeout(function() {
			jQuery("#zd_buy_type").focus();
		},
		0);
		return false;
	}
	*/
	var other_message="";
	var other_list=document.getElementsByName("other_message");
        var objarray=other_list.length;
        for (i=0;i<objarray;i++){
            if(other_list[i].checked == true){
                other_message+=other_list[i].value+",";
            }
     }
	jQuery.ajax({
		url : '/action/ajax.jsp',
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
	jQuery("#zd_name").val(jQuery("#uname").val());
	jQuery("#zd_mobile_phone").val(jQuery("#uphone").val());
    jQuery("#zd_other_message").val(other_message) ;
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	  jQuery("#theform").ajaxSubmit({
	 	type:'post',
	    url:'/action/detail_order_save.jsp' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='rand'){
			    alert("您提交的过于频繁，请稍后再试!") ;
			}else{
			    alert("您的询价信息已成功提交，我们将及时联系您进行报价！!") ;
 
	    	$.cookies.set("order_name",jQuery("#zd_name").val()) ;
		    $.cookies.set("order_phone",jQuery("#zd_mobile_phone").val()) ;
	    	jQuery("#rand").val("") ;
	        //setTimeout("window.location.reload()",1000);
			jQuery("#zd_name").val("");
			jQuery("#zd_mobile_phone").val("");
			jQuery("#zd_province").val("");
			jQuery("#zd_city").val("");
            }
	    }
	 }) ;
   return false ;
}