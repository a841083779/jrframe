<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String orderid = CommonString.getFormatPara(request.getParameter("id")) ; // 一条产品订单的id
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;  // 偏移量
	String province = CommonString.getFormatPara(request.getParameter("province")) ;
	String city = CommonString.getFormatPara(request.getParameter("city")) ;
	Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
    Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;
	String search_province="";
	String search_city="";
	if(!"".equals(orderid) && orderid.indexOf("?")!=-1){
		orderid = orderid.substring(0,orderid.indexOf("?")) ;
	}
	if(orderid != null && orderid.length() >= 10){
		response.setStatus(301);
		response.setHeader("Location", "/inquiry/"); 
		return;	
	}
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map oneOrder = dbHelper.getMap(" select id,view_count,factoryname,cataname,name,mobile_phone,contact_tel,contact_address,product_name,add_date,message,product_id,factoryid,catanum from pro_product_form where is_deleted=0 and id=?",new Object[]{orderid}) ;
	if(oneOrder == null){
		response.setStatus(301);
		response.setHeader("Location", "/inquiry/"); 
		return;	
	}
	Map oneProduct = new HashMap() ;
	if(oneOrder != null && !"".equals(CommonString.getFormatPara(oneOrder.get("product_id"))) && !"null".equalsIgnoreCase(CommonString.getFormatPara(oneOrder.get("product_id")))){ // 如果产品id是空，则查询品牌
		oneProduct = dbHelper.getMap(" select id,factoryid,factoryname,catalognum,catalogname,name,img2,introduce,file_name from pro_products where id=?",new Object[]{CommonString.getFormatPara(oneOrder.get("product_id"))}); // 取出一个产品记录
	}else{
		oneProduct = dbHelper.getMap(" select top 1 id,factoryid,factoryname,catalognum,catalogname,name,img2,introduce,file_name from pro_products where factoryid=? order by id desc ",new Object[]{CommonString.getFormatPara(oneOrder.get("factoryid"))}); // 取出一个产品记录
	}
	String showtel = "".equals(CommonString.getFormatPara(oneOrder.get("mobile_phone")))?CommonString.getFormatPara(oneOrder.get("contact_tel")):CommonString.getFormatPara(oneOrder.get("mobile_phone")) ;
	if(showtel.length()>7&&showtel.length()<=20){
		showtel = showtel.substring(0,2)+"*****"+showtel.substring(showtel.length()-2) ;
	}else if(showtel.length()>3){
		showtel = showtel.substring(0,4)+"*******" ;
	}else
	{
		showtel = showtel+"*******" ;
	}
	// 分布处理
	StringBuffer whereStr = new StringBuffer(" and is_deleted=0") ;
	if(!"".equals(CommonString.getFormatPara(oneOrder.get("factoryid")))){
		whereStr.append(" and factoryid = "+CommonString.getFormatPara(oneOrder.get("factoryid"))+"") ;
	}
	if(!"".equals(CommonString.getFormatPara(oneOrder.get("product_id")))){
		whereStr.append(" and product_id ="+CommonString.getFormatPara(oneOrder.get("product_id"))+"") ;
	}
    if(!"".equals(city)&&city!=null){
	   search_city = ((String)hzpyMap.get(city)).replace("市","");
	   whereStr.append(" and city like '%"+search_city+"%'") ;
	}
	if(!"".equals(province)&&province!=null){
	   search_province = (String)hzpyMap.get(province);
	   whereStr.append(" and province like '%"+search_province+"%'") ;
	}
	
	//区域该产品订单查询
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(10) ;
	 Integer nowPage = 1 ;
	  if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	  }
	pageBean.setNowPage(nowPage) ;
	List<Map> pro_orders = new ArrayList() ;
	pageBean.setTableName("pro_product_form") ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" id,factoryname,cataname,product_name,name,contact_tel,mobile_phone,contact_address,add_date,factoryid,province,city") ;
	pageBean.setOrderBy(" add_date desc") ;
	//区域该类别产品订单查询
	StringBuffer whereStrCata= new StringBuffer(" and 1=1");
	 if(!"".equals(city)&&city!=null){
	   search_city = ((String)hzpyMap.get(city)).replace("市","");
	   whereStrCata.append(" and city like '%"+search_city+"%'") ;
	}
	if(!"".equals(province)&&province!=null){
	   search_province = (String)hzpyMap.get(province);
	   whereStrCata.append(" and province like '%"+search_province+"%'") ;
	}
	whereStrCata.append(" and catanum = '"+CommonString.getFormatPara(oneOrder.get("catanum"))+"'") ;
    PageBean pageBeanCata = new PageBean() ;
	pageBeanCata.setPageSize(10) ;
	 Integer nowPageCata = 1 ;
	  if(!"".equals(offset) && !"0".equals(offset)){
		   nowPageCata = Integer.parseInt(offset)/pageBeanCata.getPageSize()+1 ;
	  }
	pageBeanCata.setNowPage(nowPageCata) ;
	List<Map> pro_cata_orders = new ArrayList() ;
	pageBeanCata.setTableName("pro_product_form") ;
	pageBeanCata.setCondition(whereStrCata.toString()) ;
	pageBeanCata.setFields(" id,factoryname,cataname,product_name,name,contact_tel,mobile_phone,contact_address,add_date,factoryid,province,city") ;
	pageBeanCata.setOrderBy(" add_date desc") ;
	
	if(oneProduct == null){
		Common.do302(response,"/inquiry/");
		return;
	}
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("factoryname"))) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalogname"))) %>价格表】<%=CommonString.getFormatPara(oneOrder.get("contact_address")) %><%=search_province%><%=search_city%><%=(CommonString.getFormatPara(oneOrder.get("name")).length()>1)?CommonString.getFormatPara(oneOrder.get("name")).substring(0,1)+"***":"张**" %><%=showtel %><%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("factoryname"))) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalogname"))) %>询价单 - 铁臂商城</title>
<meta name="keywords" content="<%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %>价格表,<%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>价格表,<%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>价格表, <%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>最新询价单" />
<meta name="description" content="咨询【<%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>成交价格】请上铁臂商城,铁臂商城提供最新的<%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>价格,帮助您了解工<%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>价格的最新动态。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; 
  <a href="/inquiry/">采购询价</a> &gt;&gt; 
  <a href="/inquiry/0_0_<%=CommonString.getFormatPara(oneProduct==null?"0":oneProduct.get("factoryid")) %>_0_0.shtm"><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %></a>&gt;&gt;
  <a href="/inquiry/0_0_0_<%=CommonString.getFormatPara(oneProduct.get("catalognum")).length()>=6?CommonString.getFormatPara(oneProduct.get("catalognum")).substring(0,6):CommonString.getFormatPara(oneProduct.get("catalognum")) %>_0.shtm"><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %></a>&gt;&gt;
   <a  href="/inquiry/0_0_<%=CommonString.getFormatPara(oneProduct.get("factoryid")) %>_<%=CommonString.getFormatPara(oneProduct.get("catalognum")).length()>=6?CommonString.getFormatPara(oneProduct.get("catalognum")).substring(0,6):CommonString.getFormatPara(oneProduct.get("catalognum")) %>_0.shtm "><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %></a>   
  &gt;&gt; <%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>价格</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
<jsp:include page="/include/agent/left_inquiry.jsp" flush="true"></jsp:include>
  <!--left end--> 
  <!--right-->
  <%
  	String cDate = CommonDate.getToday("yyyy-MM-dd HH:mm");
	String addDate = (CommonString.getFormatPara(oneOrder.get("add_date")).length()>15)?CommonString.getFormatPara(oneOrder.get("add_date")).substring(0,16):CommonString.getFormatPara(oneOrder.get("add_date"));
	if(cDate.compareTo(addDate) < 0){
		addDate = cDate;	
	}
  %>
  <div class="w757 r">
    <div class="w755 border03 l rightPart03 mb10">
      <div class="title08">
        <h3><b><%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>最新询价单</b></h3>
        <span>询价时间：<%= addDate%>　　浏览次数：<%=CommonString.getFormatPara(oneOrder.get("view_count")) %></span> </div>
      <div class="li">
        <ul>
          <li class="i8">联 系 人：<%=(CommonString.getFormatPara(oneOrder.get("name")).length()>1)?CommonString.getFormatPara(oneOrder.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i9">联系电话：<%=showtel %></li>
          <li class="i10">所在地区：<%=CommonString.getFormatPara(oneOrder.get("contact_address")) %></li>
          <li class="i11">留言内容：<%="".equals(CommonString.getFormatPara(oneOrder.get("message")))?"该订单无留言！":CommonString.getFormatPara(oneOrder.get("message")) %></li>
        </ul>
      </div>
      <div class="wfull l alignCenter pb15"> <a href="javascript:;" title="免费询价" onclick="showinquery('<%=CommonString.getFormatPara(oneOrder.get("product_id")) %>','<%=CommonString.getFormatPara(oneOrder.get("factoryid")) %>')"><img src="../images/pd_btn.gif" alt="免费询价" width="188" height="45" class="mb10" /></a><br />
        <strong>因不同地区代理商及价格差异，请您点击<b onclick="showinquery('<%=CommonString.getFormatPara(oneOrder.get("product_id")) %>','<%=CommonString.getFormatPara(oneOrder.get("factoryid")) %>')" style="color:red; cursor:pointer">咨询最低价</b>。</strong> </div>
        <%
			if(oneProduct != null){
		%>
      <div class="plist">
        <ul>
          <li> <a href="/proDetail/<%=CommonString.getFormatPara(oneProduct.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneProduct.get("img2")).toLowerCase() %>" onerror="this.src='/uploadfiles/no_small.gif'" width="130" height="90" class="plimg" alt="<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct.get("catalogname")) %>" title="<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct.get("catalogname")) %>"/></a>
            <div class="w618 r">
              <h2><a href="/proDetail/<%=CommonString.getFormatPara(oneProduct.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct.get("catalogname")) %></a></h2>
              <span class="info"><a href="/inquiry/index.jsp?proId=<%=CommonString.getFormatPara(oneOrder.get("product_id")) %>" target="_blank">订单</a> <em>|</em> <a href="http://photo.21-sun.com/list.jsp?factoryid=<%=CommonString.getFormatPara(oneOrder.get("factoryid")) %>&catalogid=<%=CommonString.getFormatPara(oneOrder.get("catanum")).length()>=6?CommonString.getFormatPara(oneOrder.get("catanum")).substring(0,6):CommonString.getFormatPara(oneOrder.get("catanum"))%>" target="_blank">图片</a> <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneProduct.get("id")) %>','')" class="plbtn">询价</a></span>
              <div class="plInfo"> <%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(oneProduct.get("introduce"))),150) +"..."%><b><a href="/proDetail/<%=CommonString.getFormatPara(oneProduct.get("file_name")) %>" target="_blank">[查看详情]</a></b> </div>
              <div class="wfull l">询价单号：<%=orderid %> 
			    <div style="float:right;"><a target="_blank" href="/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneProduct.get("factoryid")) %>"><span style="color:#2e65b7"><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %></span></a>|<a target="_blank" href="/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneProduct.get("factoryid")) %>&catalog=<%=CommonString.getFormatPara(oneProduct.get("catalognum")).length()>=6?CommonString.getFormatPara(oneProduct.get("catalognum")).substring(0,6):CommonString.getFormatPara(oneProduct.get("catalognum")) %>"><span style="color:#2e65b7"> <%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %></span></a> </div>
			  </div>
            </div>
          </li>
        </ul>
      </div>
      <%
			}
	  %>
    </div>
	
	<!--该产品本地区订单-->
    <cache:cache cron="*/1 * * * *">
    <%
		pro_orders = pageBean.getDatas() ;
	%>
    <!--询价列表-->
    <div class="w755 border03 l mb10 list08">
      <div class="title08 listTop">
        <h3><b><%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>询价单总数：<%=pageBean.getTotal() %></b> </h3>
        <div class="r" style="padding-top:0px;"> <a title="
		<%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>询价单" href="/inquiry/" target="_blank">更多</a>  </div>
      </div>
      <ul class="ti">
        <li class="i1">编号</li>
        <li class="i2">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7">询价时间</li>
      </ul>
      <div class="li" id="showorders">
        <%
       int i=1;
      if(null!=pro_orders && pro_orders.size()>0){
    	  String showtel02 = "" ; 
    	  for(Map oneMap:pro_orders){
	        showtel02 = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
        		
        		if(showtel02.length()>7&&showtel02.length()<=20){
        			showtel02 = showtel02.substring(0,2)+"***"+showtel02.substring(showtel02.length()-2) ;
        		}else if(showtel02.length()>3){
        			showtel02 = showtel02.substring(0,4)+"***" ;
        		}else
        		{
        			showtel02 = showtel02+"***" ;
        		}
    		  %>
        <ul class="libg01">
          <li class="i1"><%=i %></li>
          <li class="i2" style="text-align:left"><a href="detail_for_<%=oneMap.get("id") %>.htm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name"))%><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>1)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel02 %></li>
          <li class="i5"><a href="/inquiry/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_0_0.shtm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6">
		  <a href="/inquiry/<%=(String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))%>_0_0_0_0.shtm"><%="".equals(CommonString.getFormatPara(oneMap.get("province")))?"-":CommonString.getFormatPara(oneMap.get("province"))  %></a>
		  <a href="/inquiry/<%=(String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))%>_<%if(((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city"))))==null){%>0<%}else{%><%=((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city")))) %><%}%>_0_0_0.shtm"><%="".equals(CommonString.getFormatPara(oneMap.get("city")))?"-":CommonString.getFormatPara(oneMap.get("city"))  %></a>
		  </li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>
        <%
            i++ ;
            }
      }
      %>
      </div>
      <!--翻页-->

    </div>
	</cache:cache>
    <!--翻页--> 
	
	
	
	
	
	<!--该产品本地区评论-->
	  <cache:cache cron="*/1 * * * *">
    <!--询价列表-->
    <div class="w755 border03 l mb10 list08">
      <div class="title08 listTop">
        <h3><b><%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>用户评论：</b> </h3>
        <div class="r"  style="padding-top:0px;"> <a title="更多<%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>评论"  href="http://koubei.21-sun.com/list/<%=CommonString.getFormatPara(oneOrder.get("product_id"))%>.htm" target="_blank">更多</a> </div>
      </div>
        <ul class="commentList" id="commentListId">
          评论加载中...
        </ul>

      <!--翻页-->
    </div>
	</cache:cache>
  <!--翻页--> 
	
	
	<!--此类产品本地区订单-->
	 <cache:cache cron="*/1 * * * *">
    <%
		pro_cata_orders = pageBeanCata.getDatas() ;
	%>
    <!--询价列表-->
    <div class="w755 border03 l mb10 list08">
      <div class="title08 listTop">
        <h3><b><%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>询价单总数：<%=pageBeanCata.getTotal() %></b> </h3>
        <div class="r" style="padding-top:0px;"> <a title="更多<%=search_province%><%=search_city%><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>询价单" href="/inquiry/0_0_0_<%=CommonString.getFormatPara(oneOrder.get("catanum")).length()>6?CommonString.getFormatPara(oneOrder.get("catanum")).substring(0,6):CommonString.getFormatPara(oneOrder.get("catanum")) %>_0.shtm" target="_blank">更多</a> </div>
      </div>
      <ul class="ti">
        <li class="i1">编号</li>
        <li class="i2">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7">询价时间</li>
      </ul>
      <div class="li" id="showorders">
        <%
       int i=1;
      if(null!=pro_cata_orders && pro_cata_orders.size()>0){
    	  String showtel02 = "" ; 
    	  for(Map oneMap:pro_cata_orders){
	        showtel02 = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
        		
        		if(showtel02.length()>7&&showtel02.length()<=20){
        			showtel02 = showtel02.substring(0,2)+"***"+showtel02.substring(showtel02.length()-2) ;
        		}else if(showtel02.length()>3){
        			showtel02 = showtel02.substring(0,4)+"***" ;
        		}else
        		{
        			showtel02 = showtel02+"***" ;
        		}
    		  %>
        <ul class="libg01">
          <li class="i1"><%=i %></li>
          <li class="i2" style="text-align:left"><a href="detail_for_<%=oneMap.get("id") %>.htm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name"))%><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>1)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel02 %></li>
          <li class="i5"><a href="/inquiry/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_0_0.shtm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6">
		  <a href="/inquiry/<%=(String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))%>_0_0_0_0.shtm"><%="".equals(CommonString.getFormatPara(oneMap.get("province")))?"-":CommonString.getFormatPara(oneMap.get("province"))  %></a>
		  <a href="/inquiry/<%=(String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))%>_<%if(((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city"))))==null){%>0<%}else{%><%=((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city")))) %><%}%>_0_0_0.shtm"><%="".equals(CommonString.getFormatPara(oneMap.get("city")))?"-":CommonString.getFormatPara(oneMap.get("city"))  %></a>
		  
		  </li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>
        <%
            i++ ;
            }
      }
      %>
      </div>
      <!--翻页-->

    </div>
	</cache:cache>
    <!--翻页--> 
	
	
	
  </div>
  <!--询价列表结束--> 
  
</div>
<!--right end-->
<div class="clear"></div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot--> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script type="text/javascript">
	//左侧
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"<%=CommonString.getFormatPara(oneOrder.get("factoryid"))%>","catalog":"<%=CommonString.getFormatPara(oneOrder.get("catanum"))%>","url":"/inquiry/"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})
	
	jQuery.ajax({
		url:"/action/ajax.jsp",
		data:{flag:"viewCount",tableName:"pro_product_form",id:"<%=CommonString.getFormatPara(oneOrder.get("id"))%>"} ,
		success:function(msg){
		}
	}) ;
	jQuery("#showorders ul").hover(function(){
	 jQuery(this).toggleClass("libg02") ; 
	}) ;
	
		//评论列表
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"id":"<%=CommonString.getFormatPara(oneOrder.get("product_id")) %>","flag":"commentInquiryList","name":"","factoryname":"<%=CommonString.getFormatPara(oneOrder.get("factoryname")) %>","catalogname":"<%=CommonString.getFormatPara(oneOrder.get("product_name")) %>","place":"<%=search_province%><%=search_city%>"},
		success:function(data){
			jQuery("#commentListId").html(jQuery.trim(data));	
		}
	})
</script>
</body>
</html>