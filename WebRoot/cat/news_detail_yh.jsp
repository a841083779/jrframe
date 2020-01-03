<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<% 
	String newsId = CommonString.getFormatPara(request.getParameter("id"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map newsMap = null;
	String title = "";
	String content = "";
	String news_type = "";
	String add_date = "";
	String seoContent = "";
	if(newsId!=null && !newsId.equals("")){
		try{
		    newsMap = dbHelper.getMap(" select title,content,news_type,add_date from pro_agent_news where id=?",new Object[]{newsId}) ;
		}catch(Exception e){
			System.out.println("卡特优惠政策错误");
		    e.printStackTrace();
	     }finally{
	     }
		if(newsMap == null){
			response.setStatus(301);
			response.setHeader("Location", "/cat/"); 
			return;	
		}else{
			title = CommonString.getFormatPara(newsMap.get("title"));
			content = CommonString.getFormatPara(newsMap.get("content"));
			news_type = CommonString.getFormatPara(newsMap.get("news_type"));
			add_date = CommonString.getFormatPara(newsMap.get("add_date"));
			seoContent = CommonHtml.filterHTML(content, 100);
		}
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		Common.doForward(request,response,"/404.htm");
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=title %>-铁臂商城卡特彼勒专区</title>
<meta name="Keywords" content="卡特挖机,卡特挖掘机,卡特彼勒公司,卡特电子商务平台 cat电商平台,挖掘机价格,挖掘机报价,挖机价格,挖机报价,挖掘机" />
<meta name="Description" content="卡特挖掘机电商平台是世界最大的挖掘机生产厂家之一卡特彼勒公司旗下的Cat电商平台卡特挖掘机价格查询中心。了解最新卡特挖机报价相关信息登录卡特挖掘机电商平台。" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body>

<!--top--begin-->
<jsp:include page="include/top.jsp" flush="true"></jsp:include>
<jsp:include page="include/nav.jsp" flush="true"></jsp:include>
<!--top--end-->

<div class="wrap_list">
  <div class="list_banner">
  <div class="word">
   	<h3>Cat®(卡特)小型挖掘主要亮点</h3>
        <p>卓越的性能，将生产效率最大化<br />
          先进的液压系统<br />
          安全舒适的驾驶室，长期操作也不易疲劳<br />
          液压系统可加装多种工装<br />
          强大的代理商网络提供世界级的售后服务和备件支持<br />
        Cat®(卡特) 车辆管理系统提供远程设备状况监控</p>
      </div>
  </div>
  <div class="list_con clearfix">
    <div class="list_left l">
      <ul class="up">
        <% if(news_type.equals("0")){	%>
      		<li class="cur"><a href="news.jsp?flag=news">Cat<sup>&reg;</sup>(卡特)新闻</a></li>
      	<%	}else{	%>
      		<li><a href="news.jsp?flag=news">Cat<sup>&reg;</sup>(卡特)新闻</a></li>
      	<%	} %>
      	<% if(news_type.equals("1")){	%>
      		<li class="cur"><a href="news.jsp?flag=pre">优惠政策</a></li>
      	<%	}else{	%>
      		<li><a href="news.jsp?flag=pre">优惠政策</a></li>
      	<%	} %>
      </ul>
    </div>
    <div class="news_list_right r">
      	<div class="right_top clearfix">
      		<div class=" share clearfix">
        		<h2><% if(news_type.equals("0")){	%>Cat<sup>&reg;</sup>(卡特)新闻<%	}else{	%>优惠政策<%	} %></h2>
        	</div>
      	</div>
      	<div class="news_content">
        <div class="news_top">
      		<h3><%=title %></h3>
            <div class="share clearfix">
            <span class="date">日期：<%=add_date.length()>10?add_date.substring(0,10):add_date %></span>
            <i>分享到:</i>
            <div class="jiathis_style">
	<a class="jiathis_button_renren"></a>
	<a class="jiathis_button_tsina"></a>
	<a class="jiathis_button_douban"></a>
	<a class="jiathis_button_tqq"></a>
	<a class="jiathis_button_kaixin001"></a>

</div>
</div>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=undefined" charset="utf-8"></script>
            </div>
            <div class="con">
            <%=content %>
      		</div>
      	</div>
      
    </div>
  </div>
  
	<!--foot--begin-->
	<jsp:include page="include/foot.jsp" flush="true"></jsp:include>
	<!--foot--end-->
	
</div>
<script type="text/javascript" src="scripts/comm.js"></script> 
<script type="text/javascript">
function nTabs(thisObj, Num) {
	if (thisObj.className == "active") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "active";
			document.getElementById(tabObj + "_Content" + i).style.display = "block";
		} else {
			tabList[i].className = "normal";
			document.getElementById(tabObj + "_Content" + i).style.display = "none";
		}
	}
}
$(document).ready(function(e) {
    $('.TabTitle li').click(function(){
		$('html,body').stop(1,0).animate({scrollTop:$('.TabTitle').offset().top},500);
	})
});
</script>
</body>
</html>