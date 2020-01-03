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
	String cacheKey =  usern+catalog;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<cache:cache cron="* * */2 * *" >
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
	
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=factoryName %><%=catalogName %>_<%=factoryName %><%=catalogName %>产品大全_<%=factoryName %> -  铁臂商城</title>
<meta name="keywords" content="<%=factoryName %><%=catalogName %>,<%=factoryName %><%=catalogName %>产品大全,<%=factoryName %>,<%=factoryName %><%=catalogName %>" />
<meta name="description" content="铁臂商城<%=factoryName %><%=catalogName %>产品专区，包括<%=factoryName %><%=catalogName %>所有型号产品，帮助您全面了解<%=factoryName %><%=catalogName %>。" />
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
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt;  <a href="/brand/">品牌大全</a> &gt;&gt;  <a href="/brand/<%=usern %>/"><%=factoryName %></a> &gt;&gt;  <a href="/brand/<%=usern %>/product.htm"><%=factoryName %>产品</a> &gt;&gt;  <%=factoryName %><%=catalogName %>产品</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 n_pp_promain">
	<div class="npp_protitle"><span><h1><%=factoryName %><%=catalogName %>产品</h1></span></div>
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
            		<li><a href="/brand/<%=usern %>/products_<%=num %>.htm" title="<%=factoryName %><%=name %>"><%=factoryName %><%=name %></a></li>
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
                	<p class="npp_b_img"><a href="/proDetail/<%=file_name %>" title="<%=factoryname %><%=name %><%=catalogname %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" alt="<%=factoryname %><%=name %><%=catalogname %>" title="<%=factoryname %><%=name %><%=catalogname %>" style="width:120px;height:90px;"/></a></p>
                    <p class="npp_b_name"><a href="/proDetail/<%=file_name %>" title="<%=factoryname %><%=name %><%=catalogname %>" target="_blank"><%=factoryname %><%=name %><%=catalogname %></a></p>
                    <p class="npp_b_cs"><span><a href="/proDetail/<%=file_name.replace(".shtm","") %>_parameter.shtm" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>参数">参数</a></span> | <span><a href="/proDetail/<%=file_name.replace(".shtm","") %>_message.shtm" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>口碑">口碑</a></span> | <span><a href="/proDetail/<%=file_name.replace(".shtm","") %>_pic.shtm" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>图片">图片</a></span></p>
        	<%}}%>
            </ul>
             <div class="npp_seeall"><a href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryId %>" target="_blank" title="更多<%=factoryName %>产品">更多<%=factoryName %>产品 &gt;&gt;  </a></div>
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