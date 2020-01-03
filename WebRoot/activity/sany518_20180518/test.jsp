<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder" pageEncoding="UTF-8"%>
<%	
	String ua = ((HttpServletRequest) request).getHeader("user-agent").toLowerCase();
 
	//backUrl+="?sqopenid="+openId+"&nickname="+nickname+"&headimgurl="+headimgurl;
	String openId= CommonString.getFormatPara(request.getParameter("sqopenid"));
	String headimgurl= CommonString.getFormatPara(request.getParameter("headimgurl"));
	String nickname= CommonString.getFormatPara(request.getParameter("nickname"));
    String  uid = CommonString.getFormatPara(session.getAttribute("wx_id"));
 


 
%>
<%
Connection connection = null;
DBHelper dbHelper = DBHelper.getInstance();
List<Map> payLogList=null;
Map firstPro=null;Map secPro=null;
String firstState="0";String secState="0";
String nowDate = CommonDate.getToday("yyyy-MM-dd") ;
int month=0;int day=0;
month=Integer.parseInt(nowDate.substring(5,7));
day=Integer.parseInt(nowDate.substring(8,10));
System.out.println(nowDate.substring(0,4)+";"+nowDate.substring(5,7)+";"+nowDate.substring(8,10));
Calendar cal1 = new GregorianCalendar(2018, 5, 18);
Calendar cal2 = new GregorianCalendar(2018, month, day);
int i=cal1.compareTo(cal2);
System.out.println("日期比较："+i);
try{
	connection = dbHelper.getConnection(); 	
	payLogList=dbHelper.getMapList(" select * from activity_sany_pay_log where open_id= '"+openId+"' and order_state >0 ",connection);
	firstPro=dbHelper.getMap(" select top 1 order_state from activity_sany_pay where product_id=21004 and open_id='"+openId+"' ",connection);
	if(firstPro!=null){
		firstState=CommonString.getFormatPara(firstPro.get("order_state"));
	}
	secPro=dbHelper.getMap(" select top 1 order_state from activity_sany_pay where product_id=21005 and open_id='"+openId+"' ",connection);
	if(secPro!=null){
		secState=CommonString.getFormatPara(secPro.get("order_state"));
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBHelper.freeConnection(connection);
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>三一微挖全新升级 限时秒杀</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
	</head>
	<body class="index">
		
		<div class="header fix">
			<a href="javascript:void(0);" class="l"><img src="images/logo_01.jpg"/></a>
			<img src="images/line.jpg" class="l"/>
			<a href="javascript:void(0);" class="l"><img src="images/logo_03.jpg"/></a>
		</div>
		<div class="banner">
			<img src="images/banner_02.jpg"/>
		</div>
		<%
		if(payLogList!=null&&payLogList.size()>0){
		%>
		<div class="order_status fix">
			<div class="img_header l">
				<img src="<%=headimgurl%>"/>
			</div>
			<div class="order_info l">
				<div class="fix">
					<p class="l"><%=nickname%></p>
					<!--<p class="l">18800001111</p>-->
					<p class="r status">支付成功！</p>
				</div>
				<%
				for(Map model:payLogList){
					String source="";String type="";
					if(CommonString.getFormatPara(model.get("source")).equals("zfb")){
						source="支付宝";
					}else if(CommonString.getFormatPara(model.get("source")).equals("vx")){
						source="微信";
					}
					
					if(CommonString.getFormatInt(CommonString.getFormatPara(model.get("order_state")))==1){
						type="预售金";
					}else if(CommonString.getFormatInt(CommonString.getFormatPara(model.get("order_state")))==2){
						type="定金";
					}
					
				%>
				<div class="info_detail">
					<%=CommonDate.getFormatDate("yyyy-MM-dd",model.get("add_date")) %> 通过 <%=source %> 支付<%=CommonString.getFormatPara(model.get("product_name"))%><%=type %> <%=CommonString.getFormatPara(model.get("price")) %> 元
				</div>
				<%} %>
			</div>
		</div>
		<%} %>
		<div class="liucheng">
			<img src="images/liucheng_07.jpg"/>
		</div>
		
		<div class="machine">
			<div class="mac_img">
				<img src="images/machine1_03.jpg"/>
			</div>
			<div class="mac_price">
				<img src="images/ma_detail1_09.jpg"/>
			</div>
			<div class="mac_detail">
				<div class="line_box fix">
					<p class="l">最大挖掘高度：3665</p>
					<p class="l">最大卸载高度：2635</p>
					<p class="l">工作重量：1850</p>
					<p class="l">标准铲斗容量：0.04</p>
				</div>
			</div>
			<div class="mac_name">三一SY16C微型液压挖掘机</div>
			<div class="mac_btns fix">
				<a href="test_sy16c.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>" class="l">产品测评</a>
				<a href="paras_sy16c.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>" class="r">查看参数</a>
			</div>
			<div class="mac_pay">
				<% 
				if(firstState.equals("0")){
				%>
				<a href="pay.jsp?productId=21004&productName=SY16C&productImg=http://product.21-sun.com/activity/sany518/images/machine1_03.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" >预售 ￥200 定金可退</a>
				<%}else if(firstState.equals("1")&& i > 0 ){ %>
				<a style="background-color: #ddd;">定金 ￥1800 定金可退</a>
				<%}else if(firstState.equals("2")&& i <= 0){ %>
				<a href="pay.html" >定金 ￥1800 定金可退</a>
				<%} %>
			</div>
		</div>
		<div class="machine">
			<div class="mac_img">
				<img src="images/machine2_07.jpg"/>
			</div>
			<div class="mac_price">
				<img src="images/mac_detail2_11.jpg"/>
			</div>
			<div class="mac_detail">
				<div class="line_box fix">
					<p class="l">最大挖掘高度：4855</p>
					<p class="l">最大卸载高度：3460</p>
					<p class="l">工作重量：3780</p>
					<p class="l">标准铲斗容量：0.12</p>
				</div>
			</div>
			<div class="mac_name">三一SY35U微型液压挖掘机</div>
			<div class="mac_btns fix">
				<a href="test_sy35u.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>" class="l">产品测评</a>
				<a href="paras_sy35u.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>" class="r">查看参数</a>
			</div>
			<div class="mac_pay">
				<% 
				if(secState.equals("0")){
				%>
				<a href="pay.jsp?productId=21005&productName=SY35U&productImg=http://product.21-sun.com/activity/sany518/images/machine2_07.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" >预售 ￥200 定金可退</a>
				<%}else if(secState.equals("1")&& i > 0 ){ %>
				<a style="background-color: #ddd;">定金 ￥1800 定金可退</a>
				<%}else if(secState.equals("2")&& i <= 0){ %>
				<a href="pay.html" >定金 ￥1800 定金可退</a>
				<%} %>
			</div>
		</div>
		
		<div class="act_rules">
			<p class="title">活动说明</p>
			<div class="ac_con">
				<p>三一集团联合铁臂商城开展5.18微挖抄底活动，价格超低，优惠幅度前所未有，活动机型5.18当天限量首发，仅限20台。</p>
				<p>1、2018年5月5日至2018年5月18日前参与注册并预交定金的用户，可享受活动当天抄底价，成功购机并于6月30日前回传发票可额外获得1000元汽车加油卡。</p>
				<p>2、网友需在成功购机后再次进入本活动页面（请提前收藏页面），凭注册时的姓名和手机号上传您的购机发票。（登录姓名需与购机发票上的姓名一致，且登录姓名与手机号均需与注册姓名和手机号保持一致，若因姓名或手机号不一致而无法核实购机的真实性，将视为无效）；网友所登记的姓名、手机号码将作为参与活动的身份核实标准，具有唯一性。 如因网友本人提交信息有误，或与之前提交信息不匹配，导致无法获得相应奖品，铁臂商城将不予承担责任。</p>
				<p>3.本次活动的服务热线为4006-603-068，欢迎您的报名咨询。</p>
				<p>* 本次优惠不与其他优惠同享，最终解释权归三一集团所有</p>
			</div>
		</div>
		
		<!--<div class="pay_names">
			<p class="title">最新预定</p>
			<div class="names_roll">
				<div class="roll_in">
					<div class="roll_main">
						
					</div>
				</div>
			</div>
		</div>-->
		
		<div class="footer">
			<p>产品询价专线:4006-603-068</p>
			<p>中国工程机械商贸网 Copyright © 2000-2018</p>
		</div>
		
		
	<div style="display:none;"><script src="https://s13.cnzz.com/z_stat.php?id=1273609916&web_id=1273609916" language="JavaScript"></script></div>	
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/index.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script>
var appIds="";
var timestamps="";
var nonceStrs="";
var signatures="";

(function(){
	var url=location.href.split('#')[0];
	$.post('http://xxlfront.jerei.com/magezine/weixinJsConfig_tb.jsp',{"url":url},function(data){
			appIds=$.trim(data.split('@@')[0]);
			timestamps=$.trim(data.split('@@')[1]);
			nonceStrs=$.trim(data.split('@@')[2]);
			signatures=$.trim(data.split('@@')[3]);
	wx.config({
	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId:appIds, // 必填，公众号的唯一标识
	    timestamp:timestamps, // 必填，生成签名的时间戳
	    nonceStr:nonceStrs, // 必填，生成签名的随机串
	    signature: signatures,// 必填，签名，见附录1
	    jsApiList: [
	        'checkJsApi',
	        'onMenuShareTimeline',
	        'onMenuShareAppMessage',
	        'onMenuShareQQ',
	        'onMenuShareWeibo',
	        'hideMenuItems',
	        'showMenuItems',
	        'hideAllNonBaseMenuItem',
	        'showAllNonBaseMenuItem',
	        'translateVoice',
	        'startRecord',
	        'stopRecord',
	        'onRecordEnd',
	        'playVoice',
	        'pauseVoice',
	        'stopVoice',
	        'uploadVoice',
	        'downloadVoice',
	        'chooseImage',
	        'previewImage',
	        'uploadImage',
	        'downloadImage',
	        'getNetworkType',
	        'openLocation',
	        'getLocation',
	        'hideOptionMenu',
	        'showOptionMenu',
	        'closeWindow',
	        'scanQRCode',
	        'chooseWXPay',
	        'openProductSpecificView',
	        'addCard',
	        'chooseCard',
	        'openCard'
	    ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	
	wx.ready(function () {
  // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
  wx.checkJsApi({
    jsApiList: [
      'onMenuShareTimeline'
    ],
    success: function (res) {
      //alert(JSON.stringify(res));
    }
  });
        var title= '三一微挖全新升级，限时秒杀';
		var desc='三一微挖全新升级，限时秒杀，铁臂商城限量首发';
        var link= 'http://product.21-sun.com/activity/sany518/index.jsp';
        var imgUrl= 'http://product.21-sun.com/activity/sany518/images/banner_02.jpg';
  // 分享给朋友
  wx.onMenuShareAppMessage({
	    title: title,
		desc: desc,
	    link: link,
	    imgUrl: imgUrl,
	    trigger: function (res) {
	    },
	    success: function (res) {
	        subShare();
	        alert("分享成功！");
	        hideShare()
	        //setTimeout(function(){window.location.reload();}, 3000 )
	    },
	    cancel: function (res) {
	         //alert('已取消');
	         hideShare();
	    },
	    fail: function (res) {
	      //alert(JSON.stringify(res));
	    }
  });

  //分享朋友圈
  wx.onMenuShareTimeline({
      title: title,
      desc: desc,
      link: link,
      imgUrl: imgUrl,
      trigger: function (res) {
      },
      success: function (res) {
        subShare();
        alert("分享成功！");
        hideShare()
        //setTimeout(function(){window.location.reload();}, 3000 )
      },
      cancel: function (res) {
        hideShare()
      },
      fail: function (res) {
        //alert(JSON.stringify(res));
      }
    });
});
wx.error(function (res) {
  //alert(res.errMsg+"error");
});
		
		});
})();
</script>


</html>
