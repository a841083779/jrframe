<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null; 
	Connection connection_market = null; 
	try{
	connection = dbHelper.getConnection();
	connection_market = dbHelper.getConnection("web21market");
   	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factory"));
	String province = CommonString.getFilterStr(request.getParameter("province")) ;
    String city = CommonString.getFilterStr(request.getParameter("city")) ;
	if(catalog.equals("0")){catalog="";}
	if(factoryid.equals("0")){factoryid="";}
	if("0".equals(province)){province="";}
    if("0".equals(city)){city="";}
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String showtonandmeter = "";
	String wordsSelect="";
	Map brandMap = (Map) application.getAttribute("brandMap");
	List<Map> catalogList = (List) application.getAttribute("catalogList"); 
	List<Map> brandList = (List) application.getAttribute("brandList"); 
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	Integer nowPage = 1; 
    PageBean pageBean = new PageBean(); // 分页程序
	if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
	}
    if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
    }
	String whereStr="and is_pub=1 and html_filename is not NULL "; 
	String market="";
	if(!catalog.equals("")){
	   whereStr+=whereStr+" and title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
	  market+=market+" and title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
	}
    if(!factoryid.equals("")){
	  whereStr+=whereStr+" and title like '%"+ CommonString.getFormatPara(brandMap.get(factoryid))+"%'";
	  market+=market+" and title like '%"+ CommonString.getFormatPara(brandMap.get(factoryid))+"%'";
	}
	if(!keyword.equals("")){
	    whereStr+=whereStr+" and title like '%"+ keyword+"%'";
	    market+=market+" and title like '%"+ keyword+"%'";
	}
    pageBean.setPageSize(10); // 每页显示条数
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("id,title,pub_date,html_filename,catalog_no");
	pageBean.setTableName("article_other");
	if ("0".equals(order)) {
			pageBean.setOrderBy(" view_count desc"); // 点击量排序
    }else{
			pageBean.setOrderBy(" pub_date desc"); // 默认排序
	}
	List <Map>list = pageBean.getDatas(connection);
	//供求市场的维修信息
	String weixiuQuery = "select top 10 id,title,province,city,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')"+market;
	List<Map> weixiuList = dbHelper.getMapList(weixiuQuery, connection_market);
	//TDK
	String title="【工程机械维修】工程机械维修知识大全_工程机械维修论坛 - 铁臂维修";
	String keywords="工程机械维修,工程机械维修知识,工程机械维修论坛";
	String description="铁臂维修提供大量的工程机械维修方法,帮助您快速解决工程机械故障维修难题，买工程机械就上铁臂商城。";
	if(!factoryid.equals("")||!catalog.equals("")){
	title="【图文】"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修_"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修保养_"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修大全 - 铁臂维修";
	keywords=(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修,"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修保养,"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修大全";
	description="铁臂维修为您提供"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修方法，"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修保养知识，快速解决"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修问题，买"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
	}
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
  <h3 class="breadCrumbs">铁臂维修 <%="".equals(factoryid)?"":" &gt;&gt; <a href='/weixiu/index.jsp?factory="+factoryid+"'>"+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +"</a>"%> <%="".equals(catalog)?"":" &gt;&gt; <a href='/weixiu/index.jsp?catalog="+catalog+"'>"+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) +"</a>"%> <%=("".equals(catalog)||"".equals(factoryid))?"":" &gt;&gt; "+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))%> <%=("".equals(catalog)&&"".equals(factoryid))?"":" &gt;&gt; "+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))+"维修"%></h3>
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
            <a href="/weixiu/index.jsp"> <span class="reset">重置</span></a>
            <%}%>
            <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("","<%=factoryid%>","","","<%=order%>")'></a> </span>
            <%}%>
            <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
            <%}%>
            <%if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {%>
            <span><em><%=showtonandmeter%></em> <a
										href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
            <%}%>
          </div>
          <h1 class="r" style="font-size:14px;"><%="".equals(catalog+factoryid)?"工程机械":""%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修大全</h1>
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
            <input type="hidden" name="factory" id="factory_id" />
            <input type="hidden" name="catalog" id="catalognum" />
            <dd> <a href="/weixiu/index.jsp<%=factoryid.equals("")?"":"?factory="+factoryid%>" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> 
       <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101001.htm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机维修</a> 
            <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101002.htm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机维修</a>
             <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-102.htm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机维修</a>
              <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101003.htm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机维修</a> 
              <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-103.htm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土维修</a>
               <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-106001.htm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机维修</a>
                <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101005.htm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机维修</a>
                 <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-105003.htm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻维修</a>
                  <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-113001.htm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤维修</a>
                   <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-104001.htm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机维修</a>
                    <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-107.htm" <%if("107".equals(catalog)){%> class='select' <%} %>>叉车维修</a>
                     <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-104.htm" <%if("1040".equals(catalog)){%> class='select' <%} %>>筑养路维修</a> 
                     <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-105.htm" <%if("105".equals(catalog)){%> class='select' <%} %>>桩工维修</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
                <jsp:include page="/include/weixiu/catalog.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            <jsp:param value="photo" name="flag"/>
            </jsp:include>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 品牌 </dt>
            <dd>
              <%if (!"".equals(catalog)) {%>
              <a onclick="sosuo('<%=catalog%>','','<%=tonandmeter%>');"
											href="javascript:void(0)" <%if("".equals(factoryid)){%>
											class="select" <%} %>>不限</a>
              <%List<Map> recommend_brands = dbHelper.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog+ "' order by order_no desc",connection);
					if (null != recommend_brands && recommend_brands.size() > 0) {
						int i = 0;
							for (Map oneMap : recommend_brands) {
								i++;
								if (i == 11) {break;}
										%>
              <!-- 挖掘机 -->
              <a onclick="sosuo('<%=catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>','<%=tonandmeter%>')"
											href="javascript:;"
											<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
              <%
											}
													}
												} else {
										%>
              <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/weixiu/0-0-0-0.htm">不限</a>
              <!-- 挖掘机 -->
              <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-133-<%=catalog.equals("")?"0":catalog%>.htm">三一</a>
              <!-- 挖掘机 -->
              <a <%if("182".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-182-<%=catalog.equals("")?"0":catalog%>.htm">小松</a>
              <!-- 挖掘机 -->
              <a <%if("192".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-192-<%=catalog.equals("")?"0":catalog%>.htm">斗山</a>
              <!-- 挖掘机 -->
              <a <%if("184".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-184-<%=catalog.equals("")?"0":catalog%>.htm">日立</a>
              <!-- 挖掘机 -->
              <a <%if("183".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-183-<%=catalog.equals("")?"0":catalog%>.htm">神钢</a>
              <!-- 挖掘机 -->
              <a <%if("175".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-175-<%=catalog.equals("")?"0":catalog%>.htm">沃尔沃</a>
              <!-- 挖掘机 -->
              <a <%if("174".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-174-<%=catalog.equals("")?"0":catalog%>.htm">卡特彼勒</a>
              <!-- 挖掘机 -->
              <a <%if("146".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-146-<%=catalog.equals("")?"0":catalog%>.htm">玉柴重工</a>
              <!-- 挖掘机 -->
              <a <%if("136".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-136-<%=catalog.equals("")?"0":catalog%>.htm">柳工</a>
              <a <%if("134".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-134-<%=catalog.equals("")?"0":catalog%>.htm">中联重科</a> 
              <a <%if("209".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-209-<%=catalog.equals("")?"0":catalog%>.htm">徐工</a> 
              <a <%if("139".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-139-<%=catalog.equals("")?"0":catalog%>.htm">厦工</a> 
              <a <%if("135".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-135-<%=catalog.equals("")?"0":catalog%>.htm">龙工</a>
              <a <%if("141".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-141-<%=catalog.equals("")?"0":catalog%>.htm">福田雷沃</a>
              <a <%if("137".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-137-<%=catalog.equals("")?"0":catalog%>.htm">临工</a> 
              <a <%if("144".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-144-<%=catalog.equals("")?"0":catalog%>.htm">山推</a> 
              <a <%if("152".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-152-<%=catalog.equals("")?"0":catalog%>.htm">山重建机</a> 
              <a <%if("189".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-189-<%=catalog.equals("")?"0":catalog%>.htm">加藤</a> 
              <a <%if("455".equals(factoryid)){%> class='select' <%} %> href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-455-<%=catalog.equals("")?"0":catalog%>.htm">凯斯</a>
              <%
											}
										%>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
                <jsp:include page="/include/products/brand.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            <jsp:param value="photo" name="flag"/>
            </jsp:include>
              </div>
            </dd>
          </li>
          <script type="text/javascript">
	            if('<%=catalog%>'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
        </ul>
        <input type="hidden" name="order" id="order" />
      </div>
    </form>
    <!--品牌查找结束-->
    <!--维修list-->
    <div class="rp clearfix mb10 nwx_zxlist repairList">
      <div class="title">
        <h3>最新工程机械维修</h3>
        <div class="nwx_zxlist_ph np_fix"><a href="javascript:;" class="select">默认</a> <a href="javascript:;">已解决</a> <a href="javascript:;">未解决</a></div>
      </div>
      <div class="content rList01">
        <ul class="list blue">
          <%
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
          <li>
            <h3><span class="lb">[维修]</span><a href="/weixiu/detail.jsp?id=<%=CommonString.getFormatPara(m.get("id")) %>" target="_blank" title="<%=CommonString.getFormatPara(m.get("title")) %>"><%=CommonString.getFormatPara(m.get("title")) %></a></h3>
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
            <h3><span class="lb">[维修]</span><a href="http://market.21-sun.com/viewSellBuy_for_<%=id %>.htm" target="_blank" title="<%=title_weixiu %>"><%=title_weixiu %></a></h3>
            <span class="time"><%=pub_date %></span> </li>
          <%}}%>
          <%if((list==null||list.size()<=0)&&(weixiuList==null|| weixiuList.size()<=0)){%>
          <div align="center">暂无相关信息</div>
          <%}%>
        </ul>
      </div>
      <div id="pagination" class="page" style="float:left;display:none">
        <tags:page pageBean="<%=pageBean%>" />
      </div>
    </div>
    <!--维修list结束-->
    <!--询价单-->
    <jsp:include page="/include/weixiu/order_list.jsp"  flush="true">
    <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
    </jsp:include>
    <!--询价单结束-->
  </div>
  <!--right end-->
</div>
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