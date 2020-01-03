<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonApplication"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */5 * *">
<%	
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	if(catalog.equals("110005")){catalog="119002";}
	//if(catalog.equals("103015")){catalog="119002";}
	if(catalog.equals("103006")){catalog="103019";}
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
	//调取新类别
	Map catalog_numNew=null;
	String catalognum_new=catalog;
	//国内品牌
	Map brandInnerMap = (Map) application.getAttribute("brandInnerMap");
	String innerBrand =CommonString.getFormatPara(brandInnerMap.get(catalognum_new));
	if(innerBrand.equals("")){innerBrand =CommonString.getFormatPara(brandInnerMap.get("101001"));}
	String innerName[]=innerBrand.split(",");	
	//国外品牌
	Map brandOutMap = (Map) application.getAttribute("brandOutMap");
	String outBrand = CommonString.getFormatPara(brandOutMap.get(catalognum_new));
	if(outBrand.equals("")){outBrand =CommonString.getFormatPara(brandOutMap.get("101001"));}
	String outnerName[]=outBrand.split(",");	
	Map seoTitleKeywordMapNew = (HashMap)application.getAttribute("seoTitleKeywordMapNew") ;
	String tonandmeter="";
	String order="";
	String factoryid="";
	try{
			int totalParts = 0;
	     	//搜索新	
	        String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product";
	        HttpSolrServer servers = new HttpSolrServer(httpUrl);
	        /*接收参数*/
	        SolrQuery query = new SolrQuery();
	        List<SolrQuery.SortClause> koubeiList = new ArrayList<SolrQuery.SortClause>();
	        //排序
			String orderbyStr = "";
	        koubeiList.add(SolrQuery.SortClause.desc("commentCount"));
			 //分页
	        Integer nowPage = 1 ;
	        int pageSize = 16;
            if(!"".equals(offset) && !"0".equals(offset)){
	            nowPage = Integer.parseInt(offset)/pageSize+1 ;
            }
	        List<String> whereList = new ArrayList<String>();
			 query.setQuery("*:*");
		    //分页查询
		    List<String> filterQuery = new ArrayList<String>(0); 	   
	        String showName="";
            if(!catalog.equals("0")){filterQuery.add("catalognum:"+catalog+"*"); showName=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog));}
	        if(!factory.equals("0")){filterQuery.add("factoryid:"+factory);	}
	        if(orderby.equals("3")){filterQuery.add("tonandmeter:{30 TO * }");  showName="大挖";}
	        if(orderby.equals("2")){filterQuery.add("tonandmeter:{14 TO 30 }"); showName="中挖";}
	        if(orderby.equals("1")){filterQuery.add("tonandmeter:{1 TO 13 }"); showName="小挖";} 
            /*查询*/				
	        String [] filterArr = new String [filterQuery.size()];
	        filterArr = filterQuery.toArray(filterArr);
	        query.addFilterQuery(filterArr);
			query.setRequestHandler("/jereh");
	        query.setSorts(koubeiList);
	        query.setRows(pageSize);
	        query.setStart((nowPage - 1) * pageSize);
	        query.setParam("hl.fl", "name");
	        QueryResponse res = servers.query(query);
	        totalParts = (int)res.getResults().getNumFound();
	        int pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	        SolrDocumentList searchkoubei = res.getResults();		

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%if(catalog.equals("0")&&factory.equals("0")){%>
<title>【工程机械产品口碑】口碑大全_优点_缺点 – 铁臂口碑</title>
<meta name="keywords" content="工程机械产品口碑,工程机械产品口碑大全" />
<meta name="description" content="铁臂口碑包含了大量真实用户的工程机械产品口碑，帮助您通过网络了解工程机械产品，买工程机械产品就上铁臂商城。" />
<%}%>
<%if(!catalog.equals("0")&&!factory.equals("0")){%>
<title>【<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>怎么样?】<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>口碑_<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %><% if(goodbad.equals("good")){ %>优点<%}else if(goodbad.equals("bad")){ %>缺点<%}else{ %>优点缺点投诉<%} %>- 铁臂口碑</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>哪个品牌好,<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>哪个好,<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>口碑,<%=showName %>" />
<meta name="description" content="铁臂口碑包含了大量<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>产品口碑，帮助您通过网络了解<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>产品怎么样，哪个好,买<%=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName %>产品就上铁臂商城。" />
<%}else if(!factory.equals("0")){%>
<title>【<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>怎么样?】<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑_<%=CommonString.getFormatPara(brandMap.get(factory))+showName %><% if(goodbad.equals("good")){ %>优点<%}else if(goodbad.equals("bad")){ %>缺点<%}else{ %>优点缺点投诉<%}%>- 铁臂口碑</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>怎么样,<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>哪个好,<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑,<%=showName %>" />
<meta name="description" content="铁臂口碑包含了大量<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品口碑，帮助您通过网络了解<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品怎么样，哪个好,买<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>产品就上铁臂商城。" />
<%}else if(!catalog.equals("0")){%>
<title>【<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>哪个品牌好?】<%=CommonString.getFormatPara(brandMap.get(factory))+showName %>口碑_<%=CommonString.getFormatPara(brandMap.get(factory))+showName %><% if(goodbad.equals("good")){ %>优点<%}else if(goodbad.equals("bad")){ %>缺点<%}else{ %>优点缺点投诉<%} %>- 铁臂口碑</title>
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
<link href="/new_resources/css/style.css" rel="stylesheet" />
<link href="/new_resources/css/style_common.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<%if(factory.equals("0")&&!catalog.equals("0")){%>
<script type="text/javascript" src="http://product.21-sun.com/Static/app/mobile.js"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/web_kb_list.jsp?catalog=<%=catalog%>");</script>
<%}else if(!factory.equals("0")){%>
<script type="text/javascript" src="http://product.21-sun.com/Static/app/mobile.js"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/web_kbcat_list.jsp?factory=<%=factory%><%=catalog.equals("")?"":"&catalog="+catalog%>");</script>
<%}%>
<script type="text/javascript">
//导航选中状态
var jrChannel='1#0'
</script>
<style type="text/css">
.disp .sel02_1 {
	height:46px;
	overflow:hidden;
}
.sel_more, .disp .sel_more {
	height:auto;
	overflow-y:auto;
	overflow-x:hidden;
	width:670px;
	background-color:#f0f4fa;
}
.disb .sel02_3 {
	height:46px;
	overflow:hidden;
}
.sel_more, .disb .sel_more {
	height:auto;
	overflow-y:auto;
	overflow-x:hidden;
	width:670px;
	background-color:#f0f4fa;
}
.photoParts {
	border: 0px solid #DEE3E7;
}
.nph_plist .list1_ph li {
	margin: 20px 10px 0px 14px;
}
.Similar {
	border: 0px solid #DEE3E7;
}
</style>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--top end-->
<div class="contain1190 mb10" style="  margin-top: 10px;">
  <h3 class="breadCrumbs">我的位置：<a href="http://product.21-sun.com/">铁臂商城</a> >><a href="/" title="铁臂口碑">铁臂口碑</a>&nbsp;&gt;&gt;&nbsp;<a href="/list/">机器大全</a>
    <% if(!catalog.equals("0")&&!factory.equals("0")){ %>
    <% if(catalog.length()>=6&&1==2){ %>
    &gt;&gt;&nbsp;<a href="/<%=catalog.substring(0, 3) %>-0-<%=orderby%>.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a>
    <%} %>
    &gt;&gt;&nbsp;<a href="/<%=catalog %>-0-<%=orderby%>.htm"><%=showName %></a> &gt;&gt;&nbsp;<a href="/0-<%=factory %>-0.htm"><%=CommonString.getFormatPara(brandMap.get(factory)) %></a> &gt;&gt;&nbsp;<a href="/<%=catalog %>-<%=factory %>-<%=orderby%>.htm"><%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特") %><%=showName %></a> &gt;&gt;&nbsp;<%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)) %><%=showName %>怎么样
    <% }else if(!catalog.equals("0")&&factory.equals("0")){ %>
    <div style="display:none">&gt;&gt;&nbsp;<a href="/<%=catalog.substring(0, 3) %>-0-<%=orderby%>.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a></div>
    <% if(catalog.length() == 6){ %>
    &gt;&gt;&nbsp;<a href="/<%=catalog %>-<%=factory %>-<%=orderby%>.htm"><%="0".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)) %><%=showName %></a> &gt;&gt;&nbsp;<%=showName %>哪个品牌好
    <% }else{ %>
    &gt;&gt;&nbsp;<%=showName %>哪个品牌好
    <% } %>
    <% }else if(catalog.equals("0")&&!factory.equals("0")){ %>
    &gt;&gt;&nbsp;<a href="/0-<%=factory %>-0.htm"><%=CommonString.getFormatPara(brandMap.get(factory)) %>口碑</a> &gt;&gt;&nbsp;<%=CommonString.getFormatPara(brandMap.get(factory)) %>怎么样
    <% } %>
  </h3>
</div>
<div class="contain1190 fix">
  <!--left-->
  <div class="w210 l np_left">
    <div id="listByCatalog" class="Similar mb10">
      <div class="txd_plant fix" style="height:30px">
        <div class="tpl_title">热评产品推荐</div>
      </div>
      <div class="scontent">
        <ul class="slist">
          <jsp:include page="/include/koubei/hot_comment_pro.jsp" flush="true" />
        </ul>
      </div>
    </div>
    <div class="w208 border02 l leftPart02 mb10">
      <div class="txd_plant fix" style="height:30px">
        <div class="tpl_title">猜你喜欢</div>
      </div>
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
  <div class="txd_nright">
    <div class="txd_plant fix" style="margin-top: -10px;">
      <div class="tpl_title"><strong>
        <%if(!catalog.equals("0")&&!factory.equals("0")){%>
        <%=(catalog.equals("0")&&factory.equals("0"))?"工程机械":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+showName%>口碑
        <%}else{%>
        <%=(catalog.equals("0")&&factory.equals("0"))?"工程机械":CommonString.getFormatPara(brandMap.get(factory))+showName%>口碑
        <%}%>
        </strong></div>
      <form name="theform" id="theform">
        <div class="ConditionTop  fix" style="width:88%;">
          <div class="l"> </div>
        </div>
        <input type="hidden" name="factory" id="factory_id">
        <input type="hidden" name="catalog" id="catalognum">
        <input type="hidden" name="order" id="order">
        <input type="hidden" name="tonandmeter" id="tonandmeter">
        <input type="hidden" name="keyword" id="key_word">
      </form>
    </div>
    <div class="txd_shaixuan">
      <dl class="fix">
        <dt>类别</dt>
        <dd class="">
          <div class="tsx_ddheight"> <a href="/0-<%=factory%>-0.htm" <%if(catalog.equals("0")){%>class="select"<%}%>>不限</a> <a href="/101001-<%=factory%>-0.htm" <%if(catalog.equals("101001")){%>class="select"<%}%>>挖掘机</a> <a href="/101002-<%=factory%>-0.htm" <%if(catalog.equals("101002")){%>class="select"<%}%>>装载机</a> <a  href="/102-<%=factory%>-0.htm" <%if(catalog.equals("102")){%>class="select"<%}%>>起重机</a> <a href="/101003-<%=factory%>-0.htm" <%if(catalog.equals("101003")){%>class="select"<%}%>>推土机</a> <a  href="/103-<%=factory%>-0.htm" <%if(catalog.equals("103")){%>class="select"<%}%>>混凝土</a> <a href="/106001-<%=factory%>-0.htm" <%if(catalog.equals("106001")){%>class="select"<%}%>>压路机</a> <a href="/101005-<%=factory%>-0.htm" <%if(catalog.equals("101005")){%>class="select"<%}%>>平地机</a> <a href="/105003-<%=factory%>-0.htm" <%if(catalog.equals("105003")){%>class="select"<%}%>>旋挖钻</a> <a  href="/113001-<%=factory%>-0.htm" <%if(catalog.equals("113001")){%>class="select"<%}%>>破碎锤</a> <a href="/104001-<%=factory%>-0.htm" <%if(catalog.equals("104001")){%>class="select"<%}%>>摊铺机</a> <a href="/101003-<%=factory%>-0.htm" target="_top"> 推土机 </a> <a href="/101002-<%=factory%>-0.htm" target="_top"> 装载机 </a> <a href="/101001-<%=factory%>-0.htm" target="_top"> 挖掘机 </a> <a href="/101005-<%=factory%>-0.htm" target="_top"> 平地机 </a> <a href="/101004-<%=factory%>-0.htm" target="_top"> 铲运机 </a> <a href="/101008-<%=factory%>-0.htm" target="_top"> 自卸卡车 </a> <a href="/102013-<%=factory%>-0.htm" target="_top"> 桥梁式起重机 </a> <a href="/102012-<%=factory%>-0.htm" target="_top"> 伸缩臂叉装机 </a> <a href="/102002-<%=factory%>-0.htm" target="_top"> 塔式起重机 </a> <a href="/102011-<%=factory%>-0.htm" target="_top"> 施工升降机 </a> <a href="/102010-<%=factory%>-0.htm" target="_top"> 高空作业车 </a> <a href="/102007-<%=factory%>-0.htm" target="_top"> 汽车起重机 </a> <a href="/102008-<%=factory%>-0.htm" target="_top"> 履带式起重机 </a> <a href="/102006-<%=factory%>-0.htm" target="_top"> 随车起重机 </a> <a href="/102003-<%=factory%>-0.htm" target="_top"> 高空作业平台 </a> <a href="/103008-<%=factory%>-0.htm" target="_top"> 干粉砂浆生产设备 </a> <a href="/103009-<%=factory%>-0.htm" target="_top"> 粉粒物料运输车 </a> <a href="/103005-<%=factory%>-0.htm" target="_top"> 混凝土布料设备 </a> <a href="/103006-<%=factory%>-0.htm" target="_top"> 混凝土搅拌运输车 </a> <a href="/103015-<%=factory%>-0.htm" target="_top"> 其它混凝土设备 </a> <a href="/103012-<%=factory%>-0.htm" target="_top"> 干混砂浆生产线 </a> <a href="/103011-<%=factory%>-0.htm" target="_top"> 沥青砂浆车 </a> <a href="/103014-<%=factory%>-0.htm" target="_top"> 干混砂浆背罐车 </a> <a href="/103002-<%=factory%>-0.htm" target="_top"> 混凝土搅拌设备 </a> <a href="/103001-<%=factory%>-0.htm" target="_top"> 混凝土泵车 </a> <a href="/103010-<%=factory%>-0.htm" target="_top"> 喷湿机 </a> <a href="/104006-<%=factory%>-0.htm" target="_top"> 稳定土拌合机 </a> <a href="/104005-<%=factory%>-0.htm" target="_top"> 铣刨机 </a> <a href="/104008-<%=factory%>-0.htm" target="_top"> 稳定土厂拌设备 </a> <a href="/104007-<%=factory%>-0.htm" target="_top"> 沥青混合料搅拌设备 </a> <a href="/104009-<%=factory%>-0.htm" target="_top"> 沥青搅拌站 </a> <a href="/104004-<%=factory%>-0.htm" target="_top"> 其它路面机械 </a> <a href="/104001-<%=factory%>-0.htm" target="_top"> 摊铺机 </a> <a href="/104002-<%=factory%>-0.htm" target="_top"> 养护机械 </a> <a href="/105017-<%=factory%>-0.htm" target="_top"> 强夯机 </a> <a href="/105018-<%=factory%>-0.htm" target="_top"> 长螺旋钻孔机 </a> <a href="/105009-<%=factory%>-0.htm" target="_top"> 液压静力压桩机 </a> <a href="/105019-<%=factory%>-0.htm" target="_top"> 多功能钻机 </a> <a href="/105007-<%=factory%>-0.htm" target="_top"> 连续墙抓斗 </a> <a href="/105028-<%=factory%>-0.htm" target="_top"> 截桩机/破桩机 </a> <a href="/105011-<%=factory%>-0.htm" target="_top"> 打桩机 </a> <a href="/105016-<%=factory%>-0.htm" target="_top"> 连续墙钻机 </a> <a href="/105015-<%=factory%>-0.htm" target="_top"> 打桩锤 </a> <a href="/105027-<%=factory%>-0.htm" target="_top"> 其它桩工机械 </a> <a href="/105026-<%=factory%>-0.htm" target="_top"> 多轴钻孔机 </a> <a href="/105013-<%=factory%>-0.htm" target="_top"> 液压步履式桩架 </a> <a href="/105003-<%=factory%>-0.htm" target="_top"> 旋挖钻机 </a> <a href="/105004-<%=factory%>-0.htm" target="_top"> 潜孔钻机 </a> <a href="/105005-<%=factory%>-0.htm" target="_top"> 水平定向钻 </a> <a href="/106004-<%=factory%>-0.htm" target="_top"> 夯实机 </a> <a href="/106003-<%=factory%>-0.htm" target="_top"> 压实机 </a> <a href="/106001-<%=factory%>-0.htm" target="_top"> 压路机 </a> <a href="/107010-<%=factory%>-0.htm" target="_top"> 专用叉车 </a> <a href="/107001-<%=factory%>-0.htm" target="_top"> 内燃叉车 </a> <a href="/107003-<%=factory%>-0.htm" target="_top"> 电动叉车 </a> <a href="/107005-<%=factory%>-0.htm" target="_top"> 仓储叉车 </a> <a href="/109004-<%=factory%>-0.htm" target="_top"> 提梁机 </a> <a href="/109005-<%=factory%>-0.htm" target="_top"> 检测车 </a> <a href="/109002-<%=factory%>-0.htm" target="_top"> 运梁车 </a> <a href="/109006-<%=factory%>-0.htm" target="_top"> 砂浆车 </a> <a href="/109001-<%=factory%>-0.htm" target="_top"> 架桥机 </a> <a href="/110010-<%=factory%>-0.htm" target="_top"> 凿岩钻车 </a> <a href="/110008-<%=factory%>-0.htm" target="_top"> 凿岩台车 </a> <a href="/110009-<%=factory%>-0.htm" target="_top"> 破碎机 </a> <a href="/110011-<%=factory%>-0.htm" target="_top"> 凿岩机和钻机 </a> <a href="/110012-<%=factory%>-0.htm" target="_top"> 筛分机 </a> <a href="/110013-<%=factory%>-0.htm" target="_top"> 装载及搬运设备 </a> <a href="/110014-<%=factory%>-0.htm" target="_top"> 连续采煤机和隧道掘进机 </a> <a href="/110005-<%=factory%>-0.htm" target="_top"> 采煤机 </a> <a href="/110015-<%=factory%>-0.htm" target="_top"> 输送和辅助设备 </a> <a href="/110002-<%=factory%>-0.htm" target="_top"> 矿用掘进机 </a> <a href="/110016-<%=factory%>-0.htm" target="_top"> 全液压凿岩钻机 </a> <a href="/110017-<%=factory%>-0.htm" target="_top"> 隧道轨道设备 </a> <a href="/110001-<%=factory%>-0.htm" target="_top"> 盾构掘进机 </a> <a href="/111003-<%=factory%>-0.htm" target="_top"> 吊具 </a> <a href="/111001-<%=factory%>-0.htm" target="_top"> 正面吊 </a> <a href="/111002-<%=factory%>-0.htm" target="_top"> 堆高机 </a> <a href="/111007-<%=factory%>-0.htm" target="_top"> 推耙机 </a> <a href="/111006-<%=factory%>-0.htm" target="_top"> 场桥 </a> <a href="/113002-<%=factory%>-0.htm" target="_top"> 液压剪 </a> <a href="/113001-<%=factory%>-0.htm" target="_top"> 破碎锤 </a> <a href="/118004-<%=factory%>-0.htm" target="_top"> 牵引车 </a> <a href="/118002-<%=factory%>-0.htm" target="_top"> 专用车辆 </a> <a href="/118003-<%=factory%>-0.htm" target="_top"> 消防车 </a> <a href="/119001-<%=factory%>-0.htm" target="_top"> 煤炭机械 </a> </div>
        </dd>
        <div class="tsx_more">更多</div>
      </dl>
      <dl class="fix">
        <dt>国内品牌</dt>
        <dd>
          <%if(!innerBrand.equals("")){%>
          <div class="tsx_ddheight">
            <%for(int i=0;i<innerName.length;i++){
						String inNum=CommonString.getFormatPara(innerName[i]);
						String inName=CommonString.getFormatPara(brandMap.get(inNum));%>
            <a href="/<%=catalog%>-<%=inNum%>-0.htm" <%if(inNum.equals(factoryid)){%> class='selected' <%}%>><%=inName%></a>
            <%}%>
          </div>
          <%}else{%>
          <div class="tsx_ddheight"> <a href="/products/prolist.jsp?factory=209<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("209")){%> class='selected' <%}%>>徐工</a> <a href="/products/prolist.jsp?factory=133<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("133")){%> class='selected' <%}%>>三一</a> <a href="/products/prolist.jsp?factory=136<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("136")){%> class='selected' <%}%>>柳工</a> <a href="/products/prolist.jsp?factory=134<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("134")){%> class='selected' <%}%>>中联重科</a> <a href="/products/prolist.jsp?factory=175<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("175")){%> class='selected' <%}%>>沃尔沃</a> <a href="/products/prolist.jsp?factory=141<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("141")){%> class='selected' <%}%>>福田雷沃</a> <a href="/products/prolist.jsp?factory=135<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("135")){%> class='selected' <%}%>>龙工</a> <a href="/products/prolist.jsp?factory=139<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("139")){%> class='selected' <%}%>>厦工</a> <a href="/products/prolist.jsp?factory=142<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("142")){%> class='selected' <%}%>>山河智能</a> <a href="/products/prolist.jsp?factory=137<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("137")){%> class='selected' <%}%>>山东临工</a> <a href="/products/prolist.jsp?factory=144<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("144")){%> class='selected' <%}%>>山推</a> <a href="/products/prolist.jsp?factory=152<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("152")){%> class='selected' <%}%>>山重建机</a> <a href="/products/prolist.jsp?factory=146<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("146")){%> class='selected' <%}%>>玉柴</a> <a href="/products/prolist.jsp?factory=178<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("178")){%> class='selected' <%}%>>卡特重工</a> <a href="/products/prolist.jsp?factory=159<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("159")){%> class='selected' <%}%>>一拖</a> <a href="/products/prolist.jsp?factory=150<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("150")){%> class='selected' <%}%>>徐挖</a> <a href="/products/prolist.jsp?factory=149<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("149")){%> class='selected' <%}%>>沃得重工</a> <a href="/products/prolist.jsp?factory=138<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("138")){%> class='selected' <%}%>>山工机械</a> <a href="/products/prolist.jsp?factory=143<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("143")){%> class='selected' <%}%>>宇通重工</a> <a href="/products/prolist.jsp?factory=154<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("154")){%> class='selected' <%}%>>宣工</a> </div>
          <%}%>
        </dd>
        <div class="tsx_more">更多</div>
      </dl>
      <dl class="fix">
        <dt>国外品牌</dt>
        <dd>
          <%if(!outBrand.equals("")){%>
          <div class="tsx_ddheight">
            <%for(int i=0;i<outnerName.length;i++){
						String outNum=CommonString.getFormatPara(outnerName[i]);
						String outName=CommonString.getFormatPara(brandMap.get(outNum));%>
            <a href="/<%=catalog%>-<%=outNum%>-0.htm" <%if(outNum.equals(factoryid)){%> class='selected' <%}%>><%=outName%></a>
            <%}%>
          </div>
          <%}else {%>
          <div class="tsx_ddheight"> <a href="/products/prolist.jsp?factory=182<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("182")){%> class='selected' <%}%>>小松</a> <a href="/products/prolist.jsp?factory=192<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("192")){%> class='selected' <%}%>>斗山</a> <a href="/products/prolist.jsp?factory=174<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("174")){%> class='selected' <%}%>>卡特彼勒</a> <a href="/products/prolist.jsp?factory=184<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("184")){%> class='selected' <%}%>>日立</a> <a href="/products/prolist.jsp?factory=183<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("183")){%> class='selected' <%}%>>神钢</a> <a href="/products/prolist.jsp?factory=179<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("179")){%> class='selected' <%}%>>利勃海尔</a> <a href="/products/prolist.jsp?factory=189<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("189")){%> class='selected' <%}%>>加藤</a> <a href="/products/prolist.jsp?factory=455<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("455")){%> class='selected' <%}%>>凯斯</a> <a href="/products/prolist.jsp?factory=176<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("176")){%> class='selected' <%}%>>特雷克斯</a> <a href="/products/prolist.jsp?factory=194<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("194")){%> class='selected' <%}%>>现代</a> <a href="/products/prolist.jsp?factory=185<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("185")){%> class='selected' <%}%>>住友</a> <a href="/products/prolist.jsp?factory=177<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("177")){%> class='selected' <%}%>>JCB</a> <a href="/products/prolist.jsp?factory=187<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("187")){%> class='selected' <%}%>>久保田</a> <a href="/products/prolist.jsp?factory=188<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("188")){%> class='selected' <%}%>>竹内</a> <a href="/products/prolist.jsp?factory=198<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("198")){%> class='selected' <%}%>>全进重工</a> <a href="/products/prolist.jsp?factory=454<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("454")){%> class='selected' <%}%>>山猫</a> <a href="/products/prolist.jsp?factory=212<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("212")){%> class='selected' <%}%>>戴纳派克</a> <a href="/products/prolist.jsp?factory=163<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("163")){%> class='selected' <%}%>>东岳重工</a> <a href="/products/prolist.jsp?factory=191<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("191")){%> class='selected' <%}%>>洋马</a> <a href="/products/prolist.jsp?factory=190<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("190")){%> class='selected' <%}%>>石川岛</a> <a href="/products/prolist.jsp?factory=180<%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"  <%if(factoryid.equals("180")){%> class='selected' <%}%>>阿特拉斯</a> </div>
          <%}%>
        </dd>
        <div class="tsx_more">更多</div>
      </dl>
    </div>
    <%if(!factory.equals("0")||!catalog.equals("0")){%>
    <div class="photoParts" style="width:960px">
      <div class="content nph_plist">
        <ul class="modelList">
          <li class="mll">
            <ul class="list1_ph np_fix">
              <%
		   String mulName="";  String cataName="";  String cataNo="";
		   if(searchkoubei !=null && searchkoubei.size()>0){
			   for(Map oneMap:searchkoubei){
			   cataNo=CommonString.getFormatPara(oneMap.get("catalognum"));
			   if(cataNo.length()>6){cataNo=cataNo.substring(0,6);}
			   cataName=CommonString.getFormatPara(catalogMap.get(cataNo));
			   mulName=CommonString.getFormatPara(oneMap.get("factoryname")).replace("卡特彼勒","卡特")+cataName;
			   if(mulName.length()>10){mulName=mulName.substring(0,10)+"...";}
			   %>
              <li>
                <p class="npg_img"><a href="/list/<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>口碑" target="_blank"><img width="135" height="100" src="<%=CommonString.getFormatPara(oneMap.get("img"))%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>口碑" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"></a></p>
                <p class="nph_name" style="text-align:center"><a title="<%=CommonString.getFormatPara(oneMap.get("title"))%>口碑" href="/list/<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("title"))%>口碑</a></p>
                <p class="nph_cat" style="text-align:center"><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%>" href="/0-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>-0.htm">[<%=CommonString.getFormatPara(oneMap.get("factoryname"))%>]</a><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname")).replace("卡特彼勒","卡特")%><%=cataName%>" href="/<%=CommonString.getFormatPara(oneMap.get("catalognum")).length()>6?CommonString.getFormatPara(oneMap.get("catalognum")).substring(0,6):CommonString.getFormatPara(oneMap.get("catalognum"))%>-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>-0.htm"> [<%=mulName%>]</a></p>
                <p class="nph_lik" style="text-align:center">评论数：<%=CommonString.getFormatPara(oneMap.get("commentCount")).equals("")?"0":CommonString.getFormatPara(oneMap.get("commentCount"))%>条 | <a href="compare_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm">对比</a></p>
              </li>
              <%}}else{%>
              <%}%>
            </ul>
          </li>
        </ul>
      </div>
      <div class="w755 l">
        <div id="pagination" class="page">
          <%
		if(catalog.equals("")){catalog="0";}
		if(factory.equals("")){factory="0";}
		  %>
          <tags:page_koubei_list_solr nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>"  factoryid="<%=factory%>"  catalog="<%=catalog%>"/>
        </div>
      </div>
    </div>
    <%}else{%>
    <div class="photoParts mb20" style="width:960px">
      <div class="txd_plant fix">
        <div class="tpl_title">热门品牌</div>
        <a href="/brands/" class="tpl_more" target="_blank">查看全部品牌</a> </div>
      <div class="content">
        <ul class="pbList">
          <li><a style="cursor:pointer" title="三一口碑" href="/0-133-0.htm"><img width="100" height="50" alt="三一" src="../images/sany.jpg">三一</a></li>
          <li><a style="cursor:pointer" title="徐工口碑" href="/0-209-0.htm"><img width="100" height="50" alt="徐工" src="../images/xcmg.jpg">徐工</a></li>
          <li><a style="cursor:pointer" title="中联重科口碑" href="/0-134-0.htm"><img width="100" height="50" alt="中联重科" src="../images/photo_brandimg04.gif">中联重科</a></li>
          <li><a style="cursor:pointer" title="柳工口碑" href="/0-136-0.htm"><img width="100" height="50" alt="柳工" src="../images/photo_brand_lg.gif">柳工</a></li>
          <li><a style="cursor:pointer" title="山推口碑" href="/0-144-0.htm"><img width="100" height="50" alt="山推" src="../images/photo_brand_st.gif">山推</a></li>
          <li><a style="cursor:pointer" title="山东临工口碑" href="/0-137-0.htm"><img width="100" height="50" alt="山东临工" src="../images/photo_brand_lingong.gif">山东临工</a></li>
          <li><a style="cursor:pointer" title="卡特彼勒口碑" href="/0-174-0.htm"><img style="width:90px;height:50px"  alt="卡特彼勒" src="http://product.21-sun.com//uploadfiles/20081204173853_0.jpg">卡特彼勒</a></li>
        </ul>
      </div>
    </div>
    <div class="photoParts" style="width:960px">
      <div class="txd_plant fix">
        <div class="tpl_title">热门机型</div>
      </div>
      <div class="content nph_plist">
        <ul class="modelList">
          <li class="mll">
            <div class="mt" style="width:940px">
              <h3>挖掘机</h3>
              <span class="more"><a href="/101001-0-0.htm" target="_blank" title="更多挖掘机口碑">更多&gt;&gt;</a></span> </div>
            <ul class="list1_ph np_fix">
              <jsp:include page="/include/koubei/list_wjj.htm" flush="true" />
            </ul>
          </li>
          <li class="mll">
            <div class="mt" style="width:940px">
              <h3>装载机</h3>
              <span class="more"><a href="/101002-0-0.htm" target="_blank" title="更多装载机口碑">更多&gt;&gt;</a></span> </div>
            <ul class="list1_ph np_fix">
              <jsp:include page="/include/koubei/list_zzj.htm" flush="true" />
            </ul>
          </li>
          <li class="mll">
            <div class="mt" style="width:940px">
              <h3>起重机</h3>
              <span class="more"><a href="/102-0-0.htm" target="_blank" title="更多起重机口碑">更多&gt;&gt;</a></span> </div>
            <ul class="list1_ph np_fix">
              <jsp:include page="/include/koubei/list_qzj.htm" flush="true" />
            </ul>
          </li>
          <li class="mll">
            <div class="mt" style="width:940px">
              <h3>推土机</h3>
              <span class="more"><a href="/101003-0-0.htm" target="_blank" title="更多推土机口碑">更多&gt;&gt;</a></span> </div>
            <ul class="list1_ph np_fix">
              <jsp:include page="/include/koubei/list_ttj.htm" flush="true" />
            </ul>
          </li>
          <li class="mll">
            <div class="mt" style="width:940px">
              <h3>平地机</h3>
              <span class="more"><a href="/101005-0-0.htm" target="_blank" title="更多平地机口碑">更多&gt;&gt;</a></span> </div>
            <ul class="list1_ph np_fix">
              <jsp:include page="/include/koubei/list_pdj.htm" flush="true" />
            </ul>
          </li>
          <li class="mll">
            <div class="mt" style="width:940px">
              <h3>压路机</h3>
              <span class="more"><a href="/106-0-0.htm" target="_blank" title="更多压路机口碑">更多&gt;&gt;</a></span> </div>
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
<jsp:include page="/include/foot_koubei.jsp" flush="false"/>
<!--end of foot-->
</body>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<script type="text/javascript" src="/new_resources/js/sele_t.js"></script>
<script type="text/javascript"  src="/new_resources/js/new_common.js"></script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>
