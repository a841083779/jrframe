<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String province = CommonString.getFilterStr(request.getParameter("province")) ;
    String city = CommonString.getFilterStr(request.getParameter("city")) ;
	
	if(!"".equals(factory) && "".equals(factoryid)){
		factoryid = factory ;
	}
	if(!"".equals(catalogid) && "".equals(catalog)){
		catalog = catalogid ;
	}
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
    Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String url = CommonString.getFormatPara(request.getQueryString()) ;
	String showtonandmeter = "";
	if ("grab_1_13".equals(tonandmeter)) {
		showtonandmeter = "小挖(1T~13T)";
	} else if ("grab_14_30".equals(tonandmeter)) {
		showtonandmeter = "中挖(14T~30T)";
	} else if ("grab_30_1".equals(tonandmeter)) {
		showtonandmeter = "大挖(30T以上)";
	} else if ("loader_1_3".equals(tonandmeter)) {
		showtonandmeter = "3T以下";
	} else if ("loader_3_01".equals(tonandmeter)) {
		showtonandmeter = "3T";
	} else if ("loader_3_5".equals(tonandmeter)) {
		showtonandmeter = "3T~5T";
	} else if ("crane_1_16".equals(tonandmeter)) {
		showtonandmeter = "16T以下";
	} else if ("crane_20_70".equals(tonandmeter)) {
		showtonandmeter = "20T~70T";
	} else if ("crane_70_1".equals(tonandmeter)) {
		showtonandmeter = "70T以上";
	} else {
		showtonandmeter = "";
	}
	
   //搜索条件
   	String whereStr = " and flag = 2 and is_show = 1 ";
	String brand =factoryid;           //品牌
    String model =catalog;          //类别
	//如果有品牌，首先查询出该品牌的全部代理商
	if(!"".equals(brand)){
			whereStr += " and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) ";
		//	whereStr += " and agent_fac in  ( '"+brand+"' ) ";
	}
	//如果有代理类型
	if(!"".equals(model)){
				whereStr += " and id in ( ";
				whereStr += " select distinct agent_id from pro_agent_products ";
				whereStr += " where product_id in ( select id from pro_products where catalognum like '"+model+"%' and is_show = 1 ) ";
				whereStr += " ) ";   
	}
    String orderByStr = " id desc";
   //拆分吨位
	String[] parttonandmeters = null;
	String firsttonandmeter = "";
	String sectonandmeter = "";
	        PageBean pageBean = new PageBean();
			Integer nowPage = 1 ;
		    if(!"".equals(offset) && !"0".equals(offset)){
	             nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	        }
	//TDK
	String title="【维修网点】工程机械维修中心_工程机械售后服务 - 铁臂维修";
	String keywords="工程机械维修网点,工程机械维修中心,工程机械售后服务,铁臂维修";
	String description="铁臂维修包括所有工程机械品牌的维修网点，帮助您快速解决工程机械故障难题，买工程机械就上铁臂商城。";
    try{	
	        connection = dbHelper.getConnection();
			pageBean.setTableName("pro_agent_factory");  
			pageBean.setFields("id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made");
			pageBean.setCondition(whereStr);
			pageBean.setIsShowSql(true);
			pageBean.setOrderBy(orderByStr);
			pageBean.setNowPage(nowPage);
			pageBean.setPageSize(18);
			List<Map> agents = pageBean.getDatas(connection);
			//查询省市
		    List<Map> provinceList = dbHelper.getMapList(" select * from hz_py where province='0' order by id asc ",connection) ;
			List <Map> sanylist=null;
			List <Map> catlist=null;
			List <Map> xcmglist=null;
			List <Map> zoomlionlist=null;
			List <Map> volvolist=null;
			if(factoryid.equals("")&&catalog.equals("")){
			//三一代理商
			String sql_sany = " select top 9 full_name,is_qijiandian,is_made,usern from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%133%' order by view_count desc";
			sanylist= (List <Map>)dbHelper.getMapList(sql_sany,new Object[]{});
			//卡特代理商
			String sql_cat = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%174%'  order by view_count desc";
			catlist= (List <Map>)dbHelper.getMapList(sql_cat,new Object[]{});		   
		   //徐工代理商
			String sql_xcmg = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%209%'  order by view_count desc";
			xcmglist= (List <Map>)dbHelper.getMapList(sql_xcmg,new Object[]{});		   
			//中联代理商
			String sql_zoomlion = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%134%'  order by view_count desc";
			zoomlionlist= (List <Map>)dbHelper.getMapList(sql_zoomlion,new Object[]{});		   
			//沃尔沃代理商
			String sql_volvo = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%175%'  order by view_count desc";
      		volvolist= (List <Map>)dbHelper.getMapList(sql_volvo,new Object[]{});		   
			}
			
			if(!factoryid.equals("")||!catalog.equals("")){
		    title="【电话】"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修网点_"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修中心_"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修 - 铁臂维修";
			keywords=(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"地维修网点,"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修中心,铁臂维修";
			description="铁臂维修包括"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修网点，帮您快速解决"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"维修问题，买"+(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
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
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs">铁臂维修
      <%="".equals(factoryid)?"":" &gt;&gt; <a href='/weixiu/network.jsp?factory="+factoryid+"'>"+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +"</a>"%>
  <%="".equals(catalog)?"":" &gt;&gt; <a href='/weixiu/network.jsp?catalog="+catalog+"'>"+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) +"</a>"%>
  <%=("".equals(catalog)||"".equals(factoryid))?"":" &gt;&gt; "+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))%>
   <%=("".equals(catalog)&&"".equals(factoryid))?"":" &gt;&gt; "+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))+"维修网点"%></h3>
  
</div>
<div class="contain980 clearfix">
  <!--left-->
  <div class="nre_left">
    <!--最新产品口碑开始-->
    <jsp:include page="/include/weixiu/koubei_list.jsp" flush="true">
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
    <jsp:param name="catalognum" value="<%=catalogid%>"></jsp:param>
    </jsp:include>
    <!--最新产品口碑结束-->
    <!--维修视频开始-->
    <jsp:include page="/include/weixiu/video_list.jsp" flush="true">
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
    <jsp:param name="catalognum" value="<%=catalogid%>"></jsp:param>
    </jsp:include>
    <!--维修视频结束-->
  </div>
  <!--left end-->
  <!--right-->
  <div class="nre_right">
    <!--分类查找-->
    <form name="theform" id="theform">
      <div class="border03 l Condition mb10 nwx_net_sea">
        <div class="ConditionTop">
          <div class="l">
            <%if (!"".equals(catalog) || !"".equals(factoryid)) {%>
            <a href="/weixiu/network.jsp"> <span class="reset">重置</span></a>
            <%}%>
            <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("","<%=factoryid%>","","","<%=order%>")'></a> </span>
            <%}%>
            <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
            <%}%>
            <%if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {%>
            <span><em><%=showtonandmeter%></em>
             <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
            <%}%>
          </div>
          <h1 class="r" style="font-size:14px;"><%="".equals(catalog+factoryid)?"工程机械":""%><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修网点</h1>
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
	  
	  	  <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province)) ){%>
      <li class="cblist">
        <dt> 省份 </dt>
        <dd> <a href="" <%if("0".equals(province)||"".equals(province)){%> class='select' <%} %>>不限</a>
       		<%for(Map provinceInfo : provinceList) {%>
			<a href="<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-<%=catalog.equals("")?"0":catalog%>.htm" <%if(CommonString.getFormatPara(provinceInfo.get("pinyin")).equals(province)){%> class='select' <%} %>><%=CommonString.getFormatPara(provinceInfo.get("hanzi"))%></a> 
            <%}%>
      </li>
	  <%}%>
	  
	  <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province))){}else{%>
      <li class="cblist" id="city" <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province))){%>style="display:none"<%}%>>
        <dt> 城市 </dt>
		<%for(Map provinceInfo : provinceList) {%>
        <dd id="<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>" class="city" <%if(province.equals(CommonString.getFormatPara(provinceInfo.get("pinyin"))) ){%> style="display:block;"<%}else{%> style="display:none;"   <%}%>>
		<%
		  List<Map> cityList = dbHelper.getMapList(" select * from hz_py where province='"+CommonString.getFormatPara(provinceInfo.get("hanzi"))+"' order by id desc ",connection) ;
           if(cityList.size()>0){	
   		      	for(Map cityeInfo : cityList) {
		%>
		<a href="##"><%=CommonString.getFormatPara(cityeInfo.get("hanzi"))%></a> 
		<%}}else{%>
		    
		<%}%>
		</dd>
        <%}%>	
      </li>
	  <%}%>
	  
          <li class="cblist">
            <dt> 类别 </dt>
            <input type="hidden" name="factory" id="factory_id" />
            <input type="hidden" name="catalog" id="catalognum" />
            <dd> 

       <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101001.htm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
            <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101002.htm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a>
             <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-102.htm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a>
              <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101003.htm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
              <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-103.htm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a>
               <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-106001.htm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a>
                <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101005.htm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a>
                 <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-105003.htm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a>
                  <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-113001.htm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a>
                   <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-104001.htm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
                    <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-107.htm" <%if("107".equals(catalog)){%> class='select' <%} %>>叉车</a>
                     <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-104.htm" <%if("1040".equals(catalog)){%> class='select' <%} %>>筑养路</a> 
                     <a href="/weixiu/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-105.htm" <%if("105".equals(catalog)){%> class='select' <%} %>>桩工</a>
			<div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
           <jsp:include page="/include/products/catalog.jsp" flush="true">
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
              <a onclick="sosuo('<%=catalog%>','','<%=tonandmeter%>');" href="javascript:void(0)" <%if("".equals(factoryid)){%>  class="select" <%} %>>不限</a>
              <% List<Map> recommend_brands = dbHelper.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog+ "' order by order_no desc",connection);
				if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 11) {
																break;
															}
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
              <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/weixiu/network.jsp">不限</a>
              <!-- 挖掘机 -->
              <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/weixiu/network.jsp?factory=133<%=catalog.equals("")?"":"&catalog="+catalog%>">三一</a>
              <!-- 挖掘机 -->
              <a <%if("182".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=182<%=catalog.equals("")?"":"&catalog="+catalog%>">小松</a>
              <!-- 挖掘机 -->
              <a <%if("192".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=192<%=catalog.equals("")?"":"&catalog="+catalog%>">斗山</a>
              <!-- 挖掘机 -->
              <a <%if("184".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=184<%=catalog.equals("")?"":"&catalog="+catalog%>">日立</a>
              <!-- 挖掘机 -->
              <a <%if("183".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=183<%=catalog.equals("")?"":"&catalog="+catalog%>">神钢</a>
              <!-- 挖掘机 -->
              <a <%if("175".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=175<%=catalog.equals("")?"":"&catalog="+catalog%>">沃尔沃</a>
              <!-- 挖掘机 -->
              <a <%if("174".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=174<%=catalog.equals("")?"":"&catalog="+catalog%>">卡特彼勒</a>
              <!-- 挖掘机 -->
              <a <%if("146".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=146<%=catalog.equals("")?"":"&catalog="+catalog%>">玉柴重工</a>
              <!-- 挖掘机 -->
              <a <%if("136".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=136<%=catalog.equals("")?"":"&catalog="+catalog%>">柳工</a>
              <!-- 挖掘机 -->
              <a <%if("194".equals(factoryid)){%>
											class='select' <%} %> href="/weixiu/network.jsp?factory=194<%=catalog.equals("")?"":"&catalog="+catalog%>">现代京城</a>
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
        <input type="hidden" name="keyword" id="key_word" />
      </div>
    </form>
    <!--分类查找结束-->
    <!--网点-->
	<%if(factoryid.equals("")&&catalog.equals("")){%>
    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>三一维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
   <%
     if(sanylist != null && sanylist.size() > 0){
  	    for(int i = 0;i < sanylist.size(); i++){
  %>
<%if(CommonString.getFormatPara(sanylist.get(i).get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(sanylist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentstore/<%=CommonString.getFormatPara(sanylist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(sanylist.get(i).get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(sanylist.get(i).get("is_made")).equals("1")){%>
<li><a href="http://<%=CommonString.getFormatPara(sanylist.get(i).get("usern"))%>.product.21-sun.com" target="_blank" title="<%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(sanylist.get(i).get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(sanylist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentshop02/<%=CommonString.getFormatPara(sanylist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%></a></li>
<%}else{%>
<li><a href="/agent/<%=CommonString.getFormatPara(sanylist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(sanylist.get(i).get("full_name"))%></a></li>
<%}%>
       <%} }%>
        </ul>
      </div>
    </div>
	
    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>卡特维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
   <%
     if(catlist != null && catlist.size() > 0){
  	for(int i = 0;i < catlist.size(); i++){
  %>
<%if(CommonString.getFormatPara(catlist.get(i).get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(catlist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentstore/<%=CommonString.getFormatPara(catlist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(catlist.get(i).get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(catlist.get(i).get("is_made")).equals("1")){%>
<li><a href="http://<%=CommonString.getFormatPara(catlist.get(i).get("usern"))%>.product.21-sun.com" target="_blank" title="<%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(catlist.get(i).get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(catlist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentshop02/<%=CommonString.getFormatPara(catlist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%></a></li>
<%}else{%>
<li><a href="/agent/<%=CommonString.getFormatPara(catlist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(catlist.get(i).get("full_name"))%></a></li>
<%}%>
       <%} }%>
        </ul>
      </div>
    </div>
	
	    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>徐工维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
   <%
     if(xcmglist != null && xcmglist.size() > 0){
  	for(int i = 0;i < xcmglist.size(); i++){
  %>
<%if(CommonString.getFormatPara(xcmglist.get(i).get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(xcmglist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentstore/<%=CommonString.getFormatPara(xcmglist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(xcmglist.get(i).get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(xcmglist.get(i).get("is_made")).equals("1")){%>
<li><a href="http://<%=CommonString.getFormatPara(xcmglist.get(i).get("usern"))%>.product.21-sun.com" target="_blank" title="<%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(xcmglist.get(i).get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(xcmglist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentshop02/<%=CommonString.getFormatPara(xcmglist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%></a></li>
<%}else{%>
<li><a href="/agent/<%=CommonString.getFormatPara(xcmglist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(xcmglist.get(i).get("full_name"))%></a></li>
<%}%>
       <%} }%>
        </ul>
      </div>
    </div>
	
	    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>中联维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
   <%
     if(zoomlionlist != null && zoomlionlist.size() > 0){
  	for(int i = 0;i < zoomlionlist.size(); i++){
  %>
<%if(CommonString.getFormatPara(zoomlionlist.get(i).get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(zoomlionlist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentstore/<%=CommonString.getFormatPara(zoomlionlist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(zoomlionlist.get(i).get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(zoomlionlist.get(i).get("is_made")).equals("1")){%>
<li><a href="http://<%=CommonString.getFormatPara(zoomlionlist.get(i).get("usern"))%>.product.21-sun.com" target="_blank" title="<%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(zoomlionlist.get(i).get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(zoomlionlist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentshop02/<%=CommonString.getFormatPara(zoomlionlist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%></a></li>
<%}else{%>
<li><a href="/agent/<%=CommonString.getFormatPara(zoomlionlist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(zoomlionlist.get(i).get("full_name"))%></a></li>
<%}%>
  <%} }%>
        </ul>
      </div>
    </div>
	
	    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>沃尔沃维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
   <%
     if(volvolist != null && volvolist.size() > 0){
  	for(int i = 0;i < volvolist.size(); i++){
  %>
<%if(CommonString.getFormatPara(volvolist.get(i).get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(volvolist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentstore/<%=CommonString.getFormatPara(volvolist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(volvolist.get(i).get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(volvolist.get(i).get("is_made")).equals("1")){%>
<li><a href="http://<%=CommonString.getFormatPara(volvolist.get(i).get("usern"))%>.product.21-sun.com" target="_blank" title="<%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(volvolist.get(i).get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(volvolist.get(i).get("is_made")).equals("1")){%>
<li><a href="/agentshop02/<%=CommonString.getFormatPara(volvolist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%></a></li>
<%}else{%>
<li><a href="/agent/<%=CommonString.getFormatPara(volvolist.get(i).get("usern"))%>/" target="_blank" title="<%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%>"><%=CommonString.getFormatPara(volvolist.get(i).get("full_name"))%></a></li>
<%}%>
       <%} }%>
        </ul>
      </div>
    </div>
	
	<%}else{%>
                       <ul style="display:none"><li> <a class="selected" href="">工程机械代理商</a> </li></ul>
                       <ul class="agent_ti" style="width:725px;">
                          <li class="g1">代理商</li>
                          <li class="g2">代理区域</li>
                          <li class="g3" style="width:135px;">主营品牌</li>
                          <li class="g5">联系电话</li>
                       </ul>
<div class="agent_li" style="height: auto;width:725px;">
     <%
        if(null !=agents && agents.size()>0){
		int i=0;
		for(Map oneMap:agents){
		
	%>
<ul style="width:725px;"  class="libg0<%=((i%2)+1)%>">
<%if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
<li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
<li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://<%=CommonString.getFormatPara(oneMap.get("usern"))%>.product.21-sun.com" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
<%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
<li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
<%}else{%>
<li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
<%}%>
<li class="g2"><span title="<%=CommonString.getFormatPara(oneMap.get("city"))%>"><%=CommonString.getFormatPara(oneMap.get("city"))%></span></li>
<li class="g3" style="width:135px;"><span title="<%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%>"><%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%></span></li>
<li class="g5" style="overflow:hidden;"><a id="seePhone_<%=CommonString.getFormatPara(oneMap.get("id"))%>" href="javascript:void(0);" onclick="lianXiDianHua('<%=CommonString.getFormatPara(oneMap.get("id"))%>');">点击查看联系电话</a></li>
</ul>
<%i++;}}%>
</div>
	
	<%}%>
    <!--网点结束-->
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
    var nowBrand = '<%=factoryid %>';
	var nowCatalog = '<%=catalog %>';
	var nowBrandName = '';
	var nowCatalogName = '';
	var nowProvince = '';
	var nowCity = '';
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

	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		var xunjia_phone = jQuery.cookies.get("xunjia_phone");
		var xunjia_catalog = jQuery.cookies.get("xunjia_catalog");
		var xunjia_catalog_name = jQuery.cookies.get("xunjia_catalog_name");
		var xunjia_brand = jQuery.cookies.get("xunjia_brand");
		var xunjia_brand_name = jQuery.cookies.get("xunjia_brand_name");
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
			name : xunjia_user,
			mobile_phone : xunjia_phone,
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			id : id
		},function(data){
			jQuery("#seePhone_"+id).addClass("gcur");
			jQuery("#seePhone_"+id).html(data);
			jQuery("#seePhone_"+id).attr("tip_title",data);
			jQuery("#seePhone_"+id).removeAttr("onclick");
			jQuery("#seePhone_"+id).yitip();
			var singleTitleTip = jQuery("#seePhone_"+id).yitip("api");
			singleTitleTip.setPosition("rightMiddle");
		});
	}
	function lianXiDianHua(id){
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
	
		function zaiXianXunJia(id){
		var url = '/include/agent/enquiry.jsp?id='+id;
		if(nowBrand!=''){
			url += "&nowBrand="+nowBrand;
		}
		if(nowBrandName!=''){
			url += "&nowBrandName="+nowBrandName;
		}
		if(nowCatalog!=''){
			url += "&nowCatalog="+nowCatalog;
		}
		if(nowCatalogName!=''){
			url += "&nowCatalogName="+nowCatalogName;
		}
		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 380,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>