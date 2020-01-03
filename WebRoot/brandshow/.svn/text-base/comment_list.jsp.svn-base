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
	String view_count = "";
	String catalogName = "";

	if(usern!=null && !usern.equals("")){
		String factory_sql = "select is_made,pro_brand_title, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,url,img1,telphone,banner,create_date,master,weibo,email,view_count from pro_agent_factory where usern = '"+usern+"' and is_show=1 and flag=1" ;
		factoryMap = dbHelper.getMap(factory_sql);
		factoryId = CommonString.getFormatPara(factoryMap.get("id"));
		factoryName = CommonString.getFormatPara(factoryMap.get("name"));
		factorypro_brand_title = CommonString.getFormatPara(factoryMap.get("pro_brand_title"));
		factorylogo = CommonString.getFormatPara(factoryMap.get("logo"));
		factoryurl = CommonString.getFormatPara(factoryMap.get("url")); 
		factorytelphone = CommonString.getFormatPara(factoryMap.get("telphone")); 
		view_count = CommonString.getFormatPara(factoryMap.get("view_count")); 
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		Common.doForward(request,response,"/404.htm");
	}
	
	//排名
	String topCount = "";
	if(!view_count.equals("")){
		String topSql = "select count(id)+1 as topCount from pro_agent_factory where is_show=1 and flag=1 and  view_count>"+view_count;
		Map topMap = dbHelper.getMap(topSql);
		if(topMap!=null && topMap.size()>0){
			topCount = CommonString.getFormatPara(topMap.get("topCount"));
		}
		
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
	StringBuffer whereStr = new StringBuffer(" and pp.factoryname is not null") ;
	if(!"".equals(factoryId)){
		whereStr.append(" and pp.factoryid="+factoryId) ;
	}
	if(!"".equals(catalog)){
		whereStr.append(" and pp.catalognum like '"+catalog+"%'") ;
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
	pageBean.setFields(" pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count,pp.catalognum") ;
	//pageBean.setIsShowSql(true) ;
	pageBean.setTableName(" pro_comments pm left join pro_products pp on  pm.product_id=pp.id") ;
	pageBean.setMain("pm") ;
	String orderbyStr = "pm.add_date desc,pm.id desc";
	pageBean.setOrderBy(orderbyStr) ;
	// 根据条件查出的产品
	List<Map> searchProducts = pageBean.getDatas() ;  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=factoryName %><%=catalogName %>口碑大全_<%=factoryName %><%=catalogName %>好不好 - 铁臂商城<%=factoryName %>专区</title>
<meta name="keywords" content="<%=factoryName %><%=catalogName %>口碑, <%=factoryName %><%=catalogName %>好不好,<%=factoryName %>" />
<meta name="description" content="铁臂<%=factoryName %>专区，为您提供<%=factoryName %><%=catalogName %>口碑信息，帮助您了解用户对<%=factoryName %><%=catalogName %>产品的真实评价。买<%=factoryName %><%=catalogName %>产品，就上铁臂商城！" />
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
      <li class="selected"><a href="/comment_list.htm"><%=factoryName %>口碑</a></li>
      <li><a href="/agent_list.htm"><%=factoryName %>代理商</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=factoryName %>专区</a> &gt;&gt; <a href="/comment_list.htm"><%=factoryName %>口碑</a> &gt;&gt; <%=factoryName %><%=catalogName %>口碑</div>
</div>
<div class="s_main fix">
  <!--left-->
  <div class="contain980 fix">
    <div class="s_mleft">
      <!--口碑-->
      <div class="comBox mb10">
        <div class="hd fix">
          <h3><%=factoryName %>口碑</h3>
        </div>
        <div class="bd fix">
          <div class="s_kb_total fix">
            <span class="s_total">共有<b><%=pageBean.getTotal() %></b>条<%=factoryName %>口碑</span>
            <span class="s_rank">品牌关注度排行榜<strong>TOP<%=topCount %></strong></span>
            <span class="s_point">品牌关注指数：<%=view_count %></span>
          </div>
          
          <div class="s_kb">
            <div class="s_hd fix">
              <h3>网友口碑</h3>
              <ul class="s_cate">
                <li><a href="/comment_list.htm" <% if(catalog.equals("")){ %>class="selected" <%} %> target="_blank">全部</a></li>
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
	                	<li><a <% if(catalog.equals(catalogNum)){ %>class="selected" <%} %> href="/comment_list_<%=catalogNum %>.htm"><%=catalogTName %></a></li>
	                <%i++;
	                	if(i==5){break;}
                	}}} %>
              </ul>
              <span class="more"><a href="http://koubei.21-sun.com/" target="_blank">发布口碑 &gt;&gt;</a></span>
            </div>
            <div class="s_bd fix">
              <div class="s_kb_list">
                <ul class="fix">
                <%
			   if(searchProducts !=null && searchProducts.size()>0){
				   for(Map oneMap:searchProducts){
					   String pId = CommonString.getFormatPara(oneMap.get("id"));
					   String pContact_address = CommonString.getFormatPara(oneMap.get("contact_address"));
					   String pFactoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
					   String pProduct_name = CommonString.getFormatPara(oneMap.get("product_name"));
					   String pCatalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
					   String pCatalognum = CommonString.getFormatPara(oneMap.get("catalognum"));
					   String pFile_name = CommonString.getFormatPara(oneMap.get("file_name"));
					   String pImg2 = CommonString.getFormatPara(oneMap.get("img2"));
					   String pCactoryid = CommonString.getFormatPara(oneMap.get("factoryid"));
					   String pAdd_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(oneMap.get("add_date")));
					   String pName = CommonString.getFormatPara(oneMap.get("name"));
					   String pContent = CommonString.getFormatPara(oneMap.get("content"));
					   String pUsername = CommonString.getFormatPara(oneMap.get("username"));
			%>
                  <li>
                    <div class="user"><img src="/brandshow/images/s_face.png" /><%=pUsername.equals("")?pContact_address:pUsername %></div>
                    <div class="intro">
                      <a href="http://koubei.21-sun.com/detail/<%=pId %>.htm" target="_blank" title="<%=pFactoryname+pProduct_name+pCatalogname %>使用感受">
                      <strong class="n">真实口碑 <%=pFactoryname+pProduct_name+pCatalogname %>使用感受</h3></strong>
                      <span class="time"><%=pAdd_date %></span>
                      <div class="text"><%=pContent.length()>100?pContent.substring(0,99)+"...":pContent %></div>
                      <span class="more">查看完整口碑 &gt;&gt;</span>
                      </a>
                    </div>
                  </li>
              	<%
					   }
				   }else{
				%>
				  	<li>
				   	该品牌下的产品暂无评论
				 	</li>
				<% } %>
                </ul>
                
                <div id="pagination" class="page page_add">
					<div id="pagination" class="paging page">
		            	<tags:page pageBean="<%=pageBean%>" />
					</div>
                </div>
                
              </div>
            </div>
          </div>
          
        </div>
      </div>
    <!--三一代理商--></div>
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