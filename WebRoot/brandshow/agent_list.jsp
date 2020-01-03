<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="java.net.URLEncoder"%><%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;   // 厂家
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类别
	Map catalogMap = (Map) application.getAttribute("catalogMap");
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
	
	String url = CommonString.getFormatPara(request.getQueryString()) ;  // 调整url，做分页处理
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	StringBuffer whereStr = new StringBuffer(" and flag = 2 and is_show = 1 ") ;
	if(!"".equals(factoryId)){
		whereStr.append(" and agent_fac like '%"+factoryId+"%'") ;
	}
	if(!"".equals(catalog)){
		whereStr.append(" and id in(select DISTINCT(agent_id) from pro_agent_products where catalognum like '"+catalog+"%')");
		catalogName = CommonString.getFormatPara(catalogMap.get(catalog));
	}
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(16) ;
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 	nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;
	pageBean.setParams(url) ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" id,name,full_name,agent_fac,agent_fac_name,telphone,fax,address,city,usern  ") ;
	pageBean.setIsShowSql(true) ;
	pageBean.setTableName(" pro_agent_factory") ;
	String orderbyStr = " is_cooperate desc ,id desc";
	pageBean.setOrderBy(orderbyStr);
	// 根据条件查出的产品
	List<Map> searchProducts = pageBean.getDatas() ;  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=factoryName %><%=catalogName.equals("")?"":catalogName %>代理商_<%=factoryName %><%=catalogName %>售后服务 – 铁臂<%=factoryName %>专区</title>
<meta name="keywords" content="<%=factoryName %><%=catalogName %>代理商,<%=factoryName %><%=catalogName %>售后服务" />
<meta name="description" content="铁臂<%=factoryName %>专区，为您提供<%=factoryName %><%=catalogName %>代理商信息，帮助您了解全国各地的<%=factoryName %><%=catalogName %>代理商，让您在选择<%=factoryName %><%=catalogName %>产品时更放心。买<%=factoryName %><%=catalogName %>产品，就上铁臂商城！" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
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
      <li><a href="/product_list.htm"><%=factoryName %>产品</a></li>
      <li><a href="/comment_list.htm"><%=factoryName %>口碑</a></li>
      <li class="selected"><a href="/agent_list.htm"><%=factoryName %>代理商</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=factoryName %>专区</a> &gt;&gt; <a href="/agent_list.htm"><%=factoryName %>代理商</a><%=catalogName.equals("")?"":" &gt;&gt; "+factoryName+catalogName+"代理商"%></div>
</div>
<div class="s_main fix">
  <!--left-->
  <div class="contain980 fix">
    <div class="s_mleft">
      <div class="comBox mb10">
        <div class="hd fix">
          <h3>品牌售后服务</h3>
        </div>
        <div class="cg mb10"> 
          <strong>类别：</strong>
          <a <% if(catalog.equals("")){ %>class="selected" <%} %> href="/agent_list.htm">全部</a><em>|</em>
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
	                	<a <% if(catalog.equals(catalogNum)){ %>class="selected" <%} %> href="/agent_list_<%=catalogNum %>.htm"><%=catalogTName %></a><em>|</em>
	                <%i++;
	                	if(i==5){break;}
           }}} %>
        </div>
        
        <div class="bd fix s_company">
          <ul class="fix">
          <%
          if(searchProducts !=null && searchProducts.size()>0){
			   for(Map oneMap:searchProducts){
						String pId = CommonString.getFormatPara(oneMap.get("id"));
						String pUsern = CommonString.getFormatPara(oneMap.get("usern"));
						String full_name = CommonString.getFormatPara(oneMap.get("full_name"));
						String name = CommonString.getFormatPara(oneMap.get("name"));
						String agent_fac_name = CommonString.getFormatPara(oneMap.get("agent_fac_name"));
						String city = CommonString.getFormatPara(oneMap.get("city"));
						String telphone = CommonString.getFormatPara(oneMap.get("telphone"));
						String fax = CommonString.getFormatPara(oneMap.get("fax"));
						String address = CommonString.getFormatPara(oneMap.get("address"));
			%>
            <li>
              <a class="n" href="http://dealer.21-sun.com/<%=pUsern %>/" title="<%=full_name %>" target="_blank"><%=full_name %></a>
              <span class="area"><%=city %></span>
              <div class="text">
                代理品牌：<%=agent_fac_name %><br />
                电话：<%=telphone %><br />
                传真：<%=fax %><br />
                地址：<%=address %>
              </div>
              <a href="http://dealer.21-sun.com/<%=pUsern %>/" target="_blank" class="btn">进入店铺</a>
            </li>
            <%}} %>
          </ul>
          </div>
          <div id="pagination" class="page page_add">
			<div id="pagination" class="paging page">
            	<tags:page pageBean="<%=pageBean%>" />
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
</html>