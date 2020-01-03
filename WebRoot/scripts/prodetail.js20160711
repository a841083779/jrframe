//详细页大数据
jQuery(function(){
if (window.jereiReceiver) {
var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
_jrTracker.setCustomProperty("product", [$("#zd_product_id").val(),$("#zd_factoryname").val()+$("#zd_product_name").val()+$("#zd_cataname").val(),$("#zd_catanum").val(),$("#zd_factoryid").val()]);
_jrTracker.track();
}

}) ;

//发表口碑
function writeKoubei(a,b,c,d){
	    jQuery.jBox("iframe:/include/koubei_page/koubei_write_pro.jsp?a="+a+"&b="+b+"&c="+c+"&d="+d, {
		title: "发表口碑信息",
		width: 720,
		height: 380,
		iframeScrolling : 'no',
		buttons: { '关闭': false }
		});
		jQuery(".jbox-button-panel").attr("style","display:none;") ;
		jQuery(".jbox-close").css("backgroundImage","url(/plugin/dialog/jBox/Skins/GreyBlue/images/jbox-close1.gif)");
}


//请求代理商报价
$('.txd_dlp_dllist').find('._btn').on('click',function(){
	showinquery();
	return false;
})	
function showinquery(pid,factoryid){
	var factoryname=$("#zd_factoryname").val();
	if (window.jereiReceiver) { 
    var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
     _jrTracker.trackEvent("询价", "点击询价", factoryname, 1); 
    }
	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid+"&factoryid="+factoryid, {	
	title: "在线询价",
	width: 769,
	height: 600,
	top: '10%',	
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
}	


//投票
function vote(id){
        var result=$("#vote_"+id).html();
		result=result.replace("(","").replace(")","");
		var help = parseInt(result);
		if(setlooked(id)==1){
			$.ajax({
			  url: "/action/ajax.jsp?flag=koubeiHelp&id="+id,
			  cache: false,
			  async: true,
			  success: function(html){
			  }
			});
			$("#vote_"+id).html("("+(help+1)+")");
			$.jBox.tip('感谢您的支持！');
		}else{
			$.jBox.tip('您已经投过票了哟！');
		}
}
function setlooked(id){
		var x = 0;
		var imgs = jQuery.cookies.get("help_imgs");
		if(imgs==null || imgs == "" || imgs.indexOf("help"+id) < 0){
			var newImgs = imgs+",help"+id;
			jQuery.cookies.set("help_imgs",newImgs,{hoursToLive : 10});
			x = 1;
		}
		return x;
}
 
//对比
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
		            $('#xjbox').css('right','-328px');
	            }
	            $('.fiopen').css('display','none');
	            $('#divShowCarCompare').css('display','block');
	            startMove(oCom_wrap,{right:0});
	            $('#divShowCarCompare').css('position','fixed');			
			}else{

			}
		}
	});
	}else{             
	    $(".fipop_cont").css("display", "block");
		$("#cmpContainer").css("display", "block");
		$("#closebtn").css("display", "block");
		$("#divShowCarCompare").css("width", "310px");
		$('#xjbox').css('display','none');
		$('#xjbox').css('right','0px');
	    $('.fiopen').css('display','none');
	    $('#divShowCarCompare').css('display','block');
	    startMove(oCom_wrap,{right:0});
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
		jQuery(".fipop_cont").css("display", "block");
		$("#cmpContainer").css("display", "block");
		$("#openbtn").css("display", "none");
		$("#closebtn").css("display", "block");
		$("#divShowCarCompare").css("width", "310px");		
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
			    jQuery.jBox.tip("您提交的过于频繁，请稍后再试!") ;
			}else{
			    jQuery.jBox.tip("您的询价信息已成功提交，我们将及时联系您进行报价！!") ;
                if (window.jereiReceiver) { 
	            var pro_id=jQuery("#zd_product_id").val();
                var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
                //_jrTracker.track(); 
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

    //询价代理商
    var nowBrand = '0';
    var nowBrandName = '';
	var nowCatalog = '0';
	var nowCatalogName = '';
	var nowProvince = '';
	var nowCity = '';
	function zaiXianXunJia(id){
	    var  product_id= jQuery("#zd_product_id").val();
		var  product_name= jQuery("#zd_product_name").val();
	    var  catalogname= jQuery("#zd_cataname").val();
	    var  catalognum= jQuery("#zd_catanum").val();
	    var  factoryname= jQuery("#zd_factoryname").val();
	    var  factoryid= jQuery("#zd_factoryid").val();
		var url = '/include/agent/enquiry.jsp?id='+id;
		if(product_id!=''){
			url += "&product_id="+product_id;
		}
		if(product_name!=''){
			url += "&product_name="+product_name;
		}
		if(catalogname!=''){
			url += "&cataname="+catalogname;
		}
		if(catalognum!=''){
			url += "&catanum="+catalognum;
		}
		if(factoryname!=''){
			url += "&factoryname="+factoryname;
		}
		if(factoryid!=''){
			url += "&factoryid="+factoryid;
		}
		if(nowBrand!=''){
			url += "&nowBrand="+nowBrand;
		}
		if(nowBrandName!=''){
			url += "&nowBrandName="+nowBrandName;
		}
		if(nowCatalog!=''){
			url += "&nowCatalog="+nowCatalog;
		}
		if(nowCatalogName!=''){
			url += "&nowCatalogName="+nowCatalogName;
		}
		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 210,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
    }
	
	//评论提交	
	function doComments(){
		var rs = Validator.Validate(document.getElementById("comment_form"),1);
		if(rs){
		   var  content = jQuery.trim(jQuery("#content").val()) ;
		   if(content!=content.replace(/<\/?[^>]*>/g,'').replace('&lt','').replace('&gt','') || (content.indexOf("www.")!=-1 || content.indexOf("http:")!=-1)){
		       alert('您的评论内容不符合规则，请重新输入!') ;	
		       jQuery("#content").val("") ;
		       jQuery("#content").focus() ;
		        return false ;
		   }
			jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
			jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
			jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
			jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);
			jQuery("#comment_form").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
					if($.trim(data)=="login"){
						login();
					}else{
						alert("评论提交成功！");
						window.location.reload();
					}
					
				}					  
			});
		}
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
	
	

	$('#zd_buy_time').change(function(e) {
		var buy=($(this).children('option:selected').val()); 
		var buy_time="";
		if(buy=="102007"){buy_time="1个周内";}
		else if(buy=="102001"){buy_time="1个月内";}
		else if(buy=="102002"){buy_time="1—3个月";}
		else if(buy=="102003"){buy_time="4—6个月";}
		else if(buy=="102004"){buy_time="7—12个月";}
		else if(buy=="102005"){buy_time="1年后";}
		else if(buy=="102006"){buy_time="不确定";}
		if (window.jereiReceiver) { 
		var pro_id=jQuery("#zd_product_id").val();
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		 _jrTracker.trackFmFill("详细页询价单",pro_id,"购买时间",buy_time) ;
        }
	});
	
	$('#zd_buy_type').change(function(e) {
	
		if (window.jereiReceiver) { 
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		var pro_id=jQuery("#zd_product_id").val();
		 _jrTracker.trackFmFill("详细页询价单",pro_id,"购买方式",$(this).children('option:selected').val()) ;
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
	if(jQuery("#jr_province").val()==''||jQuery("#jr_province").val().indexOf("选择")>=0){
			jQuery.jBox.tip("请选择省份") ;
			jQuery("#jr_province").focus() ;
		     return false ;
	}
	if(jQuery("#jr_city").val()==''||jQuery("#jr_city").val().indexOf("选择")>=0){
			jQuery.jBox.tip("请选择城市") ;
			jQuery("#jr_city").focus() ;
		     return false ;
	}
	/*
 	if($.trim($("#jr_buy_time").val()) == ""){
 		$.jBox.tip("请选择预计购买时间！");
 		$("#jr_buy_time").focus();
 		return false;
 	}
	if (null == jQuery("#jr_buy_type").val() || jQuery("#jr_buy_type").val().length == 0) {
		jQuery.jBox.tip("请输入您的付款方式!");
		setTimeout(function() {
			jQuery("#jr_buy_type").focus();
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
    jQuery("#jr_other_message").val(other_message) ;
	jQuery("#jr_contact_address").val(jQuery("#jr_province").val()+jQuery("#jr_city").val()) ;
	jQuery("#theform_right").ajaxSubmit({
	 	type:'post',
	    url:'/action/save.jsp' ,
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