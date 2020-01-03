<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder" pageEncoding="UTF-8"%>
<%	
	String ua = ((HttpServletRequest) request).getHeader("user-agent").toLowerCase();
    if (ua.indexOf("micromessenger")==-1) {// 是微信浏览器
		response.sendRedirect("noweixin.jsp");
		return;
	}
	//backUrl+="?sqopenid="+openId+"&nickname="+nickname+"&headimgurl="+headimgurl;
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
        //response.sendRedirect("http://xxlfront.jerei.com/auth_head_t.jsp?back="+enurl);
		        response.sendRedirect("http://xxlfront.jerei.com/auth_head_tt.jsp?back="+enurl);//


	    return;
    }else{
		session.setAttribute("wxImg", headimgurl); 
		session.setAttribute("wx_id", openId); 
		session.setAttribute("nickname", nickname); 
	}
	}else{
		openId= CommonString.getFormatPara(session.getAttribute("wx_id"));
		headimgurl= CommonString.getFormatPara(session.getAttribute("wxImg"));
		nickname= CommonString.getFormatPara(session.getAttribute("nickname"));
	}


 
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
if(openId.equals("oBp9ht3rNMXKkbz1c8tln69uxiqQ")){
	i=0;
}
try{
	connection = dbHelper.getConnection(); 	
	payLogList=dbHelper.getMapList(" select * from activity_sany_pay_log where open_id= '"+openId+"' and order_state >0 ",connection);
	firstPro=dbHelper.getMap(" select top 1 order_state from activity_sany_pay where product_id=21004 and open_id='"+openId+"' order by id asc ",connection);
	if(firstPro!=null){
		firstState=CommonString.getFormatPara(firstPro.get("order_state"));
	}
	secPro=dbHelper.getMap(" select top 1 order_state from activity_sany_pay where product_id=21005 and open_id='"+openId+"' order by id asc ",connection);
	if(secPro!=null){
		secState=CommonString.getFormatPara(secPro.get("order_state"));
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBHelper.freeConnection(connection);
}
%>
<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>三一微挖全新升级 限时秒杀</title>
<meta content="" name="Keywords">
<meta content="" name="Description">
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.jerei.com">
<link href="Static/css/ui.css" rel="stylesheet" />
<link href="Static/grid/grid12.css" rel="stylesheet" />
<link href="Static/css/style.css" rel="stylesheet" />
<link href="Static/css/responsive.css" rel="stylesheet" />
<!--[if lt IE 9]><script src="Static/lib/H5shiv.js"></script><![endif]-->
</head>
<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
        var title= '三一微挖全新升级，限时秒杀';
		var desc='三一微挖全新升级，限时秒杀，铁臂商城限量首发';
        var link= 'http://product.21-sun.com/activity/sany518/index.jsp';
        var imgUrl= 'http://product.21-sun.com//activity/sany518/images/fx.jpg';
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
<body>

<!--banner-->
<div class="banner pr">
	<img src="Static/img/mobile_banner.jpg" data-src="Static/img/pc_banner.jpg" alt="" class="pa" />
</div>
<!--banner end-->

<!--part1-->
<div class="part1">
	<div class="wrap">
		<div class="part1_box">
			<div class="time">抢购倒计时 <span class="count_down" data-date="2018/05/18"><i class="num move"></i><i class="num move single"></i></span> 天</div>
			<h3 class="title01">每卖出5台挖掘机，就有1台是三一</h3>
			<div class="title02">
				2017年，全国共卖出140303台挖掘机，三一占20.9%  
			</div>
		</div>
	</div>
</div>
<!--part1 end-->

<!--预订名单-->
<!--<div class="part2">
	<div class="wrap">
		<h3 class="list_title tc">活动预定名单</h3>
		<div class="name_list">

		</div>
	</div>
</div>-->
<!--预订名单 end-->

<!--产品1-->
<div class="pro_box pro_01">
	<div class="wrap tc">
		<img src="Static/img/pro_img.jpg">
		<div class="pro_text">
			<div class="pro_data">
				<span>整机重量：1750kg</span><span>斗容：0.04㎡</span><span>功率：10.3kw/2200rpm</span><span>适合工况：农田改造\园林绿化</span>
			</div>
			<h2 class="pro_title">SY16C灵动精灵·壮汉十八不如三一微挖</h2>
			<div class="tip_tit">
				灵活穿行狭窄巷道，墙边墙角作业不再愁<br/>
				驾驶棚或驾驶室随意选，稳定高效性能传承
			</div>
			<h4 class="tips">[三一挖机连续7年销量第一]</h4>
			<div class="button_box MobilePush">
				<a href="test_sy16c.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>">产品评测</a> 
				<a href="paras_sy16c.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>">查看参数</a> 
				<% 
				if(firstState.equals("0")){
				%>
				<a href="pay.jsp?productId=21004&productName=SY16C&productImg=http://product.21-sun.com/activity/sany518/images/machine1_03.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" class="def">预售 ￥200 定金可退</a>
				<%}else if(firstState.equals("1")&& i > 0 ){ %>
				<a style="background-color: #ddd;color: #fff;border: 1px solid #ddd;">定金 ￥1800 定金可退</a>
				<%}else if(firstState.equals("1")&& i <= 0){ %>
				<a href="paySec.jsp?productId=21004&productName=SY16C&productImg=http://product.21-sun.com/activity/sany518/images/machine1_03.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>"  class="def">定金 ￥1800 定金可退</a>
				<%} %>
			</div>
			<div class="message fix">
				<div class="message_hd l">已订购14台</div>
				<div class="message_bd_box l">
					<div class="message_bd name_list" id="msgPro1"> 
						<p>山东 王先生 135****7540已交定金</p>
						<p>河南 郑先生 186****2834 已交定金</p>
						<p>安徽 李先生 138****7983 已交定金</p>
						<p>山东 王先生 138****3203 已交定金</p>
						<p>北京 张先生 135****4577已交定金</p>
						<p>山东 曲先生 188****3599 已交定金</p>
						<p>江苏 孙先生 186****8683 已交定金</p>
						<p>湖南 王先生 133****6690 已交定金</p>
						<p>辽宁 江先生 136****0003 已交定金</p>
						<p>北京 葛先生 188****0585 已交定金</p>
						<p>河北 巴先生 151****0066已交定金</p>
						<p>湖南 赵先生 155****1611 已交定金</p>
						<p>北京 孙先生 135****7666 已交定金</p>
						<p>湖南 王先生 177****2326 已交定金</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--产品1 end-->

<!--产品2-->
<div class="pro_box pro_02">
	<div class="wrap tc">
		<img src="Static/img/pro_2.jpg">
		<div class="pro_text">
			<div class="pro_data">
				<span>整机重量：3780kg</span><span>斗容：0.12㎡</span><span>功率：20.4kw/2200rpm</span><span>适合工况：农田改造\园林绿化\管道建设</span>
			</div>
			<h2 class="pro_title">SY35U灵动精灵·壮汉十八不如三一微挖</h2>
			<div class="tip_tit">
				效率高3.3%以上，油耗低至9.2以下<br/>
				寿命延长100%，无尾设计更灵活
			</div>
			<h4 class="tips">[三一挖机连续7年销量第一]</h4>
			<div class="button_box MobilePush">
				<a href="test_sy35u.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>">产品评测</a>
				<a href="paras_sy35u.jsp?headimgurl=<%=headimgurl%>&nickname=<%=nickname%>&sqopenid=<%=openId%>">查看参数</a>
				<% 
				if(secState.equals("0")){
				%>
				<a href="pay.jsp?productId=21005&productName=SY35U&productImg=http://product.21-sun.com/activity/sany518/images/machine2_07.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" class="def">预售 ￥200 定金可退</a>
				<%}else if(secState.equals("1")&& i > 0 ){ %>
				<a style="background-color: #ddd;color: #fff;border: 1px solid #ddd;">定金 ￥1800 定金可退</a>
				<%}else if(secState.equals("1")&& i <= 0){ %>
				<a href="paySec.jsp?productId=21005&productName=SY35U&productImg=http://product.21-sun.com/activity/sany518/images/machine2_07.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" class="def"> 定金 ￥1800 定金可退</a>
				<%} %>
			</div>
			<div class="message fix">
				<div class="message_hd l">已订购9台</div>
				<div class="message_bd_box l">
					<div class="message_bd name_list" id="msgPro2"> 
						<p>江苏 曾先生 185****5556 已交定金</p>
						<p>湖南 董先生 186****5575 已交定金</p>
						<p>黑龙江 李先生 132****1877 已交定金</p>
						<p>山东 李先生 186****1203已交定金</p>
						<p>河北 张先生 188****7460 已交定金</p>
						<p>黑龙江 肖先生 186****5355 已交定金</p>
						<p>黑龙江 曹先生 135****2388 已交定金</p>
						<p>山东 高先生 186****2756已交定金</p>
						<p>山西 马先生 188****4283 已交定金</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--产品2 end-->

<!--video-->
<div class="video_box" data-v="https://v.qq.com/iframe/player.html?vid=k0518pztz2b&tiny=0&auto=0"><h3 class="video_title hide">挖机视频</h3></div>
<!--video end-->

<!--pro_detail-->
<div class="pro_detail">
	<div class="tab_hd">
		<div class="tab_hd_wrap fix">
			<div class="tab_t tc l">三一重工SY16C微挖</div>
			<div class="tab_t tc r">三一重工SY35U</div>
		</div>
	</div>
	<div class="tab_bd">
		<div class="tab_c tc">
			<img src="Static/img/pro_detail1.jpg" alt=""/>
		</div>
		<div class="tab_c tc">
			<img src="Static/img/pro_detail2.jpg" alt=""/>
		</div>
	</div>
</div>	
<!--pro_detail end-->

<!--part6-->
<div class="part6">
	<div class="wrap">
		<div class="text1 tc">
			本次活动由三一重工联合中国工程机械商贸网旗下“铁臂商城”共同举办，你可以在三一京东旗舰店访问该活动，也可以在铁臂商城活动页面（本页面）参加活动！
		</div>
		<div class="text2 tc">
			在铁臂商城参加本活动，除了以上优惠，成功购车的用户还将额外享受铁臂商城送出的<em>1000元油卡！！</em>（京东没有）
		</div>
		<div class="full-row part6_main">
			<div class="span-5 smal-12">
				<div class="part6_owl owl-carousel">
					<div class="item">
						<span class="rect-75">
							<img src="images/about21sun.jpg" alt="关于中国工程机械商贸网" class="_full" />
						</span>
					</div>
				</div>
			</div>
			<div class="span-7 smal-12">
				<div class="text_box">
					<h3 class="title">关于中国工程机械商贸网</h3>
					<div class="text">
						中国工程机械商贸网始终扎根于工程机械领域，通过不懈的技术创新、庞大海量的行业数据库、敏锐的市场观察和对行业的深入理解，现在已成为中国工程机械企业上网首选网站，电子商务应用与企业信息化首选合作伙伴。今天， "中国工程机械商贸网"拥有有效注册的工程机械业内会员近20万家，超过1000万条数据信息，日浏览量超过300万次，正在为2000家工程机械企业提供着从企业网站制作及维护、企业电子邮局服务、行业数据分析报告、互联网品牌推广、产品手册编制、企业VI设计及公关服务、互联网贸易及服务、企业应用软件定制开发、企业ERP信息化解决方案等为中国工程机械行业贴身定制的各类优秀的产品及服务。
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--part6 end-->

<!--part7-->
<div class="part7">
	<div class="wrap">
		<h4 class="title tc">活动说明</h4>
		<div class="p">
		三一集团联合铁臂商城开展5.18微挖抄底促销活动，价格超低，优惠幅度前所未有，活动机型5.18当天限量首发，两款热销机型共仅限20台。<br/>
 		<br/>
		活动说明：<br/>
		1. 2018年5月5日至2018年5月17日前参与注册并支付200元定金首期款的用户，可享受18日活动当天底价抢购；付款成功后会收到短信通知，页面中也会显示付款成功信息<br/>
		2. 已支付过200元定金首期款的客户，在5月18日当天进入页面选择相应产品，支付1800元定金尾款，可抢购20台微挖优惠名额（SY16C和SY35U各仅限10台）；由于名额有限，以最终定金尾款支付成功顺序为准<br/>
		3. 三一厂家销售经理会会动联系抢购成功客户，并指导客户办理相关手续，并于6月30日前交齐全款，过期未交齐全款者视为放弃活动资格（定金可直接冲抵货款）；商品发货顺序以交齐全款先后顺序为准
		4. 最终抢购成功的客户在购机后再次进入本活动页面（请提前收藏页面），于6月30日前上传购机发票可额外获得1000元中石化加油卡<br/>
		5.您可以微信关注“铁臂商城”，随时查看活动详情！
		<br/>
		* 定金可退，未参与抢购或抢购未成功者将有客服人员联系确认，将定金原数退回<br/>
		* 客户所登记的姓名、手机号码将作为参与活动的身份核实标准，具有唯一性。如因本人提交信息有误、或信息不匹配，导致无法获得相应奖励，铁臂商城将不予承担责任<br/>
		* 本次优惠不与其他优惠同享，最终解释权归三一集团所有
		</div>
		<h4 class="title tc">购买须知</h4>
		<div class="p">
		关于活动价格：5月18日活动结束后，产品即恢复铁臂商城直销价（SY16C直销价为15.8万，SY35U直销价为23.8万）<br/>
		关于定金: 您在铁臂商城铁订惠所交付的定金可直接冲抵货款,也可直接申请退款<br/>
		关于运费:  购买铁臂商城三一微挖,可享免费送货到家政策<br/>
		关于发货:  本次活动设备,由三一集团下属公司三一重机从江苏昆山工厂直接发货<br/>
		关于质保： 集团官方旗舰店微挖与线下同享“一年或者3000小时,先到为准”<br/>
		关于售后服务：铁臂商城三一微挖与线下同享全国联保。全国拥有600多个服务中心,可以实现365X24全时服务,2小时内到达现场,1天内排除故障<br/>
		关于金额分期：厂家直销暂不支持金融分期<br/>
		关于发票：购买设备均有正规增值税发票，报价已经包含购置税<br/>
		（注：合同签订后，定金不退）
		</div>
		<div class="p" style="text-align:center;margin-top:-10px">
			<strong style="font-size:20px;color:red">咨询电话：0535-6792733<strong>
        </div>
	</div>
</div>
<!--part7 end-->

<div class="footer_ewm PcPush">
	<img src="Static/img/flot_ewm.jpg" alt="">
</div>
<div style="display:none;"><script src="https://s13.cnzz.com/z_stat.php?id=1273609916&web_id=1273609916" language="JavaScript"></script></div>	
</body>
<script src="Static/modules/seajs/sea.js" id="seajsnode" ></script>
<script src="seajs.config.js"></script>
<script>
var jrChannel='0#0';
seajs.use('index/index.js');
</script>

</html>
