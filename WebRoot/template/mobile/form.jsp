﻿<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("pid"))) ;  // 产品
	product_id=product_id.replaceAll(",","");
	String zd_factoryname="";
	String zd_product_name="";
	String zd_cataname="";
	String zd_factoryid="";
	String zd_catalognum="";
    Map one_proform = dbHelper.getMap("  select  id,factoryname,catalogname,name,factoryid,catalognum from pro_products where id="+product_id);
	
	if(one_proform !=null && one_proform.get("id") != null){
	  zd_factoryname=CommonString.getFormatPara(one_proform.get("factoryname"));
	  zd_product_name=CommonString.getFormatPara(one_proform.get("name"));
	  zd_cataname=CommonString.getFormatPara(one_proform.get("catalogname"));
	  zd_factoryid=CommonString.getFormatPara(one_proform.get("factoryid"));
	  zd_catalognum=CommonString.getFormatPara(one_proform.get("catalognum"));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>

<script type="text/javascript" src="http://product.21-sun.com/scripts/rememberAccount.js"></script>


<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<title>铁臂商城</title>
<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body class="brands">
<header>
  <h2 class="logo"><a href="/"><img src="Static/img/logo.png" alt="铁臂商城"></a></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a>
  <a href="/brands_list.jsp" class="search">筛选<img src="Static/img/search_ico.png"></a>
</header>

<div class="form">
<strong>想了解&nbsp;&nbsp;<%=zd_factoryname+zd_product_name+zd_cataname%>&nbsp;&nbsp;最低价？请填写如下信息，销售经理将直接与您联系最低价？请填写如下信息，销售经理将直接与您联系</strong>
  <form action="/action/order_save_mobiles.jsp" method="post" name="form1" id="form1" >    <ul class="f1">
      <li><strong class="n">姓名</strong>
        <input type="text" name="zd_name" id="zd_name" value="请输入您的姓名" class="inputholder">
      </li>
      <li style="border:0;"><strong class="n">电话</strong>
        <input type="text" name="zd_mobile_phone" id="zd_mobile_phone" value="请输入您的电话" class="inputholder">        
      </li>
    </ul>
    <div class="btn">
      <a href="javascript:void(0)" onclick="submitYN(this);" style="font-size:18px" >获取最低价</a>
    </div>
	
	      <input name = "zd_factoryname" type="hidden" id="zd_factoryname" value="<%=zd_factoryname%>"/>
          <input name = "zd_product_name" type="hidden" id="zd_product_name" value="<%=zd_product_name%>"/>
         <input type="hidden" name="zd_cataname" id="zd_cataname" value="<%=zd_cataname%>" />
         <input type="hidden" name="zd_product_id" id="zd_product_id" value="<%=product_id%>" />
         <input type="hidden" name="zd_factoryid" id="zd_factoryid" value="<%=zd_factoryid%>" />
         <input type="hidden" name="zd_catanum" id="zd_catanum" value="<%=zd_catalognum%>" />



  </form>
</div>

<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="#"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
<%@ include file="hm.jsp" %>
<%
_HMT _hmt = new _HMT("68a002ecc1238a0d146069ac0b00940e");
_hmt.setDomainName("m.product.21-sun.com");
_hmt.setHttpServletObjects(request, response);
String _hmtPixel = _hmt.trackPageview();
%>

<%@ include file="cs.jsp" %>
<%CS cs = new CS(5923031);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  />
<img src="<%= _hmtPixel %>" width="0" height="0"  />
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('app/product.js');
	
	
	function submitYN(event) {
	


	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	
	var  content = jQuery.trim(jQuery("#zd_message").val()) ;
		   if(content!=content.replace(/<\/?[^>]*>/g,'').replace('&lt','').replace('&gt','') || (content.indexOf("www")!=-1 || content.indexOf("http")!=-1)){
		       //alert('您的留言内容不符合规则，请重新输入!') ;	
		      // jQuery("#zd_message").val("") ;
		      // jQuery("#zd_message").focus() ;
		        //return false ;
    }
	
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
	if(jQuery("#zd_ifgroup").val()=='公司'){
		if(jQuery("#zd_company").val()=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").focus() ;
		     return false ;
		}
	} 

	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	//jQuery("#form1").submit() ;
  				jQuery("#form1").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
			     if(jQuery.trim(data)=='no'){
				   alert("您输入的内容中含有敏感词，请重新输入") ;
				    jQuery("#content").val("") ;
		            jQuery("#content").focus() ; 
				   return ;
				}
					alert("询价成功！");
					//getComment();
					jQuery("#form1").clearForm();
		
				}					  
			});

}

jQuery(function(){
	var order_name = jQuery.trim(unescape(GetCookie("order_name"))) ;  // 订单人
    var order_phone = jQuery.trim(GetCookie("order_phone")) ;  // 订单电话
    if(''!=order_name && null!=order_name && "null"!=order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_phone){
    	jQuery("#zd_mobile_phone").val(order_phone) ;
    }
})
</script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://"); document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F68a002ecc1238a0d146069ac0b00940e' type='text/javascript'%3E%3C/script%3E")); </script>
</html>