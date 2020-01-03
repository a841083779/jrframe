<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%  DBHelper dbHelper = DBHelper.getInstance() ;
	String keywordCheck = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String pageKeyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    if(keywordCheck.equals("0")){keywordCheck="";}
	if(keywordCheck.equals("旋挖钻")){keywordCheck="旋挖钻机";}
	if(catalog.equals("")){catalog="0";}
	if(factory.equals("")){factory="0";}
	if(pageKeyword.equals("")){pageKeyword="0";}
	int totalParts = 0;
	String tempCatalog="";
	String tempFactory="";
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("id"));
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("*:*");
	}else{
	   query.setQuery("title:" + keywordCheck+tempFactory+tempCatalog);
	}
    /*查询*/				
	int pageSize = 15;
	query.setRequestHandler("/jereh");
	//query.setSorts(orderList);
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);

	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	QueryResponse res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	int pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	SolrDocumentList products = res.getResults();
	String TDK_title="";String TDK_keywords="";String TDK_desc="";
	if(totalParts>0){
	TDK_title=(keywordCheck.equals("")?"":keywordCheck+" - ")+"产品搜索 - 铁臂商城";
	TDK_keywords=(keywordCheck.equals("")?"":keywordCheck+",")+"铁臂商城";
	TDK_desc="在铁臂商城中找到了"+totalParts+"条"+keywordCheck+"相关信息，其中包含了"+keywordCheck+"价格表，"+keywordCheck+"图片，"+keywordCheck+"型号大全等信息，买"+keywordCheck+"就上铁臂商城。";
	}else{
	TDK_title=keywordCheck+" - 产品搜索 - 铁臂商城";
	TDK_keywords=keywordCheck+",铁臂商城";
	TDK_desc="在铁臂商城中找到了0件"+keywordCheck+"相关信息，请重新选择，买工程机械就上铁臂商城。";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=TDK_title%></title>
<meta name="keywords" content="<%=TDK_keywords%>" />
<meta name="description" content="<%=TDK_desc%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/history/json.js"></script>
<script type="text/javascript" src="/scripts/history/history_search.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top_search.jsp" flush="true">
     <jsp:param value="<%=keywordCheck%>" name="keyword"/>
</jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">搜索结果
  <%if(!keywordCheck.equals("")){%>
  &gt;&gt; <%=keywordCheck%>
  <%}%>
  </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<!--有搜索结果--> 
<%if(totalParts>0){%>
<div class="np_fix contain980"> 
  <!--left-->
  <div class="w210 l">
     <jsp:include page="/include/search/left_catalog.jsp" flush="true">
        <jsp:param value="<%=catalog%>" name="catalog"/>
        <jsp:param value="<%=factory%>" name="factory"/>
		<jsp:param value="<%=pageKeyword%>" name="keyword"/>
    </jsp:include>
	<!--class="cur"-->
    <div class="nseleft_listo mb10">
      <ul class="nse_secat_list">
	     <li><a target="_blank" style="line-height:30px;background:#f7f7f7;">
		 <span style="margin-left:-20px;">更多<span style="color:red"><%=keywordCheck%></span>相关搜索结果</span>
		 </a></li>
	  
        <li><a target="_blank"  href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(keywordCheck,"utf-8")%>&f=news">动态</a></li>
        <li><a  target="_blank" href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(keywordCheck,"utf-8")%>&f=market">供求</a>
          <ul>
            <li><a target="_blank" href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(keywordCheck,"utf-8")%>&f=market">&middot; 供应</a></li>
            <li><a target="_blank" href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(keywordCheck,"utf-8")%>&f=market_buy">&middot; 求购</a></li>
          </ul>
        </li>
        <li><a target="_blank" href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(keywordCheck,"utf-8")%>&f=used">二手</a></li>
        <li><a target="_blank" href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(keywordCheck,"utf-8")%>&f=rent">租赁</a></li>
      </ul>
    </div>
    <div class="Similar nse_left_viewpro">
      <div class="stitle">
        <h3>最近浏览过的产品</h3>
      </div>
      <div class="scontent"> 
        <ul class="slist" id="history">
        </ul>	
      </div>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
   <div class="w757 r">
    <%if(keywordCheck.indexOf("叉车")!=-1){%>
      <div class='nse_xg_search'>相关搜索：<span><a href='/search/林德叉车_0_0_0.htm'>林德叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/二手叉车_0_0_0.htm'>二手叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/杭州叉车_0_0_0.htm'>杭州叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/伸缩臂叉车_0_0_0.htm'>伸缩臂叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/广州叉车_0_0_0.htm'>广州叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/上海叉车出租_0_0_0.htm'>上海叉车出租</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/叉车_0_0_0.htm'>叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href='/search/龙工叉车_0_0_0.htm'>龙工叉车</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;</div> 
  	 <%}else if(!keywordCheck.equals("")){%>
	 <%
    	//UIRelated uiRelated = new UIRelated();
    	//out.print(uiRelated.related(request));
     %>
	  <%}%>
    <form name="theform" id="theform">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l">
		   <%if ((!"0".equals(catalog)&&catalog.length()>3)|| !"0".equals(factory)) {%>
              <span class="reset" ><a href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_0_0_0.htm">重置</a></span>
           <%}%>
		   <%if (!"0".equals(catalog) &&catalog.length()>3) {%>
              <span><em>
		      <%="0".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_<%=factory.equals("")?"0":factory%>_0_0.htm" title="取消" class="delete" ></a> </span>
           <%}%>
           <%if (!"0".equals(factory) && !"".equals(factory)) {%>
              <span><em><%="".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory))%></em> <a href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_0_<%=catalog.equals("")?"0":catalog%>_0.htm" title="取消" class="delete" ></a> </span>
           <%}%>
		  </div>
          <h1 class="r" style="font-size:14px;"><%="".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory))%><%=("0".equals(catalog)||catalog.length()<=3) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></h1>
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
			 <%if(keywordCheck.indexOf("叉车")!=-1){%>
			<a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_0_<%=catalog%>_0.htm" <%if(factory.equals("0")||factory.equals("")){%> class="select" <%}%>>不限</a> 
			<a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_1742_<%=catalog%>_0.htm" <%if(factory.equals("1742")){%> class="select" <%}%>>林德</a> 
            <a href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_137_<%=catalog%>_0.htm" <%if(factory.equals("137")){%> class="select" <%}%>>临工</a>   
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_136_<%=catalog%>_0.htm" <%if(factory.equals("136")){%> class="select" <%}%>>柳工</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_138_<%=catalog%>_0.htm" <%if(factory.equals("138")){%> class="select" <%}%>>山工</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_135_<%=catalog%>_0.htm" <%if(factory.equals("135")){%> class="select" <%}%>>龙工</a>
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_209_<%=catalog%>_0.htm" <%if(factory.equals("209")){%> class="select" <%}%>>徐工</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_144_<%=catalog%>_0.htm" <%if(factory.equals("144")){%> class="select" <%}%>>山推</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_133_<%=catalog%>_0.htm" <%if(factory.equals("133")){%> class="select" <%}%>>三一</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_192_<%=catalog%>_0.htm" <%if(factory.equals("192")){%> class="select" <%}%>>斗山</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_182_<%=catalog%>_0.htm" <%if(factory.equals("182")){%> class="select" <%}%>>小松</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_175_<%=catalog%>_0.htm" <%if(factory.equals("175")){%> class="select" <%}%>>沃尔沃</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_157_<%=catalog%>_0.htm" <%if(factory.equals("157")){%> class="select" <%}%>>力士德</a> 
			<%}else{%>
			<a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_0_<%=catalog%>_0.htm" <%if(factory.equals("0")||factory.equals("")){%> class="select" <%}%>>不限</a> 
			<a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_174_<%=catalog%>_0.htm" <%if(factory.equals("174")){%> class="select" <%}%>>卡特彼勒</a> 
            <a href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_137_<%=catalog%>_0.htm" <%if(factory.equals("137")){%> class="select" <%}%>>临工</a>   
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_136_<%=catalog%>_0.htm" <%if(factory.equals("136")){%> class="select" <%}%>>柳工</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_138_<%=catalog%>_0.htm" <%if(factory.equals("138")){%> class="select" <%}%>>山工</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_135_<%=catalog%>_0.htm" <%if(factory.equals("135")){%> class="select" <%}%>>龙工</a>
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_209_<%=catalog%>_0.htm" <%if(factory.equals("209")){%> class="select" <%}%>>徐工</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_144_<%=catalog%>_0.htm" <%if(factory.equals("144")){%> class="select" <%}%>>山推</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_133_<%=catalog%>_0.htm" <%if(factory.equals("133")){%> class="select" <%}%>>三一</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_192_<%=catalog%>_0.htm" <%if(factory.equals("192")){%> class="select" <%}%>>斗山</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_182_<%=catalog%>_0.htm" <%if(factory.equals("182")){%> class="select" <%}%>>小松</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_175_<%=catalog%>_0.htm" <%if(factory.equals("175")){%> class="select" <%}%>>沃尔沃</a> 
            <a  href="/search/<%=keywordCheck.equals("")?"0":keywordCheck%>_157_<%=catalog%>_0.htm" <%if(factory.equals("157")){%> class="select" <%}%>>力士德</a> 
			<%}%>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
              <jsp:include page="/include/search/brand.jsp" flush="true">
                <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=factory%>" name="factory"/>
				<jsp:param value="<%=pageKeyword%>" name="keyword"/>
             </jsp:include>
              </div>
            </dd>
          </li>
        </ul>
      </div>
      <input type="hidden" name="order" id="order">
      <input type="hidden" name="keyword" id="key_word">
    </form>
    <div class="nseresult_pro">
      <!--询价猫-->
      <div class="pro_searlist_xjcat">
          <div class="cat_miao_img"><a href="#"><img src="../images/cat_miao_2.png"/></a></div>
          <div class="cat_miao_close"><img src="../images/cat_close.png"></div>
      </div>
      <!--询价猫结束-->
      <div class="nse_usedate">找到约<%=totalParts %>条结果</div>
      <ul class="nser_searchList">
	   <%if(totalParts>0&&keywordCheck.equals("挖掘机")){%>
	  	<li class="pro">
          <div class="proimg"> <a target="_blank" href="http://product.21-sun.com/proDetail/320D320DL.shtm" title="卡特彼勒320D 320D L挖掘机"> <img title="卡特彼勒320D 320D L挖掘机" alt="卡特彼勒320D 320D L挖掘机" onerror="this.src='/uploadfiles/no_big.gif'" src="http://product.21-sun.com/uploadfiles/20081205094423_0.jpg" width="131" height="90"> </a> </div>
          <div class="prointro">
            <h3><a title="卡特彼勒320D 320D L挖掘机 " target="_blank" href="http://product.21-sun.com/proDetail/320D320DL.shtm" >卡特彼勒320D&nbsp;320D&nbsp;L履带式<span class="red">挖掘机</span></a> <span class="proLinks">【<a title="卡特彼勒320D 320D L挖掘机参数" target="_blank" href="http://product.21-sun.com/proDetail/320D320DL_parameter.shtm" >参数</a>】【<a title="卡特彼勒320D 320D L挖掘机图片" target="_blank" href="http://product.21-sun.com/proDetail/320D320DL_pic.shtm" >图片</a>】【<a target="_blank" title="卡特彼勒320D 320D L挖掘机询价" href="http://product.21-sun.com/proDetail/320D320DL_order.shtm"><font>询价</font></a>】</span></h3>
            <span class="sc">320D/320DL液压<span class="red">挖掘机</span>更多作业机具选装件、强劲的新型发动机以及更简便的操作提高了生产率并降低了运营成本。...</span></span>
            <div class="site"> <a target="_blank" href="http://product.21-sun.com/proDetail/320D320DL.shtm" style="color: #4D9724;">http://product.21-sun.com/proDetail/320D320DL.shtm</a> </div>
          </div>
        </li>
	  <%}%>
	 <%if(totalParts>0&&keywordCheck.equals("旋挖钻机")&&nowPage<=1){%>
	  	<li class="pro">
          <div class="proimg"> <a target="_blank" href="http://product.21-sun.com/proDetail/KR80A.shtm" title="泰信机械KR80A小旋挖钻机"> <img title="泰信机械KR80A小旋挖钻机" alt="泰信机械KR80A小旋挖钻机" onerror="this.src='/uploadfiles/no_big.gif'" src="http://product.21-sun.com/uploadfiles//image/2014/08/05/20140805135636_393.jpg" width="131" height="90"> </a> </div>
          <div class="prointro">
            <h3><a title="泰信机械KR80A小旋挖钻机" target="_blank" href="http://product.21-sun.com/proDetail/KR80A.shtm" >泰信机械KR80A小<span class="red">旋挖钻机</span></a> <span class="proLinks">【<a title="泰信机械KR80A小旋挖钻机参数" target="_blank" href="http://product.21-sun.com/proDetail/KR80A_parameter.shtm" >参数</a>】【<a title="泰信机械KR80A小旋挖钻机图片" target="_blank" href="http://product.21-sun.com/proDetail/KR80A_pic.shtm" >图片</a>】【<a target="_blank" title="泰信机械KR80A小旋挖钻机询价" href="http://product.21-sun.com/proDetail/KR80A_order.shtm"><font>询价</font></a>】</span></h3>
            <span class="sc">泰信机械KR80A小<span class="red">旋挖钻机</span>性能特点：1.领先的整体运输式全液压旋挖钻机，实现运输状态与施工状态快速转换；2.与天津大学数控与液压技术研究所合作研制的高性...</span></span>
            <div class="site"> <a target="_blank" href="http://product.21-sun.com/proDetail/KR80A.shtm" style="color: #4D9724;">http://product.21-sun.com/proDetail/KR80A.shtm</a> </div>
          </div>
        </li>
	  <%}%>
	  <%if(totalParts>0&&nowPage<=1){%>
	    <jsp:include page="/include/search/ying_xiao_bao.jsp">
        	<jsp:param name="keywords" value="<%=keywordCheck %>" />
        </jsp:include>
	  <%}%>
        <%  
		String title_hl = "";
        int i = 0;
		for(SolrDocument m : products){	
			String img=CommonString.getFormatPara(m.getFieldValue("img"));
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
			String url = CommonString.getFormatPara(m.getFieldValue("url"));
			String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
			String intro = CommonString.getFormatPara(m.getFieldValue("intro"));
			if(res.getHighlighting().get(id) != null){
				Map<String, List<String>> hl = res.getHighlighting().get(id);
				if(hl.get("title") != null){
					title_hl = hl.get("title").get(0);
				}
			}
			if(intro.length()>90){intro=intro.substring(0,90)+"...";}
			String titleAlt = title;
		 	if(title.length()>20){
		 		titleAlt=title;
		 		title=title.substring(0,20)+"...";
			}
		%>
			<%if(totalParts>0&&keywordCheck.equals("推土机")&&nowPage==1&&i==2){%>
		  	<li class="pro">
	          <div class="proimg"> <a target="_blank" href="/proDetail/T165-2.shtm" title="宣工T165-2履带推土机"> <img title="宣工T165-2履带推土机" alt="宣工T165-2履带推土机" onerror="this.src='/uploadfiles/no_big.gif'" src="http://product.21-sun.com/uploadfiles/hbxuangong/20101028115443570.jpg" width="131" height="90"> </a> </div>
	          <div class="prointro">
	            <h3><a title="宣工T165-2履带推土机" target="_blank" href="/proDetail/T165-2.shtm">宣工T165-2履带<span style="color:red;">推土机</span></a> <span class="proLinks">【<a title="宣工T165-2履带推土机参数" target="_blank" href="/proDetail/T165-2_parameter.shtm">参数</a>】【<a title="宣工T165-2履带推土机图片" target="_blank" href="/proDetail/T165-2_pic.shtm">图片</a>】【<a target="_blank" title="宣工T165-2履带推土机询价" href="/proDetail/T165-2_order.shtm"><font>询价</font></a>】</span></h3>
	            <span class="sc">半刚性悬挂、机械传动，单杆先导工作装置操纵。具有生产效率高、通过能力强、操纵简便、结构简单直观、维修方便且成本低的优点。是交通、沙漠、油田、电力、矿山等土石方施</span>
	            <div class="site"> <a target="_blank" href="/proDetail/T165-2.shtm" style="color: #4D9724;">http://product.21-sun.com/proDetail/T165-2.shtm</a> </div>
	          </div>
	        </li>
	  		<%}%>
		
			
		<li class="pro">
          <div class="proimg"> <a target="_blank" href="<%=url%>" title="<%=title%>"> <img title="<%=title%>" alt="<%=title%>" onerror="this.src='/uploadfiles/no_big.gif'" src="<%=img%>" width="131" height="90"> </a> </div>
          <div class="prointro">
            <h3><a title="<%=title%>" target="_blank" href="<%=url%>" ><%=title_hl.equals("") ? title : title_hl %></a> <span class="proLinks">【<a title="<%=title%>参数" target="_blank" href="<%=url.replace(".shtm","")%>_parameter.shtm" >参数</a>】【<a title="<%=title%>图片" target="_blank" href="<%=url.replace(".shtm","")%>_pic.shtm" >图片</a>】【<a target="_blank" title="<%=title%>询价" href="<%=url.replace(".shtm","")%>_order.shtm"><font>询价</font></a>】</span></h3>
            <span class="sc"><%=intro%></span>
            <div class="site"> <a target="_blank" href="<%=url%>" style="color: #4D9724;">http://product.21-sun.com<%=url%></a> </div>
          </div>
        </li>
		
					<%if(totalParts>0&&keywordCheck.equals("装载机")&&nowPage==1&&i==1){%>
	<li class="pro">
          <div class="proimg"> <a target="_blank" href="/proDetail/YX635.shtm" title="英轩重工YX635轮式装载机"> <img title="英轩重工YX635轮式装载机" alt="英轩重工YX635轮式装载机" onerror="this.src='/uploadfiles/no_big.gif'" src="http://product.21-sun.com/uploadfiles//image/2014/01/20140124145201_748.jpg" width="131" height="90"> </a> </div>
          <div class="prointro">
            <h3><a title="英轩重工YX635轮式装载机" target="_blank" href="/proDetail/YX635.shtm"><span style="color:red;">英</span><span style="color:red;">轩</span><span style="color:red;">重工</span>YX635轮式装载机</a> <span class="proLinks">【<a title="英轩重工YX635轮式装载机参数" target="_blank" href="/proDetail/YX635_parameter.shtm">参数</a>】【<a title="英轩重工YX635轮式装载机图片" target="_blank" href="/proDetail/YX635_pic.shtm">图片</a>】【<a target="_blank" title="英轩重工YX635轮式装载机询价" href="/proDetail/YX635_order.shtm"><font>询价</font></a>】</span></h3>
            <span class="sc">●全景车窗，外观时尚；高强度整体式框架结构，安全性高；密封减震性好；豪华座椅，可选装空调，给用户提供舒适的操作环境；●采用高性能发动机，动力强劲，低油耗，低噪音</span>
            <div class="site"> <a target="_blank" href="/proDetail/YX635.shtm" style="color: #4D9724;">http://product.21-sun.com/proDetail/YX635.shtm</a> </div>
          </div>
        </li>
	  		<%}%>
         <%i++;}%>
      </ul>
    </div>
      <div class="nse_page">
         <tags:page_search nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" factory="<%=factory%>" catalog="<%=catalog%>" keyword="<%=pageKeyword%>" />
      <div class="l nse_allresult">共约<%=totalParts %>条结果</div>
    </div>
  </div>
  <!--right end--> 
</div>
<%}else{%>
<!--无搜索结果--> 
<div id="history" style="display:none"></div>
<div class="contain980">
  <div class="nser_nots mb10">非常抱歉，没有找到与“<span><%=keywordCheck%></span>”相关的商品</div>
  <div class="np_fix n_seach_no">
    <div class=" border03 l Condition mb10">
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
        <li class="cblist" id="grab" style="display:;">
          <dt> 热门<br>
            品牌 </dt>
          <dd> 
		  <a href="/search/三一重工_0_0_0.htm">三一重工</a>
		  <a href="/search/徐工_0_0_0.htm">徐工</a>
		  <a href="/search/中联重科_0_0_0.htm">中联重科</a>
		  <a href="/search/柳工_0_0_0.htm">柳工</a>
		  <a href="/search/山推_0_0_0.htm">山推</a>
		  <a href="/search/临工_0_0_0.htm">临工</a>
		  <a href="/search/福田雷沃_0_0_0.htm">福田雷沃</a>
		  <a href="/search/龙工_0_0_0.htm">龙工</a>
		  <a href="/search/小松_0_0_0.htm">小松</a>
		  <a href="/search/卡特_0_0_0.htm">卡特</a>
		  <a href="/search/沃尔沃_0_0_0.htm">沃尔沃</a>
		  <a href="/search/利勃海尔_0_0_0.htm">利勃海尔</a>
		  <a href="/search/神钢_0_0_0.htm">神钢</a>
		  <a href="/search/日立_0_0_0.htm">日立</a>
		  <a href="/search/酒井_0_0_0.htm">酒井</a>
		  <a href="/search/杰西博_0_0_0.htm">杰西博</a>
		  </dd>
        </li>
      </ul>
    </div>
  </div>
  <div class="np_fix n_seach_no">
    <div class=" border03 l Condition mb10">
      <ul class="ConditionBottom">
        <li class="cblist" id="grab" style="display:;">
          <dt> 热门<br>
            产品 </dt>
          <dd>
		 <a href="/search/挖掘机_0_0_0.htm">挖掘机</a>
		 <a href="/search/装载机_0_0_0.htm">装载机</a>
		 <a href="/search/推土机_0_0_0.htm">推土机</a>
		 <a href="/search/平地机_0_0_0.htm">平地机</a>
		 <a href="/search/自卸卡车_0_0_0.htm">自卸卡车</a>
		 <a href="/search/铲运机_0_0_0.htm">铲运机</a>
		 
		 <a href="/search/塔式起重机_0_0_0.htm">塔式起重机</a>
		 <a href="/search/汽车起重机_0_0_0.htm">汽车起重机</a>
		 <a href="/search/履带式起重机_0_0_0.htm">履带式起重机</a>
		 <a href="/search/高空作业平台_0_0_0.htm">高空作业平台</a>
		 <a href="/search/高空作业车_0_0_0.htm">高空作业车</a>
		 <a href="/search/随车起重机_0_0_0.htm">随车起重机</a>
		 <a href="/search/施工升降机_0_0_0.htm">施工升降机</a>
		 <a href="/search/伸缩臂叉装机_0_0_0.htm">伸缩臂叉装机</a>
	
		 <a href="/search/泵车_0_0_0.htm">泵车</a>
		 <a href="/search/车载泵_0_0_0.htm">车载泵</a>
		 <a href="/search/拖泵_0_0_0.htm">拖泵</a>
		 <a href="/search/输送泵_0_0_0.htm">输送泵</a>
		 <a href="/search/混凝土搅拌设备_0_0_0.htm">混凝土搅拌设备</a>
		 <a href="/search/混凝土布料设备_0_0_0.htm">混凝土布料设备</a>
		 <a href="/search/混凝土搅拌运输车_0_0_0.htm">混凝土搅拌运输车</a>
		 <a href="/search/干粉砂浆生产设备_0_0_0.htm">干粉砂浆生产设备</a>	
		 <a href="/search/粉粒物料运输车_0_0_0.htm">粉粒物料运输车</a>
		 <a href="/search/其它混凝土设备_0_0_0.htm">其它混凝土设备</a>
		 <a href="/search/干混砂浆生产线_0_0_0.htm">干混砂浆生产线</a>
		 <a href="/search/沥青砂浆车_0_0_0.htm">沥青砂浆车</a>
		 <a href="/search/干混砂浆背罐车_0_0_0.htm">干混砂浆背罐车</a>
		 <a href="/search/喷湿机_0_0_0.htm">喷湿机</a> 
		 
		 <a href="/search/摊铺机_0_0_0.htm">摊铺机</a>
		 <a href="/search/养护机械_0_0_0.htm">养护机械</a>
		 <a href="/search/其它路面机械_0_0_0.htm">其它路面机械</a>
		 <a href="/search/沥青混合料搅拌设备_0_0_0.htm">沥青混合料搅拌设备</a>
		 <a href="/search/铣刨机_0_0_0.htm">铣刨机</a>
		 <a href="/search/稳定土厂拌设备_0_0_0.htm">稳定土厂拌设备</a>
		 <a href="/search/沥青搅拌站_0_0_0.htm">沥青搅拌站</a>
		 <a href="/search/稳定土拌合机_0_0_0.htm">稳定土拌合机</a>
		 
		 <a href="/search/旋挖钻机_0_0_0.htm">旋挖钻机</a>
		 <a href="/search/液压静力压桩机_0_0_0.htm">液压静力压桩机</a>
		 <a href="/search/打桩机_0_0_0.htm">打桩机</a>
		 <a href="/search/水平定向钻_0_0_0.htm">水平定向钻</a>
		 <a href="/search/连续墙抓斗_0_0_0.htm">连续墙抓斗</a>
		 <a href="/search/长螺旋钻孔机_0_0_0.htm">长螺旋钻孔机</a>
		 <a href="/search/打桩锤_0_0_0.htm">打桩锤</a>
		 <a href="/search/潜孔钻机_0_0_0.htm">潜孔钻机</a>
		 <a href="/search/多功能钻机_0_0_0.htm">多功能钻机</a>
		 <a href="/search/强夯机_0_0_0.htm">强夯机</a>
		 <a href="/search/液压步履式桩架_0_0_0.htm">液压步履式桩架</a>
		 <a href="/search/多轴钻孔机_0_0_0.htm">多轴钻孔机</a>
		 <a href="/search/连续墙钻机_0_0_0.htm">连续墙钻机</a>
		 <a href="/search/截桩机_0_0_0.htm">截桩机</a>
		 <a href="/search/其它桩工机械_0_0_0.htm">其它桩工机械</a>		 
		 
		 <a href="/search/压路机_0_0_0.htm">压路机</a>
		 <a href="/search/压实机_0_0_0.htm">压实机</a>
		 <a href="/search/夯实机_0_0_0.htm">夯实机</a>

		 <a href="/search/内燃叉车_0_0_0.htm">内燃叉车</a>
		 <a href="/search/电动叉车_0_0_0.htm">电动叉车</a>
         <a href="/search/仓储叉车_0_0_0.htm">仓储叉车</a>	

		 <a href="/search/破碎锤_0_0_0.htm">破碎锤</a>
         <a href="/search/液压剪_0_0_0.htm">液压剪</a>	
		 
		 <a href="/search/凿岩机和钻机_0_0_0.htm">凿岩机和钻机</a>
         <a href="/search/输送和辅助设备_0_0_0.htm">输送和辅助设备</a>	
		 <a href="/search/破碎机_0_0_0.htm">破碎机</a>
         <a href="/search/装载及搬运设备_0_0_0.htm">装载及搬运设备</a>	
		 <a href="/search/连续采煤机和隧道掘进机_0_0_0.htm">连续采煤机和隧道掘进机</a>
         <a href="/search/矿用掘进机_0_0_0.htm">矿用掘进机</a>
		 <a href="/search/采煤机_0_0_0.htm">采煤机</a>
         <a href="/search/凿岩台车_0_0_0.htm">凿岩台车</a>
		 <a href="/search/筛分机_0_0_0.htm">筛分机</a>
         <a href="/search/全液压凿岩钻机_0_0_0.htm">全液压凿岩钻机</a>
		 <a href="/search/盾构掘进机_0_0_0.htm">盾构掘进机</a>
         <a href="/search/凿岩钻车_0_0_0.htm">凿岩钻车</a>	

	     <a href="/search/检测车_0_0_0.htm">检测车</a>
         <a href="/search/运梁车_0_0_0.htm">运梁车</a>	
		 <a href="/search/架桥机_0_0_0.htm">架桥机</a>
         <a href="/search/提梁机_0_0_0.htm">提梁机</a>	
		 <a href="/search/砂浆车_0_0_0.htm">砂浆车</a>
         <a href="/search/堆高机_0_0_0.htm">堆高机</a>
		 <a href="/search/正面吊_0_0_0.htm">正面吊</a>
         <a href="/search/场桥_0_0_0.htm">场桥</a>
		 <a href="/search/推耙机_0_0_0.htm">推耙机</a>
         <a href="/search/吊具_0_0_0.htm">吊具</a>
		 <a href="/search/专用车辆_0_0_0.htm">专用车辆</a>
         <a href="/search/消防车_0_0_0.htm">消防车</a>
		 <a href="/search/牵引车_0_0_0.htm">牵引车</a>

		 
		  </dd>
        </li>
      </ul>
    </div>
  </div>
  <div class="border03 n_se_nopro">
    <div class="n_se_nopro_t1">热门产品推荐</div>
    <div class="n_sepro_list">
      <ul class="tabList01 np_fix">
		<jsp:include page="/include/search/hot_pro_list.jsp" flush="false"/>
      </ul>
    </div>
  </div>
  <div class="telTip mt10">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
</div>
<%}%>
<!--main end--> 
<%if(totalParts>0){%>
<!--foot search 有搜索结果时出现-->
<div class="contain980">
    
	<div class="nse_foot_search"><span>重新搜索</span><input onkeypress="tj();" value="<%=keywordCheck%>"  name="keyword" id="keywords" type="text" class="nse_foot_seinp"/>
	<input type="submit" class="nse_foot_sebtn" value="搜索" onclick="tj();" /></div>
    <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>

				<script>
		  function tj(){
		  	  if(jQuery('#keywords').val()==''){
		     jQuery('#keywords').focus();
			 return false;
		  }
		  var keyword=jQuery('#keywords').val();
		  window.location.href="/search/"+keyword+"_0_0_0.htm";
		  }
		</script>
</div>
<!--foot search end-->
<!--like-->
<div class="contain980 mt10 pb10">
	<div class="nse_youlike">
    	<p class="nse_guesslike">根据浏览猜你喜欢</p>		
		<jsp:include page="/include/search/other_pro_list.jsp" flush="false"/>
    </div>
</div>
<!--like end-->
<%}%>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<script>
    // 显示浏览记录 
	setTimeout(function(){ 
		 	   if(jQuery.trim(jQuery("#history").html())==''){
		 	   jQuery("#tophistory").hide() ;   
		 	   }
		 },10) ;
	jQuery(function(){                                          
		 	 DisplayHistory() ;
	}) ;
	function clearHistory(){
		jQuery("#tophistory").fadeOut("slow") ;
    	DeleteCookie("history") ;
	}
</script>
<script type="text/javascript">
$('.pro_searlist_xjcat .cat_miao_close').click(function(){
	$('.pro_searlist_xjcat').hide();
});
</script>
</body>
</html>