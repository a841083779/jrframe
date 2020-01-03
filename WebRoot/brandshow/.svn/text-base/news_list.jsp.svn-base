<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;   // 厂家
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String showtip = "最新动态";
	String tableName = "article";
	String whereStr = " and is_pub=1 and is_del=0 and sort_num like '%,22,%' ";
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
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map factoryMap = null; 
	String factoryName = "";
	String factoryId = "";
	String factorycatalogName = "";
	String factorypro_brand_title = "";
	String factorylogo = "";
	String factoryurl = "";
	String factorytelphone="";
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
	if (!"".equals(factoryName)) {
		whereStr += " and product_brand = '"+factoryName+"' ";
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
	try {
		getNewsList = pageBean.getDatasByWebService("Web21sunDBHelper");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns:wb="http://open.weibo.com/wb">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=factoryName %>动态 - 铁臂<%=factoryName %>专区</title>
<meta name="keywords" content="<%=factoryName %>动态,<%=factoryName %>" />
<meta name="description" content="铁臂<%=factoryName %>专区，为您提供最新<%=factoryName %>动态，帮助您全面了解<%=factoryName %>动态。买<%=factoryName %>产品，就上铁臂商城！" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
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
      <li class="selected"><a href="/news.htm"><%=factoryName %>动态</a></li>
      <li><a href="#"><%=factoryName %>人物</a></li>
      <li><a href="/product_list.htm"><%=factoryName %>产品</a></li>
      <li><a href="/comment_list.htm"><%=factoryName %>口碑</a></li>
      <li><a href="/agent_list.htm"><%=factoryName %>代理商</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=factoryName %>专区</a> &gt;&gt; <%=factoryName %>动态</div>
</div>
<div class="s_main fix">
  <!--left-->
  <div class="contain980 fix">
    <div class="s_mleft">
      <!--新闻-->
      <div class="comBox">
        <div class="hd fix mt10">
          <h3><%=factoryName %>动态</h3>
          
        </div>
        <div class="bd fix">
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
							String newUrl="news_detail_"+newId+".htm";
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
          <div class="s_topNews new_news mt10">
          	<% if(isFile){%>
            <a href="<%=newUrl %>" target="_blank" title="<%=titleAlt%>"><img title="<%=titleAlt%>"  alt="<%=titleAlt%>" src="<%=imageUrl%>" class="img" width="175" height="115" /></a> 
            <%} %>
            <div class="intro">
              <a href="<%=newUrl %>" target="_blank" title="<%=titleAlt%>"><h3><%=newTitle %></h3>
              <div class="text"><%=newContent %></div>
              <div class="time pr"><%=add_date %></div>
              <span class="btn">继续阅读</span></a>
              <%if(!factoryInfo.equals("")||!catalogInfo.equals("")){%>
              <span class="tag" style="display:none">标签：
					<%if(!factoryInfo.equals("")&&!factoryInfo.equals("null")){%>
                  <a title="<%=factoryInfo%>" href="" ><%=factoryInfo%></a>
                  <%}%>
                  <%if(!catalogInfo.equals("")&&!catalogInfo.equals("null")){%>
                  <a title="<%=catalogMap.get(catalogInfo)%>"  href="" ><%=catalogMap.get(catalogInfo)%></a>
                  <%}%>
                  <%if(!factoryInfo.equals("")&&!catalogInfo.equals("")&&!factoryInfo.equals("null")&&!catalogInfo.equals("null")){%>
                  <a title="<%=factoryInfo%><%=catalogMap.get(catalogInfo)%>" href=""><%=factoryInfo%><%=catalogMap.get(catalogInfo)%></a>
                  <%}%>
				</span>
			 <%}%>
            </div>
          </div>
          <%}} %>
            
        <div class="comPage">
          <div class="page page_add" id="pagination">
            <div id="pagination" class="paging page">
            	<tags:page pageBean="<%=pageBean%>" />
            </div>
          </div>
        </div>
        </div>
      </div>
      <!--<%=factoryName %>代理商-->
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
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
	}
%>