<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*,com.jerehnet.wxpay.*"%>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%
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

Connection connection = null;
DBHelper dbHelper = DBHelper.getInstance();
List<Map> brandList = null;
try{
	connection = dbHelper.getConnection(); 	
	brandList = dbHelper.getMapList(" select id,name from anniversary18_brand order by id  ",connection);
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
		<title>品牌势力榜</title>
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
	<body class="ranking">
		<a href="/activity/18anniversary/" class="to_index">
			<img class="pa bg" src="images/roll_bg.png"/>
			<img class="pa arr" src="images/arr_round.png"/>
		</a>
		<div class="rl_header fix">
			<p class="l rl_no">排名</p>
			<p class="l rl_br">品牌</p>
			<p class="l rl_co">势力值</p>
			<p class="l rl_btn"></p>
		</div>
		<div class="rl_main">
			
		</div>
		<div class="mask hide">
			<div class="rk_tc">
				<div class="rule">
					<div class="rule_title">活动规则</div>
					<div class="rule_main">
						<p>1、活动期间，每人先选定1个支持品牌，活动结束，支持前三名品牌的用户，分别获得1500、1000、500积分奖励；</p>
						<p>2、每人每天有10票，可以投给任意品牌；</p>
						<p>3、积分可以兑换机模、保温杯、毛巾等精美礼品(积分在铁臂商城APP使用)。</p>
					</div>
				</div>
				<div class="input_box">
					<div class="box fix">
						<p class="box_name l">选品牌：</p>
						<select name="brand" id="brand"  class="l">
							<option value="0">请选择</option>
							<%
							if(brandList!=null && brandList.size()>0){
								for(Map m:brandList){
							%>
									<option value="<%=CommonString.getFormatPara(m.get("id"))%>"><%=CommonString.getFormatPara(m.get("name"))%></option>
							<%
								}
							}
							%>
							<option value="999">其他（需要自行填写）</option>
						</select>
					</div>
					<div class="box fix hide write_brand">
						<p class="box_name l">填品牌：</p>
						<input type="text" class="l" name="otherBrand" id="otherBrand"/>
					</div>
					<div class="box fix">
						<p class="box_name l">填电话：</p>
						<input type="tel" class="l" name="tel" id="tel"/>
					</div>
				</div>
				<input name="openId" id="openId" type="hidden" value="<%=openId%>"/>
				<a href="javascript:void(0);" class="sub_btn">提交</a>
			</div>
		</div>
		
		<!--提示-->
		<div class="tip_mask hide">
			<div class="tip_all">
				<p class="el"></p>
				<a href="javascript:void(0);" class="close_it">
					<img src="images/close.png"/>
				</a>
			</div>
		</div>
		
		<div class="tip_masks hide">
			<div class="tip_alls">
				<p class="els el"></p>
				<a href="javascript:void(0);" class="close_its">
					<img src="images/close.png"/>
				</a>
			</div>
		</div>
		<div style="display:none;">
			<script src="https://s13.cnzz.com/z_stat.php?id=1274296873&web_id=1274296873" language="JavaScript"></script>
		</div>
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/ranking_list.js" type="text/javascript" charset="utf-8"></script>
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
				var title= '铁臂嘉年华-品牌势力榜';
				var desc=' 中国工程机械商贸网18周年庆，给你支持的品牌投票。';
				var link= 'http://product.21-sun.com/activity/18anniversary/ranking_list.jsp';
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
