<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
	<cache:cache  cron="* * * */1 *">
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	
	//获取处理参数部分
	Integer cityCount = 0;
	Integer provinceCount = 0;
	String fp = "0";
	String factoryid = CommonString.getFilterStr(request.getParameter("factoryid")) ;
	String isAuto = CommonString.getFormatPara(request.getParameter("isAuto"));
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
    factoryid = factoryid.replace("-", "").trim();
    if(factoryid.equals("")){
  	   factoryid = CommonString.getFormatPara(request.getParameter("factoryid")).replace("-", "").trim();
     }
    String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
    catalog = catalog.replace("-", "").trim();
    Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String order = CommonString.getFormatPara(request.getParameter("order"));
	Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
    Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;
    String province = CommonString.getFilterStr(request.getParameter("province"));
	String city = CommonString.getFilterStr(request.getParameter("city"));
    if("0".equals(catalog)){catalog="";}
    if("0".equals(factoryid)){factoryid="";}
	String brand=factoryid;
    if("0".equals(province)){province="";}
    if("0".equals(city)){city="";}
	String search_province="";
	String search_city="";
	
	try{
		connection = dbHelper.getConnection();
		if(!province.equals("")){search_province = (String)hzpyMap.get(province);}
	    if(!city.equals("")){search_city = (String)hzpyMap.get(city);}
				
		List<Map> provinceList = dbHelper.getMapList(" select hanzi,pinyin from hz_py where province='0' order by id asc ",connection) ;
		//根据产品查询品牌
		List<Map> brandList=null;
		if(!"".equals(catalog)){
		brandList= dbHelper.getMapList("SELECT top 10 id,name,factoryid FROM (select id,name from pro_agent_factory where pro_agent_factory.flag=1  )AS b INNER  JOIN  (SELECT factoryid FROM pro_products WHERE catalognum  like '%"+catalog+"%' AND factoryid!=0 GROUP BY factoryid) AS p  ON b.id =p.factoryid  order by id asc",connection) ;
		}
		
		//TDK
		String seo=search_province+search_city+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog));
		if(seo.equals("")){seo="工程机械";}
		String seo1=search_province+search_city;
		String seo2=CommonString.getFormatPara(brandMap.get(factoryid));
		String seo3=CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog));
		String seo4="";
		if(!seo1.equals("")||!seo2.equals("")||!seo3.equals(""))
		{    
		     seo4+=seo+"代理商,";
		     if(!seo1.equals("")&&!seo1.equals(seo)){seo4+=seo1+"代理商,";}
			 if(!seo2.equals("")&&!seo2.equals(seo)){seo4+=seo2+"代理商,";}
			 if(!seo3.equals("")&&!seo3.equals(seo)){seo4+=seo3+"代理商,";}
			 seo4+="代理商";
		}else{
		     seo4="工程机械代理商,工程机械代理商信息,工程机械,代理商";
		}
		
		    //分页查询
		    String whereStr = " and flag = 2 and is_show = 1 ";
		    //如果有代理类型
			if(!"".equals(catalog)){
				whereStr += " and id in ( ";
				whereStr += " select distinct agent_id from pro_agent_products ";
				whereStr += " where product_id in ( select id from pro_products where catalognum like '"+catalog+"%' and is_show = 1 ) ";
				whereStr += " ) ";   
			}
			//如果有品牌，首先查询出该品牌的全部代理商
			if(!"".equals(brand)){
			 	whereStr += " and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) ";
			}	
			//省份
			if(!"".equals(search_province)){
				whereStr += " and (address like '%"+search_province+"%' or full_name like '%"+search_province+"%' or city like '%"+search_province+"%')";  
			}		
			//城市	
			if(!"".equals(search_city)){
				whereStr += " and (address like '%"+search_city.replace("市","")+"%' or full_name like '%"+search_city.replace("市","")+"%' or city like '%"+search_city.replace("市","")+"%')";  
			}
			String orderByStr = " is_shop desc,flag ASC , name DESC , id DESC ";
		PageBean pageBean = new PageBean() ;
        pageBean.setPageSize(10) ;
        Integer nowPage = 1 ;
        if(!"".equals(offset) && !"0".equals(offset)){
	       nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
        }
        pageBean.setNowPage(nowPage) ;
        pageBean.setOrderBy(orderByStr) ;
        pageBean.setTableName("pro_agent_factory");
        pageBean.setFields("id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made");		
        pageBean.setCondition(whereStr.toString());
        		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【电话】<%=seo%>代理商_<%=seo%>代理商信息大全 - 铁臂商城</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=seo4%>" />
<meta name="description" content="寻找【<%=seo%>代理商】请上铁臂商城。铁臂商城拥有全国各个地区的代理商信息,是<%=seo%>最全的代理商平台。 " /> 
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../scripts/scripts.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="../scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<script>

</script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">  <a href="/">铁臂商城</a> &gt;&gt; <a href="/agent/">代理商专区</a>
   <%="".equals(search_province+search_city)?"":" &gt;&gt; <a href='/agent/"+(province.equals("")?"0":province)+"_"+(city.equals("")?"0":city)+"_0_0.shtm'>"+search_province+search_city+"</a>"%> 
		<%="".equals(catalog)?"".equals(factoryid)?"":" &gt;&gt; "+ CommonString.getFormatPara(brandMap.get(factoryid)): "".equals(factoryid)?"":" &gt;&gt; <a href='/agent/0_0_"+(factoryid.equals("")?"0":factoryid)+"_0.shtm'>"+CommonString.getFormatPara(brandMap.get(factoryid))+"</a>"%> 
        <a href="/agent/0_0_0_<%=catalog.equals("")?"0":catalog%>.shtm"><%="".equals(catalog)?"":" &gt;&gt; "+CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))%></a>
         <a href="/agent/<%=(province.equals("")?"0":province)%>_<%=(city.equals("")?"0":city)%>_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>.shtm">
		<%if((!(search_province+search_city).equals(""))||!factoryid.equals("")){%>
		<%="".equals(catalog)?"":" &gt;&gt; "+((search_province+search_city).equals("")?"":(search_province+search_city))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))%>
		 <%}%>
		 </a> 
 <%="".equals(catalog)?"":" &gt;&gt; "+((search_province+search_city).equals("")?"":(search_province+search_city))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))+"代理商"%>
  </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10" style="margin-bottom: 0px;">
<!--left-->

	<jsp:include page="/include/agent/left_agent.jsp" flush="true"></jsp:include>
<!--left end--> 
<!--right-->
<div class="w757 r mb10">

  <div class="w755 border03 l Condition mb10">
    <div class="ConditionTop">
      <div class="l">
        <%if (!"".equals(catalog) || !"".equals(factoryid)) {%>
        <span class="reset" ><a href="/agent/">重置</a></span>
        <%}%>
        <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
        <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/agent/<%=province.equals("0")?"":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm" title="取消" class="delete" ></a> </span>
        <%}%>
        <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
        <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="/agent/<%=province.equals("0")?"":province%>_<%=city.equals("")?"0":city%>_0_<%=catalog.equals("")?"0":catalog%>.shtm" title="取消" class="delete" ></a> </span>
        <%}%>
		<%if (!"".equals(search_province) && !"".equals(search_province)) {%>
        <span><em><%=search_province%></em> <a href="/agent/0_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>.shtm" title="取消" class="delete" ></a> </span>
        <%}%>
      </div>
      <h1 style="font-size:14px;" class="r"><%=search_province%><%=search_city%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog)&&"".equals(factoryid)?"工程机械" : CommonString.getFormatPara(catalogMap.get(catalog))%>代理商</h1>
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
        <dd> <a href="/agent/index.jsp?province=''<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%>" <%if("".equals(province)){%> class='select' <%} %>>不限</a> 
		<%for(Map provinceInfo : provinceList) {%>
		 <a    href="/agent/<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>.shtm" <%if(CommonString.getFormatPara(provinceInfo.get("pinyin")).equals(province)){%> class='select' <%} %>><%=CommonString.getFormatPara(provinceInfo.get("hanzi"))%></a> 
		 <%}%>
        </dd>
      </li>
	  <%}%>
      <li class="cblist" id="city" <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province))){%>style="display:none"<%}%> >
        <dt> 城市 </dt>
		<%for(Map provinceInfo : provinceList) {%>
       <dd id="<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>" class="city" <%if(province.equals(CommonString.getFormatPara(provinceInfo.get("pinyin")))){%> style="display:block;"<%}else{%> style="display:none;"   <%}%>> 
	   	<%
		  List<Map> cityList = dbHelper.getMapList(" select hanzi,pinyin from hz_py where province='"+CommonString.getFormatPara(provinceInfo.get("hanzi"))+"' order by id desc ",connection) ;
           if(cityList.size()>0){	
   		      	for(Map cityeInfo : cityList) {
		%>
		<a href="/agent/<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>_<%=CommonString.getFormatPara(cityeInfo.get("pinyin"))%>_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>.shtm"><%=CommonString.getFormatPara(cityeInfo.get("hanzi"))%></a>
         <%}}%>
		</dd>
		 <%}%>

		
      </li>
      <li class="cblist">
        <dt> 类别 </dt>
        <dd>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm" <%if("0".equals(catalog)||"".equals(catalog)){%> class='select' <%} %>>不限</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001.shtm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002.shtm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102.shtm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101003.shtm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103.shtm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001.shtm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101005.shtm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_105003.shtm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_113001.shtm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001.shtm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
          <div id="changethis" class="pbtn"></div>
          <div class="plmore" style="padding-left: 0px; width: 680px;;">
            <jsp:include page="/include/products/catalog_agent.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            </jsp:include>
          </div>
        </dd>
      </li>
	 <li class="cblist" id="cataDetail" style="display:none">
               <dt> </dt>
        <dd id="101001"> <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001001.shtm" >履带式挖掘机</a> 
		                 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001004.shtm" >轮式挖掘机</a> 
						 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001006.shtm" >正铲挖掘机</a>
						 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001008.shtm" >反铲挖掘机</a> 
						 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001007.shtm" >其它挖掘机</a> </dd>
        <dd id="101002"> <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002007.shtm">轮式装载机</a>
                  		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002009.shtm">滑移装载机</a> 
						<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002008.shtm">挖掘装载机</a> 
						 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002003.shtm">履带式装载机</a>
						 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002010.shtm">叉装机</a> 
						 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002004.shtm">其它装载机</a> </dd>
        <dd id="102"> <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102002.shtm">塔式起重机</a>
             		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102007.shtm">汽车起重机</a> 
					<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102008.shtm">履带式起重机</a>
					<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102006.shtm"> 随车起重机</a> </dd>
        <dd id="101003"> <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101003001.shtm"> 履带推土机</a>
		                 <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101003004.shtm"> 轮式推土机</a> </dd>
        <dd id="103"> <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103001.shtm">泵车</a> 
		              <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103017.shtm">车载泵</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103018.shtm">拖泵</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103020.shtm">输送泵</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103002.shtm">混凝土搅拌设备</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103005.shtm">混凝土布料设备</a>
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103019.shtm">混凝土搅拌运输车</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103008.shtm">干粉砂浆生产设备</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103009.shtm">粉粒物料运输车</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103015.shtm">其它混凝土设备</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103012.shtm">干混砂浆生产线</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103011.shtm">沥青砂浆车</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103014.shtm">干混砂浆背罐车</a> 
					  <a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103010.shtm">喷湿机</a>
		</dd>

		 
        <dd id="106001">
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001001.shtm">单钢轮压路机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001002.shtm">双钢轮压路机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001009.shtm">振动压路机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001005.shtm">轮胎压路机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001003.shtm">三轮压路机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001004.shtm">光轮压路机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001006.shtm">冲击式压路机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001008.shtm">静碾压路机</a> </dd>
        <dd id="104001">
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001002.shtm">履带式摊铺机</a> 
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001001.shtm">轮式摊铺机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001005.shtm">滑模摊铺机</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001004.shtm">熨平板</a>
		<a href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001006.shtm">混凝土摊铺机</a> </dd>  
      </li>
	  
	 <%if(catalog.equals("")){%> 
      <li class="cblist">
        <dt> 品牌 </dt>
        <dd>
 
          <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_0_<%=catalog.equals("")?"0":catalog%>.shtm">不限</a>
       
          <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_133_<%=catalog.equals("")?"0":catalog%>.shtm">三一</a>
     
          <a <%if("182".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_182_<%=catalog.equals("")?"0":catalog%>.shtm">小松</a>
   
          <a <%if("192".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_192_<%=catalog.equals("")?"0":catalog%>.shtm">斗山</a>

          <a <%if("184".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_184_<%=catalog.equals("")?"0":catalog%>.shtm">日立</a>
 
          <a <%if("183".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_183_<%=catalog.equals("")?"0":catalog%>.shtm">神钢</a>

          <a <%if("175".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_175_<%=catalog.equals("")?"0":catalog%>.shtm">沃尔沃</a>
       
          <a <%if("174".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_174_<%=catalog.equals("")?"0":catalog%>.shtm">卡特彼勒</a>
       
          <a <%if("146".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_146_<%=catalog.equals("")?"0":catalog%>.shtm">玉柴重工</a>
        
          <a <%if("136".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_136_<%=catalog.equals("")?"0":catalog%>.shtm">柳工</a>
         
          <a <%if("194".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_194_<%=catalog.equals("")?"0":catalog%>.shtm">现代京城</a>
		  <a <%if("1220".equals(factoryid)){%>
											class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_1220_<%=catalog.equals("")?"0":catalog%>.shtm">华通动力</a>

          <div id="changethis" class="pbtn"></div>
          <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand_agent.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            </jsp:include>
          </div>
        </dd>
      </li>
	  	  <%}else{%>
	   <li class="cblist">
        <dt> 品牌 </dt>
        <dd>
 
          <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_0_<%=catalog.equals("")?"0":catalog%>.shtm">不限</a>
	      <%    
		        if(brandList.size()>0&&brandList!=null){	
   		      	for(Map brandInfo : brandList) {
		  %>
		  <a <%if(CommonString.getFormatPara(brandInfo.get("id")).equals(factoryid)){%> class='select' <%} %> href="/agent/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=CommonString.getFormatPara(brandInfo.get("id"))%>_<%=catalog.equals("")?"0":catalog%>.shtm"><%=CommonString.getFormatPara(brandInfo.get("name"))%></a>
            <%}}%>
          <div id="changethis" class="pbtn"></div>
          <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand_agent.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            </jsp:include>
          </div>
        </dd>
      </li>
	  <%}%>
	  
	  
      <!-- 广告投放 -->
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
  </div>

  <div class="a_agent_tab">
    <ul>
      <li><a href="" class="selected"><%=search_province %><%=search_city%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "工程机械" : CommonString.getFormatPara(catalogMap.get(catalog))%>代理商</a></li>
      <li style="display: none;"><a href="#">地图查看</a></li>
    </ul>
  </div>
  <ul class="agent_ti">
    <li class="g1">代理商</li>
    <li class="g2">代理区域</li>
    <li class="g3">主营品牌</li>
    <li class="g4">在线询价</li>
    <li class="g5">联系电话</li>
  </ul>
  
  <div class="agent_li" style="height: auto">
  <!-- 代理商列表 -->
  
    <!-- 默认进来推荐一个卡特的代理商 -->
  <%if(province.equals("")&&city.equals("")&&factoryid.equals("")&&catalog.equals("")&&(offset.equals("")||offset.equals("0"))){%>
  	   <ul   class="libg02">
        <li class="g1"><a title="信昌机器工程有限公司 永安分公司" href="/agent/xcjqgcyxgsyafgs/" target="_blank">信昌机器工程有限公司 永安分公司</a></li>
        <li class="g2"><span title="福建永安">福建永安</span></li>
        <li class="g3" ><span title="卡特彼勒">卡特彼勒</span></li>
        <li class="g4"><a href="javascript:void(0);" onClick="zaiXianXunJia('8232');">在线询价</a></li>      
	  <li class="g5" style="overflow:hidden;"><a id="seePhone_8232" href="javascript:void(0);" onClick="lianXiDianHua('8232');">点击查看联系电话</a></li>
      </ul>
  <%}%>
      <%
	  List<Map> agents = pageBean.getDatas(connection);
	   if(agents.size()>0){
	   		int i=0;
		    for(Map oneMap:agents){
	 %>
	       <ul   class="libg0<%=((i%2)+1)%>">
        <%if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://<%=CommonString.getFormatPara(oneMap.get("usern"))%>.product.21-sun.com" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("3")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentshop03/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
		<%}else{%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}%>
        <li class="g2"><span title="<%=CommonString.getFormatPara(oneMap.get("city"))%>"><%=CommonString.getFormatPara(oneMap.get("city"))%></span></li>
        <li class="g3" ><span title="<%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%>"><%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%></span></li>
        <li class="g4"><a href="javascript:void(0);" onClick="zaiXianXunJia('<%=CommonString.getFormatPara(oneMap.get("id"))%>');">在线询价</a></li>      
	  <li class="g5" style="overflow:hidden;"><a id="seePhone_<%=CommonString.getFormatPara(oneMap.get("id"))%>" href="javascript:void(0);" onClick="lianXiDianHua('<%=CommonString.getFormatPara(oneMap.get("id"))%>');">点击查看联系电话</a></li>
      </ul>
      <%i++;}}%>
  </div>


		  <%
		     if("".equals(catalog)){catalog="0";}
            if("".equals(factoryid)){factoryid="0";}
            if("".equals(province)){province="0";}
            if("".equals(city)){city="0";}
		  %>
          <div class="np_fix">
          <tags:page_agent pageBean="<%=pageBean %>"   province="<%=province %>" city="<%=city %>"  factoryid="<%=factoryid%>"  catalog="<%=catalog%>" />
          </div>

    
    <script type="text/javascript">
    var nowBrand = '<%=factoryid %>';
    var nowBrandName = '';
	var nowCatalog = '<%=catalog %>';
	var nowCatalogName = '';
	var nowProvince = '<%=search_province %>';
	var nowCity = '<%=search_city %>';
  	function setHover(){
  		 jQuery(".agent_li ul").hover(function(){
			jQuery(this).toggleClass("a_hover");
		},function(){
			jQuery(this).removeClass("a_hover");
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
			province : '<%=province %>',
			city : '<%=city %>',
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
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		if(null!=xunjia_user){
			seePhone(id);
			return;
		}
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
  </script>
  
  <div class="agent_part">
    <div class="title">
      <h3>代理商推荐</h3>
      <span class="more"><a href="/">更多&gt;&gt;</a></span>
    </div>
    <div class="content">
      <ul class="hotAgent">
        <li>
          <div class="img"><a href="http://dingfengjixie.product.21-sun.com" target="_blank"><img src="http://product.21-sun.com/uploadfiles/image/2012/11/20121117113124_82.jpg" alt="浙江成峰工程机械有限公司" width="120" height="90" /></a></div>
          <h3><a href="http://dingfengjixie.product.21-sun.com" title="浙江成峰工程机械有限公司" target="_blank">浙江成峰工程机械有限</a></h3>
          <div class="a_brand"><a href="http://dingfengjixie.product.21-sun.com" title="三一" target="_blank">三一</a></div>
        </li>
        <li> 
          <div class="img"><a href="http://jzlg.product.21-sun.com" target="_blank"><img src="http://product.21-sun.com/uploadfiles/image/2012/09/20120905174729_403.jpg" alt="武汉九州龙工程机械有限公司" width="120" height="90" /></a></div>
          <h3><a href="http://jzlg.product.21-sun.com" title="武汉九州龙工程机械有限公司" target="_blank">武汉九州龙工程机械有</a></h3>
          <div class="a_brand"><a href="http://jzlg.product.21-sun.com" title="三一" target="_blank">三一</a></div>
        </li>
        <li>
          <div class="img"><a href="/agent/nmgrq/" target="_blank"><img src="http://product.21-sun.com/uploadfiles/image/2012/09/20120906101026_381.jpg" alt="内蒙古日强建筑机械有限责任公司" width="120" height="90" /></a></div>
          <h3><a href="/agent/nmgrq/" title="内蒙古日强建筑机械有限责任公司" target="_blank">内蒙古日强建筑机械有</a></h3>
          <div class="a_brand"><a href="/agent/nmgrq/" title="日立建机" target="_blank">日立建机</a></div>
        </li>
        <li>
          <div class="img"><a href="/agent/lxh/" target="_blank"><img src="http://product.21-sun.com/uploadfiles/image/2012/09/20120917115734_628.jpg" alt="利星行机械有限公司" width="120" height="90" /></a></div>
          <h3><a href="/agent/lxh/" title="利星行机械有限公司" target="_blank">利星行机械有限公司</a></h3>
          <div class="a_brand"><a href="/agent/lxh/" title="卡特彼勒" target="_blank">卡特彼勒</a></div>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="agent_part">
    <div class="title">
      <h3>品牌代理商推荐</h3>
      <span class="more"><a href="/agent/">更多&gt;&gt;</a></span>
    </div>
    <div class="content">
      <div class="agentList">
      
        <div class="al"><a title="山重代理商" href="/agent/0_0_152_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/shanz.gif"></a>
          <h3><a href="/agent/0_0_152_0.shtm" target="_blank">山重代理商</a></h3>
          <ul>
            <li><a target="_blank" href="http://product.21-sun.com/agent/ynsz/">云南山重工程机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/xjsz/">新疆山重建设机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/scsz/">四川山重机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/sxmz/">陕西明志山重工程机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/sdts/">山东泰盛机电设备有限公司</a></li>
          </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_152_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        
        <div class="al"><a title="沃尔沃代理商" href="/agent/0_0_175_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz02.gif"></a>
          <h3><a href="/agent/0_0_175_0.shtm" target="_blank">沃尔沃代理商</a></h3>
          <ul>
	        <li><a target="_blank" href="/agent/bjrsj/">北京融世杰机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/whzn/">武汉中南工程机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/jnty/">济南天业工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/lagc/">辽宁辽鞍工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/znhx/">广州中南华星设备有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_175_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="小松代理商" href="/agent/0_0_182_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz03.gif"></a>
          <h3><a href="/agent/0_0_182_0.shtm" target="_blank">小松代理商</a></h3>
          <ul>
	        <li><a target="_blank" href="/agent/ahxs/">安徽小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/fjxs/">福建小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/sxxs/">山西小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/ccxs/">长春小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/whxs/">武汉小松工程机械有限公司</a></li>
	      </ul> 
          <div class="more"><a target="_blank" href="/agent/0_0_182_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="柳工代理商" href="/agent/0_0_136_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/liugong.gif"></a>
          <h3><a href="/agent/0_0_136_0.shtm" target="_blank">柳工代理商</a></h3>
	<ul>
        <li><a target="_blank" href="/agent/keyuan/">南京科源机械有限公司</a></li>
        <li><a target="_blank" href="/agent/hblg/">河北柳工机械贸易有限公司</a></li>
        <li><a target="_blank" href="/agent/lngl/">辽宁桂柳机械设备有限公司</a></li>
        <li><a target="_blank" href="/agent/hualiu/">安徽华柳工程机械有限责任公司 </a></li>
        <li><a target="_blank" href="/agent/gongli/">徐州工力路桥机械设备有限公司</a></li>
      </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_136_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="神钢代理商" href="/agent/0_0_183_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz05.gif"></a>
          <h3><a href="/agent/0_0_183_0.shtm" target="_blank">神钢代理商</a></h3>
		<ul>
        <li><a target="_blank" href="/agent/hfjixie/">四川汇发机械设备有限公司</a></li>
        <li><a target="_blank" href="/agent/ahly/">安徽力源工程机械限责任公司</a></li>
        <li><a target="_blank" href="/agent/ahny/">安徽南亚工程机械有限公司</a></li>
        <li><a target="_blank" href="/agent/hnlj/">湖南励骏机械设备有限公司</a></li>
        <li><a target="_blank" href="/agent/hfjixie/">汇发机械集团</a></li>
      </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_183_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="徐工代理商" href="/agent/0_0_209_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz06.gif"></a>
          <h3><a href="/agent/0_0_209_0.shtm" target="_blank">徐工代理商</a></h3>
			<ul>
	        <li><a target="_blank" href="/agent/lnyuhua/">辽宁裕华机电设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/hrbzhongcheng/">哈尔滨市中成机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/bjrtd/">北京瑞泰达机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/tajw/">泰安市巨威工程机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/qdstd/">青岛森泰达工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_209_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="三一代理商" href="/agent/0_0_133_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz07.gif"></a>
          <h3><a href="/agent/0_0_133_0.shtm" target="_blank">三一代理商</a></h3>
		   <ul>
	        <li><a target="_blank" href="/agent/hnzw/">湖南中旺工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/hfxy/">合肥湘元工程机械有限公司</a></li>
	        <li><a target="_blank" href="http://jzlg.product.21-sun.com">武汉九州龙工程机械有限公司</a></li> 
	        <li><a target="_blank" href="/agent/tyjj/">太原建机工程有限公司</a></li>
	        <li><a target="_blank" href="http://dingfengjixie.product.21-sun.com">浙江成峰工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_133_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="现代代理商" href="/agent/0_0_194_0.shtm" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz08.gif"></a>
          <h3><a href="/agent/0_0_194_0.shtm" target="_blank">现代代理商</a></h3>
		  <ul>
	        <li><a target="_blank" href="/agent/gxxd/">广西现代星工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/jshr/">江苏恒日工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/hbhc/">河北惠诚工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/bjps/">北京排山工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/shandongjunda/">山东骏大工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="/agent/0_0_194_0.shtm">查看更多&gt;&gt;</a></div>
        </div>
      </div>
    </div>
  </div>
  
</div>
<!--right end-->
<div class="clear"></div>
</div>
<!--main end--> 
<!--foot--> 
<jsp:include page="/include/foot.jsp" flush="true" />
</body>
</html>
<script type="text/javascript">
var sz_flag = false;
jQuery(window).scroll(function(){
	var sH = jQuery(window).scrollTop();
	var dH = jQuery(document).height()-160-530;
	var dH1 = jQuery(document).height()-131-670;
	if(sH>200){
		jQuery("#smartFloat").addClass("sfocus");
		if(!sz_flag){
			var wH = jQuery(window).height()-jQuery(".leftTab").height()-jQuery(".treeSubNavv1").height()-5;
			jQuery("#treev1").height(wH);
			jQuery("#agent_tab02").height(wH+88);
		}
		sz_flag = true;
		if(sH>dH1){
			var _w = jQuery(window).height()-131-150+(965-sH);
			if(jQuery.browser.msie){
				_w = jQuery(window).height()-131-150+(1000-sH);
			}
			jQuery("#treev1").height(_w);
			jQuery("#agent_tab02").height(_w+86);
			sz_flag = false;
		}
	}else{
		jQuery("#smartFloat").removeClass("sfocus");
	}
});
</script>
<script type="text/javascript" src="../scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="../scripts/sort.js"></script> 
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>