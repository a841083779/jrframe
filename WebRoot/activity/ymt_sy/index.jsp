<%@page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
String url  = CommonString.getFormatPara(request.getHeader("referer")) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>抢大红包，提前过年！---三一“压得快”系列压路机 首发狂欢</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.21-sun.com">
<link href="static/ui/ui.css" rel="stylesheet">
<link href="style/style.css" rel="stylesheet">
<!--<script>
if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
	window.location.href="http://m.21-sun.com/";//匹配到移动端网站
	}
</script>-->
</head>

<body>
<div class="header">
  <div class="wrap fix">
    <a href="http://product.21-sun.com/tuan/" target="_blank"><h1 class="logo l">铁臂优买团--尽享优惠，为您而省！</h1></a>
    <span class="servTel r"></span>
  </div>
</div>
<div class="banner">
  <div class="banner-top center-pos"><img src="static/images/banner.jpg" /></div>
  <div class="banner-bot">
    <div class="banner-tip center-pos"><img src="static/images/banner_tip.jpg" /></div>
    <div class="banner-des"><img src="static/images/banner_des.jpg" /></div>
  </div>
</div>
<div class="main">
  <div class="main-title">
    <h3>-活动产品-</h3>
    <p>施工效率高、综合性能好、动力强劲</p>
  </div>
  <div class="pro-list">
    <ul class="fix">
      <li>
        <a href="http://product.21-sun.com/proDetail/SSR200AC-8.shtm" target="_blank"><img src="images/pro_1.jpg" alt="SSR200AC-8全液压单驱单钢轮压路机" /></a>
        <div class="pro-infor fix">
          <span class="pro-tip l">首发预售价</span>
          <h3 class="pro-price l"><i>&yen;</i>33.8万<span>(预付认筹金再享3重优惠)</span></h3>
          <span class="pri-price r">&yen;39万</span>
        </div>
        <div class="buy-btn fix"><a class="order-btn r" id="order_0">立即预定</a></div>
      </li>
      <li>
        <a href="http://product.21-sun.com/proDetail/SSR220AC-8.shtm" target="_blank"><img src="images/pro_2.jpg" alt="SSR220AC-8全液压单驱单钢轮压路机" /></a>
        <div class="pro-infor fix">
          <span class="pro-tip l">首发预售价</span>
          <h3 class="pro-price l"><i>&yen;</i>34.8万<span>(预付认筹金再享3重优惠)</span></h3>
          <span class="pri-price r">&yen;40万</span>
        </div>
        <div class="buy-btn fix"><a class="order-btn r" id="order_1">立即预定</a></div>
      </li>
    </ul>
  </div>
  <div class="wechat-share fix">
    <div class="wechat-box l">
      <img src="static/images/wechat.jpg" /><br />立即推荐给好友
    </div>
    <div class="wechat-des r">
      <h3>推荐有礼</h3>
      <p>凡推荐朋友全款购买SSR200/220AC-8压路机，推荐人可获得1000元现金奖励。购买成功后，联系在线客服领取。</p>
    </div>
  </div>
  <div class="activity-des">
    <h3>-活动说明-</h3>
    <p><span class="des-name">活动时间</span><span class="des-cont"><i>2016年12月13日-2017年01月15日</i></span></p>
    <p><span class="des-name">活动对象</span><span class="des-cont">支付千元认筹金并<i>全款购机</i>的客户可享3重优惠。</span></p>
    <p><span class="des-name">关于认筹金</span><span class="des-cont">缴纳的认筹金，可在<i>2017年3月31日</i>之后申请退款。</span></p>
    <p><span class="des-name">发货时间</span><span class="des-cont"><i>2017年1月15日之后。可工厂自提，</i>代发货需自行承担运费。</span></p>
    <p><span class="des-name">优惠说明</span><span class="des-cont">“千元认筹享3重好礼”仅限活动时间内前31位全款成交客户。</span></p>
  </div>
</div>
<div class="footer">
  <div class="wrap">
    <div class="footLeft l"> <a href="http://www.21-sun.com/service/guanggao/index.htm" target="_blank">广告服务</a><em>|</em> <a href="http://aboutus.21-sun.com/contact/" target="_blank">联系方式</a><em>|</em> <a href="http://www.jerei.com/" target="_blank">关于我们</a><em>|</em> <a href="http://www.jerei.com/news/index-list-0.htm" target="_blank">本网动态</a><em>|</em> <a href="http://www.jerei.com/contact/legal.jsp" target="_blank">法律声明</a><em>|</em> <a href="http://aboutus.21-sun.com/map.htm" target="_blank">网站导航</a><em>|</em> <a href="http://aboutus.21-sun.com/contact/" target="_blank">联系客服</a> </div>
    <div class="footRight r">产品询价专线：4006-521-526<em>|</em><a href="http://www.21-sun.com" target="_blank">中国工程机械商贸网</a> © copyright 2000-
      <script type="text/javascript">document.write((new Date()).getFullYear());</script>
    </div>
  </div>
</div>


<div class="form-box">
  <form action="action/action.jsp" method="post" name="theform" id="theform" >
    <label>-产品订购-</label>
    <span><i>*</i>产品型号：</span><select name="proType" id="proType"><option data-value="SSR200AC-8">SSR200AC-8</option><option data-value="SSR220AC-8">SSR220AC-8</option></select><br />
    <span><i>*</i>姓名：</span><input type="text" name="zd_name" id="zd_name" /><br />
    <span><i>*</i>联系电话：</span><input type="text" datatype="m" name="zd_mobile_phone"  id="zd_mobile_phone" errormsg="请输入正确的11位手机号" /><br />
    <div class="fix"><span class="l"><i>*</i>区域：</span>
		<div id="citySelect" class="city-select l"><select class="prov"></select><select class="city" disabled="disabled"></select></div>
		<input type="hidden" name="zd_province" id="zd_province" value="">
        <input type="hidden" name="zd_city" id="zd_city" value="">
		<input type="hidden" name="zd_contact_address" id="zd_contact_address" value=""/>
	</div>
    <input type="submit" name="submitBtn" id="submitBtn"  onclick="submitYN();"  value="" />
	
	<input type="hidden" name="zd_agentid" id="zd_agentid" value="" />
    <input type="hidden" name="zd_factoryid" id="zd_factoryid" value="" />
    <input type="hidden" name="zd_factoryname" id="zd_factoryname" value=""/>
	<input type="hidden" name="zd_product_id" id="zd_product_id" value=""/>
    <input type="hidden" name="zd_product_name" id="zd_product_name" value=""/>
    
    <input type="hidden" name="zd_cataname" id="zd_cataname" value="" />
    <input type="hidden" name="zd_catanum" id="zd_catanum" value=""/>
    <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
    <input type="hidden" name="zd_referer" id="zd_referer" value="<%=url %>" />
    <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
    <input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
	<input type="hidden" name="zd_message" id="zd_message" value="" />

  </form>
  <div class="close-btn animated"></div>
</div>
<div class="wechat">
  <img src="static/images/wechat.jpg" alt="扫一扫查看手机版">
  <p>扫描查看手机版</p>
</div>
<div  style="display:none;">
<script src="http://s95.cnzz.com/z_stat.php?id=1261006347&web_id=1261006347" language="JavaScript"></script>
</div>
</body>
<script src="static/lib/jquery/jquery.js"></script>
<!--<script src="static/lib/cityselect/city.min.js"></script>-->
<script src="static/lib/cityselect/jquery.cityselect.js"></script>
<script src="static/lib/validator/wofoshan/validator.min.js" ></script>
<script src="static/lib/validator/rjboy/Validform_v5.3.1.js"></script>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" charset="GB2312" ></script>
<script src="js/index.js"></script>
</html>

<script>
function submitYN(){
var prov=remote_ip_info.province;
var cityv=remote_ip_info.city;
$.extend($.Datatype,{
			"m" : /^1[34578]\d{9}$/
		});
$.Tipmsg.r=null;
$("#theform").Validform({
			tipSweep:true,
		 	ajaxPost : true,
			beforeCheck : function(){
				if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
					alert("请输入您的姓名!");
					setTimeout(function() { jQuery("#zd_name").focus(); }, 0);
					return false;
				}
				if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
					alert("请输入您的手机号！");
					setTimeout(function() { jQuery("#zd_mobile_phone").focus(); }, 10);
					return false;
				}
				if(jQuery("#zd_province").val()==''){
						alert("请选择省份");
						jQuery(".prov").focus() ;
						 return false ;
				}
				if(jQuery("#zd_city").val()==''||jQuery("#zd_city").val()=='-请选择-'){
						alert("请选择城市");
						jQuery(".city").focus() ;
						 return false ;
				}
			},
			tiptype:function(msg){
				if(msg=="请输入正确的11位手机号"){
				alert(msg);
				}
		    },
		 	callback : function(data){
				var returnv=data.responseText;
				if('error'==$.trim(returnv)){
					alert("请输入正确的11位手机号!");
					jQuery("#zd_mobile_phone").focus();
				}else if('success'==$.trim(returnv)){
					alert("提交成功！");
					$('#zd_name').val("");
					$('#zd_mobile_phone').val("");
					$("option").prop("selected",false);//清空选中
					$("option[value='"+prov+"']").prop("selected",true);//赋默认值
					$("option[value='"+cityv+"']").prop("selected",true);//赋默认值
					$('#zd_province').val(prov);
					$('#zd_city').val(cityv);
					$('#zd_contact_address').val(prov+cityv);
					$('.close-btn').parent().fadeOut();//提交完返回关闭
				}else{
					alert("操作失败，请重新提交！");
				}
		 	 	
		 	}
	 	});
}
</script>
