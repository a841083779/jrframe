<%@ page language="java" import="com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>营销宝-中国工程机械产品中心</title>
<meta name="keywords" content="营销宝登录,营销宝注册,营销宝,信息管理,营销推广,订单管理,数据分析" />
<meta name="description" content="欢迎注册登录营销宝，营销宝用户专享特权包括，信息管理、营销推广、订单管理、数据分析" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/plugin/validator/rjboy/Validform_v5.3.1.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<style type="text/css">
.login_banner { width:100%; height:370px; clear:both; position:relative; z-index:1; margin-top:-10px;}
#login_bannerShow { width:100%; height:370px; position:relative; z-index:1; overflow:hidden;}
#login_bannerShow .lb_imgs,#login_bannerShow .lb_imgs li { width:100%; height:370px; position:absolute; left:0px; top:0px;}
#login_bannerShow .lb_imgs li a { display:block; width:980px; height:370px; margin:0 auto;}
.lb_points { width:120px; height:17px; position:absolute; left:50%; margin-left:-60px; bottom:13px; z-index:2;}
.lb_points li { width:17px; height:17px; float:left; margin-right:13px; background:url(../images/login_banne_points.png) right 0px no-repeat; cursor:pointer; overflow:hidden; _background:#fff;}
.lb_points li.selected { background-position:0px 0px; _background:#b3b3b3;}
.login { position:absolute; right:50%; margin-right:-490px; top:23px; z-index:2; width:306px; height:326px;}
.loginbg { position:absolute; left:0px; top:0px; z-index:1; width:100%; height:326px; background:url(../images/loginbg.png) top repeat-x; _background-color:#000; _filter:alpha(opacity=20);}
.login-con { position:absolute; left:8px; top:8px; z-index:2; width:260px; height:280px; padding:15px; background:#ecf1f6 url(../images/login-conbg.jpg) top repeat-x;}
.login-con .btn03 { text-align:center; border-bottom:#cdcdcd 1px dashed; padding-bottom:20px; margin-bottom:10px;}
.login_form { width:100%; float:left; position:relative; height:219px;}
.login_form dl { width:100%; height:auto; line-height:32px; padding:5px 0px; float:left;}
.login_form dl dt { width:47px; float:left; text-align:center;}
.login_form dl dd { width:210px; float:right;}
.login_form dl a { color:#0030c5; text-decoration:underline;}
.login_form dl dd .login_input { width:189px; height:30px; line-height:30px; padding:0px 6px; border:#c2c3c5 1px solid; background:url(../images/login_form_inputbg.gif) 0px 0px no-repeat; color:#333; font-family:Verdana;}
.login_form dl.login_btn a { display:block; width:123px; height:35px; background:url(../images/login_form_btn02.gif) 0px 0px no-repeat; margin-left:49px; overflow:hidden; text-indent:-9999px; margin-top:5px;}
.login_form dl.login_btn a:hover { background-position:0px -35px;}

.login_form dl.lb_text { color:#929497; line-height:20px;}
.login_content { width:100%; height:auto; background:#f7f7f7 url(../images/login_order_contentbg.gif) bottom repeat-x; padding:20px 0px;}
.login_content .title { width:100%; height:34px; float:left; border-bottom:#e0e0e0 1px solid; margin-bottom:15px; cursor:default;}
.login_content .title h3 { font:100 18px/34px 微软雅黑; color:#212121;}
.login_content .content { width:100%; float:left;}
.login_left { width:670px; float:left;}
.login_right { width:300px; float:right;}
.orderList { width:100%; float:left; cursor:default;}
.orderList li.ol { width:335px; height:165px; float:left;}
.orderList li.ol em { width:60px; height:60px; float:left; background:url(../images/login_icon.gif) no-repeat; overflow:hidden;}
.orderList li.ol01 em { background-position:0px 0px;}
.orderList li.ol02 em { background-position:-60px 0px;}
.orderList li.ol03 em { background-position:-120px 0px;}
.orderList li.ol04 em { background-position:-180px 0px;}
.orderList li.ol ul { width:240px; padding-right:30px; float:right;}
.orderList li.ol ul h3 { height:50px; font:100 18px/50px 微软雅黑; color:#c5a078;}
.orderList li.ol ul li { color:#888888; line-height:20px; font-family:Verdana; padding-bottom:5px;}
.activeList { width:100%; float:left;}
.activeList li { width:285px; padding-left:15px; height:24px; line-height:24px; float:left; background:url(../images/news_list_point_g.gif) 5px 10px no-repeat;}
.activeList li a { color:#888888;}

.loginTip { width:193px; border:#E6C99E 1px solid; background-color:#FFFFE4; padding:5px; color:#FF7300; position:absolute; left:50px; bottom:71px; cursor:default; display:none;}
.login_form .name { top:36px; bottom:auto; padding:4px;}
.login_form .code { top:79px; bottom:auto; padding:4px}
.login_form .yzm { top:122px; width:75px; bottom:auto; padding:4px;}
</style> 
<script type="text/javascript">
var t = n = 0, count;
jQuery(document).ready(function(){	
    count=jQuery("#login_bannerShow .lb_imgs li").length;
    jQuery("#login_bannerShow .lb_imgs li:not(:first-child)").hide();
    jQuery("#login_bannerShow .lb_points li").click(function() {
        var i = jQuery(this).attr("value") - 1;
        n = i;
        if (i >= count) return;
        jQuery("#login_bannerShow .lb_imgs li").filter(":visible").fadeOut(500).parent().children().eq(i).fadeIn(500);
        jQuery(this).toggleClass("selected");
        jQuery(this).siblings().removeAttr("class");
    });
    t = setInterval("showAuto()", 5000);
    jQuery("#login_bannerShow ul.lb_points").hover(function(){clearInterval(t)}, function(){t = setInterval("showAuto()", 5000);});
})
function showAuto(){
    n = n >=(count - 1) ? 0 : ++n;
    jQuery("#login_bannerShow .lb_points li").eq(n).trigger('click');
}
</script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--main-->
<div class="login_banner">
  <div id="login_bannerShow">
    <ul class="lb_imgs">
      <li style="background-color:#ff9700;"><a href="javascript:void(0);"><img src="../images/login_banner01.jpg" alt="信息管理" width="980" height="370" /></a></li>
      <li style="background-color:#21b4f4;" class="hide"><a href="javascript:void(0);"><img src="../images/login_banner02.jpg" alt="营销推广" width="980" height="370" /></a></li>
      <li style="background-color:#ffed29;" class="hide"><a href="javascript:void(0);"><img src="../images/login_banner03.jpg" alt="订单管理" width="980" height="370" /></a></li>
      <li style="background-color:#78ba00;" class="hide"><a href="javascript:void(0);"><img src="../images/login_banner04.jpg" alt="数据分析" width="980" height="370" /></a></li>
    </ul>
    <ul class="lb_points">
      <li value="1" class="selected"></li>
      <li value="2"></li>
      <li value="3"></li>
      <li value="4"></li>
    </ul>
  </div>
  <form name="loginform" id="loginform" action="/agent/action/ajax.jsp">
  <div class="login">
    <div class="loginbg"></div>
    <div class="login-con">
      <div class="btn03"><a href="javascript:void(0);" onclick="joinUs();" title="申请加入营销宝"><img src="../images/login_form_btn01.gif" alt="申请加入营销宝" width="244" height="45" /></a></div>
	  <div class="login_form">
        <div class="loginTip" style="display:none;">
          用户名或密码错误
        </div>
        <div class="loginTip name" style="display:none;" id="loginTip_name">
          请输入用户名
        </div>
        <div class="loginTip code" style="display:none;" id="loginTip_code" onpaste="return false">
          请输入密码
        </div>
        <div class="loginTip yzm" style="display:none;" id="loginTip_yzm">
          请输入验证码
        </div>
        <dl>
          <dt>用户名</dt>
          <dd>
            <input maxlength="20"  type="text" value="" name="agent_name" id="agent_name" class="login_input" onfocus="this.style.border='#818181 1px solid'" onblur="this.style.border='#c2c3c5 1px solid'" />
          </dd>
        </dl>
        <dl>
          <dt>密　码</dt>
          <dd>
            <input type="password"  maxlength="20" value=""  name="agent_pass" id="agent_pass" class="login_input" onfocus="this.style.border='#818181 1px solid'" onblur="this.style.border='#c2c3c5 1px solid'" />
          </dd>
        </dl>
        <dl>
          <dt>验证码</dt>
          <dd>
            <span class="l" style="margin-right:5px;"><input maxlength="4" type="text"  name="rand" id="rand" class="login_input" style="width:71px;" onfocus="this.style.border='#818181 1px solid'" onblur="this.style.border='#c2c3c5 1px solid'" /></span> 
            <span class="l"><img id="authImg" src="/webadmin/authImgServlet" onClick="refresh();" width="62" height="22" align="absmiddle" /> <a href="javascript:;" onClick="refresh();">看不清？</a></span>
          </dd>
        </dl>
        <dl>
           <dd><span id="showmsg"></span></dd>
        </dl>
        <dl class="login_btn"><a href="javascript:;" onclick="doCheckInput();">立即登录</a></dl>
        <dl class="lb_text" style="display:none;">还没有21-sun通行证？ <a href="#">立即注册</a></dl>
      </div>
    </div>
  </div>
  </form>
</div>
<div class="login_content">
  <div class="contain980">
    <div class="login_left">
      <div class="title">
        <h3>营销宝用户专享特权</h3>
      </div>
      <div class="content">
        <ul class="orderList">
          <li class="ol ol01">
            <em></em>
            <ul>
              <h3>信息管理</h3>
              <li>★ 信息发布无需繁琐注册</li>
              <li>★ 即发即推送商贸网或区域版块显著位置</li>
              <li>★ 区域信息最大化关注</li>
            </ul>
          </li>
          <li class="ol ol02">
            <em></em>
            <ul>
              <h3>营销推广</h3>
              <li>★ 让您的广告投放更精准</li>
              <li>★ 效果查看更真实，更好的提高广告转化率</li>
              <li>★ 按效果付费更划算</li>
              <li>★ 为您量身提供多种广告投放方案</li>
            </ul>
          </li>
          <li class="ol ol03">
            <em></em>
            <ul>
              <h3>订单管理</h3>
              <li>★ 在线询价，在线电话联系管理，让您的管理更及时</li>
              <li>★ 终端用户在线询价，进行即时推送</li>
              <li>★ 随时随地关注区域订单变化指数</li>
            </ul>
          </li>
          <li class="ol ol04">
            <em></em>
            <ul>
              <h3>数据分析</h3>
              <li>★ 各区域、品牌排行指数分析，让您的网上营销更精准</li>
              <li>★ 为营销策略制定提供依据，随时关注用户变化</li>
              <li>★ 区域订单变化指数更清晰</li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
    <div class="login_right">
      <div class="title">
        <h3>热门活动</h3>
      </div>
      <div class="content">
        <span class="w100 l mb10"><a href="http://ad.21-sun.com/link_to.jsp?paras=1,0,100016&url=http://product.21-sun.com/tuan/april/ " target="_blank"><img src="../images/ymtgg03.jpg" width="299" height="70" alt="优买团4月工程机械订货季！" /></a></span>
         <div class="w100 l mb10"><a href="http://product.21-sun.com/activity/hthsy/" target="_blank"><img src="../images/ads_order.jpg" width="299" height="70"  alt="3.18宏通好声音三一挖机网络订货会"/></a></div>
        <div class="w100 l mb10"><a href="http://product.21-sun.com/activity/yhsy/" target="_blank"><img src="../images/ads_order1.jpg" width="299" height="70"  alt="湖南中旺3.17大型挖机订货会"/></a></div>
        <ul class="activeList">
        <%
        	String sel_sql = "select top 4 id,title from pro_agent_news" ;
        	List<Map> newsList = dbHelper.getMapList(sel_sql) ;
        	if(null!=newsList && newsList.size()>0){
        		for(Map oneMap:newsList){
        			%>
        			<li><a href="/news/detail.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id")) %>&t_flag=product" target="_blank"><%=CommonString.getFormatPara(oneMap.get("title")) %></a></li>
        			<%
        		}
        	}
        %>
        </ul>
      </div>  
    </div>
  <div class="clear"></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<script type="text/javascript">
function refresh(){
		document.getElementById("authImg").src='/webadmin/authImgServlet?now=' + new Date();
}
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
function doCheckInput(){
	var agent_name = jQuery.trim(jQuery("#agent_name").val()) ;
	var agent_pass = jQuery.trim(jQuery("#agent_pass").val()) ;
	var rand = jQuery.trim(jQuery("#rand").val()) ;
	if(''==agent_name){
	   jQuery(".loginTip").hide() ;
	   jQuery("#loginTip_name").html("请输入用户名").show() ;
	   jQuery("#agent_name").focus() ;
	   return false ;
	}
	if(''==agent_pass){
	    jQuery(".loginTip").hide() ;
	   jQuery("#loginTip_code").html("请输入密码").show() ;
		jQuery("#agent_pass").focus() ;
		return false ;
	}
	if(''==rand){
	    jQuery(".loginTip").hide() ;
	   jQuery("#loginTip_yzm").html("请输入验证码").show() ;
		jQuery("#rand").focus() ;
		return false ;
	}
	jQuery("#loginform").ajaxSubmit({
		url:'/agent/action/ajax.jsp',
		type:'post',
		async:false ,
		success:function(msg){
			if(jQuery.trim(msg)=='0'){
				jQuery(".loginTip").hide() ;
	 			 jQuery("#loginTip_yzm").html("验证码错误").show() ;
				jQuery("#rand").focus() ;
				return false ;
			}
			if(jQuery.trim(msg)=='1'){
				setTimeout(function(){
					  window.location.href="http://member.21-sun.com/home/login_action.jsp?usern="+agent_name ;
				   //    window.location.href="http://192.168.50.98:1030/home/login_action.jsp?usern="+agent_name ;
				},10) ;
			}
			if(jQuery.trim(msg)=='3' || jQuery.trim(msg)=='4'){  // 厂家跳转
			   // window.location.href='/admin/factory/main.jsp';
			   setTimeout(function(){
				     window.location.href="http://member.21-sun.com/home/factory_login_action.jsp?usern="+agent_name+"&pwd="+agent_pass ;
				},10) ;
			}
			if(jQuery.trim(msg)=='2'){
			  jQuery(".loginTip").hide() ;
			  setTimeout(function(){
			  	  jQuery("#loginTip_name").html("用户名或密码错误").show() ;
			  },10) ;
			  jQuery("#agent_name").select() ;
			  return false ;
			}
		}
	}) ;
}
jQuery("#rand").keydown(function(e){
	if(e.keyCode==13){
		jQuery(".login_btn a").click();
	}
})
    jQuery("#loginform input").blur(function(){
	jQuery(".loginTip").hide() ;
    }) ;
    jQuery(function(){
    	    jQuery("#agent_name").focus() ;
    }) ;
</script> 
<!--end of foot--> 
</body>
</html>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
function joinUs(){
	jQuery.jBox("iframe:/include/agent/ding_dan_tong.jsp",{
		title : "申请加入营销宝",
		iframeScrolling:'no' ,
		buttons: { '确定' : false , '关闭': true  } ,
		width: 500,
		height : 280,
		submit : function(v,h,f){
			if(!v){
				var rs = jQuery.jBox.getIframe().contentWindow.doSub();
				return rs;
			}
		}
	});
}
</script>