<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String orderid = CommonString.getFormatPara(request.getParameter("id")) ; // 一条产品订单的id
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;  // 偏移量
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
	Map oneOrder = dbHelper.getMap(" select id,view_count,factory_name factoryname,cata_name cataname,user_name name,contact_tel,contact_address,product_name,add_date,message,product_id,factory_id factoryid,cata_num from pro_agent_products_form where id=?",new Object[]{orderid}) ;
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
		showtel = showtel.substring(0,3)+"*****"+showtel.substring(showtel.length()-3) ;
	}else if(showtel.length()>3){
		showtel = showtel.substring(0,4)+"*******" ;
	}else
	{
		showtel = showtel+"*******" ;
	}
	// 分布处理
	StringBuffer whereStr = new StringBuffer(" and is_deleted=0") ;
	if(!"".equals(CommonString.getFormatPara(oneOrder.get("factoryname")))){
		whereStr.append(" and factoryname like '%"+CommonString.getFormatPara(oneOrder.get("factoryname"))+"%'") ;
	}
	if(!"".equals(CommonString.getFormatPara(oneOrder.get("product_name")))){
		whereStr.append(" and product_name like'%"+CommonString.getFormatPara(oneOrder.get("product_name"))+"%'") ;
	}
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(15) ;
	 Integer nowPage = 1 ;
	  if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	  }
	 pageBean.setNowPage(nowPage) ;
	List<Map> pro_orders = new ArrayList() ;
	pageBean.setTableName("pro_product_form") ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" id,factoryname,cataname,product_name,name,contact_tel,mobile_phone,contact_address,add_date") ;
	pageBean.setOrderBy(" add_date desc") ;
	
	if(oneProduct == null){
		Common.do302(response,"/inquiry/");
		return;
	}
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("factoryname"))) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalogname"))) %>价格表】<%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("factoryname"))) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalogname"))) %>报价_ <%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("factoryname"))) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalognum"))).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":CommonString.getFormatPara(oneProduct.get("catalogname"))) %>最新价格询价单 - 中国工程机械商贸网</title>
<meta name="keywords" content=" <%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>价格表,<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>报价,<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>最新价格,<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>询价单" />
<meta name="description" content="最新<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>价格表，每日更新<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>价格和询价单，<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>报价，<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>多少钱。更多<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>价格表信息请来中国工程机械商贸网。" />
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
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; 
  <a href="/inquiry/">采购询价</a> &gt;&gt;
   <a href="/inquiry/?factory=<%=CommonString.getFormatPara(oneProduct.get("factoryid")) %>&catalog=<%=CommonString.getFormatPara(oneProduct.get("catalognum")).length()>=6?CommonString.getFormatPara(oneProduct.get("catalognum")).substring(0,6):CommonString.getFormatPara(oneProduct.get("catalognum")) %>"><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %></a> 
   &gt;&gt; <%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).length()>6?CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalognum")).substring(0,6))):CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("catalogname")) %>价格</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
  <div class="w210 l"> 
    <!--热门品牌-->
    <div id="leftId"> </div>
    <!--热门品牌结束--> 
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r">
    <div class="w755 border03 l rightPart03 mb10">
      <div class="title08">
        <h3><b><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %><%=CommonString.getFormatPara(oneOrder.get("cataname")) %>最新询价单</b></h3>
        <span>询价时间：<%=(CommonString.getFormatPara(oneOrder.get("add_date")).length()>15)?CommonString.getFormatPara(oneOrder.get("add_date")).substring(0,16):CommonString.getFormatPara(oneOrder.get("add_date")) %>　　浏览次数：<%=CommonString.getFormatPara(oneOrder.get("view_count")).equals("")?"1":CommonString.getFormatPara(oneOrder.get("view_count")) %></span> </div>
      <div class="li">
        <ul>
          <li class="i8">联 系 人：<%=(CommonString.getFormatPara(oneOrder.get("name")).length()>1)?CommonString.getFormatPara(oneOrder.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i9">联系电话：<%=showtel %></li>
          <li class="i10">所在地区：<%=CommonString.getFormatPara(oneOrder.get("contact_address")) %></li>
          <li class="i11">留言内容：<%="".equals(CommonString.getFormatPara(oneOrder.get("message")))?"该订单无留言！":CommonString.getFormatPara(oneOrder.get("message")) %></li>
        </ul>
      </div>
      <div class="wfull l alignCenter pb15"> <a href="javascript:;" title="免费询价" onclick="showinquery('<%=CommonString.getFormatPara(oneOrder.get("product_id")) %>','<%=CommonString.getFormatPara(oneOrder.get("factoryid")) %>')"><img src="../images/pd_btn.gif" alt="免费询价" width="188" height="45" class="mb10" /></a><br />
        <strong>如果您也想咨询价格，请点“免费询价”按钮</strong> </div>
        <%
			if(oneProduct != null){
		%>
      <div class="plist">
        <ul>
          <li> <a href="/proDetail/<%=CommonString.getFormatPara(oneProduct.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneProduct.get("img2")).toLowerCase() %>" onerror="this.src='/uploadfiles/no_small.gif'" width="130" height="90" class="plimg" alt="<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct.get("catalogname")) %>" title="<%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct.get("catalogname")) %>"/></a>
            <div class="w618 r">
              <h2><a href="/proDetail/<%=CommonString.getFormatPara(oneProduct.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneProduct==null?"":oneProduct.get("factoryname")) %><%=CommonString.getFormatPara(oneProduct.get("name")) %><%=CommonString.getFormatPara(oneProduct.get("catalogname")) %></a></h2>
              <span class="info"><a href="/inquiry/?factory=<%=CommonString.getFormatPara(oneProduct.get("factoryid")) %>&catalog=<%=CommonString.getFormatPara(oneProduct.get("catalognum")) %>" target="_blank">订单</a> <em>|</em> <a href="/photo/list.jsp?factoryid=<%=CommonString.getFormatPara(oneOrder.get("factoryid")) %>&catalogid=<%=CommonString.getFormatPara(oneOrder.get("catanum")) %>" target="_blank">图片</a> <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneProduct.get("id")) %>','')" class="plbtn">询价</a></span>
              <div class="plInfo"> <%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(oneProduct.get("introduce"))),150) +"..."%><b><a href="/proDetail/<%=CommonString.getFormatPara(oneProduct.get("file_name")) %>" target="_blank">[查看详情]</a></b> </div>
              <div class="wfull l">询价单号：<%=orderid %></div>
            </div>
          </li>
        </ul>
      </div>
      <%
			}
	  %>
    </div>
    <cache:cache cron="*/1 * * * *">
    <%
		pro_orders = pageBean.getDatas() ;
	%>
    <!--询价列表-->
    <div class="w755 border03 l mb10 list08">
      <div class="title08 listTop">
        <h3><b><%=CommonString.getFormatPara(oneOrder.get("factoryname")) %><%=CommonString.getFormatPara(oneOrder.get("product_name")) %>询价单总数：<%=pageBean.getTotal() %></b> </h3>
        <div class="r"> <%=pageBean.getUpPageBar() %> </div>
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
        			showtel02 = showtel02.substring(0,3)+"***"+showtel02.substring(showtel02.length()-3) ;
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
          <li class="i5"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></li>
          <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address")) %></li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>
        <%
            i++ ;
            }
      }
      %>
      </div>
      <!--翻页-->
      <div class="w755 l">
        <div id="pagination" class="page">
          <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
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
		data:{flag:"viewCount",tableName:"pro_agent_products_form",id:"<%=CommonString.getFormatPara(oneOrder.get("id"))%>"} ,
		success:function(msg){
		}
	}) ;
	jQuery("#showorders ul").hover(function(){
	 jQuery(this).toggleClass("libg02") ; 
	}) ;
</script>
</body>
</html>