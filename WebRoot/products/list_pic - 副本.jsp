<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%  
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
	connection = dbHelper.getConnection();
    String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factory"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String whereStr=""; 
	if(!catalog.equals("")){
	   whereStr+=whereStr+"and catalognum like '%"+catalog+"%'";
	}
    if(!factoryid.equals("")){
	    whereStr+=whereStr+"and factoryid = "+factoryid;
	}
    Integer nowPage = 1; 
    PageBean pageBean = new PageBean(); // 分页程序
    pageBean.setPageSize(24); // 每页显示条数
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("id,img2,name,file_name,factoryname,catalogname");
	pageBean.setTableName("pro_products");
	if ("0".equals(order)) {
			pageBean.setOrderBy(" view_count desc"); // 点击量排序
    }else{
			pageBean.setOrderBy(" order_no desc, view_count desc"); // 默认排序
	}
	List <Map>list = pageBean.getDatas(connection);
	Map brandMap = (Map) application.getAttribute("brandMap");
	List<Map> catalogList = (List) application.getAttribute("catalogList"); 
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	//TDK
   String title="【工程机械图片】工程机械图片大全_工程机械图库 - 铁臂商城";
   String keywords="工程机械图片,工程机械图库,工程机械图片大全";
   String description="铁臂商城工程机械图片专区,为您提供所有工程机械品牌图片大全,买工程机械就上铁臂商城。";
   String selectWords=CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog));
   String cata="";
   String brand="";
   if(!"".equals(CommonString.getFormatPara(catalogMap.get(catalog)))){
         cata=","+CommonString.getFormatPara(catalogMap.get(catalog));
   }
   if(!"".equals(CommonString.getFormatPara(brandMap.get(factoryid)))){
         brand=","+CommonString.getFormatPara(brandMap.get(factoryid));
   }
   if(!"".equals(selectWords)){
      title=selectWords+"图片_"+selectWords+"图片大全 - 铁臂商城";
	  keywords=selectWords+"图片,"+selectWords+"图片大全"+cata+brand;
	  description="铁臂商城"+selectWords+"图片专区,为您提供"+selectWords+"全系列图片,帮助您全面了解"+selectWords+".买"+selectWords+"产品就上铁臂商城。";
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
</head>
<body>
<!--top-->
<jsp:include page="/include/top_new.jsp" flush="true">
<jsp:param name="keyword" value="1"></jsp:param>
<jsp:param name="catalog" value="1"></jsp:param>
<jsp:param name="factoryid" value="1"></jsp:param>
</jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">铁臂商城</a>
  <%="".equals(factoryid)?"":" &gt;&gt; <a href='/products/list_pic.jsp?factory="+factoryid+"'>"+CommonString.getFormatPara(brandMap.get(factoryid))+"</a>"%>
  <%="".equals(catalog)?"":" &gt;&gt; <a href='/products/list_pic.jsp?catalog="+catalog+"'>"+CommonString.getFormatPara(catalogMap.get(catalog))+"</a>"%>
  <%=("".equals(catalog)||"".equals(factoryid))?"":" &gt;&gt; <a href='/products/list_pic.jsp?factory="+factoryid+"&catalog="+catalog+"'>"+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))+"</a>"%>
   &gt;&gt; <%="".equals(factoryid+catalog)?"工程机械":CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))%>图片大全</a> </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10"> 

  <!--left-->
  <div class="w210 l np_left">
     <div id="leftId">
      <div class="npro_tab">
      	<ul class="np_fix">
        </ul>
      </div>  
	  <jsp:include page="/include/left_brandlist.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
         <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
		 <jsp:param name="url" value="/products/list_pic.jsp"></jsp:param>
       </jsp:include>
    </div>
   <div id="leftId">
      <div class="npro_tab">
      	<ul class="np_fix">
        </ul>
      </div>  
	  	<jsp:include page="/include/left_prolist.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
         <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
		 <jsp:param name="url" value="/products/list_pic.jsp"></jsp:param>
    </jsp:include>
    </div>
  </div>
  <!--left end--> 

  <!--right-->
  <div class="w757 r np_right mb10">
 
  <!-- 列表头部 -->
   <div class="w755 l border03 listTop">
   <div style="display:none"><form name="theform" id="theform"><input type="hidden" name="order" id="order" /></form></div>
    <div class="l" id="showorder"> <h1><strong style="font-size:12px;width:160px;"><%="".equals(factoryid+catalog)?"工程机械":CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))%>图片大全</strong> </h1>
	<a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','','',1,'');"
								class="select">默认</a> <a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','','',0,'');">热度</a> </div>
    <div class="r"> <span><b><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%> </b>&nbsp;&nbsp;共</span><b><%=pageBean.getTotal()%></b><span>张图片&nbsp;|</span> 
      <!--  <a href="javascript:void(0);" class="pre noPre"></a> <b>1/11</b> <a href="#" class="next"></a> --> 
      <%=pageBean.getUpPageBar()%> </div>
  </div>
   <!-- 列表头部 -->
   
    <div class="np_piclist np_fix l">
    <ul class="list12 np_fix">
        <%
			if(list != null && list.size() > 0){
				for(Map m : list){
		%> 
              <li>
                <div class="photo"><a target="_blank" href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> 
			  </li>  
        	   <%}}else{%><div align="center">暂无信息</div><%}%>  
       </ul>
    </div>
    
    <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
    <div class="w755 l">
      <div id="pagination" class="page">
        <tags:page pageBean="<%=pageBean%>" />
      </div>
    </div>
  </div>
  <!--right end-->
  <div class="clear"></div> 
<!--最新订单-->
<div class="contain980 mb10">
  <div class="title04">
    <h2><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新订单 </h2>
    <span><a
						href="/inquiry/?<%="".equals(factoryid) ? "" : "factory=" + factoryid + "&"%><%="".equals(catalog) ? "" : "catalog=" + catalog%>"
						target="_blank">更多&gt;&gt;</a> </span> </div>
  <div class="list04">
    <div id="MarqueeDiv"
						style="width: 978px; height: auto; overflow: hidden;">
      <ul>
        <jsp:include page="/include/products/order_sub_foot.jsp" flush="true">
        <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
        </jsp:include>
      </ul>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!--最新订单结束--> 
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>