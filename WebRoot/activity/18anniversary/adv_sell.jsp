<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.text.SimpleDateFormat,java.util.Date" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*,com.jerehnet.wxpay.*"%>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	
	String path= "http://" + request.getServerName()+":"+request.getServerPort()+ request.getContextPath() + request.getServletPath(); 
	System.out.println(path);
	String ua = ((HttpServletRequest) request).getHeader("user-agent").toLowerCase();
    if (ua.indexOf("micromessenger")==-1) {// 是微信浏览器
		response.sendRedirect("noweixin.jsp");
		return;
	}

     String openId= CommonString.getFormatPara(request.getParameter("sqopenid"));
	String headimgurl= CommonString.getFormatPara(request.getParameter("headimgurl"));
	String nickname= CommonString.getFormatPara(request.getParameter("nickname"));
    String  uid = CommonString.getFormatPara(session.getAttribute("wx_id"));
	
	if(uid==null||uid.equals("")){
		if(openId==null||openId.equals("")){
			String url=request.getScheme()+"://"+request.getHeader("host")+request.getRequestURI();  
			String paramsStr=request.getQueryString();
			if(paramsStr!=null&&!paramsStr.equals("")){
				url+="?"+request.getQueryString();
			}
			String enurl=URLEncoder.encode(url);
			response.sendRedirect("http://xxlfront.jerei.com/auth_head_tt.jsp?back="+enurl);//


			return;
		}else{
			session.setAttribute("wxImg", headimgurl); 
			session.setAttribute("wx_id", openId); 
			session.setAttribute("nickname", nickname); 
			response.sendRedirect(path);
		}
	}else{
		openId= CommonString.getFormatPara(session.getAttribute("wx_id"));
		headimgurl= CommonString.getFormatPara(session.getAttribute("wxImg"));
		nickname= CommonString.getFormatPara(session.getAttribute("nickname"));
	}
	
//String openId="oBp9ht3rNMXKkbz1c8tln69uxiqQ";	
//String headimgurl=	"http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLJ55iasmMeibRRNT9RgVm0ZIzWrDXdho1QrsASlh1wNttOPW0ziarZibLvsjvcyicANSkq9K1JibvdMrgQ/132";
//String nickname="老衲";

List<Map> list = null;
List<Map> orderList = null; 
int days=0;double addMoney=0.00;
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
Date now = df.parse(df.format(new Date()));
try{
	connection = dbHelper.getConnection();
	list = dbHelper.getMapList(" select id,title,img,original_price,now_price,ad_state from anniversary18_ad order by  order_no asc,id desc   ",connection);//ad_state asc,
	orderList = dbHelper.getMapList(" select a.img,a.title,p.money,p.order_state,p.add_date from anniversary18_wxpay_log p left join anniversary18_ad a on p.ad_id=a.id where open_id=? and order_state=1 order by p.id desc ",new Object[]{openId},connection);
	days = differentDaysByMillisecond(df.parse("2018-08-06 00:00:00"),now);
	if(days>0){
		addMoney = 10*days;
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
		<title>广告/会员1.8折起</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script>
		//4.4以下js适配
		 (function (win, doc) {
			var docEl = doc.documentElement,
			resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
			setFontSize = function () {
			var clientWidth = docEl.clientWidth;
			if (!clientWidth) return;
				docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
			};
			if (!doc.addEventListener) return;
			win.addEventListener(resizeEvt, setFontSize, false);
			doc.addEventListener('DOMContentLoaded', setFontSize, false);
			if (/Android (\d+\.\d+)/.test(navigator.userAgent)) {
					win.addEventListener(resizeEvt, function () {
						clearTimeout(timer);
						timer = setTimeout(setFontSize, 300);
					}, false);
					win.addEventListener("pageshow", function(e) {
						if (e.persisted) {
							clearTimeout(timer);
							timer = setTimeout(setFontSize, 300);
						}
					}, false);
					setFontSize();
				} 
			})(window,document);
		</script>
	</head>
	<body class="adv_sell">
		<div class="sell_bg"></div>
		<a href="/activity/18anniversary/" class="to_index">
			<img class="pa bg" src="images/roll_bg.png"/>
			<img class="pa arr" src="images/arr_round.png"/>
		</a>
		
		<a href="javascript:void(0);" class="to_my">我的订单</a>
		
		<div class="sell_ban">
			<img src="images/adv_banner.png"/>
		</div>
		
		<div class="des_my">
			<div class="des_title">21-sun介绍</div>
			<div class="des_all">中国工程机械商贸网是业内企业数字营销解决方案提供商。自上线以来，至今已累计吸纳工程机械业内会员40多万，依托公司在数字技术和电子商务领域的专业实力，已经为业内3000多家企业提供高品质的互联网综合服务，包括卡特彼勒、小松、斗山、沃尔沃等国际巨擘，以及徐工、三一、中联、柳工等国内领军企业。</div>
		</div>
		<br/>
		<div class="des_my">
			<div class="des_title">促销规则</div>
			<div class="des_all">铁臂商城客户端月活跃人数8000，是机友们看资讯、查设备的首选！本次促销，我们精心挑选了高价值的客户端广告与网站会员服务，欢迎订购！<br/>8月6日-8月15日，18个广告位+2个会员，限时限量特价！<br/>每过1天，所有广告价格均上调10元！<br/>虚拟服务一经售出&nbsp;&nbsp;概不退款</div>
		</div>
		
		<div class="sell_main">
			<div class="des_title">优惠介绍</div>
			<%
			if(list !=null && list.size()>0){
				for(Map m:list){
					int adId = CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")));
					double money = (days>=0||CommonString.getFormatInt(CommonString.getFormatPara(m.get("ad_state")))==0)?(Double.parseDouble(CommonString.getFormatPara(m.get("now_price")))+addMoney):Double.parseDouble(CommonString.getFormatPara(m.get("original_price")));
			%>
			<div class="sell_item fix">
				<div class="item_img l">
					<img src="<%=CommonString.getFormatPara(m.get("img"))%>"/>
				</div>
				<div class="item_des l">
					<div class="item_name"><%=CommonString.getFormatPara(m.get("title"))%></div>
					<%if(adId==19 || adId==20){%><div class="item_pro">原价：<%=CommonString.getFormatPara(m.get("original_price"))%>元/年</div><%}%>
					<%if(adId==19 || adId==20){%><div class="item_cost"><span><%=CommonString.getFormatPara(m.get("now_price"))%></span>元/年</div><%}else{if(CommonString.getFormatInt(CommonString.getFormatPara(m.get("ad_state")))==0){%><div class="item_cost"><span><%=money%></span>元</div><%}}%>
					<%
					if(CommonString.getFormatInt(CommonString.getFormatPara(m.get("ad_state")))==0){
					%>
					<a href="to_pay.jsp?id=<%=CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")))%>&money=<%=(adId==19 || adId==20)?CommonString.getFormatPara(m.get("now_price")):money%>" class="item_btn">支付</a>
					<%
					}else{
					%>
					<a class="sell_out">已售罄</a>
					<%
					}
					%>
				</div>
			</div>
			<%
				}
			}
			%>
		</div>
		
		<!--<div class="des_companys">
			<div class="des_title">合作客户</div>
			<div class="des_all">新财富金牌董秘评选旨在挖掘中国资本市场最优秀的投资者关系管理者，促进上市公司治理结构优化、提升上市公司信息披露水平、推动中国资本市场的健康发展。在本届评选中，新财富首次面向港股上市公司IR 部门开展评选，“新财富最佳IR港股公司”候选名单包括了港股通标的443家港股上市公司，从监管角</div>
		</div>-->
		
		
		<div class="mask hide">
			<%
			if(orderList!=null && orderList.size()>0){
				for(Map m:orderList){
			%>
			<div class="dd_item">
				<div class="item_img l">
					<img src="<%=CommonString.getFormatPara(m.get("img"))%>"/>
				</div>
				<div class="item_des l">
					<div class="item_name el"><%=CommonString.getFormatPara(m.get("title"))%></div>
					<div class="item_pro">支付金额：￥<%=CommonString.getFormatPara(m.get("money"))%></div>
					<div class="item_cost"><%if("1".equals(CommonString.getFormatPara(m.get("order_state")))){ out.print("支付成功"); }else{ out.print("未支付"); }%></div>
					<div class="item_time"><%=CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",m.get("add_date"))%></div>
				</div>
			</div>
			<%
				}
			}
			%>
			<a href="javascript:void(0);" class="close_mask">
				<img src="images/close.png"/>
			</a>
			
		</div>
		<!--<div class="tip"></div>-->
		<div style="display:none;">
			<script src="https://s13.cnzz.com/z_stat.php?id=1274296873&web_id=1274296873" language="JavaScript"></script>
		</div>
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/adv_sell.js" type="text/javascript" charset="utf-8"></script>
	<script>
var appIds="";
var timestamps="";
var nonceStrs="";
var signatures="";

(function(){
	var url=location.href.split('#')[0];
	$.post('http://xxlfront.jerei.com/magezine/weixinJsConfig_t.jsp',{"url":url},function(data){
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
				var title= '铁臂嘉年华-广告/会员1.8折起';
				var desc=' 中国工程机械商贸网18周年庆，活动大放价，广告/会员1.8折起。';
				var link= 'http://product.21-sun.com/activity/18anniversary/adv_sell.jsp';
				var imgUrl= 'http://product.21-sun.com/activity/18anniversary/images/share.jpg';
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
<%!
public static int differentDaysByMillisecond(Date date1,Date date2)
    {
		int days=0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			days = (int) ((date2.getTime() - date1.getTime()) / (1000*3600*24));
		}catch(Exception e){
			e.printStackTrace();
		}
        return days;
    }
%>
