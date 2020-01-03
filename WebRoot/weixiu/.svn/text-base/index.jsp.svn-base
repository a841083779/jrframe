<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
    int loginFlag=1;
	String nickname=""; String img=""; String usern=""; String password="";
    Map memberInfo = (Map)session.getAttribute("memberInfo");
    if(memberInfo==null){
			loginFlag=0;

	}else{
		usern= CommonString.getFormatPara(memberInfo.get("username"));
	    nickname= CommonString.getFormatPara(memberInfo.get("nickname"));
		password=CommonString.getFormatPara(memberInfo.get("password"));
		if(nickname.equals("")){nickname=usern;}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta name="renderer" content="webkit">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/weixiu/style/weixiu.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<title>【工程机械维修】工程机械维修网点_工程机械维修知识 - 铁臂维修</title>
<meta name="keywords" content="工程机械维修,工程机械维修网点,工程机械维修知识,工程机械" />
<meta name="description" content="铁臂维修为您提供挖掘机、装载机、起重机、破碎锤、路面机械、混凝土机械等工程机械维修、维修网点、维修知识等信息，买工程机械就上铁臂商城。" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 clearfix">
  <div class="left01 ">
    <div class="clearfix mb20">
      <div class="index_news _tab_title ">
        <div class="_T">
          <h2 class="_N">维修图片</h2>
        </div>
        <div class="_C">
          <div class="slide">
		  	    <jsp:include page="/include/weixiu/news_index_pic.htm" flush="true" />
          </div>
        </div>
      </div>
      <div class="index_news_blocks">
	    <jsp:include page="/include/weixiu/news_index.htm" flush="true" />
      </div>
    </div>
    <div class=" _tab_title mb20">
      <div class="_T">
        <h2 class="_N">挖掘机维修大全</h2>
        <a href="/plist-101001-0-0.htm" target="_blank" class="_more" title="更多挖掘机维修">更多&gt;&gt;</a> </div>
      <div class="_C">
	           <jsp:include page="/include/weixiu/wjj_index.htm" flush="true" />
      </div>
    </div>
    
    <div class=" _tab_title mb20">
      <div class="_T">
        <h2 class="_N">装载机维修大全</h2>
        <a href="/plist-101002-0-0.htm" target="_blank" class="_more" title="更多装载机维修">更多&gt;&gt;</a> </div>
      <div class="_C">
     	       <jsp:include page="/include/weixiu/zzj_index.htm" flush="true" />
      </div>
    </div>
    
    <div class=" _tab_title mb20">
      <div class="_T">
        <h2 class="_N">推土机维修大全</h2>
        <a href="/plist-101003-0-0.htm" target="_blank" class="_more" title="更多推土机维修">更多&gt;&gt;</a> </div>
      <div class="_C">
          	 <jsp:include page="/include/weixiu/ttj_index.htm" flush="true" />
      </div>
    </div>
    
  </div>
  <div class="nre_left" style="float:right">
    <div class="index_log mb10">

	     <%if(loginFlag==0){%>
        <div class="_layer">
          <div class="_row">
            <label for="username" class="_t">用户名</label>
            <input type="text" id="username" class="_inp" />
          </div>
          <div class="_row">
            <label for="password" class="_t">密码</label>
            <input type="password" id="password" class="_inp" onKeyDown="if(event.keyCode==13){doLogin();}" />
          </div>

          <div class="_act_bar">
            <button href="javascript:void(0)"  onclick="doLogin();" class="_sub">立即登录</button>
            <a href="http://koubei.21-sun.com/activity/koubei/register.jsp" class="_link" target="_blank">免费注册</a> </div>
        </div>
		<%}else{%>
		 <div class="_layer" style="height:110px;">
           <div style="float:left" ><a target="_blank" href="javascript:void(0)" onclick="goTO()">
		   <img  src="<%= CommonString.getFormatPara(memberInfo.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" width="99" height="99" />
		   </a>
		   </div>
           <div style="float:left"><strong><a target="_blank" href="javascript:void(0)" onclick="goTO()"><%=nickname%><br>个人中心</a></strong><br><br><br><br><a href="javascript:void(0)"  onclick="loginOut();" style="display: inline-block;width: 111px;height: 30px;background: url(http://product.21-sun.com/koubei/images/out_btn.png) no-repeat;letter-spacing: -9px;"></a></div>
	   </div>
		<%}%>
  
    </div>
	
	

	  
	  
    <div class="index_log_bar mb10"> <a><img src="/weixiu/images/ad/ad03.jpg"  /></a> </div>
    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3>热门区域维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">	
            <li><a href="/0-105500-0.htm" title="北京维修">北京</a></li>
			<li><a href="/0-105300-0.htm" title="上海维修">上海</a></li>
			<li><a href="/0-105690-0.htm" title="天津维修">天津</a></li>
			<li><a href="/0-105880-0.htm" title="重庆维修">重庆</a></li>
			<li><a href="/0-106410-0.htm" title="石家庄维修">石家庄</a></li>
			<li><a href="/0-108310-0.htm" title="太原维修">太原</a></li>
			<li><a href="/0-109710-0.htm" title="呼和浩特维修">呼和浩特</a></li>
			<li><a href="/0-120010-0.htm" title="沈阳维修">沈阳</a></li>
			<li><a href="/0-119010-0.htm" title="长春维修">长春</a></li>
			<li><a href="/0-122010-0.htm" title="哈尔滨维修">哈尔滨</a></li>
			<li><a href="/0-110910-0.htm" title="南京维修">南京</a></li>
			<li><a href="/0-104210-0.htm" title="杭州维修">杭州</a></li>
			<li><a href="/0-102320-0.htm" title="合肥维修">合肥</a></li>
			<li><a href="/0-142010-0.htm" title="福州维修">福州</a></li>
			<li><a href="/0-103110-0.htm" title="南昌维修">南昌</a></li>
			<li><a href="/0-101260-0.htm" title="济南维修">济南</a></li>
			<li><a href="/0-130010-0.htm" title="郑州维修">郑州</a></li>
			<li><a href="/0-124010-0.htm" title="武汉维修">武汉</a></li>
			<li><a href="/0-126010-0.htm" title="长沙维修">长沙</a></li>
			<li><a href="/0-128010-0.htm" title="广州维修">广州</a></li>
			<li><a href="/0-113010-0.htm" title="南宁维修">南宁</a></li>
			<li><a href="/0-141510-0.htm" title="海口维修">海口</a></li>
			<li><a href="/0-139010-0.htm" title="成都维修">成都</a></li>
			<li><a href="/0-132010-0.htm" title="贵阳维修">贵阳</a></li>
			<li><a href="/0-137010-0.htm" title="昆明维修">昆明</a></li>
			<li><a href="/0-115010-0.htm" title="拉萨维修">拉萨</a></li>
			<li><a href="/0-135510-0.htm" title="西安维修">西安</a></li>
			<li><a href="/0-134010-0.htm" title="兰州维修">兰州</a></li>
			<li><a href="/0-133010-0.htm" title="西宁维修">西宁</a></li>
			<li><a href="/0-116010-0.htm" title="银川维修">银川</a></li>
			<li><a href="/0-117010-0.htm" title="乌鲁木齐维修">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>
    <div class="rp clearfix mb10 haspic" style="display:none">
      <div class="title">
        <h3>维修达人</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
          <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm"> <img src="/weixiu/images/ad/ad04.jpg" alt="" />
            <p class="t">马尔克斯</p>
            </a></li>
          <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm"> <img src="/weixiu/images/ad/ad04.jpg" alt="" />
            <p class="t">马尔克斯</p>
            </a></li>
          <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm"> <img src="/weixiu/images/ad/ad04.jpg" alt="" />
            <p class="t">马尔克斯</p>
            </a></li>
          <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm"> <img src="/weixiu/images/ad/ad04.jpg" alt="" />
            <p class="t">马尔克斯</p>
            </a></li>
        </ul>
      </div>
    </div>
    <div class="rp clearfix mb10 hasdate">
      <div class="title">
        <h3>维修心得</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
             <jsp:include page="/include/weixiu/xinde_list.jsp" flush="true"/>
		</ul>
      </div>
    </div>
  </div>
</div>


<jsp:include page="/include/index/friendlink_weixiu.htm" flush="true"/>
<jsp:include page="/include/foot.jsp" flush="true"/>
</body>
<script src="http://product.21-sun.com/weixiu/scripts/weixiu.js" ></script>
<script>
$('.index_news .slide').slide({
	
	})
	
	function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#username").val())+'&p='+encodeURI(jQuery("#password").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("登录成功！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}
		}
	});
}

function loginOut(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout',
		async:false,
		cache:false,
		success:function(data){
				jQuery.jBox.tip("退出成功！");
				setTimeout("parent.window.location.reload()",1000);
		}
	});
}

function goTO(){
window.open("http://product.21-sun.com/member/index.jsp?usernn=<%=usern%>&password=<%=password%>");
}
</script>
</html>
