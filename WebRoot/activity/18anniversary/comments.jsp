<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>写祝福</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/><script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
	<body class="comments">
		<div class="com_bg"></div>
		<a href="/activity/18anniversary/" class="to_index">
			<img class="pa bg" src="images/roll_bg.png"/>
			<img class="pa arr" src="images/arr_round.png"/>
		</a>
		
		<div class="com_jiyu">
			<h3>寄语</h3>
			<p>18年的风风雨雨，感谢有你们在背后默默的支持，你们见证了中国工程机械商贸网从00年开始的踉跄蹒跚到如今的从容不迫，从最初的稚嫩娇小长成现在的根深叶茂，在这里借着18周年庆的日子，中国工程机械商贸网愿诸位家人团圆永相聚，怀才已被伯乐识，愿您一切安好。</p>
		</div>
		
		<div class="com_write">
			<h3>写祝福</h3>
			<div class="write_main">
				<textarea class="write" placeholder="请输入您的祝福内容：" maxlength="100" id="content"></textarea>
				<input name="nickName" id="nickName" type="hidden" value="<%=nickname%>"/>
				<input name="headImg" id="headImg" type="hidden" value="<%=headimgurl%>"/>
				<input name="openId" id="openId" type="hidden" value="<%=openId%>"/>
				<a href="javascript:void(0);" class="send_btn">发送</a>
			</div>
		</div>
		
		<div class="show_coms">
			<div class="com_tab">
				<a href="javascript:void(0);" class="act">最新祝福</a>|<a href="javascript:void(0);">热门祝福</a>
			</div>
			<div class="com_all">
				<div class="com_page com_new">
					
				</div>
				
				<div class="com_page com_hot hide">

				</div>
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
		<div style="display:none;">
			<script src="https://s13.cnzz.com/z_stat.php?id=1274296873&web_id=1274296873" language="JavaScript"></script>
		</div>
		
		
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/comments.js" type="text/javascript" charset="utf-8"></script>
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
        var title= '铁臂嘉年华-写祝福';
		var desc=' 中国工程机械商贸网18周年庆，留下你对商贸网的祝福吧!';
		var link= 'http://product.21-sun.com/activity/18anniversary/comments.jsp';
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
