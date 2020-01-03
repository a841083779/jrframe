<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
    Map oneMap = null ;
%>
<!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>铁臂商城</title>
<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body class="brands">
<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="#" class="bc"><img src="Static/img/back.png"></a>
  <a href="#" class="search">筛选<img src="Static/img/search_ico.png"></a>
</header>

<div class="brandsList">
  <ul class="section">
    <li class="blt">热门品牌</li>
	
	
	
    <li><a href="/mobile/list.jsp?factory=133"><img src="Static/img/temp/temp_b01.png"><h3>三一</h3></a></li>
    <li><a href="/mobile/list.jsp?factory=209"><img src="Static/img/temp/temp_b02.png"><h3>徐工</h3></a></li>
    <li><a href="/mobile/list.jsp?factory=174"><img src="Static/img/temp/temp_b03.png"><h3>卡特彼勒</h3></a></li>
    <li><a href="/mobile/list.jsp?factory=137"><img src="Static/img/temp/temp_b04.png"><h3>山东临工</h3></a></li>
    <li><a href="/mobile/list.jsp?factory=144"><img src="Static/img/temp/temp_b05.png"><h3>山推股份</h3></a></li>
  </ul>
  <ul class="section">
    <li class="blt zm">A</li>
	
	
	<%   
	     List<Map> brandlist	= null ;
	     String sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='A'" ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
			<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>

	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">B</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='B'" ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">C</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='C'" ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">D</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='D'" ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>

  <ul class="section">
    <li class="blt zm">F</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='F' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">G</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='G' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">H</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='H' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>

  <ul class="section">
    <li class="blt zm">J</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='J' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">K</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='K' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">L</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='L' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">M</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='M' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">N</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='N' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>

  <ul class="section">
    <li class="blt zm">P</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='P' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">Q</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='Q' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">R</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='R' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">S</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='S' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">T</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='T' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>

  <ul class="section">
    <li class="blt zm">W</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='W' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">X</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='X' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">Y</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='Y' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
  <ul class="section">
    <li class="blt zm">Z</li>
	<%   
	      sql = "select name,id,logo from pro_agent_factory where is_show =1 and flag=1 and upper_index='Z' " ;
	     brandlist = dbHelper.getMapList(sql) ;
	%>
		<% 
				for(int i=0;i<brandlist.size();i++){
					oneMap = (HashMap)brandlist.get(i);

        %>
    <li><a href="#"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo"))%>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))%></h3></a></li>
	<%}%>
  </ul>
</div>
<div class="side_zm" id="SG">
  <ul>
    <li class="hot active"><a href="#">★</a></li>
    <li><a href="#">A</a></li>
    <li><a href="#">B</a></li>
    <li><a href="#">C</a></li>
    <li><a href="#">F</a></li>
    <li><a href="#">G</a></li>
    <li><a href="#">H</a></li>
    <li><a href="#">J</a></li>
    <li><a href="#">K</a></li>
    <li><a href="#">L</a></li>
    <li><a href="#">M</a></li>
    <li><a href="#">N</a></li>
    <li><a href="#">P</a></li>
    <li><a href="#">Q</a></li>
    <li><a href="#">R</a></li>
    <li><a href="#">S</a></li>
    <li><a href="#">T</a></li>
    <li><a href="#">W</a></li>
    <li><a href="#">X</a></li>
    <li><a href="#">Y</a></li>
    <li><a href="#">Z</a></li>
  </ul>
</div>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="#"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('app/brands.js');
</script>
</html>
