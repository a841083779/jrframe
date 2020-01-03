<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	PageBean pageBean = new PageBean() ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	List<Map> newsList=null;
	if(flag.equals("pre")){
		
	pageBean.setTableName("pro_agent_news") ;
	pageBean.setFields(" id,title,add_date ");
	String whereStr = " and agent_id=174 ";
	if (flag!=null && !"".equals(flag)) {
		if(flag.equals("news")){
			whereStr +=" and news_type=0 ";
		}else if(flag.equals("pre")){
			whereStr +=" and news_type=1 ";
		}
	}
	pageBean.setCondition(whereStr);
	pageBean.setOrderBy(" add_date desc , id desc ");
	pageBean.setPageSize(15);
	Integer nowPage = 1;
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}; // 当前页
	pageBean.setNowPage(nowPage);
	pageBean.setIsShowSql(true);
	newsList = pageBean.getDatas();
	
	}else {
		
	pageBean.setTableName("article") ;
	pageBean.setFields(" id,title,add_date ");
	String whereStr = " and is_pub=1 and title like '%卡特%'  ";
	pageBean.setCondition(whereStr);
	pageBean.setOrderBy("  id desc ");
	pageBean.setPageSize(15);
	Integer nowPage = 1;
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}; // 当前页
	pageBean.setNowPage(nowPage);
	newsList = pageBean.getDatasByWebService("Web21NewsDBHelper");

		
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>最新卡特<% if(flag.equals("news")){	%>新闻<%	}else{ %>优惠政策<%	} %>-卡特彼勒公司旗下挖掘机价格查询中心，卡特挖掘机电商平台，最新卡特挖机报价【Cat电商平台】</title>
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
        <% if(flag.equals("news")){	%>
      		<li class="cur">Cat<sup>&reg;</sup>(卡特)新闻</li>
      	<%	}else{	%>
      		<li><a href="news.jsp?flag=news">Cat<sup>&reg;</sup>(卡特)新闻</a></li>
      	<%	} %>
      	<% if(flag.equals("pre")){	%>
      		<li class="cur">优惠政策</li>
      	<%	}else{	%>
      		<li><a href="news.jsp?flag=pre">优惠政策</a></li>
      	<%	} %>
      	
      </ul>
    </div>
    <div class="news_list_right r">
      	<div class="right_top clearfix">
      		<div class=" share clearfix">
        		<h2><% if(flag.equals("news")){	%>Cat<sup>&reg;</sup>(卡特)新闻<%	}else{	%>优惠政策<%	} %></h2>
        	</div>
      	</div>
      	<!-- 
      	<div class="top_one_news">
      		<div class="top_one_news_img">
      			<img src="images/top_one_news_img.jpg" alt="发布梦想蓝图，赢Cat®(卡特)海外工厂参观之旅！" onerror="" />
      		</div>
      		<div class="top_one_news_right">
      			<h3>发布梦想蓝图，赢Cat®(卡特)海外工厂参观之旅！</h3>
      			<p>
      				Cat®（卡特）一贯致力于与中国客户发展长久牢固的伙伴关系，共同收获未来的进步和成功。同时来自中国各个地区的Cat（卡特）用户，也用他们自己的亲身经历，见证了Cat（卡特）和他们一起成长、发展和壮大的成功历程。
      				<a href="#" target="_blank" class="detail">【查看详情】</a>
      			</p>
      			<div class="top_one_news_date">
      				发布时间：2013-12-28
      			</div>
      		</div>
      		<div class="clear"></div>
      	</div>
      	 -->
      	<ul class="news_list">
      	<%
        	if(null!=newsList && newsList.size()>0){
        		for(Map oneMap:newsList){
        			String id = CommonString.getFormatPara(oneMap.get("id"));
        			String title = CommonString.getFormatPara(oneMap.get("title"));
        			String add_date = CommonString.getFormatPara(oneMap.get("add_date"));
					String url="news_detail.jsp";
					if(flag.equals("pre")){
						url="news_detail_yh.jsp";
					}
       %>
      		<li><a target="_blank" href="<%=url%>?id=<%=id %>"><%=title %></a>
            	<span><%=add_date.length()>10?add_date.substring(0,10):add_date %></span>
            </li>
      <%}} %>
      	</ul>
      	<% if(pageBean.getPageCount()>1){ %>
        <div id="pagination" class="paging">
      	<tags:cat_page pageBean="<%=pageBean%>" />
    	</div>
    	<%} %>
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
<script>
    var ref = ''; 
    if (document.referrer.length > 0) { 
        ref = document.referrer; 
    } 
    try { 
       if (ref.length == 0 && opener.location.href.length > 0) { 
       ref = opener.location.href; 
        } 
    }catch (e) {}
   	jQuery.ajax({
    	type:'post',
    	url:'ajax.jsp',
    	data:{flag:'visitHistory',ref:ref} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>