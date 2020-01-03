<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
    /*通用的活动付款代码*/
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";  String id="";  String phone="";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
		id = CommonString.getFormatPara(memberInfo.get("id"));
		phone = CommonString.getFormatPara(memberInfo.get("telephone"));
	}
	 /*通用的活动付款代码*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特挖掘机优惠促销-工程机械优惠活动-优买团-铁臂商城</title>
<meta name="keywords" content="卡特挖掘机优惠促销，工程机械优惠活动" />
<meta name="description" content="卡特彼勒机型争霸江湖，总有一款随你笑看风云，买工程机械就来铁臂商城4006-521-526" /> 
<link href="/tuan/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
<script>
/*通用的活动付款代码*/
function pay(pid){
		window.open("/member/order_submit.jsp?id="+pid);
}
/*通用的活动付款代码*/	
</script>
</head>
<body>
<jsp:include page="/tuan/top_index.jsp" flush="true"/>
<div class="head"></div>
<div class="part1">
  <div class="wrap  clearfix">
    <div class="l u_info">
	     <form action="action.jsp" method="post" name="theform1" id="theform1">
      <ul>

        <li><a href="javascript:void(0)"<%	if(username.equals("")){ %>onclick="login();"<%}else{%> onclick="pay('21883');"<%}%>  class="btn">立即下单</a></li>
      </ul> 
	  	 <input name = "zd_factoryname" type="hidden" id="zd_factoryname" value="卡特彼勒"/>
         <input name = "zd_product_name" type="hidden" id="zd_product_name" value="306E"/>
         <input type="hidden" name="zd_cataname" id="zd_cataname" value="挖掘机" />
         <input type="hidden" name="zd_product_id" id="zd_product_id" value="20164" />
         <input type="hidden" name="zd_factoryid" id="zd_factoryid" value="174" />
         <input type="hidden" name="zd_catanum" id="zd_catanum" value="101001" /> 
	  </form>
    </div>
    <a  href="http://product.21-sun.com/proDetail/306E.shtm" target="_blank"    class="r img_lk"></a> </div>
</div>

<div class="foot">
  <jsp:include page="/include/foot.jsp" flush="true"/>
  <script src="http://pv.21-sun.com/http/stat.jsp" type="text/javascript"></script> 
</div>
</body>
</html>
<script type="text/javascript" src="/tuan/scripts/comm.js"></script>
<!-- jbox -->
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript">
function showinquery(pid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid+"&factoryid="+factoryid, {
		
	title: "在线询价",
	width: 769,
	height: 600,
	top: '20%',
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
}


//提交订单
function submit( a ){
   var name='';  var phone='';    var proid='';   var proname='';  var rs='1';
   if(a==1){
    		 name = $("#name1").val();
			 phone = $("#phone1").val();
			 proid='20164';
			 proname='306E';
   }
   if(a==2){
    		 name = $("#name2").val();
			 phone = $("#phone2").val();
			 proid='400';
			 proname='320DGC/320D/320DL';
   }
   if(a==3){
    		 name = $("#name3").val();
			 phone = $("#phone3").val();
			 proid='9552';	
             proname='349D/349DL';			 
   }
   if(name==''){
				alert("请填写姓名！");
				rs='0';
				return false;
   }
   if(phone==''){
				alert("请填写手机号码！");
				rs='0';
				return false;
   }

               jQuery("#theform"+a).ajaxSubmit({
				//$.ajax({
		        //url:'action.jsp',
				//data:'zd_name='+name+'&zd_mobile_phone='+phone+'&zd_product_id='+proid+'&zd_factoryname=卡特彼勒&zd_cataname=挖掘机&zd_factoryid=174&zd_catanum=101001&zd_product_name='+proname,
				type : "POST",
				success : function(data){
			     if(jQuery.trim(data)=='no'){
				   alert("询价失败！") ;
				    jQuery("#content").val("") ;
		            jQuery("#content").focus() ; 
				   return ;
				}
				if(jQuery.trim(data)=='0'){
				   alert("询价失败！") ;
				   return ;
				}
					alert("询价成功！");
                    setTimeout("window.location.reload()",1000);
				}					  
			});	

			


 
}
</script>