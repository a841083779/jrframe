<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	int catalogInt = CommonString.getFormatInt(request.getParameter("catalog"));
	int factoryInt = CommonString.getFormatInt(request.getParameter("factory"));
	String orderby = CommonString.getFormatPara(request.getParameter("orderby"));
	String goodbad = CommonString.getFormatPara(request.getParameter("goodbad")) ;
	String catalog = catalogInt+"";
	String factory = factoryInt+"";
	catalog = catalog.equals("0") ? "" : catalog;
	factory = factory.equals("0") ? "" : factory;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
    Map brandUsernMap  = (HashMap)application.getAttribute("brandUsernMap") ;  // id 和 品牌代号对应
    if(null == brandUsernMap){
	    brandUsernMap = new HashMap() ;
    }
	
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	StringBuffer whereStr = new StringBuffer(" and pp.factoryname is not null and  pm.is_show=1 ") ;
	if(!"".equals(catalog)){
		whereStr.append(" and pp.catalognum like '%"+catalog+"%'") ;
	}
	if(!"".equals(factory)){
		whereStr.append(" and pp.factoryid="+factory) ;
	}
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
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(10) ;
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 	nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;
	pageBean.setParams(url) ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pm.is_help,pp.view_count,pp.catalognum") ;
	//pageBean.setIsShowSql(true) ;
	pageBean.setTableName(" pro_comments pm left join pro_products pp on  pm.product_id=pp.id") ;
	pageBean.setMain("pm") ;
	String orderbyStr = "";
	if(orderby.equals("pubdate")){
		orderbyStr = " pm.add_date desc,pm.id desc";
	}else if(orderby.equals("help")){
		orderbyStr = " pm.is_help desc,pm.add_date desc";
	}else{
		orderbyStr = " pm.add_date desc,pp.view_count desc";
	}
	pageBean.setOrderBy(orderbyStr) ;
	// 根据条件查出的产品
	List<Map> searchProducts = pageBean.getDatas() ;  
	
	List<Map> lastCommentList = dbHelper.getMapList("select top 10 pm.is_help,pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.product_id product_id,pp.factoryid,pp.factoryname,pp.id as proid,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm left join pro_products pp on  pm.product_id=pp.id where pp.factoryname is not null and pm.is_show=1 order by pm.add_date desc");
     //TDK
	String title="【口碑】工程机械产品口碑大全 – 铁臂口碑";
	String keywords="工程机械产品口碑,工程机械产品口碑大全";
	String description="铁臂口碑机器大全栏目涵盖了挖掘机、装载机、起重机等各种工程机械产品口碑，帮您更好的了解工程机械产品，买工程机械产品就上铁臂商城。";
	if(!catalog.equals("")||!factory.equals("")){
	       title=CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"评价_"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"口碑大全 – 铁臂口碑";
	       keywords=CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+", "+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"口碑,"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"评价";
	       description="铁臂口碑为您提供"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"评价,帮助您更好的了解"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+",买"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"就上铁臂商城。";
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%if(!catalog.equals("")&&!factory.equals("")){%>
<title><%=title.replace("卡特彼勒","卡特")%></title>
<meta name="keywords" content="<%=keywords.replace("卡特彼勒","卡特")%>" />
<meta name="description" content="<%=description.replace("卡特彼勒","卡特")%>" />
<%}else{%>
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
<%}%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<%if(factory.equals("")&&!catalog.equals("")){%> 
<meta name="mobile-agent" content="format=html5;url=http://m.koubei.21-sun.com/web_kb_list.jsp?catalog=<%=catalog%>">
<%}else if(!factory.equals("")){%>
<meta name="mobile-agent" content="format=html5;url=http://m.koubei.21-sun.com/web_kbcat_list.jsp?factory=<%=factory%><%=catalog.equals("")?"":"&catalog="+catalog%>">
<%}%>
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<%if(factory.equals("")&&!catalog.equals("")){%>
<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/web_kb_list.jsp?catalog=<%=catalog%>");</script>
<%}else if(!factory.equals("")){%>
<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/web_kbcat_list.jsp?factory=<%=factory%><%=catalog.equals("")?"":"&catalog="+catalog%>");</script>
<%}%>
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
<style>
  .info a{
   color:#075aad;
  }
  a:link, a:visited {
	color:#666666;
}
a:hover {
	color:#ff6600;
}
.STYLE1 {
	color: #FFFFFF
}
.pllist {
	width:85%;
	float:left;
	min-height:50px;
	overflow:visible;
	position:relative;
	padding-top:23px;
	border-bottom:#ccc 1px dotted;
	margin-right:1%;
	padding-left:8px;
}
.pllist a.plfl {
	position:absolute;
	left:8px;
	top:0px;
	margin:5px;
	font-size:14px;
	font-family:Verdana;
	color:#3355AC;
	cursor:default;
	float:none;
	padding:0px;
	width:auto;
	text-decoration:none;
}
.pllist a {
	display:inline-block;
	margin:0px 5px;
	font-size:12px;
	line-height:20px;
	height:20px;
	overflow:hidden;
	float:none;
	padding:0px;
	width:auto;
	text-decoration:none;
}
</style>
<script type="text/javascript">
//导航选中状态
var jrChannel='2#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/" title="铁臂口碑">铁臂口碑</a>&nbsp;&gt;&gt;&nbsp;<a href="/new/">最新口碑</a>
  <% if(!catalog.equals("")&&!factory.equals("")){ %>
  		<% if(catalog.length()>=6&&1==2){ %>
  		&gt;&gt;&nbsp;<a href="/comment-<%=catalog.substring(0, 3) %>-0-0-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a>
  		<%} %>
  		&gt;&gt;&nbsp;<a href="/comment-<%=catalog %>-0-0-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog)) %></a>
  		&gt;&gt;&nbsp;<a href="/comment-0-<%=factory %>-0-0-0.htm"><%=CommonString.getFormatPara(brandMap.get(factory)) %></a>
  		&gt;&gt;&nbsp;<a href="/comment-<%=catalog %>-<%=factory %>-0-0-0.htm"><%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特") %><%=CommonString.getFormatPara(catalogMap.get(catalog)) %></a>
  		&gt;&gt;&nbsp;<%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)) %><%=CommonString.getFormatPara(catalogMap.get(catalog)) %>怎么样
  <% }else if(!catalog.equals("")&&factory.equals("")){ %>
  		&gt;&gt;&nbsp;<a href="/comment-<%=catalog.substring(0, 3) %>-0-0-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a>
  		<% if(catalog.length() == 6){ %>
  			&gt;&gt;&nbsp;<a href="/comment-<%=catalog %>-<%=factory %>-0-0-0.htm"><%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)) %><%=CommonString.getFormatPara(catalogMap.get(catalog)) %></a>
  			 &gt;&gt;&nbsp;<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>哪个品牌好 
	  	<% }else{ %>
	  		&gt;&gt;&nbsp;<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>哪个品牌好 
	  	<% } %>
  <% }else if(catalog.equals("")&&!factory.equals("")){ %>
  	&gt;&gt;&nbsp;<a href="/comment-0-<%=factory %>-0-0-0.htm"><%=CommonString.getFormatPara(brandMap.get(factory)) %>口碑</a>
  	&gt;&gt;&nbsp;<%=CommonString.getFormatPara(brandMap.get(factory)) %>怎么样
  <% } %></h3>
</div>
<!--面包屑结束-->
<div class="contain980 mb10 np_fix"> 
  <!--left-->
  <div class="w210 l">
    <div id="leftId">
      <div class="leftTab">
        <ul>
          <li class="ltcur"><a href="javascript://void(0);" style="width:210px;">产品类别</a></li>
        </ul>
      </div>
      <div class="w208 border01 l leftPart mb10">
	  <div class="treev1" id="treev1" style="max-height:10000px; overflow-y:hidden;">
	    <ul>
	    <%
	    	for(Map topCat : catalogList){
	    		String topCatNum = CommonString.getFormatPara(topCat.get("num"));
	    		if(topCatNum.length() == 3){
	    			String topCatName = CommonString.getFormatPara(topCat.get("name"));
	    			String topCatId = CommonString.getFormatPara(topCat.get("id"));
	    %>
	    <li class="root" id="cat_<%=topCatNum %>">
	    	<b style="font-size:14px;"><a href="/comment-<%=topCatNum %>-0-0-0-0.htm"><%=topCatName %></a></b>
	    	<ul style="display:<%=topCatNum.equals(catalog) || (!catalog.equals("")&&catalog.substring(0, 3).equals(topCatNum)) ? "block" : "none" %><%if(catalog.equals("")&&topCatNum.equals("101")){%>block<%}%>;">
	    <%
				    for(Map subCat : catalogList){
						String subParentId = CommonString.getFormatPara(subCat.get("parentid"));
						if(subParentId.equals(topCatId)){
							String subCatNum = CommonString.getFormatPara(subCat.get("num"));
							String subCatName = CommonString.getFormatPara(subCat.get("name"));
		%>
				<li id="cat_<%=topCatNum %>_<%=subCatNum %>"<%=catalog.equals(subCatNum) ? " class=\"rootCur\"" : "" %>>
					<a href="/comment-<%=subCatNum %>-0-0-0-0.htm" class="mainBrand"><big><%=subCatName %></big></a>
				</li>
		<%
						}
					}
	    %>
	    	</ul>
	    </li>
	    <%
	    		}
	    	}
	    %>
	    </ul>
	  </div>
	  <!--字母检索结束--> 
	</div>
    </div>
	<%
  	  if(lastCommentList!=null && lastCommentList.size()>0){
	%>
	  <div class="Similar">
	  	<div class="stitle">
	  		<h3>最新产品口碑</h3>
	  	</div>
	  	<div class="scontent">
	  		<ul class="slist">
	  <%
	  		  for(Map lastComment : lastCommentList){
			  String catalognum=CommonString.getFormatPara(lastComment.get("catalognum"));
			  String factoryid=CommonString.getFormatPara(lastComment.get("factoryid"));
	  %>
	  			<li><a target="_blank" title="<%=CommonString.getFormatPara(lastComment.get("factoryname")) + CommonString.getFormatPara(lastComment.get("product_name")) + CommonString.getFormatPara(lastComment.get("catalogname"))%>口碑" href="/list/<%=CommonString.getFormatPara(lastComment.get("proid"))%>.htm"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(lastComment.get("img2")) %>" alt="<%=CommonString.getFormatPara(lastComment.get("factoryname")) + CommonString.getFormatPara(lastComment.get("product_name")) + CommonString.getFormatPara(lastComment.get("catalogname"))%>口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70" /><h4><%=CommonString.getFormatPara(lastComment.get("factoryname")) + CommonString.getFormatPara(lastComment.get("product_name")) + CommonString.getFormatPara(lastComment.get("catalogname"))%>口碑</h4></a></li>
	  <%
	  		  }
	  %>
	  		</ul>
	  	</div>
	  </div>
	<%
	}
	%>
	<%if(!catalog.equals("")){%>
    <div class="w208 border02 l leftPart02 mb10 pp_hotph" style="margin-top:10px;">
      <h2><%=CommonString.getFormatPara(catalogMap.get(catalog)) %>口碑排行 </h2>
      <ul class="list003" id="brandSubLeftId">
      	<jsp:include page="/include/koubei/brands.jsp" flush="true">
			<jsp:param name="factoryid" value="<%=factory %>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalog %>"></jsp:param>
		</jsp:include>
      </ul>
    </div>
	<%}%>
   
   <%if(catalog.equals("")&&!factory.equals("")){%>
      	<jsp:include page="/include/koubei/main_pro.jsp" flush="true">
			<jsp:param name="factoryid" value="<%=factory %>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalog %>"></jsp:param>
		</jsp:include>
	<%}%>
	
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r mb10">
    <div class="w755 border03 l Condition mb10 koubei_pp">
    	<div class="ConditionTop">
          <h1 class="r" style="font-size:14px;">
          	<% if(catalog.equals("")&&factory.equals("")){ %>
          		铁臂口碑
          	<%}else if(!catalog.equals("")&&!factory.equals("")){ %>
          		<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+CommonString.getFormatPara(catalogMap.get(catalog)) %>口碑
          	<%}else{ %>
			    <%=CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog)) %>口碑
			<%}%>
          </h1>
        </div>
      <ul class="ConditionBottom">
        <script type="text/javascript">
	  jQuery(document).ready(function() {
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
        <li class="cblist">
          <dt> 品牌 </dt>
          <dd>
            <% if (!"".equals(catalog)) {%>
            <a href="/comment-<%=catalogInt %>-0-0-0-0.htm" <%if("".equals(factory)){%> class="select" <%} %>>不限</a>
            <%
			List<Map> recommend_brands = dbHelper.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog+ "' order by order_no desc");
				if (null != recommend_brands && recommend_brands.size() > 0) {
					int i = 0;
					for (Map oneMap : recommend_brands) {
						i++;
						if (i == 20) {
							break;
						}
			%>  
            <!-- 挖掘机 --> 
            <a href="/comment-<%=catalogInt %>-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>-0-0-0.htm"
			<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factory)){%> class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
            <% }}} else { %>
            <a <%if("".equals(factory)){%> class='select' <%} %> href="/comment-0-0-0-0-0.htm">不限</a> 
            <!-- 挖掘机 --> 
            <a <%if("133".equals(factory)){%> class='select' <%} %> href="/comment-<%=catalogInt %>-133-0-0-0.htm">三一</a> 
            <!-- 挖掘机 --> 
            <a <%if("182".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-182-0-0-0.htm">小松</a> 
            <!-- 挖掘机 --> 
            <a <%if("192".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-192-0-0-0.htm">斗山</a> 
            <!-- 挖掘机 --> 
            <a <%if("184".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-184-0-0-0.htm">日立</a> 
            <!-- 挖掘机 --> 
            <a <%if("183".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-183-0-0-0.htm">神钢</a> 
            <!-- 挖掘机 --> 
            <a <%if("175".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-175-0-0-0.htm">沃尔沃</a> 
            <!-- 挖掘机 --> 
            <a <%if("174".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-174-0-0-0.htm">卡特彼勒</a> 
            <!-- 挖掘机 --> 
            <a <%if("146".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-146-0-0-0.htm">玉柴重工</a> 
            <!-- 挖掘机 --> 
            <a <%if("136".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-136-0-0-0.htm">柳工</a> 
            <!-- 挖掘机 --> 
            <a <%if("194".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-194-0-0-0.htm">现代京城</a>
            <a <%if("1220".equals(factory)){%>class='select' <%} %> href="/comment-<%=catalogInt %>-1220-0-0-0.htm">华通动力</a>
            <%
				}
			%>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand_koubei_news.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factory%>" name="factoy_id"/>
            <jsp:param value="koubei" name="flag"/>
            </jsp:include>
            </div>
          </dd>
        </li>
        <script type="text/javascript">
	            if('101001001'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('101001001'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('101001001'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
      </ul>
    </div>
    <div class="l border03 n_koubei_list border03">
      <div class="np_fix nkb_sort">
        <div class="l nkb_left">
          <ul class="np_fix">
            <!--<li <% if(orderby.equals("0")){ %>class="cur"<%} %>><a href="/<%=catalogInt %>_<%=factoryInt %>_0_<%=goodbad.equals("")?"0":goodbad%>_<%=offset.equals("")?"0":offset%>.htm">全部口碑</a></li>-->
            <li <% if(orderby.equals("pubdate")){ %>class="cur"<%} %>><a href="/comment-<%=catalogInt %>-<%=factoryInt %>-pubdate-<%=goodbad.equals("")?"0":goodbad%>-<%=offset.equals("")?"0":offset%>.htm">最新发表</a></li>
            <li <% if(orderby.equals("help")){ %>class="cur"<%} %>><a href="/comment-<%=catalogInt %>-<%=factoryInt %>-help-<%=goodbad.equals("")?"0":goodbad%>-<%=offset.equals("")?"0":offset%>.htm">有帮助</a></li>
          </ul>
        </div>
        <div class="r nkb_right">共有<%=pageBean.getTotal() %>条</div>
      </div>
      <div class="np_fix n nkb_sxtj">
        <div class="r sxtj_right"><!-- <a href="#"><img src="../images/new_pro/fbkb_btn.gif" width="69" height="21"/></a> --></div>
      </div>
      <div class="plList nkb_pro_list np_fix">
        <ul>
        <%
		   if(searchProducts !=null && searchProducts.size()>0){
			   for(Map oneMap:searchProducts){
				   String id = CommonString.getFormatPara(oneMap.get("id"));
				   String contact_address = CommonString.getFormatPara(oneMap.get("contact_address"));
				   String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
				   String product_name = CommonString.getFormatPara(oneMap.get("product_name"));
				   String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
				   String catalognum = CommonString.getFormatPara(oneMap.get("catalognum"));
				   String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
				   String product_id = CommonString.getFormatPara(oneMap.get("product_id"));
				   String img2 = CommonString.getFormatPara(oneMap.get("img2"));
				   String factoryid = CommonString.getFormatPara(oneMap.get("factoryid"));
				   String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(oneMap.get("add_date")));
				   String name = CommonString.getFormatPara(oneMap.get("name"));
				   String good = CommonString.getFormatPara(oneMap.get("good"));
				   String bad = CommonString.getFormatPara(oneMap.get("bad"));
				   String content = CommonString.getFormatPara(oneMap.get("content"));
				   if(content.length()>25){
				   content=content.substring(0,25);
				   }
				   int score1 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score1")));
				   int score2 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score2")));
				   int score3 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score3")));
				   int score4 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score4")));
				   int score = (score1+score2+score3 +score4)/4;
				   String username =CommonString.getFormatPara(oneMap.get("username"));
		%>
          <li>
            <div class="l">
              <div class="plimg"> <a href="/detail/<%=id %>.htm" target="_blank" title="<%=factoryname +product_name+catalogname %>"> <img src="/uploadfiles/<%=img2 %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=factoryname +product_name+catalogname %>" title="<%=factoryname +product_name+catalogname %>"> </a> </div>
              <!--<div class="nkb_img_cs"><span><a href="/0-<%=factoryid %>_0_0_0.htm"  title="<%=factoryname %>"><%=factoryname %></a></span>|<span><a href="/<% if(catalognum.length()>=6){ %><%=catalognum.substring(0, 6) %><%}else{ %><%=catalognum %><%} %>_<%=factoryid %>_0_0_0.htm" title="<%=factoryname.replace("卡特彼勒","卡特")%><% if(catalognum.length()>=6){ %><%=CommonString.getFormatPara(catalogMap.get(catalognum.substring(0, 6))) %><%}else{ %><%=CommonString.getFormatPara(catalogMap.get(catalognum)) %><%}%>"><%=factoryname.replace("卡特彼勒","卡特") %><% if(catalognum.length()>=6){ %><%=CommonString.getFormatPara(catalogMap.get(catalognum.substring(0, 6))) %><%} %></a></span></div>-->
            </div>
            <div class="content">
              <div class="np_fix">
                <h3><a href="http://koubei.21-sun.com/list/<%=product_id %>.htm" target="_blank" title="<%=factoryname +product_name+catalogname %>"><%=factoryname +product_name+catalogname %></a></h3>
                <span class="time"><%=add_date %></span> </div>
              <div class="plinfo01"><span class="plname"><%=username.equals("")?contact_address:username %>评论</span></div>
              <div class="w100 np_fix">
                <p class="textContent"><% if(!good.equals("")){%><% if(!goodbad.equals("bad")){%>优点：<%=good %><br /><%}}%><% if(!bad.equals("")){%><% if(!goodbad.equals("good")){%>缺点：<%=bad %><br /><%}}%><%=content %><a title="查看全文" href="/detail/<%=id %>.htm" target="_blank" style="color:red;">查看全文&gt;&gt;</a></p>
                <div class="r plt">网友评分 <font><%=score %></font> 分</div>
              </div>
              <div class="n_kb_add_pf">
              	<p class="pftitle">网友评分</p>
                <ul class="np_fix nkb_pflist np_fix" style="width:70%;float:left">
                    <li><span class="nkb_pfwz">价格：</span><div id="pricescore_<%=id %>" title="regular"></div><span class="nkb_pffs"><%=score1 %>分</span></li>
                    <li><span class="nkb_pfwz">性能：</span><div id="abilityscore_<%=id %>" title="regular"></div><span class="nkb_pffs"><%=score2 %>分</span></li>
                    <li><span class="nkb_pfwz">质量：</span><div id="qualityscore_<%=id %>" title="regular"></div><span class="nkb_pffs"><%=score3 %>分</span></li>
                    <li><span class="nkb_pfwz">售后：</span><div id="servicescore_<%=id %>"></div><span class="nkb_pffs"><%=score4 %>分</span></li>
                </ul>
				<div style="float:left"><a  href="http://koubei.21-sun.com/list/<%=product_id%>.htm#sentComment" target="_blank"><img src="/koubei/images/temp/1_05.png" alt="发表评论" width="120" height="27"></a></div>
              </div>
              <script language="javascript" type="text/javascript">
	            var s1_<%=id %> = (parseInt(<%=score1 %>,10)/20);
	  			var s2_<%=id %> = (parseInt(<%=score2 %>,10)/20);
	  			var s3_<%=id %> = (parseInt(<%=score3 %>,10)/20);
	  			var s4_<%=id %> = (parseInt(<%=score4 %>,10)/20);

	            //获得评论分数
	          	jQuery("#pricescore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s1_<%=id %>
	          	});
	          	jQuery("#abilityscore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s2_<%=id %>
	          	});
	          	jQuery("#qualityscore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s3_<%=id %>
	          	});
	          	jQuery("#servicescore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s4_<%=id %>
	          	});
              </script>
              <div class="nkb_moregg" style="clear:both"><a href="/0-<%=factoryid %>-0.htm"  title="<%=factoryname %>"><%=factoryname %></a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/<% if(catalognum.length()>=6){ %><%=catalognum.substring(0, 6) %><%}else{ %><%=catalognum %><%} %>-<%=factoryid %>-0.htm" title="<%=factoryname.replace("卡特彼勒","卡特")%><% if(catalognum.length()>=6){ %><%=CommonString.getFormatPara(catalogMap.get(catalognum.substring(0, 6))) %><%}else{ %><%=CommonString.getFormatPara(catalogMap.get(catalognum)) %><%}%>"><%=factoryname.replace("卡特彼勒","卡特") %><% if(catalognum.length()>=6){ %><%=CommonString.getFormatPara(catalogMap.get(catalognum.substring(0, 6))) %><%} %></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/comment-<% if(catalognum.length()>=6){ %><%=catalognum.substring(0, 6) %><%}else{ %><%=catalognum %><%} %>-<%=factoryid %>-0-0-0.htm" target="_blank" title="更多<%=factoryname %><% if(catalognum.length()>=6){ %><%=CommonString.getFormatPara(catalogMap.get(catalognum.substring(0, 6))) %><%} %>口碑">更多<%=factoryname.replace("卡特彼勒","卡特") %><% if(catalognum.length()>=6){ %><%=CommonString.getFormatPara(catalogMap.get(catalognum.substring(0, 6))) %><%} %>口碑</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/list/<%=product_id%>.htm#00b" target="_blank" title="询<%=factoryname +product_name+catalogname %>最低价">询最低价</a>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="youk"><a href="javascript:void(0)" onclick="voteHelp('<%=id %>')"><b style="color:red">有用</b></a> (<span id="vote_<%=id %>"><%=CommonString.getFormatInt(oneMap.get("is_help")) %></span>)</span></div>
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
      </div>
      <div class="w755 l">
    <div id="pagination" class="page">
   		<tags:page_rewrite_koubei_old pageBean="<%=pageBean %>"  />   
    </div>
  </div>
    </div>
    
  </div>
  <!--right end--> 
</div>
<%if(catalog.equals("")&&factory.equals("")){%>
<jsp:include page="/include/koubei/catalog_all.jsp" flush="false"/>
<%}%>
<jsp:include page="/include/index/friendlink_koubei.htm" flush="true"/>
<!--end of foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<script type="text/javascript">
function addCookie(){
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}

	function voteHelp(id){
		var help = parseInt($("#vote_"+id).html());
		if(setlooked(id)==1){
			$.ajax({
			  url: "/action/ajax.jsp?flag=koubeiHelp&id="+id,
			  cache: false,
			  async: true,
			  success: function(html){
			  }
			});
			$("#vote_"+id).html(help+1);
			$.jBox.tip('感谢您的支持！');
		}else{
			$.jBox.tip('您已经投过票了哟！');
		}
	}
	
		function setlooked(id){
		var x = 0;
		var imgs = jQuery.cookies.get("help_imgs");
		if(imgs==null || imgs == "" || imgs.indexOf("help"+id) < 0){
			var newImgs = imgs+",help"+id;
			jQuery.cookies.set("help_imgs",newImgs,{hoursToLive : 10});
			x = 1;
		}
		return x;
	}
</script> 
<!--end of foot-->
<div style="display:none"><script src="http://s6.cnzz.com/stat.php?id=5755842&web_id=5755842" language="JavaScript"></script></div>

<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
#ads02 { position:fixed; right:0px; top:80px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<!--对联广告-->
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/koubei/index.jsp" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/kb_dl20140702.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->
</body>
</html>