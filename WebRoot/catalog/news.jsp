<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String usernn = CommonString.getFormatPara(request.getParameter("usern"));
	Connection connection = null;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 厂家
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map brandMap2 = (HashMap)application.getAttribute("brandMap2") ;

	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	try {
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_products_second where english_name = ? ",new Object []{usernn},connection);
		if(map == null){
			Common.do302(response,"http://product.21-sun.com/");
			return;
	    }
	String catalognum=CommonString.getFormatPara(map.get("catalognum"));
	String catalogname=CommonString.getFormatPara(map.get("catalogname"));
	String showtip = "最新动态";
	String tableName = "article";
	String whereStr = " and (link_other='' or link_other is null)and is_pub=1 and is_del=0 and title like '%"+catalogname+"%' ";
	String orderBy = "pub_date desc";
	String t_flag = "" ;
	int pageSize = 8;
	List<Map> getNewsList = null;
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
	Map factoryMap = null; 
	String factoryName = "";
	String factoryId = "";
	String factorycatalogName = "";
	String factorypro_brand_title = "";
	String factorylogo = "";
	String factoryurl = "";
	String factorytelphone="";
	if (!"".equals(catalog)) {
		whereStr += " and product_catalog = '"+catalog+"' ";
	}
	PageBean pageBean = new PageBean();
	pageBean.setFields("*") ;
	pageBean.setPageSize(pageSize);
	pageBean.setTableName(tableName);
	Integer nowPage = 1;
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	if("".equals(offset) || Integer.parseInt(offset)<=0){
		offset = "0" ;
	}
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	pageBean.setNowPage(nowPage);
	pageBean.setCondition(whereStr);
	pageBean.setIsShowSql(true);
	pageBean.setParams(url);
	pageBean.setOrderBy(orderBy); 
	// 是否有图
	Pattern pattern = Pattern.compile(".*?<img\\s*.*?\\s*src=\\\"(.*)\\\"\\s*.*?>.*");
	Matcher matcher = null;
	// 获得地区
	String ip  = Common.getIp(request);
	String jsonStr = Tools.getMyProvinceAndCity(ip);
	String city = "";
	String province = "";
	if(!CommonString.getFormatPara(jsonStr).equals("")){
		JSONObject obj = new JSONObject(jsonStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	}
		getNewsList = pageBean.getDatasByWebService("Web21sunDBHelper");

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=catalogname %>动态 – 铁臂<%=catalogname %>专区</title>
<meta name="keywords" content="<%=catalogname %>动态" />
<meta name="description" content="铁臂<%=catalogname %>专区,为您提供最新<%=catalogname %>动态,帮助您全面了解<%=catalogname %>,买<%=catalogname %>产品就上铁臂商城。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<link href="/catalog/style/products.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--top end-->
<div class="contain980 fix">
  <div class="nc_channT"><h1 style="font-size:24px;"><%=catalogname %></h1></div>
  <div class="s_mainSite"><a target="_blank" href="http://product.21-sun.com/">访问首页</a></div>
  <div class="s_tel">铁臂商城客服电话：<b>4006-521-526</b></div>
</div>
<div class="s_navBar">
  <div class="contain980">
    <ul class="fix">
      <li><a href="http://<%=usernn%>.21-sun.com/"><%=catalogname%>首页</a></li>
      <li   class="selected"><a href="http://<%=usernn%>.21-sun.com/news.htm"><%=catalogname%>动态</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/koubei.htm"><%=catalogname%>口碑</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pic.htm"><%=catalogname%>图片</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pro.htm"><%=catalogname%>品牌</a></li>
      <li><a href="http://product.21-sun.com/inquiry/0_0_0_<%=catalognum%>_0.shtm" target="_blank"><%=catalogname%>询价单</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=catalogname %>专区</a> &gt;&gt; <%=catalogname %>动态</div>
</div>
<!--main-->
<div class="contain980 fix">
	<div class="s_mleft">
    	<ul class="fix pc_news_list">
    	<%
				if (null != getNewsList && getNewsList.size() > 0) {
						Map oneMap = null;
						for (Map m:getNewsList) {
							String newId = CommonString.getFormatPara(m.get("id"));
							String newTitle = CommonString.getFormatPara(m.get("title"));
							String newContent = CommonString.getFormatPara(CommonHtml.filterHTML(m.get("content").toString()));
							if(newContent.length()>80){newContent=newContent.substring(0,80)+"...";}
							String newLink_other = CommonString.getFormatPara(m.get("link_other"));
							String factoryInfo = CommonString.getFormatPara(m.get("product_brand"));
							String catalogInfo = CommonString.getFormatPara(m.get("product_catalog"));
							String newImage = CommonString.getFormatPara(m.get("image"));
							String html_filename = CommonString.getFormatPara(m.get("html_filename"));
							String add_date = CommonDate.getFormatDate("yyyy-MM-dd", m.get("add_date"));
							String titleAlt=""; 
							if(newTitle!=null){
								titleAlt=newTitle;
							} 
							if(newTitle.length()>28){ 	
								newTitle=newTitle.substring(0,28)+"...";
							}
							newTitle = newTitle.replace("^R", "<sup>®</sup>");
							String newUrl="/detail_"+newId+".htm";
							if(!newLink_other.equals("")&&!newLink_other.equals("null")){
								newUrl = newLink_other;
							}
							boolean isFile=false;
							String imageUrl="";
							 if(newImage!=null && !"".equals(newImage) && !"null".equals(newImage)){
								 if(newImage.indexOf(".pdf")==-1 && newImage.indexOf(".doc")==-1){
									imageUrl="http://news.21-sun.com/UserFiles/Image/"+newImage;
									isFile=true;	
								 } 
							 }
							 if(isFile&&newContent.length()>55){newContent=newContent.substring(0,55)+"...";}
							
			%>
        	<li>
        		<% if(isFile){%>
            	<a href="<%=newUrl %>" target="_blank" title="<%=titleAlt%>">
                	<img title="<%=titleAlt%>"  alt="<%=titleAlt%>" src="<%=imageUrl%>" width="175" height="115" />
                </a>
                <%} %>
                <div class="pc_news_title"><a href="<%=newUrl %>" target="_blank" title="<%=titleAlt%>"><%=newTitle %></a></div>
                <div class="pc_news_sum"><%=newContent %></div>
                <div class="pc_news_time"><%=add_date %></div>
                <div class="pc_news_tag">
                	<%
					if(!factoryInfo.equals("")&&factoryInfo!=null&&!factoryInfo.equals("null")){
					%>
              <span class="tag">标签：
					<%if(!factoryInfo.equals("")&&!factoryInfo.equals("null")){%>
                  <a title="<%=factoryInfo%>" target="_blank"   href="http://product.21-sun.com/products/prolist.jsp?factory=<%=brandMap2.get(factoryInfo)%>" ><%=factoryInfo%></a>
                  <%}%>
                  <%if(!catalogInfo.equals("")&&!catalogInfo.equals("null")&1==2){%>
                  <a title="<%=catalogMap.get(catalogInfo)%>" target="_blank"  href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001" ><%=catalogMap.get(catalogInfo)%></a>
                  <%}%>
                  <%if(!factoryInfo.equals("")&&!catalogInfo.equals("")&&!factoryInfo.equals("null")&&!catalogInfo.equals("null")){%>
                  <a title="<%=factoryInfo%><%=catalogMap.get(catalogInfo)%>" target="_blank"  href="http://product.21-sun.com/products/prolist.jsp?factory=<%=brandMap2.get(factoryInfo)%>&catalog=<%=catalogInfo%>"><%=factoryInfo%><%=catalogMap.get(catalogInfo)%></a>
                  <%}%>
				</span>
			 <%}%>
                </div>
                <a href="<%=newUrl %>" target="_blank" class="pc_more">继续阅读</a>
            </li>
            <%}} %>
        </ul>
        <div class="pages">
	        <form id="theform" name="theform" method="post" action="">
			<div id="pagination" class="paging  page" style="margin-right:3px;">
				<tags:page_catalog_news pageBean="<%=pageBean%>" />
			</div>
	        </form>
      	</div>
    </div>
    <div class="s_right">
	
	<!--热门产品-->
	<jsp:include page="/include/catalogshow/product_hot.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
    <!--热门品牌-->
	<jsp:include page="/include/catalogshow/hot_brand.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
    <!--热门产品图片-->
	<jsp:include page="/include/catalogshow/product_pic.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
    </div>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--foot end-->
</body>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
	}
%>