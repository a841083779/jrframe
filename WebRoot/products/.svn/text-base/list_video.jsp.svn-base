<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%  
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
	connection = dbHelper.getConnection();
	Map brandMap = (Map) application.getAttribute("brandMap");
	List<Map> catalogList = (List) application.getAttribute("catalogList"); 
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factory"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String whereStr=""; 
	if(!catalog.equals("")){
	   whereStr+=whereStr+"and title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
	}
    if(!factoryid.equals("")){
	    whereStr+=whereStr+"and title like '%"+ CommonString.getFormatPara(brandMap.get(factoryid))+"%'";
	}
    Integer nowPage = 1; 
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
    PageBean pageBean = new PageBean(); // 分页程序
	pageBean.setParams(url);
    pageBean.setPageSize(32); // 每页显示条数
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("image,link,title");
	pageBean.setTableName("product_video");
	pageBean.setOrderBy(" add_date desc");
	List <Map>list = pageBean.getDatas(connection);
   //TDK
   String title="【工程机械工作实拍大全】工程机械工作实拍 - 铁臂商城";
   String keywords="工程机械工作实拍大全,工程机械工作实拍";
   String description="铁臂商城提供大量工程机械工作实拍,工程机械施工案例,维修保养实拍,精彩工程机械工作实拍尽在铁臂商城。";
   String selectWords=CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog));
   if(!"".equals(selectWords)){
      title="【"+selectWords+"工作实拍】"+selectWords+"工作实拍大全 - 铁臂商城";
	  keywords=selectWords+"工作实拍,"+selectWords+"工作实拍大全";
	  description="铁臂商城提供大量"+selectWords+"工作实拍,寻找"+selectWords+"施工案例,维修保养实拍就到铁臂商城。";
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
  <%="".equals(factoryid)?"":" &gt;&gt; <a href='/products/list_video.jsp?factory="+factoryid+"'>"+CommonString.getFormatPara(brandMap.get(factoryid))+"</a>"%>
  <%="".equals(catalog)?"":" &gt;&gt; <a href='/products/list_video.jsp?catalog="+catalog+"'>"+CommonString.getFormatPara(catalogMap.get(catalog))+"</a>"%>
  <%=("".equals(catalog)||"".equals(factoryid))?"":" &gt;&gt; <a href='/products/list_video.jsp?factory="+factoryid+"&catalog="+catalog+"'>"+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))+"</a>"%>
   &gt;&gt; <%="".equals(factoryid+catalog)?"工程机械":CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))%>实拍大全</a> </h3>
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
		 <jsp:param name="url" value="/products/list_video.jsp"></jsp:param>
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
		 <jsp:param name="url" value="/products/list_video.jsp"></jsp:param>
    </jsp:include>
    </div>
  </div>
  <!--left end--> 
  
  <!--right-->
  <div class="w757 r np_right mb10">
  <!-- 列表头部 -->
   <div class="w755 l border03 listTop">
    <div style="display:none"><form name="theform" id="theform"><input type="hidden" name="order" id="order" /></form></div>
    <div class="l" id="showorder"> <h1><strong style="font-size:12px;width:160px;"><%="".equals(factoryid+catalog)?"工程机械":CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))%>实拍大全</strong> </h1>
	<a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','','',1,'');"
								class="select">默认</a> <a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','','',0,'');">热度</a> </div>
    <div class="r"> <span><b><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%> </b>&nbsp;&nbsp;共</span><b><%=pageBean.getTotal()%></b><span>个实拍&nbsp;|</span> 
      <!--  <a href="javascript:void(0);" class="pre noPre"></a> <b>1/11</b> <a href="#" class="next"></a> --> 
      <%=pageBean.getUpPageBar()%> </div>
  </div>
   <!-- 列表头部 -->
    <div class="wfull l introContain mb10 video" id="myTab2_ContentA1">
    <div class="np_videoval">
    	<ul class="list">
	    <%
			if(list != null && list.size() > 0){
				for(Map m : list){
		%> 
			<li>
	          <a href="<%=CommonString.getFormatPara(m.get("link"))%>" target="_blank"><img alt="<%=CommonString.getFormatPara(m.get("title"))%>" title="<%=CommonString.getFormatPara(m.get("title"))%>"  src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(m.get("image"))%>" width="160" height="90"><em class="playico"></em>
	          </a>
			  <h3 style="width:160px;overflow:hidden;"><a title="<%=CommonString.getFormatPara(m.get("title"))%>" href="<%=CommonString.getFormatPara(m.get("link"))%>" target="_blank"><%=CommonString.getFormatPara(m.get("title"))%></a></h3>
	        </li>
	   <%}}else{%><div align="center">暂无信息</div><%}%>  
      </ul>
    </div>
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
        <jsp:include page="/include/products/order_sub_foot.jsp"
								flush="true">
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

<!--副导航-->
<style>
.new_v_foot_list{ width:980px; margin:0 auto; text-align:left; margin-bottom:10px;}
.new_v_foot_list .adnf_list ul li{ float:left;  margin:0 6px 0;white-space:nowrap; padding: 6px 0;}
.new_v_foot_list .adnf_list ul li a{  display:inline-block;}
.new_v_foot_list .adnf_list ul li a:hover{ color:#ff6600}
.new_v_foot_list .adnf_title{ font-size:14px; font-weight:bold; border-bottom:1px solid #ccc; padding:7px 0; margin-bottom:5px; font-family:微软雅黑;}
.nleft_one .list003 { height:210px; overflow:auto;}
</style>
<%if(!catalog.equals("")){
String catalogname=CommonString.getFormatPara(catalogMap.get(catalog));
%>
   <div class="new_v_foot_list">
    <div class="adnf_title">其他品牌<%=catalogname %>实拍</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/products/relate_brand_list.jsp" flush="true">
     <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
     <jsp:param name="catalogName" value="<%=catalogname%>"></jsp:param>
	 <jsp:param name="listType" value="实拍"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
  </div>

<%}else if(!factoryid.equals("")){
  String factoryName=CommonString.getFormatPara(brandMap.get(factoryid));
%>
  <div class="new_v_foot_list">
    <div class="adnf_title"><%=factoryName %>产品实拍</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/products/relate_pro_list.jsp" flush="true">
     <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
     <jsp:param name="factoryName" value="<%=factoryName%>"></jsp:param>
	 <jsp:param name="listType" value="实拍"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
  </div>
<%}%>
<!--副导航-->
 
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