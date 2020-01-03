<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
	<cache:cache  cron="* * */1 * *">
<%
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null; 
	Connection connection_market = null; 
	try{
	connection = dbHelper.getConnection();
	connection_market = dbHelper.getConnection("web21market");
	String areaQuery = "select area_id,area_name,parent_area_id from comm_area where level_id=2 and area_id<>105500 and area_id<>105690 and area_id<>105300 and area_id<>105880 order by node_full_name";
    List<Map> areaList = dbHelper.getMapList(areaQuery);
    LinkedHashMap areaMap = new LinkedHashMap();
	areaMap.put("105500", "北京");
	areaMap.put("105690", "天津");
	areaMap.put("105300", "上海");
	areaMap.put("105880", "重庆");
	for(Map areaM : areaList){
			String area_id = CommonString.getFormatPara(areaM.get("area_id"));
			String area_name = CommonString.getFormatPara(areaM.get("area_name"));
			if(area_name.endsWith("州")){
				area_name = area_name.substring(0, area_name.length()-1);
			}
			area_name = area_name.replace("市", "").replace("地区", "").replace("林区", "").replace("区", "");
			if(area_name.length() < 5){
				areaMap.put(area_id, area_name);
			}
	}
	String areaName="";
   	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factory"));
	String factory = CommonString.getFormatPara(request.getParameter("factoryid"));
    String area = CommonString.getFormatPara(request.getParameter("area"));
	if(factoryid.equals("")&&!factory.equals("")){factoryid=factory;}
	if(catalog.equals("0")){catalog="";}
	if(factoryid.equals("0")){factoryid="";}
	if(area.equals("0")){area="";}
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String showtonandmeter = "";
	String wordsSelect="";
	Map brandMap = (Map) application.getAttribute("brandMap");
	List<Map> catalogList = (List) application.getAttribute("catalogList"); 
	List<Map> brandList = (List) application.getAttribute("brandList"); 
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	Integer nowPage = 1; 
    PageBean pageBean = new PageBean(); // 分页程序
	String whereStr="and is_pub=1 and html_filename is not NULL "; 
	String market="";
	if(!catalog.equals("")){
	   whereStr+=whereStr+" and title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
	   market+=market+" and title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
	}
    if(!factoryid.equals("")){
	  whereStr+=whereStr+" and title like '%"+CommonString.getFormatPara(brandMap.get(factoryid))+"%'";
	  market+=market+" and title like '%"+ CommonString.getFormatPara(brandMap.get(factoryid))+"%'";
	}

	if(!area.equals("")){
			whereStr += " and title like '%" + CommonString.getFormatPara(areaMap.get(area)) + "%'";
			market += " and title like '%" + CommonString.getFormatPara(areaMap.get(area)) + "%'";
			areaName=CommonString.getFormatPara(areaMap.get(area));
	}
    //供求市场的维修信息
	String weixiuQuery = "select top 10 id,title,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')"+market;
	if(!area.equals("")){ weixiuQuery = "select top 20 id,title,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')"+market;}
	List<Map> weixiuList = dbHelper.getMapList(weixiuQuery, connection_market);
	List <Map> list=null;
	if(area.equals("")){
    pageBean.setPageSize(10); 
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("id,title,pub_date,html_filename,catalog_no");
	pageBean.setTableName("article_other");
	pageBean.setOrderBy(" id desc"); // 点击量排序
	list = pageBean.getDatasByWebService("Web21sunDBHelper");
	}
	//TDK
	String title="【工程机械维修】工程机械维修知识大全_工程机械维修论坛 - 铁臂维修";
	String keywords="工程机械维修,工程机械维修知识,工程机械维修论坛";
	String description="铁臂维修提供大量的工程机械维修方法,帮助您快速解决工程机械故障维修难题，买工程机械就上铁臂商城。";
	if(!factoryid.equals("")||!catalog.equals("")||!area.equals("")){
	title="【图文】"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修_"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修保养_"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修大全 - 铁臂维修";
	keywords=(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修,"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修保养,"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修大全";
	description="铁臂维修为您提供"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修方法，"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修保养知识，快速解决"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修问题，买"+(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
	}
    String fullName=(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs">
    <a href="http://weixiu.21-sun.com/">铁臂维修</a>
    <%="".equals(area)?"":" &gt;&gt; <a href='/0-"+area+"-0.htm'>"+CommonString.getFormatPara(areaMap.get(area)) +"</a>"%>
    <%="".equals(factoryid)?"":" &gt;&gt; <a href='/0-0-"+factoryid+".htm'>"+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +"</a>"%>
	<%="".equals(catalog)?"":" &gt;&gt; <a href='/"+catalog+"-0-0.htm'>"+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) +"</a>"%>
	<%=((!"".equals(catalog)&&!"".equals(factoryid))||(!"".equals(factoryid)&&!"".equals(area))||(!"".equals(area)&&!"".equals(catalog)))?" &gt;&gt; "+CommonString.getFormatPara(areaMap.get(area))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))):""%>
	<%=("".equals(factoryid)&&"".equals(catalog)&&"".equals(area))?"":" &gt;&gt; "+CommonString.getFormatPara(areaMap.get(area))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))+"维修"%>
	</h3>
</div>
<div class="contain980 clearfix">
  <!--left-->
  <div class="nre_left">


  
    <!--最新产品口碑开始-->
    <jsp:include page="/include/weixiu/koubei_list.jsp" flush="true">
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
    <jsp:param name="catalognum" value="<%=catalog%>"></jsp:param>
    </jsp:include>
    <!--最新产品口碑结束-->
    <!--维修视频开始-->
    <jsp:include page="/include/weixiu/video_list.jsp" flush="true">
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
    <jsp:param name="catalognum" value="<%=catalog%>"></jsp:param>
    </jsp:include>
    <!--维修视频结束-->
  </div>
  <!--left end-->
  <!--right-->
  <style>
  .ConditionBottom li.cblist dd a{padding: 0px 6px;margin-right: 6px;}
  </style>
  <div class="nre_right">
    <!--分类查找-->
    <form name="theform" id="theform">
      <div class="border03 l Condition mb10 nwx_net_sea">
        <div class="ConditionTop">
          <div class="l">
            <%if (!"".equals(catalog) || !"".equals(factoryid)) {%>
            <a href="/0-0-0.htm"> <span class="reset">重置</span></a>
            <%}%>
            <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/0-0-<%="".equals(factoryid)?"0":factoryid%>.htm" title="取消" class="delete"></a> </span>
            <%}%>
            <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="/<%="".equals(catalog)?"0":catalog%>-0-0.htm" title="取消" class="delete"></a> </span>
            <%}%>
            <%if ( !"".equals(area)) {%>
            <span><em><%=CommonString.getFormatPara(areaMap.get(area))%></em> <a href="/<%="".equals(catalog)?"0":catalog%>-0-<%="".equals(factoryid)?"0":factoryid%>.htm" title="取消" class="delete"></a> </span>
            <% } %>
          </div>
          <h1 class="r" style="font-size:14px;"><%=CommonString.getFormatPara(areaMap.get(area))%><%="".equals(catalog+factoryid)?"工程机械":""%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修大全</h1>
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
            <dt> 区域 </dt>
            <dd> 
			<a href="/<%=catalog.equals("")?"0":catalog%>-0-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("".equals(area)){%> class='select' <%} %>>不限</a>
			<a title="北京" href="/<%=catalog.equals("")?"0":catalog%>-105500-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("105500".equals(area)){%> class='select' <%}%>>北京</a>
			<a title="上海" href="/<%=catalog.equals("")?"0":catalog%>-105300-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("105300".equals(area)){%> class='select' <%}%>>上海</a>
			<a title="天津" href="/<%=catalog.equals("")?"0":catalog%>-105690-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("105690".equals(area)){%> class='select' <%}%>>天津</a>
			<a title="重庆" href="/<%=catalog.equals("")?"0":catalog%>-105880-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("105880".equals(area)){%> class='select' <%}%>>重庆</a>
			<a title="石家庄" href="/<%=catalog.equals("")?"0":catalog%>-106410-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("106410".equals(area)){%> class='select' <%}%>>石家庄</a>
			<a title="太原" href="/<%=catalog.equals("")?"0":catalog%>-108310-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("108310".equals(area)){%> class='select' <%}%>>太原</a>
			<a title="呼和浩特" href="/<%=catalog.equals("")?"0":catalog%>-109710-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("109710".equals(area)){%> class='select' <%}%>>呼和浩特</a>
			<a title="沈阳" href="/<%=catalog.equals("")?"0":catalog%>-120010-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("120010".equals(area)){%> class='select' <%}%>>沈阳</a>
			<a title="长春" href="/<%=catalog.equals("")?"0":catalog%>-119010-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("119010".equals(area)){%> class='select' <%}%>>长春</a>
			<a title="哈尔滨" href="/<%=catalog.equals("")?"0":catalog%>-122010-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("122010".equals(area)){%> class='select' <%}%>>哈尔滨</a>			
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
                <jsp:include page="/include/weixiu/area.jsp" flush="true">
                    <jsp:param value="<%=catalog%>" name="catalog"/>
                    <jsp:param value="<%=factoryid%>" name="factoy_id"/>
                    <jsp:param value="<%=order%>" name="order"/>
                </jsp:include>
              </div>
            </dd>
          </li>
	  
          <li class="cblist">
            <dt> 类别 </dt>
            <dd> <a href="/0-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> <a href="/101001-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机维修</a> <a href="/101002-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机维修</a> <a href="/102-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机维修</a> <a href="/101003-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机维修</a> <a href="/103-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土维修</a> <a href="/106001-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机维修</a> <a href="/101005-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机维修</a> <a href="/105003-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻维修</a> <a href="/113001-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤维修</a> <a href="/104001-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机维修</a> <a href="/107-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("107".equals(catalog)){%> class='select' <%} %>>叉车维修</a> <a href="/104-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("104".equals(catalog)){%> class='select' <%} %>>筑养路维修</a> <a href="/105-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" <%if("105".equals(catalog)){%> class='select' <%} %>>桩工维修</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
              <jsp:include page="/include/weixiu/catalog.jsp" flush="true">
                <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=factoryid%>" name="factoy_id"/>
                <jsp:param value="<%=order%>" name="order"/>
				<jsp:param value="<%=area%>" name="area"/>
              </jsp:include>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 品牌 </dt>
            <dd>
              <%if (!"".equals(catalog)) {%>
              <a  href="/<%=catalog%>-<%=area.equals("")?"0":area%>-0.htm" <%if("".equals(factoryid)){%>  class="select" <%} %>>不限</a>
              <% List<Map> recommend_brands = dbHelper.getMapList(" select top 9 catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog+ "' order by order_no desc",connection);
													if (null != recommend_brands && recommend_brands.size() > 0) {
														for (Map oneMap : recommend_brands) {								
										%>
              <a  href="/<%=catalog%>-<%=area.equals("")?"0":area%>-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>.htm" <%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%> class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
              <%}}} else {%>
              <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-0.htm">不限</a> <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-133.htm">三一</a> <a <%if("182".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-182.htm">小松</a> <a <%if("192".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-192.htm">斗山</a> <a <%if("184".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-184.htm">日立</a> <a <%if("183".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-183.htm">神钢</a> <a <%if("175".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-175.htm">沃尔沃</a> <a <%if("174".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-174.htm">卡特彼勒</a> <a <%if("146".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-146.htm">玉柴重工</a> <a <%if("136".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-136.htm">柳工</a> <a <%if("194".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-194.htm">现代京城</a> <a <%if("134".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-134.htm">中联重科</a> <a <%if("209".equals(factoryid)){%>  class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-209.htm">徐工</a> <a <%if("139".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-139.htm">厦工</a> <a <%if("135".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-135.htm">龙工</a> <a <%if("141".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-141.htm">福田雷沃</a> <a <%if("137".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-137.htm">临工</a> <a <%if("144".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-144.htm">山推</a> <a <%if("152".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-152.htm">山重建机</a> <a <%if("189".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-189.htm">加藤</a> <a <%if("455".equals(factoryid)){%> class='select' <%} %> href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-455.htm">凯斯</a>
              <%}%>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
              <jsp:include page="/include/weixiu/brand.jsp" flush="true">
                 <jsp:param value="<%=catalog%>" name="catalog"/>
                 <jsp:param value="<%=factoryid%>" name="factoy_id"/>
                 <jsp:param value="<%=order%>" name="order"/>
				 <jsp:param value="<%=area%>" name="area"/>
              </jsp:include>
              </div>
            </dd>
          </li>
        </ul>
      </div>
    </form>
    <!--品牌查找结束-->
    <!--维修list-->
    <div class="rp clearfix mb10 nwx_zxlist repairList">
      <div class="title">
        <h3><%=CommonString.getFormatPara(areaMap.get(area))%><%="".equals(catalog+factoryid)?"工程机械":""%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修</h3>
        <div class="nwx_zxlist_ph np_fix" style="display:none"><a href="javascript:;" class="select">默认</a> <a href="javascript:;">已解决</a> <a href="javascript:;">未解决</a></div>
      </div>
      <div class="content rList01">
        <ul class="list blue">
          <%
			if(area.equals("")){
				for(Map m : list){
		%>
          <li>
            <h3><span class="lb">[<%=fullName%>维修]</span><a target="_blank" href="/weixiu/detail_for_<%="".equals(factoryid)?"0":factoryid%>_<%="".equals(catalog)?"0":catalog%>_<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(m.get("title")) %>"><%=CommonString.getFormatPara(m.get("title")) %></a></h3>
            <span class="time"><%=CommonString.getFormatPara(m.get("pub_date")) %></span> </li>
          <%}}else{%>
          <%}%>
          <%
        		if(weixiuList!=null && weixiuList.size()>0){
        			for(Map weixiu : weixiuList){
        				String id = CommonString.getFormatPara(weixiu.get("id"));
        				String title_weixiu = CommonString.getFormatPara(weixiu.get("title"));
        				String pub_date = CommonDate.getFormatDate("yyyy-MM-dd", weixiu.get("pub_date"));
        	%>
          <li>
            <h3><span class="lb">[<%=fullName%>维修]</span><a href="http://market.21-sun.com/viewSellBuy_for_<%=id %>.htm" target="_blank" title="<%=title_weixiu %>"><%=title_weixiu %></a></h3>
            <span class="time"><%=pub_date %></span> </li>
          <%}}%>
          <%if((list==null||list.size()<=0)&&(weixiuList==null|| weixiuList.size()<=0)){%>
          <div align="center">暂无相关信息</div>
          <%}%>
        </ul>
      </div>
    </div>
    <!--维修list结束-->
    <!--询价单-->
    <jsp:include page="/include/weixiu/order_list.jsp"  flush="true">
        <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
		  <jsp:param name="areaName" value="<%=areaName%>"></jsp:param>
    </jsp:include>
    <!--询价单结束-->
  </div>
  <!--right end-->
</div>

<style>
.new_v_foot_list{ width:980px; margin:0 auto; text-align:left; margin-bottom:10px;}
.new_v_foot_list .adnf_list ul li{ float:left;  margin:0 6px 0;white-space:nowrap; padding: 6px 0;}
.new_v_foot_list .adnf_list ul li a{  display:inline-block;}
.new_v_foot_list .adnf_list ul li a:hover{ color:#ff6600}
.new_v_foot_list .adnf_title{ font-size:14px; font-weight:bold; border-bottom:1px solid #ccc; padding:7px 0; margin-bottom:5px; font-family:微软雅黑;}
.nleft_one .list003 { height:210px; overflow:auto;}
  </style>
<%
    String catalogname="";
	String factoryname="";
    if(!catalog.equals("")){
    catalogname=CommonString.getFormatPara(catalogMap.get(catalog));
%>
<!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">更多品牌<%=catalogname %>维修</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_brand_index.jsp" flush="true">
     <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
     <jsp:param name="catalogName" value="<%=catalogname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
  <!--副导航-->
<%}else if(!factoryid.equals("")){
factoryname=CommonString.getFormatPara(brandMap.get(factoryid));
%>
<!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">更多<%=factoryname %>产品维修</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_pro_index.jsp" flush="true">
     <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
     <jsp:param name="factoryName" value="<%=factoryname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
<!--副导航-->
<%}else if(!area.equals("")){%>
<!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">更多工程机械维修分类</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_area_index.jsp" flush="true">
     <jsp:param name="area" value="<%=area%>"></jsp:param>
     <jsp:param name="areaName" value="<%=areaName%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
<!--副导航-->
<%}%>


<jsp:include page="/include/index/friendlink_weixiu.htm" flush="true"/>
<jsp:include page="/include/foot.jsp" flush="true"/>
<script type="text/javascript">
//下拉
$.fn.sele=function() {
	var ev=($(this).data('sele')?$(this).data('sele').act:'mouseenter').split(" ");
	$(this).bind(ev[0],function(){sele_show(this,ev[0])}).bind('mouseleave',function(){sele_hide(this)});
	function sele_show(me,evt){
		$(me).find('.sele_').stop(1,0).show().children('a').click(function(event){
			event.stopPropagation();
			if(!$(this).attr('target')){
				event.preventDefault();
				if($(me).find('.btn').length){
					$(me).find('.btn').attr('href',$(this).attr('href'))
				};
				$(this).parent().hide().parents('.sele').find('span').text($(this).text());
			}
		})
	};
	function sele_hide(me){
		$(me).find('.sele_').stop(1,0).hide()
	};
};
var $sele=$('.sele');
$sele.each(function(i) {$(this).css('z-index',$sele.length-i).sele()});
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
		DBHelper.freeConnection(connection_market);
	}
%>
</cache:cache>