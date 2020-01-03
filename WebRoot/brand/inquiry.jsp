<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;   // 厂家
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类别
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map factoryMap = null; 
	List<Map> productsList = null ;
	String factoryName = "";
	String factoryId = "";
	String whereStr = "is_show=1 ";
	String catalogName = "";
%>
	<cache:cache cron="* */3 * * *" >
<%
	List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
	if(allcatalogsList!=null && allcatalogsList.size()>0){
		for(Map m:allcatalogsList){
			if(m.get("num").equals(catalog)){
				catalogName = m.get("name").toString();
			}
		}
	}
	if(usern!=null && !usern.equals("")){
		String factory_sql = "select is_made, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,zturl,img1,telphone from pro_agent_factory where usern = '"+usern+"' and is_show=1 and flag=1" ;
		factoryMap = dbHelper.getMap(factory_sql);
		factoryId = CommonString.getFormatPara(factoryMap.get("id"));
		factoryName = CommonString.getFormatPara(factoryMap.get("name"));
		whereStr += "and factoryid = '"+factoryId+"'";
		if(catalog!=null && !catalog.equals("")){
			whereStr += "and catalognum like '"+catalog+"%'";
		}
		String productsSql = "select top 15 img2,factoryname,name,catalogname,introduce,file_name,view_count from pro_products where "+whereStr+"  order by view_count desc ,id desc";
		productsList = dbHelper.getMapList(productsSql);
	}
	
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=factoryName %><%=catalogName %>价格表_<%=factoryName %><%=catalogName %>报价_<%=factoryName %><%=catalogName %>询价单 - 铁臂商城</title>
<meta name="keywords" content="<%=factoryName %><%=catalogName %>价格表,<%=factoryName %><%=catalogName %>报价,<%=factoryName %>,询价单" />
<meta name="description" content="铁臂商城<%=factoryName %><%=catalogName %>询价专区，为您提供<%=factoryName %><%=catalogName %>所有产品询价信息，帮助您全面了解<%=factoryName %><%=catalogName %>产品价格。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!-- jbox -->
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top_brand.jsp" flush="true">
<jsp:param value="<%=factoryId %>" name="factoryid"/>
</jsp:include>
<!--top end--> 
<!--nav-->
<jsp:include page="brand_top.jsp" flush="true">
<jsp:param value="<%=usern %>" name="usern"/>
<jsp:param value="<%=factoryName %>" name="factoryName"/>
</jsp:include>
<!--nav end-->
<div></div>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/brand/">品牌大全</a> &gt;&gt;  <a href="/brand/<%=usern %>/"><%=factoryName %></a> &gt;&gt;  <a href="/brand/<%=usern %>/inquiry.htm"><%=factoryName %>产品价格表</a> &gt;&gt;  <%=factoryName %><%=catalogName %>价格表</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 n_pp_promain">
  <div class="npp_protitle"><span><h1><%=factoryName %><%=catalogName %>价格表</h1></span></div>
  <div class="npp_prolist">
    <div class="npp_pl_top">
      <ul class="np_fix">
        <%
       		if(allcatalogsList!=null && allcatalogsList.size()>0){
       			for(Map m:allcatalogsList){
       				String num = CommonString.getFormatPara(m.get("num"));
       				String name = CommonString.getFormatPara(m.get("name"));
       				List<Map> subcatalogList = dbHelper.getMapList("select top 1 id from pro_products where is_show=1 and factoryid = '"+factoryId+"' and catalognum like '"+num+"%'");
       				if(subcatalogList!=null && subcatalogList.size()>0){
       	%>  
       		<li><a href="/brand/<%=usern %>/inquiry_<%=num %>.htm" title="<%=factoryName %><%=name %>价格表"><%=factoryName %><%=name %>价格表</a></li>
        <%}}}%>
      </ul>
    </div>
    <div class="npp_pl_bot">
      <ul class="np_fix ">
     <%
       		if(productsList!=null && productsList.size()>0){
       			for(Map m:productsList){
       				String file_name = CommonString.getFormatPara(m.get("file_name"));
       				String factoryname = CommonString.getFormatPara(m.get("factoryname"));
       				String name = CommonString.getFormatPara(m.get("name"));
       				String catalogname = CommonString.getFormatPara(m.get("catalogname"));
       				String img2 = CommonString.getFormatPara(m.get("img2"));
       	%> 
        <li>
         <p class="npp_b_img"><a href="/proDetail/<%=file_name.replace(".shtm","") %>_order.shtm" title="<%=factoryname %><%=name %><%=catalogname %>价格" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" alt="<%=factoryname %><%=name %><%=catalogname %>价格" title="<%=factoryname %><%=name %><%=catalogname %>价格" style="width:120px;height:90px;"/></a></p>
                    <p class="npp_b_name"><a href="/proDetail/<%=file_name.replace(".shtm","") %>_order.shtm" title="<%=factoryname %><%=name %><%=catalogname %>价格" target="_blank"><%=factoryname %><%=name %><%=catalogname %>价格</a></p>
                    <p class="npp_b_cs"><span><a href="/proDetail/<%=file_name.replace(".shtm","") %>_parameter.shtm" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>参数">参数</a></span> | <span><a href="/proDetail/<%=file_name.replace(".shtm","") %>_message.shtm" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>口碑">口碑</a></span> | <span><a href="/proDetail/<%=file_name.replace(".shtm","") %>_pic.shtm" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>图片">图片</a></span></p>
        </li>
        <%}}%>
      </ul>
      <div class="npp_seeall"><a href="http://product.21-sun.com/inquiry/0_0_<%=factoryId %>_0_0.shtm" target="_blank" title="更多<%=factoryName %>产品询价 ">更多<%=factoryName %>产品询价 &gt;&gt; </a></div>
    </div>
    <!--询价单--> 
     <div style="clear:both; border: 1px solid #D3D3D3;margin-top: 20px !important; margin-bottom: 10px !important;border-top:#ff9000 2px solid;">
     	<jsp:include page="/include/products/product_detail_order.jsp" flush="true">
		<jsp:param value="<%=factoryId %>" name="factoryid"/>
		</jsp:include>
     </div>
    <!--询价单结束--> 
     <div class="wfull np_fix mb10 npp_xjdan" id="myTab2_ContentA5">
      <div class=" border03 np_fix mb10 list08">
        <ul class="ti">
          <li class="i1">编号</li>
          <li class="i2">询价产品</li>
          <li class="i3">联系人</li>
          <li class="i4">电话</li>
          <li class="i5">询价品牌</li>
          <li class="i6">询价区域</li>
          <li class="i7">询价时间</li>
        </ul>
        <!--foot-->
		<jsp:include page="/include/brand/inquiry.jsp" flush="true">
		<jsp:param value="<%=factoryId %>" name="factoryid"/>
		<jsp:param value="<%=catalog %>" name="catalog"/>
		</jsp:include>
		<!--end of foot--> 
      </div>
    </div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--end of foot--> 
<script type="text/javascript" src="../scripts/sort.js"></script>
</body>
</html>
</cache:cache>