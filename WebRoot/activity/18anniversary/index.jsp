<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder" pageEncoding="UTF-8"%>
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
	
	List<Map> list = null;
	try{
		connection = dbHelper.getConnection();
		list = dbHelper.getMapList(" select id,nick_name,head_img,content,add_date from anniversary18_message where is_show = 0  order by add_date desc,id desc   ",connection);
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
		<title>铁臂嘉年华</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<style>
		.index .roll{position:relative;box-sizing:border-box;width: 7.5rem;height: 1.9rem;margin:.3rem auto;margin-top:-0.2rem;overflow: hidden;font-size: .22rem;color: #ffffc2;padding: .1rem .85rem;background-image: url(images/new_bg.png);background-size: 100% 100%;}
		.index .roll_outer{width:100%;overflow: hidden;}
		.index .roll_line{width:100%;height: 2rem;}
		.index .roll .img_box{width: .6rem;height: .6rem;border-radius: 50%;overflow: hidden;margin-right: .2rem;}
		.index .roll .img_box img{display: block;width: 100%;height: 100%;}
		.index .roll .ly_main{width: 5rem;line-height: .35rem;}
		.index .roll .com_name{font-size: .24rem;color:#4fbbed;}
		.index .roll .com_main{display: -webkit-box;width:100%;height: 1.5rem;line-height:.5rem;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 3;-webkit-box-orient: vertical;}

		.index .light{z-index: 10;top: 0;width: 30%;transform: scale(.3);}
		</style>
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
	<body class="index pr">
		<div class="banner pr">
			<img src="images/banner.png"/>
		</div>
		
		<div class="roll">
			<div class="roll_outer">
				<div class="roll_main fix">
				<%
				if(list!=null && list.size()>0){
					for(Map m:list){
				%>
					<div class="roll_line fix l">
						<div class="img_box l">
							<img src="<%=CommonString.getFormatPara(m.get("head_img"))%>"/>
						</div>
						<div class="ly_main l">
							<div class="com_name"><%=CommonString.getFormatPara(m.get("nick_name"))%></div>
							<p class="com_main"><%=CommonString.getFormatPara(m.get("content"))%></p>
						</div>
					</div>
					<%
					}
					int num=0;
					for(Map m:list){
						num++;
						if(num==1){
					%>
					<!---->
					<div class="roll_line fix l">
						<div class="img_box l">
							<img src="<%=CommonString.getFormatPara(m.get("head_img"))%>"/>
						</div>
						<div class="ly_main l">
							<div class="com_name"><%=CommonString.getFormatPara(m.get("nick_name"))%></div>
							<p class="com_main"><%=CommonString.getFormatPara(m.get("content"))%></p>
						</div>
					</div>
					<!---->
				<%
						}
					}
				}
				%>
				</div>
			</div>
		</div>
	
		<div class="main fix pr">
			<!--<div class="main_head l">周年盛典狂欢</div>-->
			<a href="to_users.html" class="main_item l"><!--href="to_users.html"-->
				<img src="images/1.png"/>
				<!--<p>致用户的一封信</p>-->
			</a>
			<a href="21sun_say.html" class="main_item l">
				<img src="images/2.png"/>
				<!--<p>21-SUN x 品牌说</p>-->
			</a>
			<a href="https://hd.faisco.cn/12279277/eBwB7ReUYQWbNehi-onHRQ/load.html?style=57" class="main_item l">
				<img src="images/3.png"/>
				<!--<p>玩转盘抽手机</p>-->
			</a>
			<a href="ranking_list.jsp" class="main_item l">
				<img src="images/4.png"/>
				<!--<p>品牌势力榜</p>-->
			</a>
			<a href="adv_sell.jsp" class="main_item l">
				<img src="images/5.png"/>
				<!--<p>广告/会员1.8折起</p>-->
			</a>
			<a href="comments.jsp" class="main_item l">
				<img src="images/6.png"/>
				<!--<p>写留言</p>-->
			</a>
		</div>
		<div class="tip pa">中国工程机械商贸网保留在法律规定范围内对上述规则进行解释的权利</div>
		<div style="display:none;">
			<script src="https://s13.cnzz.com/z_stat.php?id=1274296873&web_id=1274296873" language="JavaScript"></script>
		</div>
		
		<div class="tip_mask hide">
			<div class="tip_all">
				<p class="el"></p>
				<a href="javascript:void(0);" class="close_it">
					<img src="images/close.png"/>
				</a>
			</div>
		</div>
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/index.js?id=1" type="text/javascript" charset="utf-8"></script>
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
        var title= '铁臂嘉年华';
		var desc=' 中国工程机械商贸网18周年庆';
		var link= 'http://product.21-sun.com/activity/18anniversary/';
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
