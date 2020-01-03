<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String orderby = CommonString.getFormatPara(request.getParameter("orderby"));
    String goodbad = CommonString.getFormatPara(request.getParameter("goodbad")) ;
	if(factory.equals("")){factory="0";}	if(catalog.equals("")){catalog="0";}   if(orderby.equals("")){orderby="0";}  
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
    StringBuffer whereStr = new StringBuffer("  ") ;
	String showName="";
    if(!catalog.equals("0")){	whereStr.append(" and catalognum like '"+catalog+"%'") ;showName=CommonString.getFormatPara(catalogMap.get(catalog));}
	if(!factory.equals("0")){		whereStr.append(" and factoryid="+factory) ;}
	if(orderby.equals("3")){whereStr.append(" and tonandmeter>30") ;showName="大挖";}
	if(orderby.equals("2")){whereStr.append(" and (tonandmeter>=14 and tonandmeter<=30 )") ;showName="中挖";}
	if(orderby.equals("1")){whereStr.append(" and (tonandmeter>=1 and tonandmeter<=13 )") ;showName="小挖";}
	//分页开始
		PageBean pageBean = new PageBean() ;
	    pageBean.setPageSize(15) ;
	    Integer nowPage = 1 ;
	    if(!"".equals(offset) && !"0".equals(offset)){
	 	    nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	    }
	    pageBean.setNowPage(nowPage) ;
	    pageBean.setParams(url) ;
	    pageBean.setCondition(whereStr.toString()) ;
	    pageBean.setFields("factoryname,name,catalogname,file_name,allcount,id,img2,factoryid,catalognum") ;
	    pageBean.setTableName("pro_koubei_list") ;
		pageBean.setOrderBy("allcount desc") ;
	    List<Map> koubeiList = pageBean.getDatas() ;  

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%if(catalog.equals("0")&&factory.equals("0")){
%><title>【工程机械产品口碑】口碑大全_优点_缺点 – 铁臂口碑</title>
<meta name="keywords" content="工程机械产品口碑,工程机械产品口碑大全" />
<meta name="description" content="铁臂口碑包含了大量真实用户的工程机械产品口碑，帮助您通过网络了解工程机械产品，买工程机械产品就上铁臂商城。" /><%
}%>
<%if(!catalog.equals("0")&&!factory.equals("0")){%>
<title>【<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>怎么样?】<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>口碑_<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %><% if(goodbad.equals("good")){ %>优点<%}else if(goodbad.equals("bad")){ %>缺点<%}else{ %>优点缺点投诉<%} %> - 铁臂口碑</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>哪个品牌好,<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>哪个好,<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>口碑,<%=showName %>" />
<meta name="description" content="铁臂口碑包含了大量<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>产品口碑，帮助您通过网络了解<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>产品怎么样，哪个好,买<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>产品就上铁臂商城。" />
<%}else if(!factory.equals("0")){
%><title>【<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>怎么样?】<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑_<%=CommonString.getFormatPara(brandMap.get(factory))+showName %><% if(goodbad.equals("good")){ %>优点<%}else if(goodbad.equals("bad")){ %>缺点<%}else{ %>优点缺点投诉<%} %> - 铁臂口碑</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>怎么样,<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>哪个好,<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑,<%=showName %>" />
<meta name="description" content="铁臂口碑包含了大量<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品口碑，帮助您通过网络了解<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品怎么样，哪个好,买<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品就上铁臂商城。" /><%
}else if(!catalog.equals("0")){%>
<title>【<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>哪个品牌好?】<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑_<%=CommonString.getFormatPara(brandMap.get(factory))+showName %><% if(goodbad.equals("good")){ %>优点<%}else if(goodbad.equals("bad")){ %>缺点<%}else{ %>优点缺点投诉<%} %> - 铁臂口碑</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>哪个品牌好,<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>哪个好,<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑,<%=showName %>" />
<meta name="description" content="铁臂口碑包含了大量<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品口碑，帮助您通过网络了解<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品怎么样，哪个好,买<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品就上铁臂商城。" />
<%}%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<%if(factory.equals("0")&&!catalog.equals("0")){%> 
<meta name="mobile-agent" content="format=html5;url=http://m.koubei.21-sun.com/web_kb_list.jsp?catalog=<%=catalog%>">
<%}else if(!factory.equals("0")){%>
<meta name="mobile-agent" content="format=html5;url=http://m.koubei.21-sun.com/web_kbcat_list.jsp?factory=<%=factory%><%=catalog.equals("")?"":"&catalog="+catalog%>">
<%}%>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<%if(factory.equals("0")&&!catalog.equals("0")){%>
<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/web_kb_list.jsp?catalog=<%=catalog%>");</script>
<%}else if(!factory.equals("0")){%>
<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/web_kbcat_list.jsp?factory=<%=factory%><%=catalog.equals("")?"":"&catalog="+catalog%>");</script>
<%}%>
<script type="text/javascript">
//导航选中状态
var jrChannel='1#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->


<div class="contain980 mb10">


  <h3 class="breadCrumbs"><a href="/" title="铁臂口碑">铁臂口碑</a>&nbsp;&gt;&gt;&nbsp;<a href="/list/">机器大全</a>
  <% if(!catalog.equals("0")&&!factory.equals("0")){ %>
  		<% if(catalog.length()>=6&&1==2){ %>
  		&gt;&gt;&nbsp;<a href="/<%=catalog.substring(0, 3) %>-0-<%=orderby%>.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a>
  		<%} %>
  		&gt;&gt;&nbsp;<a href="/<%=catalog %>-0-<%=orderby%>.htm"><%=showName %></a>
  		&gt;&gt;&nbsp;<a href="/0-<%=factory %>-0.htm"><%=CommonString.getFormatPara(brandMap.get(factory)) %></a>
  		&gt;&gt;&nbsp;<a href="/<%=catalog %>-<%=factory %>-<%=orderby%>.htm"><%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特") %><%=showName %></a>
  		&gt;&gt;&nbsp;<%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)) %><%=showName %>怎么样
  <% }else if(!catalog.equals("0")&&factory.equals("0")){ %>
  		<div style="display:none">&gt;&gt;&nbsp;<a href="/<%=catalog.substring(0, 3) %>-0-<%=orderby%>.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a></div>
  		<% if(catalog.length() == 6){ %>
  			&gt;&gt;&nbsp;<a href="/<%=catalog %>-<%=factory %>-<%=orderby%>.htm"><%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)) %><%=showName %></a>
  			 &gt;&gt;&nbsp;<%=showName %>哪个品牌好 
	  	<% }else{ %>
	  		&gt;&gt;&nbsp;<%=showName %>哪个品牌好 
	  	<% } %>
  <% }else if(catalog.equals("0")&&!factory.equals("0")){ %>
  	&gt;&gt;&nbsp;<a href="/0-<%=factory %>-0.htm"><%=CommonString.getFormatPara(brandMap.get(factory)) %>口碑</a>
  	&gt;&gt;&nbsp;<%=CommonString.getFormatPara(brandMap.get(factory)) %>怎么样
  <% } %></h3>
  
  
</div>
<div class="contain980 fix">
  <!--left-->
  <div class="w210 l np_left">
    <div id="listByCatalog" class="Similar mb10">
      <div class="stitle">
        <h3>热评产品推荐</h3></div>
      <div class="scontent">
        <ul class="slist">
		   <jsp:include page="/include/koubei/hot_comment_pro.jsp" flush="true" />
        </ul>
      </div>
    </div> 
    <div class="w208 border02 l leftPart02 mb10">
      <h2>猜你想看</h2>
      <ul id="brandSubLeftId" class="list003">
  		    <jsp:include page="/include/koubei/guess_like.jsp" flush="true" >
                <jsp:param name="factory" value="<%=factory%>"></jsp:param>
				<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
            </jsp:include>
      </ul> 
    </div>   
  </div>
  <!--left end-->
  <!--right-->
  <div class="w757 r">
    <form action="/list.jsp" id="theform" name="theform">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l">
          <%if(!"0".equals(catalog) || !"0".equals(factory)) { %>
          <a href="/list/"> <span class="reset" >重置</span></a>
          <%}%>
          <%if (!"0".equals(factory) ) { %>
          <span><em><%=CommonString.getFormatPara(brandMap.get(factory))%></em> <a class="delete" href="/<%=catalog%>-0-<%=orderby%>.htm"></a> </span>
          <% } %>
		  <%if (!"0".equals(catalog) ) { %>
          <span><em><%=CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a class="delete" href="/0-<%=factory %>-0.htm"></a> </span>
          <% } %>
		  <%if (!"0".equals(orderby) ) { %>
          <span><em><%=showName%></em> <a class="delete" href="/<%=catalog%>-<%=factory %>-0.htm"></a> </span>
          <% }%>
		  </div>
		  <%if(!catalog.equals("0")&&!factory.equals("0")){%>
          <h1 style="font-size:14px;" class="r"><%=(catalog.equals("0")&&factory.equals("0"))?"工程机械":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName%>口碑</h1>
          <%}else{%>
          <h1 style="font-size:14px;" class="r"><%=(catalog.equals("0")&&factory.equals("0"))?"工程机械":CommonString.getFormatPara(brandMap.get(factory))+showName%>口碑</h1>
          <%}%>		  
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
            <dt> 类别 </dt>
            <dd> 
			<a <%if(catalog.equals("0")){%>class="select"<%}%> href="/0-<%=factory%>-0.htm">不限</a> 
			<a <%if(catalog.equals("101001")){%>class="select"<%}%> href="/101001-<%=factory%>-0.htm">挖掘机</a> 
			<a <%if(catalog.equals("101002")){%>class="select"<%}%> href="/101002-<%=factory%>-0.htm">装载机</a> 
			<a <%if(catalog.equals("102")){%>class="select"<%}%> href="/102-<%=factory%>-0.htm">起重机</a>
			<a <%if(catalog.equals("101003")){%>class="select"<%}%> href="/101003-<%=factory%>-0.htm">推土机</a> 
			<a <%if(catalog.equals("103")){%>class="select"<%}%> href="/103-<%=factory%>-0.htm">混凝土</a> 
			<a <%if(catalog.equals("106001")){%>class="select"<%}%> href="/106001-<%=factory%>-0.htm">压路机</a> 
			<a <%if(catalog.equals("101005")){%>class="select"<%}%> href="/101005-<%=factory%>-0.htm">平地机</a> 
			<a <%if(catalog.equals("105003")){%>class="select"<%}%> href="/105003-<%=factory%>-0.htm">旋挖钻</a> 
			<a <%if(catalog.equals("113001")){%>class="select"<%}%> href="/113001-<%=factory%>-0.htm">破碎锤</a>
			<a <%if(catalog.equals("104001")){%>class="select"<%}%> href="/104001-<%=factory%>-0.htm">摊铺机</a>
              <div class="pbtn" id="changethis"></div>
              <div style="padding-left: 0px; width: 680px;;" class="plmore">
              <jsp:include page="/include/koubei/catalog_koubei.jsp" flush="true">
                  <jsp:param value="<%=catalog%>" name="catalog"/>
                  <jsp:param value="<%=factory%>" name="factory_id"/>
                  <jsp:param value="koubei" name="flag"/>
             </jsp:include>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 品牌 </dt>
           <dd> 
            <a <%if("0".equals(factory)){%> class='select' <%} %> href="/<%=catalog %>-0-0.htm">不限</a> 
            <a <%if("133".equals(factory)){%> class='select' <%} %> href="/<%=catalog %>-133-0.htm">三一</a> 
            <a <%if("182".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-182-0.htm">小松</a> 
            <a <%if("192".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-192-0.htm">斗山</a> 
            <a <%if("184".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-184-0.htm">日立</a> 
            <a <%if("183".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-183-0.htm">神钢</a> 
            <a <%if("175".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-175-0.htm">沃尔沃</a> 
            <a <%if("174".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-174-0.htm">卡特彼勒</a> 
            <a <%if("146".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-146-0.htm">玉柴重工</a> 
            <a <%if("136".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-136-0.htm">柳工</a> 
            <a <%if("194".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-194-0.htm">现代京城</a>
            <a <%if("1220".equals(factory)){%>class='select' <%} %> href="/<%=catalog %>-1220-0.htm">华通动力</a>
              <div class="pbtn" id="changethis"></div>
              <div style="padding-left: 0px; width: 680px;" class="plmore">
               <jsp:include page="/include/koubei/brand_koubei.jsp" flush="true">
                    <jsp:param value="<%=catalog%>" name="catalog"/>
                    <jsp:param value="<%=factory%>" name="factoy_id"/>
                    <jsp:param value="koubei" name="flag"/>
              </jsp:include>
              </div>
            </dd>
          </li>
		 <%if(catalog.indexOf("101001")!=-1&&1==2){%>
		 <li class="cblist" id="grab">
          <dt> 吨位 </dt>
          <dd>
            <a href="/<%=catalog %>-<%=factory%>-0.htm"  <%if(orderby.equals("0")){%>class="select"<%}%>>不限</a> 
			<a href="/<%=catalog %>-<%=factory%>-1.htm" <%if(orderby.equals("1")){%>class="select"<%}%>>小挖(1T～13T)</a>
			<a href="/<%=catalog %>-<%=factory%>-2.htm" <%if(orderby.equals("2")){%>class="select"<%}%>>中挖(14T～30T)</a>
			<a href="/<%=catalog %>-<%=factory%>-3.htm" <%if(orderby.equals("3")){%>class="select"<%}%>>大挖(30T以上)</a> </dd>
        </li>
      <%}%>
        </ul>
      </div>
    </form>
	
	
	<%if(!factory.equals("0")||!catalog.equals("0")){%>
	    <div class="photoParts">

      <div class="content nph_plist">
        <ul class="modelList">
          <li class="mll">

            <ul class="list1_ph np_fix">
			       <%
		   String mulName="";  String cataName="";  String cataNo="";
		   if(koubeiList !=null && koubeiList.size()>0){
			   for(Map oneMap:koubeiList){
			   cataNo=CommonString.getFormatPara(oneMap.get("catalognum"));
			   if(cataNo.length()>6){cataNo=cataNo.substring(0,6);}
			   cataName=CommonString.getFormatPara(catalogMap.get(cataNo));
			   mulName=CommonString.getFormatPara(oneMap.get("factoryname")).replace("卡特彼勒","卡特")+cataName;
			   if(mulName.length()>10){mulName=mulName.substring(0,10)+"...";}
			   %>
              <li>
                <p class="npg_img"><a href="/list/<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>口碑" target="_blank"><img width="135" height="100" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>口碑" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"></a></p>
                <p class="nph_name" style="text-align:center"><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>口碑" href="/list/<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>口碑</a></p>
                <p class="nph_cat" style="text-align:center"><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%>" href="/0-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>-0.htm">[<%=CommonString.getFormatPara(oneMap.get("factoryname"))%>]</a><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname")).replace("卡特彼勒","卡特")%><%=cataName%>" href="/<%=CommonString.getFormatPara(oneMap.get("catalognum")).length()>6?CommonString.getFormatPara(oneMap.get("catalognum")).substring(0,6):CommonString.getFormatPara(oneMap.get("catalognum"))%>-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>-0.htm"> [<%=mulName%>]</a></p>
                <p class="nph_lik" style="text-align:center">评论数：<%=CommonString.getFormatPara(oneMap.get("allcount")).equals("")?"0":CommonString.getFormatPara(oneMap.get("allcount"))%>条 | <a href="compare_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm">对比</a></p>
              </li>
<%}}else{

%>


<%}%>
            </ul>
          </li>
     
        </ul>
      </div>
	 <div class="w755 l">
    <div id="pagination" class="page">
   		<tags:page_rewrite_new pageBean="<%=pageBean %>"  />   
    </div>
  </div>
    </div>
	


    <%}else{%>
    <div class="photoParts mb20">
      <div class="hbTitle">
        <h2>热门品牌</h2>
        <span class="more"><a href="/brands/" target="_blank" title="更多热门品牌">更多&gt;&gt;</a></span>
      </div>
      <div class="content">
        <ul class="pbList">
          <li><a style="cursor:pointer" title="三一口碑" href="/0-133-0.htm"><img width="100" height="50" alt="三一" src="../images/sany.jpg">三一</a></li>
          <li><a style="cursor:pointer" title="徐工口碑" href="/0-209-0.htm"><img width="100" height="50" alt="徐工" src="../images/xcmg.jpg">徐工</a></li>
          <li><a style="cursor:pointer" title="中联重科口碑" href="/0-134-0.htm"><img width="100" height="50" alt="中联重科" src="../images/photo_brandimg04.gif">中联重科</a></li>
          <li><a style="cursor:pointer" title="柳工口碑" href="/0-136-0.htm"><img width="100" height="50" alt="柳工" src="../images/photo_brand_lg.gif">柳工</a></li>
          <li><a style="cursor:pointer" title="山推口碑" href="/0-144-0.htm"><img width="100" height="50" alt="山推" src="../images/photo_brand_st.gif">山推</a></li>
          <li><a style="cursor:pointer" title="山东临工口碑" href="/0-137-0.htm"><img width="100" height="50" alt="山东临工" src="../images/photo_brand_lingong.gif">山东临工</a></li>
        </ul>
      </div>
    </div> 
    <div class="photoParts">
      <div class="hbTitle">
        <h2>热门机型</h2>
      </div>
      <div class="content nph_plist">
        <ul class="modelList">
          <li class="mll">
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a href="/101001-0-0.htm" target="_blank" title="更多挖掘机口碑">更多&gt;&gt;</a></span>
            </div>
            <ul class="list1_ph np_fix">
			  <jsp:include page="/include/koubei/list_wjj.htm" flush="true" />	
            </ul>
          </li>
          <li class="mll">
            <div class="mt">
              <h3>装载机</h3>
              <span class="more"><a href="/101002-0-0.htm" target="_blank" title="更多装载机口碑">更多&gt;&gt;</a></span>
            </div>
            <ul class="list1_ph np_fix">
			  <jsp:include page="/include/koubei/list_zzj.htm" flush="true" />	
            </ul>
          </li>
          <li class="mll">
            <div class="mt">
              <h3>起重机</h3>
              <span class="more"><a href="/102-0-0.htm" target="_blank" title="更多起重机口碑">更多&gt;&gt;</a></span>
            </div>
            <ul class="list1_ph np_fix">
      			  <jsp:include page="/include/koubei/list_qzj.htm" flush="true" />	
            </ul>
          </li>
          <li class="mll">
            <div class="mt">
              <h3>推土机</h3>
              <span class="more"><a href="/101003-0-0.htm" target="_blank" title="更多推土机口碑">更多&gt;&gt;</a></span>
            </div>
            <ul class="list1_ph np_fix">
			    <jsp:include page="/include/koubei/list_ttj.htm" flush="true" />	
            </ul>
          </li>
          <li class="mll">
            <div class="mt">
              <h3>平地机</h3>
              <span class="more"><a href="/101005-0-0.htm" target="_blank" title="更多平地机口碑">更多&gt;&gt;</a></span>
            </div>
            <ul class="list1_ph np_fix">
              <jsp:include page="/include/koubei/list_pdj.htm" flush="true" />	
            </ul>
          </li>
          <li class="mll">
            <div class="mt">
              <h3>压路机</h3>
              <span class="more"><a href="/106-0-0.htm" target="_blank" title="更多压路机口碑">更多&gt;&gt;</a></span>
            </div>
            <ul class="list1_ph np_fix">
                 <jsp:include page="/include/koubei/list_ylj.htm" flush="true" />	
            </ul>
          </li>
        </ul>
      </div>
    </div>

	<%}%>
  </div>
  <!--right end-->
</div>

<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot-->
</body>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
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
</html>
