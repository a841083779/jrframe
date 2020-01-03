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
	//connection_market = dbHelper.getConnection("web21market");
    connection_market = dbHelper.getConnection();
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
	//特殊
    String area = CommonString.getFormatPara(request.getParameter("offset"));
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
	String whereStr=" and is_show=1"; 
	String market="";
	if(!catalog.equals("")){
	   whereStr+=whereStr+" and (title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%' or catalog= '"+catalog+"')";
	   market+=market+" and title like '%"+ CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
	}
    if(!factoryid.equals("")){
	  whereStr+=whereStr+" and (title like '%"+CommonString.getFormatPara(brandMap.get(factoryid))+"%'   or factory='"+factoryid+"')";
	  market+=market+" and title like '%"+ CommonString.getFormatPara(brandMap.get(factoryid))+"%'";
	}

	if(!area.equals("")){
			areaName=CommonString.getFormatPara(areaMap.get(area));
	}
    //供求市场的维修信息
	String weixiuQuery = "select top 10 id,title,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')"+market;
	if(!area.equals("")){ weixiuQuery = "select top 20 id,title,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')"+market;}
	List<Map> weixiuList = null;
	List <Map> list=null;
	//if(area.equals("")){
    pageBean.setPageSize(15); 
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("id,title,add_date");
	pageBean.setTableName("pro_weixiu_info");
	pageBean.setOrderBy(" id desc"); // 点击量排序
	list = pageBean.getDatas(connection);
	//}
	//TDK
	String title="【工程机械维修】工程机械维修知识大全_工程机械维修论坛 - 铁臂维修";
	String keywords="工程机械维修,工程机械维修知识,工程机械维修论坛";
	String description="铁臂维修提供大量的工程机械维修方法,帮助您快速解决工程机械故障维修难题，买工程机械就上铁臂商城。";
	String fullName=""; String TDK="";
	String cataName="工程机械";if(!catalog.equals("")){cataName=CommonString.getFormatPara(catalogMap.get(catalog));}
	TDK=CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+cataName;
	if(!factoryid.equals("")||!catalog.equals("")||!area.equals("")){
	if(!factoryid.equals("")&&!catalog.equals("")){
	title=TDK.replace("卡特彼勒","卡特")+"维修_"+TDK.replace("卡特彼勒","卡特")+"维修保养_"+TDK.replace("卡特彼勒","卡特")+"维修大全 - 铁臂维修";
	keywords=TDK.replace("卡特彼勒","卡特")+"维修,"+TDK.replace("卡特彼勒","卡特")+"维修知识,"+TDK.replace("卡特彼勒","卡特")+"维修论坛";
	description="铁臂维修提供大量的"+TDK.replace("卡特彼勒","卡特")+"维修方法,帮助您快速解决"+TDK.replace("卡特彼勒","卡特")+"故障维修难题，买工程机械就上铁臂商城。";
	fullName=(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+cataName);
	}else{
	title=TDK+"维修_"+TDK+"维修保养_"+TDK+"维修大全 - 铁臂维修";
	keywords=TDK+"维修,"+TDK+"维修知识,"+TDK+"维修论坛";
	description="铁臂维修提供大量的"+TDK+"维修方法,帮助您快速解决"+TDK+"故障维修难题，买工程机械就上铁臂商城。";
	fullName=(CommonString.getFormatPara(areaMap.get(area))+CommonString.getFormatPara(brandMap.get(factoryid))+cataName);
	}
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
  <h3 class="breadCrumbs">
    <a href="http://weixiu.21-sun.com/">铁臂维修</a><%if(area.equals("")&&catalog.equals("")&&factoryid.equals("")){%> &gt;&gt; <a href="/knowledge/">维修知识大全</a><%}%>
    
	<%="".equals(area)?"":" &gt;&gt; <a href='/0-"+area+"-0.htm'>"+CommonString.getFormatPara(areaMap.get(area)) +"</a>"%>
    <%="".equals(factoryid)?"":" &gt;&gt; <a href='/0-0-"+factoryid+".htm'>"+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +"</a>"%>
	<%="".equals(catalog)?"":" &gt;&gt; <a href='/"+catalog+"-0-0.htm'>"+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) +"</a>"%>
	<%=((!"".equals(catalog)&&!"".equals(factoryid))||(!"".equals(factoryid)&&!"".equals(area))||(!"".equals(area)&&!"".equals(catalog)))?" &gt;&gt; "+CommonString.getFormatPara(areaMap.get(area))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))):""%>
	<%=("".equals(factoryid)&&"".equals(catalog)&&"".equals(area))?"":" &gt;&gt; "+CommonString.getFormatPara(areaMap.get(area))+(!"".equals(factoryid)&&"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)):"")+(!"".equals(factoryid)&&!"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"):"") +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))+"维修"%>
	</h3>
</div>
<div class="contain980 clearfix">
  <!--left-->
  <div class="nre_left">
      <%if(catalog.equals("")&&factoryid.equals("")){%>
	     <jsp:include page="/include/weixiu/left_pro_list.jsp" flush="true">
	            <jsp:param value="<%=areaName%>" name="areaName"/>
	            <jsp:param value="<%=area%>" name="area"/>
                <jsp:param value="<%=factoryid%>" name="factoryid"/>
         </jsp:include>
		  <jsp:include page="/include/weixiu/left_factory_list.jsp" flush="true" >
	  	        <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=area%>" name="area"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
         </jsp:include>
	  <%}%>
      <!--产品-->
	  <%if(catalog.equals("")&&!factoryid.equals("")){%>
      <jsp:include page="/include/weixiu/left_pro_list.jsp" flush="true">
	            <jsp:param value="<%=areaName%>" name="areaName"/>
	            <jsp:param value="<%=area%>" name="area"/>
                <jsp:param value="<%=factoryid%>" name="factoryid"/>
      </jsp:include>
	  <%}%>
	  <!--品牌-->
	   <%if(factoryid.equals("")&&!catalog.equals("")){%>
	  <jsp:include page="/include/weixiu/left_factory_list.jsp" flush="true" >
	  	        <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=area%>" name="area"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
      </jsp:include>
	   <%}%>
	  <!--产品品牌-->
	  <%
	  String cataNum="";
	  if(!catalog.equals("")&&!factoryid.equals("")){
	   if(catalog.length()>3){cataNum=catalog.substring(0,3);}else{cataNum=catalog;}
	  %>
	  	  <jsp:include page="/include/weixiu/left_cata_list.jsp" flush="true" >
	  	        <jsp:param value="<%=cataNum%>" name="cataNum"/>
                <jsp:param value="<%=area%>" name="area"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
          </jsp:include>
		  
		  <jsp:include page="/include/weixiu/left_factory_list.jsp" flush="true" >
	  	        <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=area%>" name="area"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
           </jsp:include>
	  <%}%>
	  <!--区域-->
   
      <jsp:include page="/include/weixiu/left_area_list.jsp" flush="true">
	  	  	    <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=factoryid%>" name="factoryid"/>
	  </jsp:include>

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
            <a href="/knowledge/" > <span class="reset">重置</span></a>
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
          <h1 class="r" style="font-size:14px;"><%=CommonString.getFormatPara(areaMap.get(area))%><%="".equals(catalog+factoryid)?"工程机械":""%><%=showtonandmeter%><%=!"".equals(factoryid)&&!"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"):""%><%=!"".equals(factoryid)&&"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)):""%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修大全</h1>
        </div>
        <ul class="ConditionBottom">
      <script type="text/javascript">
	  jQuery(document).ready(function(){
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
        <h3><%=CommonString.getFormatPara(areaMap.get(area))%><%="".equals(catalog+factoryid)?"工程机械":""%><%=!"".equals(factoryid)&&!"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"):""%><%=!"".equals(factoryid)&&"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)):""%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修</h3><a style="float:right;display: inline-block;font-weight: bold;color: #fff;background: #f60;width:65px;text-align:center" class="_btn" href="/knowledge_edit.jsp">我要投稿</a>
      </div>
      <div class="content r_add">
        <ul class="list blue">
          <%
			if(list!=null&&list.size()>=0){
				for(Map m : list){
		%>
          <li>
            <h3 style="width:450px">
			<span class="lb">
			<%if(!catalog.equals("")&&factoryid.equals("")&&area.equals("")){%><a href="/weixiu/detail.jsp?catalog=<%=catalog%>" title="<%=fullName%>维修" style="color: #ff6600;">[<%=fullName%>维修]</a><%}else{%><a href="/<%=catalog.equals("")?"0":catalog%>-<%=area.equals("")?"0":area%>-<%=factoryid.equals("")?"0":factoryid%>.htm" title="<%=fullName%>维修" style="color: #ff6600">[<%=fullName%>维修]</a><%}%>
			</span>
			<a target="_blank" href="/info_<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank" title="<%=areaName+CommonString.getFormatPara(m.get("title")) %>"><%=areaName+CommonString.getFormatPara(m.get("title")) %></a></h3>
            <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(m.get("add_date")))%></span> </li>
          <%}%>
          <%if((list==null||list.size()<=0)){%>
          <div align="center">暂无相关信息</div>
          <%}}%>
        </ul>
      </div>
    </div>
	
	<div id="pagination" class="paging page" style="display:none">
    <tags:page_weixiu_info pageBean="<%=pageBean%>" />
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
 <!--首页默认显示的热门挖掘机和装载机厂家--> 
<%if(catalog.equals("")&&factoryid.equals("")&&area.equals("")){%>  
<style>
.allCatalog .list li {width: 113px;}
</style>
    <div class="allCatalog">
 
  	<ul class="list" style="border-width: 0 0px 1px 0px;">
      <li><a title="徐工挖掘机维修" href="/101001-0-209.htm">徐工挖掘机维修</a></li>
      <li><a title="三一挖掘机维修" href="/101001-0-133.htm">三一挖掘机维修</a></li>
      <li><a title="小松挖掘机维修" href="/101001-0-182.htm">小松挖掘机维修</a></li>
      <li><a title="柳工挖掘机维修" href="/101001-0-136.htm">柳工挖掘机维修</a></li>
      <li><a title="中联重科挖掘机维修" href="/101001-0-134.htm">中联重科挖掘机维修</a></li>
      <li><a title="斗山挖掘机维修" href="/101001-0-192.htm">斗山挖掘机维修</a></li>
      <li><a title="卡特彼勒挖掘机维修" href="/101001-0-174.htm">卡特彼勒挖掘机维修</a></li>
      <li><a title="沃尔沃挖掘机维修" href="/101001-0-175.htm">沃尔沃挖掘机维修</a></li>
      <li><a title="福田雷沃挖掘机维修" href="/101001-0-141.htm">福田雷沃挖掘机维修</a></li>
      <li><a title="日立挖掘机维修" href="/101001-0-184.htm">日立挖掘机维修</a></li>
      <li><a title="龙工挖掘机维修" href="/101001-0-135.htm">龙工挖掘机维修</a></li>
      <li><a title="厦工挖掘机维修" href="/101001-0-139.htm">厦工挖掘机维修</a></li>
      <li><a title="神钢挖掘机维修" href="/101001-0-183.htm">神钢挖掘机维修</a></li>
      <li><a title="利勃海尔挖掘机维修" href="/101001-0-179.htm">利勃海尔挖掘机维修</a></li>
      <li><a title="山河智能挖掘机维修" href="/101001-0-142.htm">山河智能挖掘机维修</a></li>
      <li><a title="山东临工挖掘机维修" href="/101001-0-137.htm">山东临工挖掘机维修</a></li>

    </ul>
  </div>




    <div class="allCatalog" style="padding-top:5px;padding-bottom:5px;">
 
  	<ul class="list" style="border-width: 0 0px 0px 0px;">
      <li><a title="徐工装载机维修" href="/101002-0-209.htm">徐工装载机维修</a></li>
      <li><a title="三一装载机维修" href="/101002-0-133.htm">三一装载机维修</a></li>
      <li><a title="小松装载机维修" href="/101002-0-182.htm">小松装载机维修</a></li>
      <li><a title="柳工装载机维修" href="/101002-0-136.htm">柳工装载机维修</a></li>
      <li><a title="中联重科装载机维修" href="/101002-0-134.htm">中联重科装载机维修</a></li>
      <li><a title="斗山装载机维修" href="/101002-0-192.htm">斗山装载机维修</a></li>
      <li><a title="卡特彼勒装载机维修" href="/101002-0-174.htm">卡特彼勒装载机维修</a></li>
      <li><a title="沃尔沃装载机维修" href="/101002-0-175.htm">沃尔沃装载机维修</a></li>
      <li><a title="福田雷沃装载机维修" href="/101002-0-141.htm">福田雷沃装载机维修</a></li>
      <li><a title="日立装载机维修" href="/101002-0-184.htm">日立装载机维修</a></li>
      <li><a title="龙工装载机维修" href="/101002-0-135.htm">龙工装载机维修</a></li>
      <li><a title="厦工装载机维修" href="/101002-0-139.htm">厦工装载机维修</a></li>
      <li><a title="利勃海尔装载机维修" href="/101002-0-179.htm">利勃海尔装载机维修</a></li>
      <li><a title="山河智能装载机维修" href="/101002-0-142.htm">山河智能装载机维修</a></li>
      <li><a title="山东临工装载机维修" href="/101002-0-137.htm">山东临工装载机维修</a></li>
      <li><a title="山推装载机维修" href="/101002-0-144.htm">山推装载机维修</a></li>

    </ul>
  </div>

<%}%>
<%
    String catalogname="";
	String factoryname="";
    if(!catalog.equals("")){
    catalogname=CommonString.getFormatPara(catalogMap.get(catalog));
%>
<!--副导航-->
    <div class="new_v_foot_list" style="height:125px;overflow:hidden;" id="morebrand">
    <div class="adnf_title">更多品牌<%=catalogname %>维修<a style="float:right" onclick="showmore();">更多</a></div>
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
<jsp:include page="/include/koubei_ad.jsp" flush="false"/>

<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
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

function showmore(){
var m = $("#morebrand");  
m.css("height","auto"); 
}

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