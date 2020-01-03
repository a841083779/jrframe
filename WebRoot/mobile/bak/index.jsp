﻿<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
    StringBuffer whereStr = new StringBuffer(" and is_show=1");
	if (!"".equals(catalog)) {
			whereStr.append(" and catalognum like '" + catalog + "%'");
			//catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
	}
	if (!"".equals(factory)) {  
			whereStr.append(" and factoryid=" + factory);
	}
	try{
	    connection = dbHelper.getConnection();
		
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(6); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
		pageBean.setOrderBy(" view_count desc"); // 点击量排序
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum,price_start,price_end,view_count");
		pageBean.setTableName("pro_products");
		List<Map> searchProducts = pageBean.getDatas(connection); // 根据条件查出的产品
		//TDK
		String newTitle="工程机械";
		String newDesc="工程机械";
		String newTitleEnd="工程机械";
		String showtonandmeter="";String keyword="";
		String keywords1="";String keywords2="";String keywords3="";String keywords4="";String keywords5="";
		if(!"".equals(factory)){keywords1=CommonString.getFormatPara(brandMap.get(factory))+"价格表,";}
        if(!"".equals(catalog)){keywords2=CommonString.getFormatPara(catalogMap.get(catalog))+"价格表,";}
		if(!"".equals(catalog)&&!"".equals(factory)){keywords3=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+CommonString.getFormatPara(catalogMap.get(catalog))+"价格表";}
		if(!"".equals(catalog)&&!"".equals(factory)&&!"".equals(showtonandmeter)){keywords5=showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog))+",";}
		String newKeyWord=keywords5+keywords4+keywords2+keywords1+keywords3;
		if(newKeyWord.equals("")){newKeyWord="工程机械,工程机械价格表,工程机械产品大全";}
		else if(newKeyWord.endsWith(",")){newKeyWord=newKeyWord.substring(0,newKeyWord.length()-1);}
		
		if(!"".equals(factory)&&!"".equals(catalog)){
		       newTitle=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newDesc=("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		}else if(!"".equals(factory)||!"".equals(catalog)){
		
		   newTitle=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   newDesc=("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   if("".equals(catalog)){
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog))+"产品";
		   }else{
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   }
		}
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
<title>【底价】<%=newTitle%>_<%=newTitle%>价格表_<%=newTitleEnd%>大全 - 铁臂商城</title>
<meta name="keywords" content="<%=newKeyWord%>" />
<meta name="description" content="铁臂商城<%=newDesc%>专区,为您提供<%=newDesc%>价格、<%=newDesc%>型号、<%=newDesc%>图片等详细信息,帮您全面了解<%=newDesc%>,买<%=newDesc%>产品就上铁臂商城。" />
<link href="Static/css/style.css" rel="stylesheet" />
<script src="http://product.21-sun.com/scripts/scripts.js"></script>
<script src="http://product.21-sun.com/scripts/jquery-1.7.min.js"></script>
</head>
<body>
<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a>
  <a href="/brands_list.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" class="search">筛选<img src="Static/img/search_ico.png"></a>
</header>
<nav>
  <ul>
    <li><a href="/index.jsp?catalog=101001" <%if(catalog.equals("101001")){%>class="cur"<%}%>>挖掘机</a></li>
    <li><a href="/index.jsp?catalog=101002" <%if(catalog.equals("101002")){%>class="cur"<%}%>>装载机</a></li>
    <li><a href="/index.jsp?catalog=101005" <%if(catalog.equals("101005")){%>class="cur"<%}%>>平地机</a></li>
    <li class="more"><span class="n">更多</span>
      <div class="box">
        <a href="/index.jsp?catalog=101003">推土机</a>
        <a href="/index.jsp?catalog=104001">摊铺机</a>
        <a href="/index.jsp?catalog=107">叉车</a>
        <a href="/index.jsp?catalog=102">起重机</a>
        <a href="/index.jsp?catalog=106001">压路机</a>
      </div>
    </li>
  </ul>
</nav>
<ul class="proList">
   <%	 
        String orderCount="";
		if (searchProducts != null && searchProducts.size() > 0) {
			for (Map oneMap : searchProducts) {
  %>
  <li>
    <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname")+(String) oneMap.get("name")+(String)oneMap.get("catalogname"))%>" class="int">
      <img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")).replace("image","")%>">
      <div class="n"><%=CommonString.getFormatPara((String) oneMap.get("factoryname")+(String) oneMap.get("name")+(String)oneMap.get("catalogname"))%></div>
      <div class="p">
	  参考价格：
	  <%if(CommonString.getFormatPara(oneMap.get("price_start")).equals("0")&&CommonString.getFormatPara(oneMap.get("price_end")).equals("0")){%>
	    <font>面议</font>
	  <%}else{%>
	      <font><%=CommonString.getFormatPara(oneMap.get("price_start")).equals("0")?"0":CommonString.getFormatPara(oneMap.get("price_start"))%>-<%=CommonString.getFormatPara(oneMap.get("price_start")).equals("0")?"未定":CommonString.getFormatPara(oneMap.get("price_start"))%>万</font>
	  <%}%>
	  </div>
	  
	  <%
	      Map one_Count = dbHelper.getMap("  select  count(id) as counts from pro_product_form where product_id="+CommonString.getFormatPara(oneMap.get("id")));
	      if(one_Count !=null ){
	         orderCount=CommonString.getFormatPara(one_Count.get("counts"));
	
	}
	  %>
      <div class="num"><span>询价：<%=orderCount%>次</span><span>浏览：<%=CommonString.getFormatPara(oneMap.get("view_count"))%>次</span></div>
    </a>
    <dl class="btn">
      <dd class="b1"><a href="tel:4006-521-526"><img src="Static/img/btn_tel.png">询问底价</a></dd>
      <dd class="b2"><a href="/form.jsp?pid=<%=CommonString.getFormatPara(oneMap.get("id"))%>"><img src="Static/img/btn_buy.png">立即订购</a></dd>
    </dl>
  </li>
  <%}}%>
  

</ul>
<div class="paging">
    <tags:page_mobile pageBean="<%=pageBean%>" />

</div>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="http://koubei.21-sun.com/"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>


<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>