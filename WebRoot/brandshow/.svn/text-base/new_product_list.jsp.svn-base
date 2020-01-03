<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="java.net.URLEncoder"%><%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;   // 厂家
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类别
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap) application.getAttribute("brandUsernMap"); 
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map factoryMap = null; 
	List<Map> articleList = null ;
	String factoryName = "";
	String factoryId = "";
	String factorycatalogName = "";
	String factorypro_brand_title = "";
	String factorylogo = "";
	String factoryurl = "";
	String factorytelphone="";
	String catalogName = "";

	if(usern!=null && !usern.equals("")){
		String factory_sql = "select is_made,pro_brand_title, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,url,img1,telphone,banner,create_date,master,weibo,email from pro_agent_factory where usern = '"+usern+"' and is_show=1 and flag=1" ;
		factoryMap = dbHelper.getMap(factory_sql);
		factoryId = CommonString.getFormatPara(factoryMap.get("id"));
		factoryName = CommonString.getFormatPara(factoryMap.get("name"));
		factorypro_brand_title = CommonString.getFormatPara(factoryMap.get("pro_brand_title"));
		factorylogo = CommonString.getFormatPara(factoryMap.get("logo"));
		factoryurl = CommonString.getFormatPara(factoryMap.get("url")); 
		factorytelphone = CommonString.getFormatPara(factoryMap.get("telphone")); 
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		Common.doForward(request,response,"/404.htm");
	}
	
	//所有分类
	String allCatalogSql = "select name,num from pro_catalog where len(num) = 6";
	List<Map> catalogList = dbHelper.getMapList(allCatalogSql);
	
	StringBuffer whereStr = new StringBuffer(" and is_show=1 and id !=20163");
	if (!"".equals(factoryId)) {  
		whereStr.append(" and factoryid=" + factoryId);
	}
	if (!"".equals(catalog)) {  
		whereStr.append(" and catalognum like'" + catalog+"%'");
		catalogName = CommonString.getFormatPara(catalogMap.get(catalog));
	}
	PageBean pageBean = new PageBean(); // 分页程序
	pageBean.setPageSize(10); // 每页显示条数
	pageBean.setCondition(whereStr.toString());
	Integer nowPage = 1;
	if("".equals(offset) || Integer.parseInt(offset)<=0){
		offset = "0" ;
	}
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	pageBean.setNowPage(nowPage);
	pageBean.setOrderBy(" view_count desc"); // 点击量排序
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
	pageBean.setParams(url);
	pageBean.setIsShowSql(false);
	pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum ");
	pageBean.setTableName("pro_products");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		List<Map> searchProducts = pageBean.getDatas(connection);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=factoryName %><%=catalogName.equals("")?"产品":catalogName %>_<%=factoryName %><%=catalogName %>产品大全 - 铁臂<%=factoryName %>专区</title>
<meta name="keywords" content="<%=factoryName %><%=catalogName %>产品,<%=factoryName %><%=catalogName %>产品大全,<%=factoryName %>" />
<meta name="description" content="铁臂<%=factoryName %>专区，为您提供<%=factoryName %><%=catalogName %>全系列产品展示，帮助您全面了解<%=factoryName %><%=catalogName %>所有产品。买<%=factoryName %><%=catalogName %>产品，就上铁臂商城！" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--top end-->
<div class="contain980 fix">
  <div class="s_brand_logo">
    <img src="http://product.21-sun.com/uploadfiles/<%=factorylogo %>" alt="<%=factoryName %>" width="120" height="50" class="s_img" /><strong class="s_n"><h1><%=factoryName %></h1></strong>
  </div>
  <div class="s_mainSite"><a href="<%=factoryurl %>" target="_blank">访问官网</a></div>
  <div class="s_tel"><%=factoryName %>品牌客服电话：<b><%=factorytelphone %></b></div>
</div>
<div class="s_navBar">
  <div class="contain980">
    <ul class="fix">
      <li><a href="/"><%=factoryName %>首页</a></li>
      <li><a href="/intro.htm"><%=factoryName %>简介</a></li>
      <li><a href="/news.htm"><%=factoryName %>动态</a></li>
      <li><a href="#"><%=factoryName %>人物</a></li>
      <li class="selected"><a href="/product_list.htm"><%=factoryName %>产品</a></li>
      <li><a href="/comment_list.htm"><%=factoryName %>口碑</a></li>
      <li><a href="/agent_list.htm"><%=factoryName %>代理商</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=factoryName %>专区</a> &gt;&gt; <a href="/product_list.htm"><%=factoryName %>产品</a><%=catalogName.equals("")?"":" &gt;&gt; "+factoryName+catalogName %></div>
</div>
<div class="s_main fix">
  <!--left-->
  <div class="contain980 fix">
    <div class="s_mleft">
      <div class="comBox">
        <div class="hd fix mt10">
          <h3><%=factoryName %>产品</h3>
        </div>
        
        <div class="cg mb10"> 
        	<strong>类别：</strong>
          <a <% if(catalog.equals("")){ %>class="selected" <%} %> href="/product_list.htm">全部</a><em>|</em>
          <%
                int i=1;
                for(Map m:catalogList){
                	String catalogNum = CommonString.getFormatPara(m.get("num"));
                	String catalogTName = CommonString.getFormatPara(m.get("name"));
                	if(catalogNum.length()==6){
	                	String catalogSql = " select top 1 c.id from pro_comments as c left join  pro_products as p on c.product_id=p.id where c.is_show=1 and p.factoryid = '"+factoryId+"' and p.catalognum like '"+catalogNum+"%'";
	                	Map cMap = dbHelper.getMap(catalogSql);
	                	if(cMap!=null &&cMap.size()>0){
	                %>
	                	<a <% if(catalog.equals(catalogNum)){ %>class="selected" <%} %> href="/product_list_<%=catalogNum %>.htm"><%=catalogTName %></a><em>|</em>
	                <%i++;
	                	if(i==5){break;}
           }}} %>
        </div>
        
        <div class="w755 l border03 listTop">
          <div class="l" id="showorder"> <strong>排序</strong> <a href="javascript:;" onclick="javascript:void(0);" class="select">默认</a></div>
          <div class="r"> 
            <span><b> <%=catalogName.equals("")?"全部产品":catalogName %> </b>&nbsp;&nbsp;共</span><b><%=pageBean.getTotal() %></b><span>款机型</span></div>
        </div>
        
        <div class="plist">
          <ul id="showproducts">
          <%	  
			if (searchProducts != null && searchProducts.size() > 0) {
				for (Map oneMap : searchProducts) {
					String id = CommonString.getFormatPara(oneMap.get("id"));
					String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
					String img2 = CommonString.getFormatPara(oneMap.get("img2"));
					String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
					String name = CommonString.getFormatPara(oneMap.get("name"));
					String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
					String introduce = CommonString.getFormatPara(oneMap.get("introduce"));
					String factoryid = CommonString.getFormatPara(oneMap.get("factoryid"));
					String catalognum = CommonString.getFormatPara(oneMap.get("catalognum"));
			%>
            <li> <a href="http://product.21-sun.com/proDetail/<%=file_name %>" target="_blank"> <img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="<%=factoryname+name+catalogname %>" title="<%=factoryname+name+catalogname %>" /> </a>
              <div class="w618 r">
                <h2> <a title="<%=factoryname+name+catalogname %>" href="http://product.21-sun.com/proDetail/<%=file_name %>" target="_blank"><%=factoryname+name+catalogname %></a> </h2>
                <span class="info"> <a title="<%=factoryname+catalogMap.get(catalognum.length()>6?catalognum.substring(0,6):catalognum) %>" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryid %>&catalog=<%=catalognum.length()>6?catalognum.substring(0,6):catalognum %>"><%=factoryname+catalogMap.get(catalognum.length()>6?catalognum.substring(0,6):catalognum) %></a><em>|</em><a href="http://product.21-sun.com/proDetail/<%=file_name.replace(".shtm","_order.shtm")%>" title="<%=factoryname+name+catalogname %>订单" target='_blank'>订单</a><em>|</em><a href="http://product.21-sun.com/proDetail/<%=file_name.replace(".shtm","_pic.shtm")%>" title="<%=factoryname+name+catalogname %>图片" target="_balnk">图片</a><em>|</em><a href="http://product.21-sun.com/proDetail/<%=file_name.replace(".shtm","_message.shtm")%>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a><em>|</em><a href="http://product.21-sun.com/proDetail/<%=file_name.replace(".shtm","_message.shtm")%>" title="<%=factoryname+name+catalogname %>评论" target="_blank">评论</a> <a href="javascript:;"	onclick="showinquery('<%=id %>','')" class="plbtn">询价</a></span>
                <div class="plInfo"><%=CommonString.substringByte(CommonHtml.filterHTML(introduce), 180) + (CommonHtml.filterHTML(introduce).equals("")?"":"...")%><a style="color:#2e65b7;" 	href="http://product.21-sun.com/proDetail/<%=file_name %>" 	target="_blank">[查看详情]</a> </div>
              </div>
            </li>
            <%}} %>
          </ul>
          <div class="page page_add" id="pagination">
            <div id="pagination" class="paging page">
            	<tags:page pageBean="<%=pageBean%>" />
			</div>
          </div>
        </div>
        
        <!--三一代理商-->
        <div class="comBox mb10">
        <div class="hd fix">
          <h3><%=factoryName %>代理商</h3>
          <span class="more"><a href="/agent_list.htm" target="_blank">更多<%=factoryName %>代理商 &gt;&gt;</a></span>
        </div>
        <div class="bd fix s_company">
          	<!--agent-->
        	<%String urlString = "/include/brandshow/brand_agent.jsp?factoryid="+factoryId; %>  
        	<jsp:include page="<%=urlString %>" />
			<!--agent end-->
        </div>
      </div>
        
      </div>
    </div>
    <!--right-->
    <div class="s_right">
    	<!--agent-->
    		<%String add = "/brandshow/"+usern+"/right.htm"; %>  
        	<jsp:include page="<%=add %>" />
		<!--agent end-->
    </div>
  </div>
</div>
<!--top-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--top end-->
</body>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>

</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>