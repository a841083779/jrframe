<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	//获取处理参数部分
	Integer cityCount = 0;
	Integer provinceCount = 0;
	String fp = "0";
	String mapDatas="";
	String factoryid = CommonString.getFilterStr(request.getParameter("factoryid")) ;
	String isAuto = CommonString.getFormatPara(request.getParameter("isAuto"));
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String order = CommonString.getFormatPara(request.getParameter("order"));

    factoryid = factoryid.replace("-", "").trim();
    if(factoryid.equals("")){
  	   factoryid = CommonString.getFormatPara(request.getParameter("factoryid")).replace("-", "").trim();
     }
    String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
    catalog = catalog.replace("-", "").trim();
	String province = CommonString.getFilterStr(request.getParameter("province"));
	if(catalog.equals("")||catalog.equals("0")){
	 catalog= CommonString.getFilterStr(request.getParameter("city"));
	 }
	String city="";
	Map areaMap = (Map) application.getAttribute("areaMap");
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
    Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
    Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;
    if("0".equals(catalog)){catalog="";}
    if("0".equals(factoryid)){factoryid="";}
	String otherSql="";
	String brand=factoryid;
	String ipProvince="";
 
	Map mapip = new HashMap();
	//代理商列表选择多个品牌
	String mulAgentSelect = CommonString.getFormatPara(session.getAttribute("mulAgentSelect"));
    String brandNames="";
 
		String[] areaArr = new String[10];
 

    if("0".equals(province)){province="";}
    if("0".equals(city)){city="";}
	String search_province="";
	String search_city="";
	try{	
	    int totalParts = 0;
	    //int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));	
	    //搜索新	
	    String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_agent";
	    HttpSolrServer server = new HttpSolrServer(httpUrl);
	    /*接收参数*/
	    SolrQuery query = new SolrQuery();
	    List<SolrQuery.SortClause> agentList = new ArrayList<SolrQuery.SortClause>();
	    //排序
		if("154".equals(brand)){
			agentList.add(SolrQuery.SortClause.asc("id"));
		}else{
			//agentList.add(SolrQuery.SortClause.desc("is_shop"));
	     	//agentList.add(SolrQuery.SortClause.desc("is_made"));
			agentList.add(SolrQuery.SortClause.asc("id"));
		}
		if(province.equals("xinjiang")){
			agentList = new ArrayList<SolrQuery.SortClause>();
			agentList.add(SolrQuery.SortClause.desc("id"));
		}
	    Integer nowPage = 1 ;
	        int pageSize = 10;
            if(!"".equals(offset) && !"0".equals(offset)){
	            nowPage = Integer.parseInt(offset)/pageSize+1 ;
            }
	        //nowPage = nowPage <= 0 ? 1 : nowPage;
	        List<String> whereList = new ArrayList<String>();
	
		if(!province.equals("")){search_province = (String)hzpyMap.get(province);}
		//TDK
		String seo=search_province+search_city+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog));
		if(seo.equals("")){seo="工程机械";}
		String seo1=search_province+search_city;
		String seo2=CommonString.getFormatPara(brandMap.get(factoryid));
		String seo3=CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog)).replace("/属具","");
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
		    query.setQuery("*:*");
		    //分页查询
		    List<String> filterQuery = new ArrayList<String>(0);   
			//型号	
			if(!"".equals(catalog)){          
                filterQuery.add("policy:*"+catalog+"*");  
			}		
			//如果有品牌，首先查询出该品牌的全部代理商(单选的情况)
			if(!"".equals(brand)){   
	             filterQuery.add("agent_fac:("+ brand +", OR,"+ brand +" OR "+brand +")"); 
                 otherSql+=" and (agent_fac not like '%,"+brand+"%' and  not agent_fac like '%"+brand+",%'  and  agent_fac! ='"+brand+"')";				 
	        }else if(!mulAgentSelect.equals("")){   //(复选的情况)
				 String mul[]=mulAgentSelect.split(",");
			     String str1="";
				 String str2="";
				 for(int i=0;i<mul.length;i++){
					if(!mul[i].equals("")){
						 str1+=mul[i]+", OR,"+ mul[i] +" OR "+mul[i] +",OR "; 
						 if(search_province.equals("")){
						 str2+=" agent_fac like '%,"+mul[i]+"%' or agent_fac like '%"+mul[i]+",%'  or agent_fac ='"+mul[i]+"' or";
						 }else{
						 str2+=" agent_fac not like '%,"+mul[i]+"%' and agent_fac not  like '%"+mul[i]+",%'  and  agent_fac! ='"+mul[i]+"' and";
						 }
						 brandNames+=CommonString.getFormatPara(brandMap.get(mul[i]))+",";
					}
				 }
				 filterQuery.add("agent_fac:("+str1.substring(0,str1.length()-4)+")"); 
				 if(search_province.equals("")){
                    otherSql+=" and ("+str2.substring(0,str2.length()-3)+")";	
				 }else{
				    otherSql+=" and ("+str2.substring(0,str2.length()-4)+")";	
				 }
				 if(brandNames.length()>1){
					 brandNames=brandNames.substring(0,brandNames.length()-1);
				 }
			}
	        //省份
	        if("".equals(search_province)){
	   	          query.setQuery("*:*");
	        }else{
	              filterQuery.add(" city:"+ search_province +"");
				  if(!"".equals(brand)||!mulAgentSelect.equals("")){
				    otherSql+=" and ( city like '%"+search_province+"%' )";
				  }else{
					otherSql+=" and ( city not  like '%"+search_province+"%' )";
				  }  
	        }
	        //城市
	        if(!"".equals(search_city)){				
			      filterQuery.add("address:"+ search_city.replace("市","") +"  OR full_name:"+ search_city.replace("市","") +"  OR city:"+ search_city.replace("市","") +"");
			}
            /*查询*/				
	        String [] filterArr = new String [filterQuery.size()];
	        filterArr = filterQuery.toArray(filterArr);
	        query.addFilterQuery(filterArr);
	        /*排序*/     	  
	        query.setRequestHandler("/jereh");
	        query.setSorts(agentList);
	        query.setRows(pageSize);
	        query.setStart((nowPage - 1) * pageSize);
	        query.setParam("hl.fl", "name");
	        QueryResponse res = server.query(query);
	        totalParts = (int)res.getResults().getNumFound();
	        int pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	        SolrDocumentList agents = res.getResults();	
			//厂家品牌
	        List<Map> brandList=null;
		    //其他区域代理商列表
			List<Map> otherAgentList=null;
 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【电话】<%=seo%>代理商_<%=seo%>代理商信息大全 - 铁臂商城</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=seo4%>" />
<meta name="description" content="寻找【<%=seo%>代理商】请上铁臂商城。铁臂商城拥有全国各个地区的代理商信息,是<%=seo%>代理商平台。 " />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="mobile-agent" content="format=html5;url=http://m.product.21-sun.com/agent_list.jsp">
<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="/new_resources/css/style.css" rel="stylesheet" />
<link href="/new_resources/css/style_common.css" rel="stylesheet" />
<link href="/Static/css/common.css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="../scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<link href="/Static/css/agent.css" rel="stylesheet" />
<link href="/Static/css/ui.css" rel="stylesheet" />
<link href="http://www.21-sun.com/css/topbar.css" rel="stylesheet" />
<script type="text/javascript" src="../scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<style>
.txd_filter_plist li {
	border-top: 1px solid #F7F7F7;
	border-bottom: 1px solid #F7F7F7;
	border-left: 1px solid #F7F7F7;
}
</style>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?998e4dbd9441f628020df509fd0e9f3c";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();

</script>

</head>
<body>
<!--top-->
<jsp:include page="/include/new_top_agent.htm" flush="true"/>
<!--nav end-->
<!--面包屑-->
<div class="contain1190 mb10" style="margin-top: 15px;">
  <h3 class="breadCrumbs"> 我的位置：<a href="/">铁臂商城</a> &gt;&gt; <a href="/agent/">代理商专区</a> <%="".equals(search_province+search_city)?"":" &gt;&gt; <a href='/agent/"+(province.equals("")?"0":province)+"_"+(city.equals("")?"0":city)+"_0_0.shtm'>"+search_province+search_city+"</a>"%> <%="".equals(catalog)?"".equals(factoryid)?"":" &gt;&gt; "+ CommonString.getFormatPara(brandMap.get(factoryid)): "".equals(factoryid)?"":" &gt;&gt; <a href='/agent/0_0_"+(factoryid.equals("")?"0":factoryid)+"_0.shtm'>"+CommonString.getFormatPara(brandMap.get(factoryid))+"</a>"%> <a href="/agent/0_0_0_<%=catalog.equals("")?"0":catalog%>.shtm"><%="".equals(catalog)?"":" &gt;&gt; "+CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))%></a> <a href="/agent/<%=(province.equals("")?"0":province)%>_<%=(city.equals("")?"0":city)%>_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>.shtm">
    <%if((!(search_province+search_city).equals(""))||!factoryid.equals("")){%>
    <%="".equals(catalog)?"":" &gt;&gt; "+((search_province+search_city).equals("")?"":(search_province+search_city))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))%>
    <%}%>
    </a> <%="".equals(catalog)?"":" &gt;&gt; "+((search_province+search_city).equals("")?"":(search_province+search_city))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))+"代理商"%></h3>
</div>
<!--面包屑结束-->
<!--main-->
<!--筛选-->

<div id="main1">
  <div id="main" style="background-color:white">
    <div class="filter fix">
      <div class="filter_hd " style="background-color:white">
        <h1 class="_n"> <%=search_province%><%=search_city%><%=factoryid.equals("")?brandNames:""%><%="".equals(factoryid) ?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog)&&"".equals(factoryid)?"":CommonString.getFormatPara(catalogMap.get(catalog))%><%if((search_province.equals("")&&search_city.equals("")&&factoryid.equals("")&&brandNames.equals("")&&catalog.equals(""))||1==1){%>工程机械<%}%></h1>
        <span class="_tip">代理商</span>  </div>
		
		 <div class="attr" >
			<div class="attrKey">类别</div>
			<div class="attrValues">
				<ul class="av-collapse" style="visibility:visible;">
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_101001_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">挖掘机/属具</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_101002_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">装载机</a></li>
                    <li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_106001_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">压路机/压实机/夯</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_102_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">起重机</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_103_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">混凝土机械</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_104_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">路面机械</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_101003_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">推土机</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_101005_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">平地机/铲运机</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_105_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">桩工机械</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_110_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">地下及矿山机械</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_101008_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">自卸卡车/矿卡</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_122_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">环卫车辆</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_118_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">专用车辆</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_107_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">叉车</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_109_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">桥梁机械</a></li>
					<li style="margin:0 15px 10px 0"><a href="/agent/<%=province.equals("")?"0":province%>_111_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">港口机械</a></li>
					
				</ul>
			</div>
		</div>
		
<div class="attr">
			<div class="attrKey">地区</div>
			<div class="attrValues">
				<ul class="av-collapse" style="visibility:visible;height:72px">
				  <li style="margin:0 15px 10px 0"><a href="/agent/0_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">全国</a></li> 			 
 <li style="margin:0 15px 10px 0"><a href="/agent/shandong_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">山东</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/anhui_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">安徽</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/jiangxi_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">江西</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/zhejiang_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">浙江</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/shanghai_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">上海</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/beijing_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">北京</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/tianjin_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">天津</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/chongqing_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">重庆</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/hebei_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">河北</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/shanxi_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">山西</a></li>
 <li style="margin:0 15px 10px 0"><a href="/agent/neimenggu_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">内蒙古</a></li>
  <li style="margin:0 15px 10px 0"><a href="/agent/jiangsu_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">江苏</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/guangxi_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">广西</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/xizang_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">西藏</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/ningxia_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">宁夏</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/xinjiang_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">新疆</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/jilin_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">吉林</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/liaoning_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">辽宁</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/heilongjiang_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">黑龙江</a></li>
  <li style="margin:0 15px 10px 0"><a href="/agent/hubei_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">湖北</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/hunan_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">湖南</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/guangdong_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">广东</a></li>
  <li style="margin:0 15px 10px 0"><a href="/agent/henan_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">河南</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/guzhou_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">贵州</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/qinghai_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">青海</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/gansu_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">甘肃</a></li>
  <li style="margin:0 15px 10px 0"><a href="/agent/shanx_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">陕西</a></li>
  <li style="margin:0 15px 10px 0"><a href="/agent/yunnan_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">云南</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/sichuan_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">四川</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/hainan_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">海南</a></li> 
  <li style="margin:0 15px 10px 0"><a href="/agent/fujian_<%=catalog.equals("")?"0":catalog%>_<%=factoryid.equals("")?"0":factoryid%>_0.shtm">福建</a></li> 
				</ul>
			</div>
</div>		

		
		
      <div class="j_Prop attr hasMore attr_brand j_Propli" id="select_brand">
        <div class="attrKey">
          <p>品牌</p>
          <div class="brandTip" style="white-space:normal;text-indent:0;position:static;padding:10px;"><a href="javascript:void(0)" id="inner" class="br01">国内品牌</a><a id="out" href="javascript:void(0)" class="br02" style="*margin-top:8px;">国外品牌</a></div>
        </div>
        <div class="attrValues">
          <div class="j_BrandSearch av-search fix">
            <input id="brand" name="brand" type="text" value="" placeholder="可搜拼音、汉字查找品牌">
          </div>
          <div class="letters"> <a href="javascript:void(0)" class="all">所有品牌</a> <a data-val="A" href="javascript:void(0)">A</a><a href="javascript:void(0)" data-val="B">B</a><a data-val="C" href="javascript:void(0)">C</a><a href="javascript:void(0)" data-val="D">D</a><a href="javascript:void(0)" data-val="F">F</a><a href="javascript:void(0)" data-val="G">G</a><a href="javascript:void(0)" data-val="H">H</a><a href="javascript:void(0)" data-val="J">J</a><a href="javascript:void(0)" data-val="K">K</a><a href="javascript:void(0)" data-val="L">L</a><a href="javascript:void(0)" data-val="M">M</a><a href="javascript:void(0)" data-val="N">N</a><a href="javascript:void(0)" data-val="O">O</a><a href="javascript:void(0)" data-val="P">P</a><a href="javascript:void(0)" data-val="Q">Q</a><a href="javascript:void(0)" data-val="R">R</a><a href="javascript:void(0)" data-val="S">S</a><a href="javascript:void(0)" data-val="T">T</a><a href="javascript:void(0)" data-val="W">W</a><a href="javascript:void(0)" data-val="X">X</a><a href="javascript:void(0)" data-val="Y">Y</a><a data-val="Z" href="javascript:void(0)">Z</a> </div>



<ul class="av-collapse" id="brand_list" style="margin-right:35px">
  <li class="br01"><a data-val="402" title="艾迪" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_402_0.shtm"><span class="m">A-艾迪</span><span class="s">EDDIE</span></a><b></b></li>
  <li class="br01"><a data-val="1710" title="安迈" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1710_0.shtm"><span class="m">A-安迈</span><span class="s">AMMANN</span></a><b></b></li>
  <li class="br01"><a data-val="1778" title="奥盛特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1778_0.shtm"><span class="m">A-奥盛特</span><span class="s">OSANIT</span></a><b></b></li>
  <li class="br01"><a data-val="14236" title="安鼎" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14236_0.shtm"><span class="m">A-安鼎</span><span class="s">AD</span></a><b></b></li>
  <li class="br01"><a data-val="772" title="艾思博" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_772_0.shtm"><span class="m">A-艾思博</span><span class="s">AXB</span></a><b></b></li>
  <li class="br01"><a data-val="13271" title="奥津" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13271_0.shtm"><span class="m">A-奥津</span><span class="s">OKUTSU</span></a><b></b></li>
  <li class="br01"><a data-val="13272" title="奥泰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13272_0.shtm"><span class="m">A-奥泰</span><span class="s">AOTAI</span></a><b></b></li>
  <li class="br01"><a data-val="16461" title="奥力特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16461_0.shtm"><span class="m">A-奥力特</span><span class="s"></span></a><b></b></li>
  <li class="br02"><a data-val="482" title="阿特拉斯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_482_0.shtm"><span class="m">A-阿特拉斯</span><span class="s">ATLASCOPCO</span></a><b></b></li>
  <li class="br01 attrbrand_hover"><a data-val="478" title="邦立" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_478_0.shtm"><span class="m">B-邦立</span><span class="s">BONNY</span></a><b></b></li>
  <li class="br02"><a data-val="186" title="北起多田野" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_186_0.shtm"><span class="m">B-北起多田野</span><span class="s">BQ.TADANO</span></a><b></b></li>
  <li class="br01"><a data-val="420" title="贝力特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_420_0.shtm"><span class="m">B-贝力特</span><span class="s">BEILITE</span></a><b></b></li>
  <li class="br01"><a data-val="825" title="搏浪沙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_825_0.shtm"><span class="m">B-搏浪沙</span><span class="s">BONANZA</span></a><b></b></li>
  <li class="br01"><a data-val="1108" title="百财" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1108_0.shtm"><span class="m">B-百财</span><span class="s">BAICAI</span></a><b></b></li>
  <li class="br01"><a data-val="1714" title="北山机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1714_0.shtm"><span class="m">B-北山机械</span><span class="s">BSJX</span></a><b></b></li>
  <li class="br01"><a data-val="1715" title="宝骊" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1715_0.shtm"><span class="m">B-宝骊</span><span class="s">KION BAOLI</span></a><b></b></li>
  <li class="br01"><a data-val="13231" title="天地奔牛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13231_0.shtm"><span class="m">B-天地奔牛</span><span class="s">BENNIU</span></a><b></b></li>
  <li class="br01"><a data-val="16834" title="山东奔马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16834_0.shtm"><span class="m">B-山东奔马</span><span class="s">BENMA</span></a><b></b></li>
  <li class="br01"><a data-val="13550" title="宝马格" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13550_0.shtm"><span class="m">B-宝马格</span><span class="s">BOMAG</span></a><b></b></li>
  <li class="br01"><a data-val="16471" title="比亚迪" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16471_0.shtm"><span class="m">B-比亚迪</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16526" title="八方" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16526_0.shtm"><span class="m">B-八方</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="484" title="八达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_484_0.shtm"><span class="m">B-八达</span><span class="s">BADA</span></a><b></b></li>
  <li class="br01"><a data-val="791" title="八达重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_791_0.shtm"><span class="m">B-八达重工</span><span class="s">BADA</span></a><b></b></li>
  <li class="br01"><a data-val="1093" title="北车重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1093_0.shtm"><span class="m">B-北车重工</span><span class="s">CNR</span></a><b></b></li>
  <li class="br01"><a data-val="1168" title="百脉建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1168_0.shtm"><span class="m">B-百脉建机</span><span class="s">BAIMAI</span></a><b></b></li>
  <li class="br01"><a data-val="13565" title="百力克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13565_0.shtm"><span class="m">B-百力克</span><span class="s">BLK</span></a><b></b></li>
  <li class="br01"><a data-val="13566" title="滨州钻机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13566_0.shtm"><span class="m">B-滨州钻机</span><span class="s">BZZJ</span></a><b></b></li>
  <li class="br01"><a data-val="13567" title="暴风雪" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13567_0.shtm"><span class="m">B-暴风雪</span><span class="s">BAOFENGXUE</span></a><b></b></li>
  <li class="br01"><a data-val="13568" title="泵虎" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13568_0.shtm"><span class="m">B-泵虎</span><span class="s">BHB</span></a><b></b></li>
  <li class="br01"><a data-val="13569" title="宝达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13569_0.shtm"><span class="m">B-宝达</span><span class="s">BAODA</span></a><b></b></li>
  <li class="br01"><a data-val="13570" title="宝鼎" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13570_0.shtm"><span class="m">B-宝鼎</span><span class="s">BAODING</span></a><b></b></li>
  <li class="br01"><a data-val="13571" title="波特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13571_0.shtm"><span class="m">B-波特</span><span class="s">BOTE</span></a><b></b></li>
  <li class="br02"><a data-val="683" title="德国宝峨" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_683_0.shtm"><span class="m">B-德国宝峨</span><span class="s">BAUER</span></a><b></b></li>
  <li class="br01"><a data-val="16856" title="北奕机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16856_0.shtm"><span class="m">B-北奕机械</span><span class="s">BEIYI</span></a><b></b></li>
  <li class="br01"><a data-val="13551" title="北京加隆" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13551_0.shtm"><span class="m">B-北京加隆</span><span class="s">CA-LONG</span></a><b></b></li>
  <li class="br02"><a data-val="13553" title="边宁荷夫" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13553_0.shtm"><span class="m">B-边宁荷夫</span><span class="s">BNHF</span></a><b></b></li>
  <li class="br02"><a data-val="13555" title="博纳地" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13555_0.shtm"><span class="m">B-博纳地</span><span class="s">BERNARDI</span></a><b></b></li>
  <li class="br01"><a data-val="13557" title="巴里巴" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13557_0.shtm"><span class="m">B-巴里巴</span><span class="s">BARYVAL</span></a><b></b></li>
  <li class="br01"><a data-val="13558" title="宝象" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13558_0.shtm"><span class="m">B-宝象</span><span class="s">BAOXIANG</span></a><b></b></li>
  <li class="br01"><a data-val="13559" title="博德" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13559_0.shtm"><span class="m">B-博德</span><span class="s">BOD</span></a><b></b></li>
  <li class="br01"><a data-val="13093" title="博山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13093_0.shtm"><span class="m">B-博山</span><span class="s">BOSHAN</span></a><b></b></li>
  <li class="br01"><a data-val="13624" title="博洋" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13624_0.shtm"><span class="m">B-博洋</span><span class="s">BOYANG</span></a><b></b></li>
  <li class="br01"><a data-val="148" title="常林公司" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_148_0.shtm"><span class="m">C-常林公司</span><span class="s">CHANGLIN</span></a><b></b></li>
  <li class="br01"><a data-val="145" title="成工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_145_0.shtm"><span class="m">C-成工</span><span class="s">CHENGGONG</span></a><b></b></li>
  <li class="br01"><a data-val="147" title="长江" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_147_0.shtm"><span class="m">C-长江</span><span class="s">SINOMACH</span></a><b></b></li>
  <li class="br01"><a data-val="1591" title="楚工龙泰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1591_0.shtm"><span class="m">C-楚工龙泰</span><span class="s">CHUGONGLONGTAI</span></a><b></b></li>
  <li class="br01"><a data-val="13174" title="长河" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13174_0.shtm"><span class="m">C-长河</span><span class="s">CHANGHE</span></a><b></b></li>
  <li class="br01"><a data-val="13574" title="郴筑" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13574_0.shtm"><span class="m">C-郴筑</span><span class="s">BINGZHU</span></a><b></b></li>
  <li class="br01"><a data-val="13575" title="昌世" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13575_0.shtm"><span class="m">C-昌世</span><span class="s">CHANGSHI</span></a><b></b></li>
  <li class="br01"><a data-val="16541" title="长虹路桥" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16541_0.shtm"><span class="m">C-长虹路桥</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16533" title="长城" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16533_0.shtm"><span class="m">C-长城</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16412" title="楚飞" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16412_0.shtm"><span class="m">C-楚飞</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16426" title="穿山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16426_0.shtm"><span class="m">C-穿山</span><span class="s"></span></a><b></b></li>
  <li class="br02"><a data-val="192" title="斗山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_192_0.shtm"><span class="m">D-斗山</span><span class="s">DOOSAN</span></a><b></b></li>
  <li class="br01"><a data-val="140" title="鼎盛重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_140_0.shtm"><span class="m">D-鼎盛重工</span><span class="s">DINGSHENG</span></a><b></b></li>
  <li class="br02"><a data-val="212" title="戴纳派克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_212_0.shtm"><span class="m">D-戴纳派克</span><span class="s">DYNAPAC</span></a><b></b></li>
  <li class="br02"><a data-val="163" title="东岳" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_163_0.shtm"><span class="m">D-东岳</span><span class="s">DONGYUE</span></a><b></b></li>
  <li class="br01"><a data-val="151" title="德工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_151_0.shtm"><span class="m">D-德工</span><span class="s">DEGONG</span></a><b></b></li>
  <li class="br02"><a data-val="405" title="东空" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_405_0.shtm"><span class="m">D-东空</span><span class="s">TOKU</span></a><b></b></li>
  <li class="br01"><a data-val="162" title="大地" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_162_0.shtm"><span class="m">D-大地</span><span class="s">DADI</span></a><b></b></li>
  <li class="br01"><a data-val="13584" title="大方" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13584_0.shtm"><span class="m">D-大方</span><span class="s">ZZDF</span></a><b></b></li>
  <li class="br01"><a data-val="13586" title="大连叉车" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13586_0.shtm"><span class="m">D-大连叉车</span><span class="s">DLCC</span></a><b></b></li>
  <li class="br01"><a data-val="13587" title="达力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13587_0.shtm"><span class="m">D-达力</span><span class="s">DALI</span></a><b></b></li>
  <li class="br02"><a data-val="13588" title="道维施" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13588_0.shtm"><span class="m">D-道维施</span><span class="s">DALWORTH</span></a><b></b></li>
  <li class="br01"><a data-val="13589" title="大山路桥" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13589_0.shtm"><span class="m">D-大山路桥</span><span class="s">DASHAN</span></a><b></b></li>
  <li class="br01"><a data-val="13590" title="东蒙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13590_0.shtm"><span class="m">D-东蒙</span><span class="s">DONGMENG</span></a><b></b></li>
  <li class="br01"><a data-val="13591" title="东方冶矿" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13591_0.shtm"><span class="m">D-东方冶矿</span><span class="s">DFZY</span></a><b></b></li>
  <li class="br01"><a data-val="13592" title="大宏立" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13592_0.shtm"><span class="m">D-大宏立</span><span class="s">DAHONGLI</span></a><b></b></li>
  <li class="br01"><a data-val="1717" title="东南机械(" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1717_0.shtm"><span class="m">D-东南机械(</span><span class="s">DONGNAN</span></a><b></b></li>
  <li class="br01"><a data-val="1351" title="东达桩工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1351_0.shtm"><span class="m">D-东达桩工</span><span class="s">DONGDA</span></a><b></b></li>
  <li class="br01"><a data-val="1195" title="大江" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1195_0.shtm"><span class="m">D-大江</span><span class="s">DAJIANG</span></a><b></b></li>
  <li class="br02"><a data-val="1218" title="道胜" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1218_0.shtm"><span class="m">D-道胜</span><span class="s">TRXBUILD</span></a><b></b></li>
  <li class="br01"><a data-val="1122" title="大汉" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1122_0.shtm"><span class="m">D-大汉</span><span class="s">DAHAN</span></a><b></b></li>
  <li class="br01"><a data-val="489" title="德基机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_489_0.shtm"><span class="m">D-德基机械</span><span class="s">DGMACHINERY</span></a><b></b></li>
  <li class="br01"><a data-val="14222" title="东倡" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14222_0.shtm"><span class="m">D-东倡</span><span class="s">DONGCHANG</span></a><b></b></li>
  <li class="br01"><a data-val="13598" title="德通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13598_0.shtm"><span class="m">D-德通</span><span class="s">DETONG</span></a><b></b></li>
  <li class="br01"><a data-val="1755" title="东风" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1755_0.shtm"><span class="m">D-东风</span><span class="s">DFM</span></a><b></b></li>
  <li class="br01"><a data-val="1716" title="达刚" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1716_0.shtm"><span class="m">D-达刚</span><span class="s">DAGANG</span></a><b></b></li>
  <li class="br01"><a data-val="16517" title="戴克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16517_0.shtm"><span class="m">D-戴克</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16785" title="盾安重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16785_0.shtm"><span class="m">D-盾安重工</span><span class="s">DUNAN</span></a><b></b></li>
  <li class="br01"><a data-val="16488" title="德邦" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16488_0.shtm"><span class="m">D-德邦</span><span class="s">DEBOOM</span></a><b></b></li>
  <li class="br01"><a data-val="164" title="抚挖重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_164_0.shtm"><span class="m">F-抚挖重工</span><span class="s">FUWA</span></a><b></b></li>
  <li class="br02"><a data-val="215" title="福格勒" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_215_0.shtm"><span class="m">F-福格勒</span><span class="s">VOGELE</span></a><b></b></li>
  <li class="br01"><a data-val="1183" title="福工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1183_0.shtm"><span class="m">F-福工</span><span class="s">FUQING</span></a><b></b></li>
  <li class="br01"><a data-val="1188" title="福大" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1188_0.shtm"><span class="m">F-福大</span><span class="s">FUDA</span></a><b></b></li>
  <li class="br02"><a data-val="1729" title="丰田" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1729_0.shtm"><span class="m">F-丰田</span><span class="s">TOYOTA</span></a><b></b></li>
  <li class="br01"><a data-val="16425" title="福建龙马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16425_0.shtm"><span class="m">F-福建龙马</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16842" title="富达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16842_0.shtm"><span class="m">F-富达</span><span class="s">LIUTECH</span></a><b></b></li>
  <li class="br01"><a data-val="1888" title="富亿" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1888_0.shtm"><span class="m">F-富亿</span><span class="s">FUYI</span></a><b></b></li>
  <li class="br01"><a data-val="1721" title="富豪" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1721_0.shtm"><span class="m">F-富豪</span><span class="s">FUHAO</span></a><b></b></li>
  <li class="br01"><a data-val="13630" title="飞涛机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13630_0.shtm"><span class="m">F-飞涛机械</span><span class="s">FEITAO</span></a><b></b></li>
  <li class="br01"><a data-val="671" title="方圆" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_671_0.shtm"><span class="m">F-方圆</span><span class="s">FANGYUAN</span></a><b></b></li>
  <li class="br01"><a data-val="1120" title="丰汇技术" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1120_0.shtm"><span class="m">F-丰汇技术</span><span class="s">FINEHOPE</span></a><b></b></li>
  <li class="br01"><a data-val="477" title="格瑞德" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_477_0.shtm"><span class="m">G-格瑞德</span><span class="s">GRAND</span></a><b></b></li>
  <li class="br02"><a data-val="423" title="工兵" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_423_0.shtm"><span class="m">G-工兵</span><span class="s">GB</span></a><b></b></li>
  <li class="br02"><a data-val="417" title="古河" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_417_0.shtm"><span class="m">G-古河</span><span class="s">FRD</span></a><b></b></li>
  <li class="br02"><a data-val="424" title="广林" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_424_0.shtm"><span class="m">G-广林</span><span class="s">KWANGLIM</span></a><b></b></li>
  <li class="br01"><a data-val="13604" title="高达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13604_0.shtm"><span class="m">G-高达</span><span class="s">GOLDEN</span></a><b></b></li>
  <li class="br01"><a data-val="13605" title="谷登机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13605_0.shtm"><span class="m">G-谷登机械</span><span class="s">GUDENG</span></a><b></b></li>
  <li class="br01"><a data-val="1754" title="高远圣工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1754_0.shtm"><span class="m">G-高远圣工</span><span class="s">SG</span></a><b></b></li>
  <li class="br01"><a data-val="776" title="连云港工兵GBPSC" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_776_0.shtm"><span class="m">G-连云港工兵GBPSC</span><span class="s">GBPSC</span></a><b></b></li>
  <li class="br01"><a data-val="1116" title="广西建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1116_0.shtm"><span class="m">G-广西建机</span><span class="s">GCCM</span></a><b></b></li>
  <li class="br01"><a data-val="16480" title="国机洛建" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16480_0.shtm"><span class="m">G-国机洛建</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="1369" title="国机重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1369_0.shtm"><span class="m">G-国机重工</span><span class="s">SINOMACH</span></a><b></b></li>
  <li class="br01"><a data-val="206" title="华力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_206_0.shtm"><span class="m">H-华力</span><span class="s">HANLYMA</span></a><b></b></li>
  <li class="br01"><a data-val="158" title="合力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_158_0.shtm"><span class="m">H-合力</span><span class="s">HELI</span></a><b></b></li>
  <li class="br01"><a data-val="170" title="恒特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_170_0.shtm"><span class="m">H-恒特</span><span class="s">HENGTE</span></a><b></b></li>
  <li class="br01"><a data-val="203" title="海诺" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_203_0.shtm"><span class="m">H-海诺</span><span class="s">HAINUO</span></a><b></b></li>
  <li class="br01"><a data-val="202" title="鸿得利" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_202_0.shtm"><span class="m">H-鸿得利</span><span class="s">HOLD</span></a><b></b></li>
  <li class="br02"><a data-val="216" title="悍马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_216_0.shtm"><span class="m">H-悍马</span><span class="s">WIRTGEN</span></a><b></b></li>
  <li class="br02"><a data-val="421" title="韩宇" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_421_0.shtm"><span class="m">H-韩宇</span><span class="s">EVERDIGM</span></a><b></b></li>
  <li class="br01"><a data-val="415" title="韩川" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_415_0.shtm"><span class="m">H-韩川</span><span class="s">HCB</span></a><b></b></li>
  <li class="br01"><a data-val="664" title="海州机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_664_0.shtm"><span class="m">H-海州机械</span><span class="s">HAIZHOU</span></a><b></b></li>
  <li class="br01"><a data-val="1761" title="恒诺" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1761_0.shtm"><span class="m">H-恒诺</span><span class="s">XZHN</span></a><b></b></li>
  <li class="br02"><a data-val="1112" title="韩工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1112_0.shtm"><span class="m">H-韩工</span><span class="s">HANGONG</span></a><b></b></li>
  <li class="br01"><a data-val="1731" title="华山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1731_0.shtm"><span class="m">H-华山</span><span class="s">HUASHAN</span></a><b></b></li>
  <li class="br01"><a data-val="1727" title="华强京工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1727_0.shtm"><span class="m">H-华强京工</span><span class="s">HIGH QUALITY</span></a><b></b></li>
  <li class="br01"><a data-val="1508" title="恒日" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1508_0.shtm"><span class="m">H-恒日</span><span class="s">HENR</span></a><b></b></li>
  <li class="br01"><a data-val="16775" title="宏昌天马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16775_0.shtm"><span class="m">H-宏昌天马</span><span class="s">SUNHUNK</span></a><b></b></li>
  <li class="br01"><a data-val="16418" title="湖北合力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16418_0.shtm"><span class="m">H-湖北合力</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="1147" title="恒天九五" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1147_0.shtm"><span class="m">H-恒天九五</span><span class="s">CHTCJOVE</span></a><b></b></li>
  <li class="br01"><a data-val="16475" title="海格力斯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16475_0.shtm"><span class="m">H-海格力斯</span><span class="s">HERCULES</span></a><b></b></li>
  <li class="br01"><a data-val="16472" title="宏大" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16472_0.shtm"><span class="m">H-宏大</span><span class="s">HONGDA</span></a><b></b></li>
  <li class="br01"><a data-val="16457" title="华鑫" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16457_0.shtm"><span class="m">H-华鑫</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16498" title="红星" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16498_0.shtm"><span class="m">H-红星</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16479" title="海盛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16479_0.shtm"><span class="m">H-海盛</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16394" title="恒立" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16394_0.shtm"><span class="m">H-恒立</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16493" title="环球" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16493_0.shtm"><span class="m">H-环球</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16551" title="华重" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16551_0.shtm"><span class="m">H-华重</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16466" title="华恒" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16466_0.shtm"><span class="m">H-华恒</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16467" title="河南宏基" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16467_0.shtm"><span class="m">H-河南宏基</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16381" title="恒旺工矿" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16381_0.shtm"><span class="m">H-恒旺工矿</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16849" title="海伦哲" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16849_0.shtm"><span class="m">H-海伦哲</span><span class="s">Handler</span></a><b></b></li>
  <li class="br01"><a data-val="14111" title="环球" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14111_0.shtm"><span class="m">H-环球</span><span class="s">WXHQ</span></a><b></b></li>
  <li class="br01"><a data-val="13622" title="惠工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13622_0.shtm"><span class="m">H-惠工</span><span class="s">HUIGONG</span></a><b></b></li>
  <li class="br01"><a data-val="13623" title="恒端" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13623_0.shtm"><span class="m">H-恒端</span><span class="s">HENDUN</span></a><b></b></li>
  <li class="br01"><a data-val="13625" title="华重" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13625_0.shtm"><span class="m">H-华重</span><span class="s">HUAZHONG</span></a><b></b></li>
  <li class="br01"><a data-val="13626" title="鸿源" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13626_0.shtm"><span class="m">H-鸿源</span><span class="s">HONGYUAN</span></a><b></b></li>
  <li class="br01"><a data-val="13629" title="宏建机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13629_0.shtm"><span class="m">H-宏建机械</span><span class="s">HJJX</span></a><b></b></li>
  <li class="br01"><a data-val="1724" title="杭州市政" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1724_0.shtm"><span class="m">H-杭州市政</span><span class="s">HZSZ</span></a><b></b></li>
  <li class="br02"><a data-val="1733" title="海斯特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1733_0.shtm"><span class="m">H-海斯特</span><span class="s">HYSTER</span></a><b></b></li>
  <li class="br01"><a data-val="1734" title="杭叉" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1734_0.shtm"><span class="m">H-杭叉</span><span class="s">HANGCHA</span></a><b></b></li>
  <li class="br01"><a data-val="1735" title="恒润高科" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1735_0.shtm"><span class="m">H-恒润高科</span><span class="s">HERON</span></a><b></b></li>
  <li class="br01"><a data-val="13616" title="惠山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13616_0.shtm"><span class="m">H-惠山</span><span class="s">HUISHAN</span></a><b></b></li>
  <li class="br01"><a data-val="13617" title="虎力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13617_0.shtm"><span class="m">H-虎力</span><span class="s">HULIFT</span></a><b></b></li>
  <li class="br01"><a data-val="13618" title="宏力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13618_0.shtm"><span class="m">H-宏力</span><span class="s">HONGLI</span></a><b></b></li>
  <li class="br01"><a data-val="13632" title="和盛达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13632_0.shtm"><span class="m">H-和盛达</span><span class="s">HESHENGDA</span></a><b></b></li>
  <li class="br01"><a data-val="13633" title="宏达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13633_0.shtm"><span class="m">H-宏达</span><span class="s">HONGDA</span></a><b></b></li>
  <li class="br01"><a data-val="13634" title="华光" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13634_0.shtm"><span class="m">H-华光</span><span class="s">HGJX</span></a><b></b></li>
  <li class="br01"><a data-val="13636" title="恒兴" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13636_0.shtm"><span class="m">H-恒兴</span><span class="s">HXJX</span></a><b></b></li>
  <li class="br01"><a data-val="13640" title="华南" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13640_0.shtm"><span class="m">H-华南</span><span class="s">SOCMA</span></a><b></b></li>
  <li class="br01"><a data-val="13641" title="恒康" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13641_0.shtm"><span class="m">H-恒康</span><span class="s">HKZG</span></a><b></b></li>
  <li class="br01"><a data-val="13609" title="宏大" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13609_0.shtm"><span class="m">H-宏大</span><span class="s">HME</span></a><b></b></li>
  <li class="br01"><a data-val="1103" title="黑金钢" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1103_0.shtm"><span class="m">H-黑金钢</span><span class="s">BLACK KING KONG</span></a><b></b></li>
  <li class="br01"><a data-val="819" title="虎霸" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_819_0.shtm"><span class="m">H-虎霸</span><span class="s">HUBA</span></a><b></b></li>
  <li class="br01"><a data-val="893" title="海德" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_893_0.shtm"><span class="m">H-海德</span><span class="s">HAIDE</span></a><b></b></li>
  <li class="br01"><a data-val="814" title="悍宇" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_814_0.shtm"><span class="m">H-悍宇</span><span class="s">ICAN</span></a><b></b></li>
  <li class="br01"><a data-val="1091" title="海山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1091_0.shtm"><span class="m">H-海山</span><span class="s">HAISHAN</span></a><b></b></li>
  <li class="br01"><a data-val="1176" title="海泰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1176_0.shtm"><span class="m">H-海泰</span><span class="s">HAITAI</span></a><b></b></li>
  <li class="br01"><a data-val="1220" title="华通动力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1220_0.shtm"><span class="m">H-华通动力</span><span class="s">HUATONG</span></a><b></b></li>
  <li class="br01"><a data-val="1512" title="华中建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1512_0.shtm"><span class="m">H-华中建机</span><span class="s">HUA ZHONG</span></a><b></b></li>
  <li class="br01"><a data-val="1525" title="合矿" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1525_0.shtm"><span class="m">H-合矿</span><span class="s">HEKING</span></a><b></b></li>
  <li class="br02"><a data-val="189" title="加藤" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_189_0.shtm"><span class="m">J-加藤</span><span class="s">KATO</span></a><b></b></li>
  <li class="br02"><a data-val="177" title="JCB" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_177_0.shtm"><span class="m">J-JCB</span><span class="s">JCB</span></a><b></b></li>
  <li class="br02"><a data-val="187" title="久保田" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_187_0.shtm"><span class="m">J-久保田</span><span class="s">KUBOTA</span></a><b></b></li>
  <li class="br01"><a data-val="479" title="江淮重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_479_0.shtm"><span class="m">J-江淮重工</span><span class="s">JAC</span></a><b></b></li>
  <li class="br01"><a data-val="172" title="晋工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_172_0.shtm"><span class="m">J-晋工</span><span class="s">JINGONG</span></a><b></b></li>
  <li class="br02"><a data-val="197" title="酒井" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_197_0.shtm"><span class="m">J-酒井</span><span class="s">SAKAI</span></a><b></b></li>
  <li class="br01"><a data-val="166" title="京城重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_166_0.shtm"><span class="m">J-京城重工</span><span class="s">JCHI</span></a><b></b></li>
  <li class="br01"><a data-val="401" title="惊天智能" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_401_0.shtm"><span class="m">J-惊天智能</span><span class="s">GIANT</span></a><b></b></li>
  <li class="br02"><a data-val="407" title="甲南" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_407_0.shtm"><span class="m">J-甲南</span><span class="s">KONAN</span></a><b></b></li>
  <li class="br01"><a data-val="679" title="军恒斯帕克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_679_0.shtm"><span class="m">J-军恒斯帕克</span><span class="s">JUNHENG</span></a><b></b></li>
  <li class="br01"><a data-val="681" title="军联" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_681_0.shtm"><span class="m">J-军联</span><span class="s">JUNLIAN</span></a><b></b></li>
  <li class="br02"><a data-val="1524" title="吉尼" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1524_0.shtm"><span class="m">J-吉尼</span><span class="s">GENIE</span></a><b></b></li>
  <li class="br01"><a data-val="1352" title="建德机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1352_0.shtm"><span class="m">J-建德机械</span><span class="s">KEN TAK</span></a><b></b></li>
  <li class="br01"><a data-val="1193" title="巨超" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1193_0.shtm"><span class="m">J-巨超</span><span class="s">JUCHAO</span></a><b></b></li>
  <li class="br01"><a data-val="1142" title="金塔" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1142_0.shtm"><span class="m">J-金塔</span><span class="s">HNJT</span></a><b></b></li>
  <li class="br01"><a data-val="1145" title="佳弋建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1145_0.shtm"><span class="m">J-佳弋建机</span><span class="s">DLJG</span></a><b></b></li>
  <li class="br01"><a data-val="816" title="骏马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_816_0.shtm"><span class="m">J-骏马</span><span class="s">JUNMA</span></a><b></b></li>
  <li class="br01"><a data-val="487" title="江麓" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_487_0.shtm"><span class="m">J-江麓</span><span class="s">NORINCO</span></a><b></b></li>
  <li class="br01"><a data-val="1132" title="锦城" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1132_0.shtm"><span class="m">J-锦城</span><span class="s">SCJC</span></a><b></b></li>
  <li class="br01"><a data-val="1094" title="上工机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1094_0.shtm"><span class="m">J-上工机械</span><span class="s">SEMW</span></a><b></b></li>
  <li class="br01"><a data-val="13657" title="金城" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13657_0.shtm"><span class="m">J-金城</span><span class="s">JCJX</span></a><b></b></li>
  <li class="br01"><a data-val="13176" title="嘉和重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13176_0.shtm"><span class="m">J-嘉和重工</span><span class="s">JIAHE</span></a><b></b></li>
  <li class="br01"><a data-val="13643" title="江加" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13643_0.shtm"><span class="m">J-江加</span><span class="s">JIANGJIA</span></a><b></b></li>
  <li class="br01"><a data-val="13645" title="佳乐" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13645_0.shtm"><span class="m">J-佳乐</span><span class="s">JAROL</span></a><b></b></li>
  <li class="br01"><a data-val="13647" title="江苏路通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13647_0.shtm"><span class="m">J-江苏路通</span><span class="s">JSLT</span></a><b></b></li>
  <li class="br01"><a data-val="13648" title="聚龙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13648_0.shtm"><span class="m">J-聚龙</span><span class="s">JULONG</span></a><b></b></li>
  <li class="br01"><a data-val="13649" title="精功" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13649_0.shtm"><span class="m">J-精功</span><span class="s">HBJG</span></a><b></b></li>
  <li class="br01"><a data-val="13650" title="靖江（JJCC）" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13650_0.shtm"><span class="m">J-靖江（JJCC）</span><span class="s">JJCC</span></a><b></b></li>
  <li class="br01"><a data-val="13651" title="金茂" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13651_0.shtm"><span class="m">J-金茂</span><span class="s">GOLDMILL</span></a><b></b></li>
  <li class="br01"><a data-val="1736" title="建研机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1736_0.shtm"><span class="m">J-建研机械</span><span class="s">JAINE</span></a><b></b></li>
  <li class="br02"><a data-val="16563" title="捷尔杰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16563_0.shtm"><span class="m">J-捷尔杰</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16511" title="吉恒" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16511_0.shtm"><span class="m">J-吉恒</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16512" title="金昊建工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16512_0.shtm"><span class="m">J-金昊建工</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="554" title="吉公" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_554_0.shtm"><span class="m">J-吉公</span><span class="s">JLGL</span></a><b></b></li>
  <li class="br01"><a data-val="1159" title="京龙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1159_0.shtm"><span class="m">J-京龙</span><span class="s">JINGLONG</span></a><b></b></li>
  <li class="br01"><a data-val="16388" title="骏强" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16388_0.shtm"><span class="m">J-骏强</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16432" title="山推建友" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16432_0.shtm"><span class="m">J-山推建友</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="1759" title="京城长野" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1759_0.shtm"><span class="m">J-京城长野</span><span class="s">NAGANO</span></a><b></b></li>
  <li class="br01"><a data-val="1586" title="劲工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1586_0.shtm"><span class="m">J-劲工</span><span class="s">JINGGONG</span></a><b></b></li>
  <li class="br01"><a data-val="1229" title="吉星" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1229_0.shtm"><span class="m">J-吉星</span><span class="s">JISUNG</span></a><b></b></li>
  <li class="br01"><a data-val="16838" title="江特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16838_0.shtm"><span class="m">J-江特</span><span class="s">JDF</span></a><b></b></li>
  <li class="br01"><a data-val="1355" title="矫马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1355_0.shtm"><span class="m">J-矫马</span><span class="s">JOMO</span></a><b></b></li>
  <li class="br01"><a data-val="1357" title="建友机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1357_0.shtm"><span class="m">J-建友机械</span><span class="s">JANEOO</span></a><b></b></li>
  <li class="br01"><a data-val="16524" title="济宁鸿业" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16524_0.shtm"><span class="m">J-济宁鸿业</span><span class="s"></span></a><b></b></li>
  <li class="br02"><a data-val="174" title="卡特彼勒" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_174_0.shtm"><span class="m">K-卡特彼勒</span><span class="s">CATERPILLAR</span></a><b></b></li>
  <li class="br02"><a data-val="455" title="凯斯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_455_0.shtm"><span class="m">K-凯斯</span><span class="s">CASE</span></a><b></b></li>
  <li class="br01"><a data-val="178" title="卡特重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_178_0.shtm"><span class="m">K-卡特重工</span><span class="s">CARTER</span></a><b></b></li>
  <li class="br01"><a data-val="160" title="开元智富" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_160_0.shtm"><span class="m">K-开元智富</span><span class="s">KAIYUAN</span></a><b></b></li>
  <li class="br01"><a data-val="1322" title="凯雷" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1322_0.shtm"><span class="m">K-凯雷</span><span class="s">CARLYLE</span></a><b></b></li>
  <li class="br01"><a data-val="1756" title="凯威" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1756_0.shtm"><span class="m">K-凯威</span><span class="s">KAIWEI</span></a><b></b></li>
  <li class="br01"><a data-val="14243" title="科友机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14243_0.shtm"><span class="m">K-科友机械</span><span class="s">KEYOMACHINE</span></a><b></b></li>
  <li class="br01"><a data-val="14247" title="开普动力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14247_0.shtm"><span class="m">K-开普动力</span><span class="s">KIPOR</span></a><b></b></li>
  <li class="br01"><a data-val="13666" title="科筑" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13666_0.shtm"><span class="m">K-科筑</span><span class="s">KEZHU</span></a><b></b></li>
  <li class="br01"><a data-val="13661" title="凯联" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13661_0.shtm"><span class="m">K-凯联</span><span class="s">KAILIAN</span></a><b></b></li>
  <li class="br01"><a data-val="13663" title="科泰重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13663_0.shtm"><span class="m">K-科泰重工</span><span class="s">KETAI</span></a><b></b></li>
  <li class="br01"><a data-val="13664" title="科尼乐" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13664_0.shtm"><span class="m">K-科尼乐</span><span class="s">CONELE</span></a><b></b></li>
  <li class="br01"><a data-val="1135" title="凯捷" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1135_0.shtm"><span class="m">K-凯捷</span><span class="s">CAPGEMINI</span></a><b></b></li>
  <li class="br01"><a data-val="16843" title="康明斯电力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16843_0.shtm"><span class="m">K-康明斯电力</span><span class="s">Cummins</span></a><b></b></li>
  <li class="br01"><a data-val="16508" title="克林曼" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16508_0.shtm"><span class="m">K-克林曼</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="14265" title="孔山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14265_0.shtm"><span class="m">K-孔山</span><span class="s">KOSAN</span></a><b></b></li>
  <li class="br01"><a data-val="1118" title="科曼萨" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1118_0.shtm"><span class="m">K-科曼萨</span><span class="s">COMANSAJIE</span></a><b></b></li>
  <li class="br01"><a data-val="16414" title="凯大" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16414_0.shtm"><span class="m">K-凯大</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="136" title="柳工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_136_0.shtm"><span class="m">L-柳工</span><span class="s">LIUGONG</span></a><b></b></li>
  <li class="br01"><a data-val="137" title="山东临工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_137_0.shtm"><span class="m">L-山东临工</span><span class="s">SDLG</span></a><b></b></li>
  <li class="br01"><a data-val="141" title="雷沃重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_141_0.shtm"><span class="m">L-雷沃重工</span><span class="s">LOVOL</span></a><b></b></li>
  <li class="br01"><a data-val="135" title="龙工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_135_0.shtm"><span class="m">L-龙工</span><span class="s">LONKING</span></a><b></b></li>
  <li class="br02"><a data-val="179" title="利勃海尔" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_179_0.shtm"><span class="m">L-利勃海尔</span><span class="s">LIEBHERR</span></a><b></b></li>
  <li class="br01"><a data-val="157" title="力士德" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_157_0.shtm"><span class="m">L-力士德</span><span class="s">LISHIDE</span></a><b></b></li>
  <li class="br01"><a data-val="207" title="陆德筑机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_207_0.shtm"><span class="m">L-陆德筑机</span><span class="s">ROADY</span></a><b></b></li>
  <li class="br01"><a data-val="412" title="力博士" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_412_0.shtm"><span class="m">L-力博士</span><span class="s">LIBOSHI</span></a><b></b></li>
  <li class="br02"><a data-val="1742" title="林德" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1742_0.shtm"><span class="m">L-林德</span><span class="s">LINDE</span></a><b></b></li>
  <li class="br01"><a data-val="13097" title="莱工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13097_0.shtm"><span class="m">L-莱工</span><span class="s">LAIGONG</span></a><b></b></li>
  <li class="br01"><a data-val="16443" title="磊蒙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16443_0.shtm"><span class="m">L-磊蒙</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16382" title="山东鲁一" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16382_0.shtm"><span class="m">L-山东鲁一</span><span class="s"></span></a><b></b></li>
  <li class="br02"><a data-val="16366" title="洛克斯特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16366_0.shtm"><span class="m">L-洛克斯特</span><span class="s">ROCKSTER</span></a><b></b></li>
  <li class="br01"><a data-val="552" title="绿地" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_552_0.shtm"><span class="m">L-绿地</span><span class="s">GREENBELT</span></a><b></b></li>
  <li class="br01"><a data-val="16359" title="临工重特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16359_0.shtm"><span class="m">L-临工重特</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16683" title="雷乔曼" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16683_0.shtm"><span class="m">L-雷乔曼</span><span class="s">LEIQM</span></a><b></b></li>
  <li class="br01"><a data-val="16530" title="雷鸣重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16530_0.shtm"><span class="m">L-雷鸣重工</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16378" title="朗信" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16378_0.shtm"><span class="m">L-朗信</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16474" title="立杰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16474_0.shtm"><span class="m">L-立杰</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16871" title="雷道" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16871_0.shtm"><span class="m">L-雷道</span><span class="s">LEADER</span></a><b></b></li>
  <li class="br01"><a data-val="1718" title="雷萨重机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1718_0.shtm"><span class="m">L-雷萨重机</span><span class="s">LOXA</span></a><b></b></li>
  <li class="br01"><a data-val="1194" title="蓝翔" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1194_0.shtm"><span class="m">L-蓝翔</span><span class="s">LANXIANG</span></a><b></b></li>
  <li class="br01"><a data-val="673" title="洛阳路通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_673_0.shtm"><span class="m">L-洛阳路通</span><span class="s">LUYANG</span></a><b></b></li>
  <li class="br01"><a data-val="543" title="雷奥" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_543_0.shtm"><span class="m">L-雷奥</span><span class="s">REHOR</span></a><b></b></li>
  <li class="br01"><a data-val="688" title="鲁岳" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_688_0.shtm"><span class="m">L-鲁岳</span><span class="s">LUYUE</span></a><b></b></li>
  <li class="br01"><a data-val="767" title="凌宇汽车" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_767_0.shtm"><span class="m">L-凌宇汽车</span><span class="s">CIMCLINYU</span></a><b></b></li>
  <li class="br01"><a data-val="14257" title="鲁宇" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14257_0.shtm"><span class="m">L-鲁宇</span><span class="s">LUYU</span></a><b></b></li>
  <li class="br01"><a data-val="13631" title="路畅养护" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13631_0.shtm"><span class="m">L-路畅养护</span><span class="s">LUCHANG</span></a><b></b></li>
  <li class="br01"><a data-val="13677" title="利洲" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13677_0.shtm"><span class="m">L-利洲</span><span class="s">LIZHOU</span></a><b></b></li>
  <li class="br01"><a data-val="13679" title="路达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13679_0.shtm"><span class="m">L-路达</span><span class="s">LUDA</span></a><b></b></li>
  <li class="br01"><a data-val="13680" title="林泰阁" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13680_0.shtm"><span class="m">L-林泰阁</span><span class="s">LINTEC</span></a><b></b></li>
  <li class="br01"><a data-val="13681" title="黎明重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13681_0.shtm"><span class="m">L-黎明重工</span><span class="s">LIMING</span></a><b></b></li>
  <li class="br01"><a data-val="13686" title="辽原筑机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13686_0.shtm"><span class="m">L-辽原筑机</span><span class="s">LYZL</span></a><b></b></li>
  <li class="br01"><a data-val="13670" title="路虹" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13670_0.shtm"><span class="m">L-路虹</span><span class="s">LUHONG</span></a><b></b></li>
  <li class="br01"><a data-val="13688" title="路宝" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13688_0.shtm"><span class="m">L-路宝</span><span class="s">LUBAO</span></a><b></b></li>
  <li class="br01"><a data-val="13118" title="山东鲁工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13118_0.shtm"><span class="m">L-山东鲁工</span><span class="s">LUGONG</span></a><b></b></li>
  <li class="br01"><a data-val="1739" title="鲁青" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1739_0.shtm"><span class="m">L-鲁青</span><span class="s">LUQING</span></a><b></b></li>
  <li class="br01"><a data-val="13689" title="玛连尼" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13689_0.shtm"><span class="m">M-玛连尼</span><span class="s">MARINI</span></a><b></b></li>
  <li class="br01"><a data-val="13691" title="闽科" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13691_0.shtm"><span class="m">M-闽科</span><span class="s">XMINKE</span></a><b></b></li>
  <li class="br01"><a data-val="13692" title="梅狮" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13692_0.shtm"><span class="m">M-梅狮</span><span class="s">MEISHI</span></a><b></b></li>
  <li class="br01"><a data-val="13693" title="曼尼通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13693_0.shtm"><span class="m">M-曼尼通</span><span class="s">HMME</span></a><b></b></li>
  <li class="br01"><a data-val="13737" title="明山路桥" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13737_0.shtm"><span class="m">M-明山路桥</span><span class="s">MSLQ</span></a><b></b></li>
  <li class="br01"><a data-val="1125" title="明威塔机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1125_0.shtm"><span class="m">M-明威塔机</span><span class="s">SDMWTJ</span></a><b></b></li>
  <li class="br01"><a data-val="16863" title="脉辉" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16863_0.shtm"><span class="m">M-脉辉</span><span class="s">MAIHUI</span></a><b></b></li>
  <li class="br01"><a data-val="16865" title="美通重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16865_0.shtm"><span class="m">M-美通重工</span><span class="s">MANTALL</span></a><b></b></li>
  <li class="br01"><a data-val="16867" title="曼克斯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16867_0.shtm"><span class="m">M-曼克斯</span><span class="s">UpRight Powered Access</span></a><b></b></li>
  <li class="br02"><a data-val="13696" title="美卓" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13696_0.shtm"><span class="m">M-美卓</span><span class="s">METSO</span></a><b></b></li>
  <li class="br01"><a data-val="13697" title="闽工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13697_0.shtm"><span class="m">M-闽工</span><span class="s">MINGONG</span></a><b></b></li>
  <li class="br01"><a data-val="16487" title="上海明工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16487_0.shtm"><span class="m">M-上海明工</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16371" title="明宇重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16371_0.shtm"><span class="m">M-明宇重工</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16490" title="明诚" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16490_0.shtm"><span class="m">M-明诚</span><span class="s">MC</span></a><b></b></li>
  <li class="br01"><a data-val="16864" title="米玛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16864_0.shtm"><span class="m">M-米玛</span><span class="s">MIMA</span></a><b></b></li>
  <li class="br01"><a data-val="16542" title="明於" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16542_0.shtm"><span class="m">M-明於</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="13095" title="美通筑机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13095_0.shtm"><span class="m">M-美通筑机</span><span class="s">METONG</span></a><b></b></li>
  <li class="br02"><a data-val="1743" title="美科斯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1743_0.shtm"><span class="m">M-美科斯</span><span class="s">MAXFORKLIFT</span></a><b></b></li>
  <li class="br01"><a data-val="169" title="南特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_169_0.shtm"><span class="m">N-南特</span><span class="s">NANTE</span></a><b></b></li>
  <li class="br01"><a data-val="200" title="南方路机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_200_0.shtm"><span class="m">N-南方路机</span><span class="s">NFLG</span></a><b></b></li>
  <li class="br01"><a data-val="1209" title="中国南车" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1209_0.shtm"><span class="m">N-中国南车</span><span class="s">CSRTI</span></a><b></b></li>
  <li class="br01"><a data-val="14249" title="宁工股份" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14249_0.shtm"><span class="m">N-宁工股份</span><span class="s">NINGKING</span></a><b></b></li>
  <li class="br01"><a data-val="13698" title="南侨" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13698_0.shtm"><span class="m">N-南侨</span><span class="s">CHINAEMA</span></a><b></b></li>
  <li class="br01"><a data-val="13699" title="诺力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13699_0.shtm"><span class="m">N-诺力</span><span class="s">NOBLELIFT</span></a><b></b></li>
  <li class="br01"><a data-val="1585" title="诺森" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1585_0.shtm"><span class="m">N-诺森</span><span class="s">NUOSEN</span></a><b></b></li>
  <li class="br01"><a data-val="14186" title="诺尔" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14186_0.shtm"><span class="m">N-诺尔</span><span class="s">NOELLCHINA</span></a><b></b></li>
  <li class="br01"><a data-val="16846" title="欧历胜" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16846_0.shtm"><span class="m">O-欧历胜</span><span class="s">Haulotte</span></a><b></b></li>
  <li class="br01"><a data-val="156" title="上海彭浦" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_156_0.shtm"><span class="m">P-上海彭浦</span><span class="s">SPPMBP</span></a><b></b></li>
  <li class="br01"><a data-val="403" title="普堃韩泰克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_403_0.shtm"><span class="m">P-普堃韩泰克</span><span class="s">PUKUN</span></a><b></b></li>
  <li class="br01"><a data-val="16866" title="普雷斯特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16866_0.shtm"><span class="m">P-普雷斯特</span><span class="s">PRECEDE</span></a><b></b></li>
  <li class="br02"><a data-val="198" title="全进重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_198_0.shtm"><span class="m">Q-全进重工</span><span class="s">JUNJINGROUP</span></a><b></b></li>
  <li class="br01"><a data-val="13704" title="泉成" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13704_0.shtm"><span class="m">Q-泉成</span><span class="s">FJQCM</span></a><b></b></li>
  <li class="br01"><a data-val="13707" title="群峰智能" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13707_0.shtm"><span class="m">Q-群峰智能</span><span class="s">QUNFENG.</span></a><b></b></li>
  <li class="br01"><a data-val="13708" title="青山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13708_0.shtm"><span class="m">Q-青山</span><span class="s">LNQSZG</span></a><b></b></li>
  <li class="br01"><a data-val="582" title="勤牛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_582_0.shtm"><span class="m">Q-勤牛</span><span class="s">CQQNWJ</span></a><b></b></li>
  <li class="br01"><a data-val="686" title="七天阳" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_686_0.shtm"><span class="m">Q-七天阳</span><span class="s">QTYANG</span></a><b></b></li>
  <li class="br02"><a data-val="16778" title="烟台全进" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16778_0.shtm"><span class="m">Q-烟台全进</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16441" title="强力路桥" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16441_0.shtm"><span class="m">Q-强力路桥</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="1750" title="全工机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1750_0.shtm"><span class="m">Q-全工机械</span><span class="s">QUANGONGJIXIE</span></a><b></b></li>
  <li class="br02"><a data-val="184" title="日立" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_184_0.shtm"><span class="m">R-日立</span><span class="s">HITACHI</span></a><b></b></li>
  <li class="br02"><a data-val="196" title="日工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_196_0.shtm"><span class="m">R-日工</span><span class="s">NIKKO-SH</span></a><b></b></li>
  <li class="br02"><a data-val="16367" title="永立建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16367_0.shtm"><span class="m">R-永立建机</span><span class="s">HITACHI</span></a><b></b></li>
  <li class="br01"><a data-val="14211" title="润邦机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14211_0.shtm"><span class="m">R-润邦机械</span><span class="s">RUNBOOM</span></a><b></b></li>
  <li class="br01"><a data-val="133" title="三一" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_133_0.shtm"><span class="m">S-三一</span><span class="s">SANY</span></a><b></b></li>
  <li class="br01"><a data-val="138" title="山工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_138_0.shtm"><span class="m">S-山工</span><span class="s">SEM</span></a><b></b></li>
  <li class="br01"><a data-val="144" title="山推" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_144_0.shtm"><span class="m">S-山推</span><span class="s">SHANTUI</span></a><b></b></li>
  <li class="br02"><a data-val="183" title="神钢" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_183_0.shtm"><span class="m">S-神钢</span><span class="s">KOBELCO</span></a><b></b></li>
  <li class="br01"><a data-val="142" title="山河智能" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_142_0.shtm"><span class="m">S-山河智能</span><span class="s">SUNWARD</span></a><b></b></li>
  <li class="br01"><a data-val="152" title="山重建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_152_0.shtm"><span class="m">S-山重建机</span><span class="s">STRONGEST</span></a><b></b></li>
  <li class="br02"><a data-val="454" title="山猫" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_454_0.shtm"><span class="m">S-山猫</span><span class="s">BOBCAT</span></a><b></b></li>
  <li class="br02"><a data-val="190" title="石川岛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_190_0.shtm"><span class="m">S-石川岛</span><span class="s">IHISCE</span></a><b></b></li>
  <li class="br01"><a data-val="201" title="上海金泰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_201_0.shtm"><span class="m">S-上海金泰</span><span class="s">SHJINTAI</span></a><b></b></li>
  <li class="br02"><a data-val="419" title="水山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_419_0.shtm"><span class="m">S-水山</span><span class="s">SOOSANXM</span></a><b></b></li>
  <li class="br01"><a data-val="14235" title="神娃" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14235_0.shtm"><span class="m">S-神娃</span><span class="s">SHENWA</span></a><b></b></li>
  <li class="br01"><a data-val="618" title="盛普隆" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_618_0.shtm"><span class="m">S-盛普隆</span><span class="s">SUPERLION</span></a><b></b></li>
  <li class="br01"><a data-val="668" title="陕建机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_668_0.shtm"><span class="m">S-陕建机械</span><span class="s">SCMC-XA</span></a><b></b></li>
  <li class="br02"><a data-val="1113" title="神斧" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1113_0.shtm"><span class="m">S-神斧</span><span class="s">SHENGFU</span></a><b></b></li>
  <li class="br01"><a data-val="1117" title="四川建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1117_0.shtm"><span class="m">S-四川建机</span><span class="s">SCM</span></a><b></b></li>
  <li class="br01"><a data-val="16368" title="赛地" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16368_0.shtm"><span class="m">S-赛地</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16433" title="生建" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16433_0.shtm"><span class="m">S-生建</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16454" title="山东鑫路通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16454_0.shtm"><span class="m">S-山东鑫路通</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16455" title="山特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16455_0.shtm"><span class="m">S-山特</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16421" title="上工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16421_0.shtm"><span class="m">S-上工</span><span class="s">SEMW</span></a><b></b></li>
  <li class="br01"><a data-val="16428" title="万里" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16428_0.shtm"><span class="m">S-万里</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16430" title="陕西现代" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16430_0.shtm"><span class="m">S-陕西现代</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16543" title="三和" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16543_0.shtm"><span class="m">S-三和</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="13711" title="仕高玛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13711_0.shtm"><span class="m">S-仕高玛</span><span class="s">SICOMA</span></a><b></b></li>
  <li class="br01"><a data-val="13713" title="森远" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13713_0.shtm"><span class="m">S-森远</span><span class="s">SENYUAN</span></a><b></b></li>
  <li class="br01"><a data-val="13715" title="上海西芝" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13715_0.shtm"><span class="m">S-上海西芝</span><span class="s">ZENITH</span></a><b></b></li>
  <li class="br01"><a data-val="13718" title="上力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13718_0.shtm"><span class="m">S-上力</span><span class="s">SAL</span></a><b></b></li>
  <li class="br01"><a data-val="16774" title="山宇重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16774_0.shtm"><span class="m">S-山宇重工</span><span class="s">SHANYU</span></a><b></b></li>
  <li class="br01"><a data-val="1711" title="扫地王" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1711_0.shtm"><span class="m">S-扫地王</span><span class="s">SWEEPACE</span></a><b></b></li>
  <li class="br02"><a data-val="14279" title="斯泰克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14279_0.shtm"><span class="m">S-斯泰克</span><span class="s">STRIKER</span></a><b></b></li>
  <li class="br01"><a data-val="16373" title="原装神钢" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16373_0.shtm"><span class="m">S-原装神钢</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16463" title="三民重科" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16463_0.shtm"><span class="m">S-三民重科</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16781" title="神工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16781_0.shtm"><span class="m">S-神工</span><span class="s">SEGO</span></a><b></b></li>
  <li class="br01"><a data-val="16500" title="师锐" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16500_0.shtm"><span class="m">S-师锐</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16484" title="圣都" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16484_0.shtm"><span class="m">S-圣都</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16535" title="山卓" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16535_0.shtm"><span class="m">S-山卓</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="14248" title="赛宇" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14248_0.shtm"><span class="m">S-赛宇</span><span class="s">SAIYU</span></a><b></b></li>
  <li class="br01"><a data-val="13739" title="嵩山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13739_0.shtm"><span class="m">S-嵩山</span><span class="s">SSZG</span></a><b></b></li>
  <li class="br01"><a data-val="13740" title="三力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13740_0.shtm"><span class="m">S-三力</span><span class="s">SANLI</span></a><b></b></li>
  <li class="br01"><a data-val="13742" title="四通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13742_0.shtm"><span class="m">S-四通</span><span class="s">STZG</span></a><b></b></li>
  <li class="br01"><a data-val="13655" title="石煤" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13655_0.shtm"><span class="m">S-石煤</span><span class="s">JZNY</span></a><b></b></li>
  <li class="br02"><a data-val="13721" title="三菱" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13721_0.shtm"><span class="m">S-三菱</span><span class="s">GRENDIA</span></a><b></b></li>
  <li class="br02"><a data-val="13722" title="斯贝柯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13722_0.shtm"><span class="m">S-斯贝柯</span><span class="s">SPECO</span></a><b></b></li>
  <li class="br01"><a data-val="13735" title="上海建冶" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13735_0.shtm"><span class="m">S-上海建冶</span><span class="s">SHJY</span></a><b></b></li>
  <li class="br01"><a data-val="1753" title="陕汽" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1753_0.shtm"><span class="m">S-陕汽</span><span class="s">SXQC</span></a><b></b></li>
  <li class="br01"><a data-val="1722" title="山猛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1722_0.shtm"><span class="m">S-山猛</span><span class="s">WEIMENG</span></a><b></b></li>
  <li class="br01"><a data-val="13744" title="山东汇强" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13744_0.shtm"><span class="m">S-山东汇强</span><span class="s">VICON</span></a><b></b></li>
  <li class="br01"><a data-val="13747" title="山东明龙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13747_0.shtm"><span class="m">S-山东明龙</span><span class="s">MINGLONG</span></a><b></b></li>
  <li class="br02"><a data-val="13749" title="三笠" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13749_0.shtm"><span class="m">S-三笠</span><span class="s">MIKASA</span></a><b></b></li>
  <li class="br01"><a data-val="13751" title="思拓瑞克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13751_0.shtm"><span class="m">S-思拓瑞克</span><span class="s">STORIKE</span></a><b></b></li>
  <li class="br01"><a data-val="13727" title="世邦" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13727_0.shtm"><span class="m">S-世邦</span><span class="s">SBM</span></a><b></b></li>
  <li class="br01"><a data-val="13728" title="陕西科尼乐" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13728_0.shtm"><span class="m">S-陕西科尼乐</span><span class="s">SISOUL</span></a><b></b></li>
  <li class="br01"><a data-val="13729" title="思嘉特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13729_0.shtm"><span class="m">S-思嘉特</span><span class="s">SIJIATE</span></a><b></b></li>
  <li class="br01"><a data-val="13730" title="森源" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13730_0.shtm"><span class="m">S-森源</span><span class="s">SENYUAN</span></a><b></b></li>
  <li class="br01"><a data-val="13731" title="山美" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13731_0.shtm"><span class="m">S-山美</span><span class="s">SANME</span></a><b></b></li>
  <li class="br01"><a data-val="13732" title="三联" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13732_0.shtm"><span class="m">S-三联</span><span class="s">SLJX</span></a><b></b></li>
  <li class="br01"><a data-val="1090" title="盛利达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1090_0.shtm"><span class="m">S-盛利达</span><span class="s">SHENGLIDA</span></a><b></b></li>
  <li class="br01"><a data-val="830" title="沈阳三洋" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_830_0.shtm"><span class="m">S-沈阳三洋</span><span class="s">SYSY</span></a><b></b></li>
  <li class="br01"><a data-val="868" title="赛通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_868_0.shtm"><span class="m">S-赛通</span><span class="s">SAITONG</span></a><b></b></li>
  <li class="br01"><a data-val="1138" title="升立建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1138_0.shtm"><span class="m">S-升立建机</span><span class="s">SEHNGLI</span></a><b></b></li>
  <li class="br01"><a data-val="1123" title="山东华夏" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1123_0.shtm"><span class="m">S-山东华夏</span><span class="s">HUAXIA</span></a><b></b></li>
  <li class="br01"><a data-val="691" title="上海华建" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_691_0.shtm"><span class="m">S-上海华建</span><span class="s">SHHUAJIAN</span></a><b></b></li>
  <li class="br01"><a data-val="1523" title="神马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1523_0.shtm"><span class="m">S-神马</span><span class="s">SHENMA</span></a><b></b></li>
  <li class="br02"><a data-val="1304" title="山特维克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1304_0.shtm"><span class="m">S-山特维克</span><span class="s">SANDVIK</span></a><b></b></li>
  <li class="br01"><a data-val="1221" title="山宝" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1221_0.shtm"><span class="m">S-山宝</span><span class="s">SHANBAO</span></a><b></b></li>
  <li class="br02"><a data-val="176" title="特雷克斯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_176_0.shtm"><span class="m">T-特雷克斯</span><span class="s">TEREX</span></a><b></b></li>
  <li class="br01"><a data-val="14261" title="泰信机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14261_0.shtm"><span class="m">T-泰信机械</span><span class="s">TYSIM</span></a><b></b></li>
  <li class="br01"><a data-val="217" title="铁力士" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_217_0.shtm"><span class="m">T-铁力士</span><span class="s">HONGDA</span></a><b></b></li>
  <li class="br02"><a data-val="404" title="泰戈" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_404_0.shtm"><span class="m">T-泰戈</span><span class="s">TIGER</span></a><b></b></li>
  <li class="br01"><a data-val="218" title="铁拓" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_218_0.shtm"><span class="m">T-铁拓</span><span class="s">TIETUO</span></a><b></b></li>
  <li class="br01"><a data-val="774" title="天为" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_774_0.shtm"><span class="m">T-天为</span><span class="s">TIANWEI</span></a><b></b></li>
  <li class="br01"><a data-val="827" title="腾迈" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_827_0.shtm"><span class="m">T-腾迈</span><span class="s">SHTENGMAI</span></a><b></b></li>
  <li class="br01"><a data-val="1730" title="台励福" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1730_0.shtm"><span class="m">T-台励福</span><span class="s">TAILIFT</span></a><b></b></li>
  <li class="br01"><a data-val="1728" title="泰安鲁能" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1728_0.shtm"><span class="m">T-泰安鲁能</span><span class="s">LUNENGMACHINERY</span></a><b></b></li>
  <li class="br01"><a data-val="1760" title="无锡泰特" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1760_0.shtm"><span class="m">T-无锡泰特</span><span class="s">HONGXINGWUXI</span></a><b></b></li>
  <li class="br01"><a data-val="1726" title="通亚汽车" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1726_0.shtm"><span class="m">T-通亚汽车</span><span class="s">CHINATONGYA</span></a><b></b></li>
  <li class="br01"><a data-val="16384" title="滕州远大" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16384_0.shtm"><span class="m">T-滕州远大</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16396" title="拓兴机电" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16396_0.shtm"><span class="m">T-拓兴机电</span><span class="s"></span></a><b></b></li>
  <li class="br02"><a data-val="1353" title="泰石克" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1353_0.shtm"><span class="m">T-泰石克</span><span class="s">TEISAKU</span></a><b></b></li>
  <li class="br01"><a data-val="538" title="太腾" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_538_0.shtm"><span class="m">T-太腾</span><span class="s">TAITENG</span></a><b></b></li>
  <li class="br01"><a data-val="1719" title="德威土行孙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1719_0.shtm"><span class="m">T-德威土行孙</span><span class="s">DWTXS</span></a><b></b></li>
  <li class="br01"><a data-val="13752" title="田中铁工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13752_0.shtm"><span class="m">T-田中铁工</span><span class="s">TZTG</span></a><b></b></li>
  <li class="br01"><a data-val="13754" title="天顺长城" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13754_0.shtm"><span class="m">T-天顺长城</span><span class="s">TSUN</span></a><b></b></li>
  <li class="br01"><a data-val="13755" title="天宇" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13755_0.shtm"><span class="m">T-天宇</span><span class="s">TIANYU</span></a><b></b></li>
  <li class="br01"><a data-val="1758" title="铁建" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1758_0.shtm"><span class="m">T-铁建</span><span class="s">CRTSG</span></a><b></b></li>
  <li class="br01"><a data-val="14221" title="TCM" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14221_0.shtm"><span class="m">T-TCM</span><span class="s">TCM</span></a><b></b></li>
  <li class="br01"><a data-val="1211" title="同力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1211_0.shtm"><span class="m">T-同力</span><span class="s">SNTONLY</span></a><b></b></li>
  <li class="br02"><a data-val="175" title="沃尔沃" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_175_0.shtm"><span class="m">W-沃尔沃</span><span class="s">VOLVO</span></a><b></b></li>
  <li class="br01"><a data-val="149" title="沃得重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_149_0.shtm"><span class="m">W-沃得重工</span><span class="s">WORLD</span></a><b></b></li>
  <li class="br02"><a data-val="214" title="维特根" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_214_0.shtm"><span class="m">W-维特根</span><span class="s">WIRTGEN</span></a><b></b></li>
  <li class="br01"><a data-val="1189" title="威肯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1189_0.shtm"><span class="m">W-威肯</span><span class="s">WEIKEN</span></a><b></b></li>
  <li class="br01"><a data-val="662" title="沃尔华" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_662_0.shtm"><span class="m">W-沃尔华</span><span class="s">WALLHUA</span></a><b></b></li>
  <li class="br02"><a data-val="16839" title="威克诺森" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16839_0.shtm"><span class="m">W-威克诺森</span><span class="s">wackerneuson</span></a><b></b></li>
  <li class="br01"><a data-val="16787" title="旺远液压" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16787_0.shtm"><span class="m">W-旺远液压</span><span class="s"></span></a><b></b></li>
  <li class="br02"><a data-val="491" title="威猛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_491_0.shtm"><span class="m">W-威猛</span><span class="s">VERMEER</span></a><b></b></li>
  <li class="br01"><a data-val="16534" title="巍立路桥" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16534_0.shtm"><span class="m">W-巍立路桥</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16395" title="无锡华通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16395_0.shtm"><span class="m">W-无锡华通</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="14263" title="潍柴特种车" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14263_0.shtm"><span class="m">W-潍柴特种车</span><span class="s">SHENGDA</span></a><b></b></li>
  <li class="br01"><a data-val="13733" title="威博士" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13733_0.shtm"><span class="m">W-威博士</span><span class="s">WEIBOS</span></a><b></b></li>
  <li class="br01"><a data-val="1140" title="威海固恒" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1140_0.shtm"><span class="m">W-威海固恒</span><span class="s">GUHENG</span></a><b></b></li>
  <li class="br01"><a data-val="1738" title="威盛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1738_0.shtm"><span class="m">W-威盛</span><span class="s">WEISHENG</span></a><b></b></li>
  <li class="br01"><a data-val="209" title="徐工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_209_0.shtm"><span class="m">X-徐工</span><span class="s">XCMG</span></a><b></b></li>
  <li class="br02"><a data-val="182" title="小松" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_182_0.shtm"><span class="m">X-小松</span><span class="s">KOMATSU</span></a><b></b></li>
  <li class="br01"><a data-val="139" title="厦工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_139_0.shtm"><span class="m">X-厦工</span><span class="s">XGMA</span></a><b></b></li>
  <li class="br02"><a data-val="194" title="现代" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_194_0.shtm"><span class="m">X-现代</span><span class="s">HYUNDAI</span></a><b></b></li>
  <li class="br01"><a data-val="154" title="宣工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_154_0.shtm"><span class="m">X-宣工</span><span class="s">HBXG</span></a><b></b></li>
  <li class="br01"><a data-val="1097" title="星邦重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1097_0.shtm"><span class="m">X-星邦重工</span><span class="s">sinoboom</span></a><b></b></li>
  <li class="br01"><a data-val="13177" title="西林" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13177_0.shtm"><span class="m">X-西林</span><span class="s">XILIN</span></a><b></b></li>
  <li class="br01"><a data-val="14112" title="烟台信人" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14112_0.shtm"><span class="m">X-烟台信人</span><span class="s">YTXINREN</span></a><b></b></li>
  <li class="br01"><a data-val="13788" title="雄辉" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13788_0.shtm"><span class="m">X-雄辉</span><span class="s">XIONGHUI</span></a><b></b></li>
  <li class="br01"><a data-val="13175" title="厦金" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13175_0.shtm"><span class="m">X-厦金</span><span class="s">XIAJIN</span></a><b></b></li>
  <li class="br01"><a data-val="13778" title="西安路邦" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13778_0.shtm"><span class="m">X-西安路邦</span><span class="s">ROADBEST</span></a><b></b></li>
  <li class="br01"><a data-val="13779" title="青岛新型建设" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13779_0.shtm"><span class="m">X-青岛新型建设</span><span class="s">XING</span></a><b></b></li>
  <li class="br01"><a data-val="13783" title="厦装" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13783_0.shtm"><span class="m">X-厦装</span><span class="s">XIAZHUANG</span></a><b></b></li>
  <li class="br01"><a data-val="13785" title="欣融" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13785_0.shtm"><span class="m">X-欣融</span><span class="s">XR</span></a><b></b></li>
  <li class="br01"><a data-val="13777" title="西尔玛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13777_0.shtm"><span class="m">X-西尔玛</span><span class="s">XIERMA</span></a><b></b></li>
  <li class="br01"><a data-val="1235" title="信达机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1235_0.shtm"><span class="m">X-信达机械</span><span class="s">XDM</span></a><b></b></li>
  <li class="br01"><a data-val="1236" title="新天和" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1236_0.shtm"><span class="m">X-新天和</span><span class="s">NEWTIMEHOPE</span></a><b></b></li>
  <li class="br01"><a data-val="687" title="雪桃" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_687_0.shtm"><span class="m">X-雪桃</span><span class="s">XUETAO</span></a><b></b></li>
  <li class="br01"><a data-val="690" title="新筑股份" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_690_0.shtm"><span class="m">X-新筑股份</span><span class="s">XINZHU</span></a><b></b></li>
  <li class="br01"><a data-val="1744" title="厦盛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1744_0.shtm"><span class="m">X-厦盛</span><span class="s">XIASHENG</span></a><b></b></li>
  <li class="br01"><a data-val="1741" title="小橋" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1741_0.shtm"><span class="m">X-小橋</span><span class="s">XIAOQIAO</span></a><b></b></li>
  <li class="br01"><a data-val="1589" title="西贝" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1589_0.shtm"><span class="m">X-西贝</span><span class="s">XIBEI</span></a><b></b></li>
  <li class="br01"><a data-val="623" title="犀牛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_623_0.shtm"><span class="m">X-犀牛</span><span class="s">RHINOCEROS</span></a><b></b></li>
  <li class="br01"><a data-val="1725" title="信瑞重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1725_0.shtm"><span class="m">X-信瑞重工</span><span class="s">ZJHQ</span></a><b></b></li>
  <li class="br01"><a data-val="16390" title="兴旺达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16390_0.shtm"><span class="m">X-兴旺达</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16408" title="鑫通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16408_0.shtm"><span class="m">X-鑫通</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16416" title="新钻" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16416_0.shtm"><span class="m">X-新钻</span><span class="s">XINZUAN</span></a><b></b></li>
  <li class="br01"><a data-val="16417" title="厦工楚胜" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16417_0.shtm"><span class="m">X-厦工楚胜</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16531" title="现代海麟" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16531_0.shtm"><span class="m">X-现代海麟</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="1683" title="新源" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1683_0.shtm"><span class="m">X-新源</span><span class="s">XINYUAN</span></a><b></b></li>
  <li class="br01"><a data-val="1227" title="现代建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1227_0.shtm"><span class="m">X-现代建机</span><span class="s">XDJJ</span></a><b></b></li>
  <li class="br01"><a data-val="16372" title="泉州鑫豪" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16372_0.shtm"><span class="m">X-泉州鑫豪</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16477" title="鑫华" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16477_0.shtm"><span class="m">X-鑫华</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16458" title="鑫海路机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16458_0.shtm"><span class="m">X-鑫海路机</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="867" title="徐州凯尔" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_867_0.shtm"><span class="m">X-徐州凯尔</span><span class="s">XZKAIER</span></a><b></b></li>
  <li class="br01"><a data-val="146" title="玉柴" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_146_0.shtm"><span class="m">Y-玉柴</span><span class="s">YUCHAIHI</span></a><b></b></li>
  <li class="br01"><a data-val="143" title="宇通重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_143_0.shtm"><span class="m">Y-宇通重工</span><span class="s">YUTONG</span></a><b></b></li>
  <li class="br01"><a data-val="1777" title="英轩重工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1777_0.shtm"><span class="m">Y-英轩重工</span><span class="s">ENSIGNHI</span></a><b></b></li>
  <li class="br01"><a data-val="161" title="移山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_161_0.shtm"><span class="m">Y-移山</span><span class="s">YISHAN</span></a><b></b></li>
  <li class="br02"><a data-val="191" title="洋马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_191_0.shtm"><span class="m">Y-洋马</span><span class="s">YANMAR</span></a><b></b></li>
  <li class="br01"><a data-val="408" title="友一" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_408_0.shtm"><span class="m">Y-友一</span><span class="s">UIL</span></a><b></b></li>
  <li class="br01"><a data-val="16862" title="优特力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16862_0.shtm"><span class="m">Y-优特力</span><span class="s">UTILEV</span></a><b></b></li>
  <li class="br01"><a data-val="13803" title="一帆" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13803_0.shtm"><span class="m">Y-一帆</span><span class="s">YIFAN</span></a><b></b></li>
  <li class="br01"><a data-val="13804" title="粤工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13804_0.shtm"><span class="m">Y-粤工</span><span class="s">YG</span></a><b></b></li>
  <li class="br01"><a data-val="13807" title="运想" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13807_0.shtm"><span class="m">Y-运想</span><span class="s">YXZ</span></a><b></b></li>
  <li class="br01"><a data-val="770" title="宜工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_770_0.shtm"><span class="m">Y-宜工</span><span class="s">YIGONG</span></a><b></b></li>
  <li class="br01"><a data-val="647" title="永工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_647_0.shtm"><span class="m">Y-永工</span><span class="s">HNYG</span></a><b></b></li>
  <li class="br01"><a data-val="562" title="愚公机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_562_0.shtm"><span class="m">Y-愚公机械</span><span class="s">YUGONG</span></a><b></b></li>
  <li class="br01"><a data-val="1231" title="一拖（洛阳）" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1231_0.shtm"><span class="m">Y-一拖（洛阳）</span><span class="s">YTO</span></a><b></b></li>
  <li class="br01"><a data-val="1643" title="江苏意玛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1643_0.shtm"><span class="m">Y-江苏意玛</span><span class="s">YIMATECH</span></a><b></b></li>
  <li class="br01"><a data-val="1092" title="圆友" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1092_0.shtm"><span class="m">Y-圆友</span><span class="s">YUANYOU</span></a><b></b></li>
  <li class="br01"><a data-val="13796" title="豫弘" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13796_0.shtm"><span class="m">Y-豫弘</span><span class="s">YUHONG</span></a><b></b></li>
  <li class="br01"><a data-val="13797" title="岳首" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13797_0.shtm"><span class="m">Y-岳首</span><span class="s">YUESHOU</span></a><b></b></li>
  <li class="br01"><a data-val="13798" title="亚洁" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13798_0.shtm"><span class="m">Y-亚洁</span><span class="s">CLEANINGMF</span></a><b></b></li>
  <li class="br01"><a data-val="13799" title="远东" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13799_0.shtm"><span class="m">Y-远东</span><span class="s">YD</span></a><b></b></li>
  <li class="br01"><a data-val="13736" title="远华" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13736_0.shtm"><span class="m">Y-远华</span><span class="s">YHLQ</span></a><b></b></li>
  <li class="br01"><a data-val="13791" title="亿龙" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13791_0.shtm"><span class="m">Y-亿龙</span><span class="s">YILONGMACHINERY</span></a><b></b></li>
  <li class="br01"><a data-val="13792" title="易山" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13792_0.shtm"><span class="m">Y-易山</span><span class="s">ESUN</span></a><b></b></li>
  <li class="br01"><a data-val="13793" title="英达" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13793_0.shtm"><span class="m">Y-英达</span><span class="s">FREETECH</span></a><b></b></li>
  <li class="br01"><a data-val="13794" title="原进" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13794_0.shtm"><span class="m">Y-原进</span><span class="s">YUANJIN</span></a><b></b></li>
  <li class="br01"><a data-val="14250" title="青岛雅凯" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14250_0.shtm"><span class="m">Y-青岛雅凯</span><span class="s">YAKAI</span></a><b></b></li>
  <li class="br01"><a data-val="16559" title="钇广重机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16559_0.shtm"><span class="m">Y-钇广重机</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16841" title="玉柴机器" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16841_0.shtm"><span class="m">Y-玉柴机器</span><span class="s">YC</span></a><b></b></li>
  <li class="br01"><a data-val="16415" title="岩鼎" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16415_0.shtm"><span class="m">Y-岩鼎</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16409" title="永力通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16409_0.shtm"><span class="m">Y-永力通</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16413" title="玉柴专汽" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16413_0.shtm"><span class="m">Y-玉柴专汽</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16327" title="友一道路" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16327_0.shtm"><span class="m">Y-友一道路</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="1152" title="圆鑫建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1152_0.shtm"><span class="m">Y-圆鑫建机</span><span class="s">YUANXIN</span></a><b></b></li>
  <li class="br02"><a data-val="14238" title="约翰迪尔" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14238_0.shtm"><span class="m">Y-约翰迪尔</span><span class="s">JOHN DEERE</span></a><b></b></li>
  <li class="br01"><a data-val="1751" title="银锚建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1751_0.shtm"><span class="m">Y-银锚建机</span><span class="s">YINMAO</span></a><b></b></li>
  <li class="br01"><a data-val="1930" title="永安" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1930_0.shtm"><span class="m">Y-永安</span><span class="s">YONGAN</span></a><b></b></li>
  <li class="br01"><a data-val="843" title="永茂" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_843_0.shtm"><span class="m">Y-永茂</span><span class="s">YONGMAO</span></a><b></b></li>
  <li class="br01"><a data-val="16468" title="野牛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16468_0.shtm"><span class="m">Y-野牛</span><span class="s">eniu</span></a><b></b></li>
  <li class="br01"><a data-val="16780" title="驭工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16780_0.shtm"><span class="m">Y-驭工</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16495" title="悦工" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16495_0.shtm"><span class="m">Y-悦工</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="134" title="中联重科" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_134_0.shtm"><span class="m">Z-中联重科</span><span class="s">ZOOMLION</span></a><b></b></li>
  <li class="br02"><a data-val="185" title="住友" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_185_0.shtm"><span class="m">Z-住友</span><span class="s">SUMITOMO</span></a><b></b></li>
  <li class="br02"><a data-val="188" title="竹内" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_188_0.shtm"><span class="m">Z-竹内</span><span class="s">TAKEUCHI</span></a><b></b></li>
  <li class="br01"><a data-val="195" title="詹阳动力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_195_0.shtm"><span class="m">Z-詹阳动力</span><span class="s">JONYANG</span></a><b></b></li>
  <li class="br01"><a data-val="13809" title="筑马" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13809_0.shtm"><span class="m">Z-筑马</span><span class="s">ZHUMA</span></a><b></b></li>
  <li class="br01"><a data-val="1219" title="中环动力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1219_0.shtm"><span class="m">Z-中环动力</span><span class="s">ZHDL</span></a><b></b></li>
  <li class="br01"><a data-val="542" title="中交西筑" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_542_0.shtm"><span class="m">Z-中交西筑</span><span class="s">XRMC</span></a><b></b></li>
  <li class="br01"><a data-val="813" title="郑州富岛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_813_0.shtm"><span class="m">Z-郑州富岛</span><span class="s">FDM</span></a><b></b></li>
  <li class="br01"><a data-val="1106" title="中集华骏" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1106_0.shtm"><span class="m">Z-中集华骏</span><span class="s">HUAJUN</span></a><b></b></li>
  <li class="br01"><a data-val="1119" title="浙江建机" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1119_0.shtm"><span class="m">Z-浙江建机</span><span class="s">ZJJJ</span></a><b></b></li>
  <li class="br01"><a data-val="1095" title="上海振中" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1095_0.shtm"><span class="m">Z-上海振中</span><span class="s">ZHENZHONG</span></a><b></b></li>
  <li class="br01"><a data-val="1214" title="中国重汽" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1214_0.shtm"><span class="m">Z-中国重汽</span><span class="s">CNHTC</span></a><b></b></li>
  <li class="br01"><a data-val="1136" title="江苏正兴" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1136_0.shtm"><span class="m">Z-江苏正兴</span><span class="s">JSZX</span></a><b></b></li>
  <li class="br01"><a data-val="13818" title="钻通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13818_0.shtm"><span class="m">Z-钻通</span><span class="s">ZT</span></a><b></b></li>
  <li class="br01"><a data-val="13819" title="中海恒通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13819_0.shtm"><span class="m">Z-中海恒通</span><span class="s">DRILL</span></a><b></b></li>
  <li class="br01"><a data-val="13820" title="中青林" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13820_0.shtm"><span class="m">Z-中青林</span><span class="s">SISOUL</span></a><b></b></li>
  <li class="br01"><a data-val="13821" title="泽通" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13821_0.shtm"><span class="m">Z-泽通</span><span class="s">ZETONG</span></a><b></b></li>
  <li class="br01"><a data-val="13823" title="中意" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13823_0.shtm"><span class="m">Z-中意</span><span class="s">ZHONGYI</span></a><b></b></li>
  <li class="br01"><a data-val="14220" title="浙江振中" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_14220_0.shtm"><span class="m">Z-浙江振中</span><span class="s">ZHENZHONG</span></a><b></b></li>
  <li class="br01"><a data-val="13810" title="中方" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13810_0.shtm"><span class="m">Z-中方</span><span class="s">ZFJX</span></a><b></b></li>
  <li class="br01"><a data-val="13811" title="浙江赤道" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13811_0.shtm"><span class="m">Z-浙江赤道</span><span class="s">ZJCD</span></a><b></b></li>
  <li class="br01"><a data-val="13813" title="中际" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13813_0.shtm"><span class="m">Z-中际</span><span class="s">ZHONGJI</span></a><b></b></li>
  <li class="br01"><a data-val="13815" title="中誉鼎力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13815_0.shtm"><span class="m">Z-中誉鼎力</span><span class="s">ZYDL</span></a><b></b></li>
  <li class="br01"><a data-val="13816" title="郑州鼎盛" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13816_0.shtm"><span class="m">Z-郑州鼎盛</span><span class="s">ZZDS</span></a><b></b></li>
  <li class="br01"><a data-val="13817" title="正泰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_13817_0.shtm"><span class="m">Z-正泰</span><span class="s">CHNT</span></a><b></b></li>
  <li class="br01"><a data-val="1951" title="中建机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_1951_0.shtm"><span class="m">Z-中建机械</span><span class="s">ZJJX</span></a><b></b></li>
  <li class="br01"><a data-val="16424" title="中通汽车" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16424_0.shtm"><span class="m">Z-中通汽车</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16453" title="中机机械" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16453_0.shtm"><span class="m">Z-中机机械</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16437" title="浙江志高" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16437_0.shtm"><span class="m">Z-浙江志高</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16548" title="卓仕" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16548_0.shtm"><span class="m">Z-卓仕</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16562" title="中首" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16562_0.shtm"><span class="m">Z-中首</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16532" title="中煤凿岩" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16532_0.shtm"><span class="m">Z-中煤凿岩</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16550" title="中泰" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16550_0.shtm"><span class="m">Z-中泰</span><span class="s"></span></a><b></b></li>
  <li class="br01"><a data-val="16552" title="卓展诺力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16552_0.shtm"><span class="m">Z-卓展诺力</span><span class="s">NOBLIFT</span></a><b></b></li>
  <li class="br01"><a data-val="16861" title="杭州中力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16861_0.shtm"><span class="m">Z-杭州中力</span><span class="s">EP</span></a><b></b></li>
  <li class="br01"><a data-val="16782" title="浙江鼎力" href="/agent/<%=(province.equals("")?"0":province)%>_<%=catalog.equals("")?"0":catalog%>_16782_0.shtm"><span class="m">Z-浙江鼎力</span><span class="s"></span></a><b></b></li>
</ul>

          <div class="av-options"> <a href="javascript:;" class="j_Multiple avo-multiple"><span>多选</span><i></i></a> <a href="javascript:;" class="j_More avo-more ui-more-drop-l">更多<i class="ui-more-drop-l-arrow" ></i></a> </div>
          <div class="av-btns" style="display:none;"> <a id="multipleBrand01" href="javascript:;" class="j_SubmitBtn ui-btn-s-primary ui-btn-disable">确定</a> <a href="javascript:;" class="j_CancelBtn ui-btn-s">取消</a> </div>
        </div>
      </div>
      <input type="hidden" id="catalog" name="catalog" value="">
      <input type="hidden" id="tonandmeter" name="tonandmeter" value="">
      <input type="hidden" id="letter" name="letter">
    </div>
    <!--筛选 end-->
  </div>
</div>
<!--筛选 end-->
<!--recommend-->
<div class="recommend fix">
  <div class="left_box">
    <div class="rcmd_left" >
      <!--<div class="rcmd_bar">
        <span>推荐代理商</span>
      </div>-->
      <ul <%if(agents.size()<=0){%>style="text-align:center;height:85px"<%}%>>
        <%
	   if(agents.size()>0){
	   		int i=0;
		    for(SolrDocument m : agents){   
		    String id=CommonString.getFormatPara(m.getFieldValue("id"));
		    String is_qijiandian=CommonString.getFormatPara(m.getFieldValue("is_qijiandian"));
			String full_name = CommonString.getFormatPara(m.getFieldValue("full_name"));		
			String is_made = CommonString.getFormatPara(m.getFieldValue("is_made"));
			String usern = CommonString.getFormatPara(m.getFieldValue("usern"));
			String policy = CommonString.getFormatPara(m.getFieldValue("policy"));
			String introduce=CommonHtml.filterHTML(CommonString.getFormatPara(m.getFieldValue("introduce"))).replace("　","");
			if(introduce.length()>=90){introduce=introduce.substring(0,90)+"...";}
		    String agent_city = CommonString.getFormatPara(m.getFieldValue("city"));    
			String agent_fac_name = CommonString.getFormatPara(m.getFieldValue("agent_fac_name"));		
			String img1= CommonString.getFormatPara(m.getFieldValue("img1"));
			String address = CommonString.getFormatPara(m.getFieldValue("address"));	
			String telphone = CommonString.getFormatPara(m.getFieldValue("telphone"));											
			String lng = CommonString.getFormatPara(m.getFieldValue("lng"));	
			String lat = CommonString.getFormatPara(m.getFieldValue("lat"));
			if(img1.indexOf("uploadfiles")>=0){
				img1="http://product.21-sun.com/"+img1;
			}else{
				img1="http://product.21-sun.com/uploadfiles/"+img1;
			}
            if(agent_city.length()>=100){
				agent_city=agent_city.substring(0,100)+"...";
			}	
            String url="";
			String proUrl="";
			if(is_qijiandian.equals("1")){
			    url="/agentstore/"+usern+"/";
				proUrl="/agentstore/"+usern+"/agent_products.shtm";
            }else{
				url="/agent/"+usern+"/";
				proUrl="/agent/"+usern+"/agent_products.shtm";
			}	
			if(id.equals("319")){
				url="http://xaas.product.21-sun.com/";
				proUrl="http://xaas.product.21-sun.com/agent_products.htm";
			}
			mapDatas+="{'url':'"+url+"','title':'"+full_name+"','content':'代理品牌："+agent_fac_name+"<br />地址："+address+"<br />电话："+telphone+"','lng_lat':'"+lng+","+lat+"','zoom':'10'},";
			
	  %>
        <li>
          <div class="rcmd_pic"><a title="<%=full_name%>" alt="<%=full_name%>" target="_blank" href="<%=url%>"><img style="height:116px"  onerror="this.src='/uploadfiles/no_big.gif'" src="<%=img1%>"></a></div>
          <div class="rcmd_list">
            <h3><a title="<%=full_name%>" target="_blank" href="<%=url%>" style="color:#434343"><img   src="/images/map/<%=i+1%>.png" />&nbsp;&nbsp;<%=full_name%></a></h3>
            <p>代理区域：<span><%=agent_city%></span></p>
            <p>代理品牌：<span><%=agent_fac_name%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><a target="_blank" style="color:#434343" href="<%=proUrl%>">【查看所有代理机型】</a></strong></p>
            <%if(!address.equals("")){%>
            <p>公司地址：<span><%=address%></span></p>
            <%}%>
            <a class="search_tel"  data-val="<%=id%>"   href="javascript:;" >点击查看联系电话</a> </div>
        </li>
        <%i++;}}else{%>
        <span style="font-size:18px;color:#FF7700;font-weight:normal;line-height:50px;width:800px;">您好，没有为您找到符合条件的代理商信息。</span> <span style="font-size:18px;color:#FF7700;font-weight:normal;line-height:50px;width:800px;float:left;margin-top:-18px">您可以试试查找其他区域或品牌的代理商，或者可以直接拨打人工服务热线：4006-603-068</span>
        <%}%>
      </ul>
    </div>
    <div <%if(agents.size()>0){%>style="width:834px;height:30px;margin-top:12px"<%}%>>
      <%  
			if(mapDatas.length()>=3){
				mapDatas=mapDatas.substring(0,mapDatas.length()-1);
			}
		    if("".equals(catalog)){catalog="0";}
            if("".equals(factoryid)){factoryid="0";}
            if("".equals(province)){province="0";}
            if("".equals(city)){city="0";}
		%>
      <tags:page_agent_solr nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" province="<%=province %>" city="<%=city %>"  factoryid="<%=factoryid%>"  catalog="<%=catalog%>" />
    </div>
 
  </div>
  <div class="right_box" id="right_box">
    <div class="themap">
      <div class="map" id="map" name="map" style="height:300px"> </div>
    </div>
    <div class="rcmd_right">
      <div class="rcmd_right_bar"> <span>推荐代理商</span> </div>
      <ul>
	  
	          <li>
          <div class="agent_name">
            <div class="logo_pic"><a title="西安安松工程机械有限责任公司"  alt="西安安松工程机械有限责任公司"  target="_blank" href="http://xaas.product.21-sun.com/"><img style="padding-top:8px" src="/images/xiansong.jpg"></a></div>
          </div>
          <div class="agent_detail"> <a title="西安安松工程机械有限责任公司"  target="_blank"  href="http://xaas.product.21-sun.com/">
            <h3 style="font-size:14px">西安安松工程机械有限责任公司</h3>
            </a> 代理品牌：小松 </div>
        </li>
	  
        <li>
          <div class="agent_name">
            <div class="logo_pic"><a title="千里马工程机械集团股份有限公司"  alt="千里马工程机械集团股份有限公司"  target="_blank" href="http://product.21-sun.com/agentstore/qianlima/" target="_blank"><img style="padding-top:8px" src="/Static/images/temp/qianlima.gif"></a></div>
          </div>
          <div class="agent_detail"> <a title="千里马工程机械集团股份有限公司" target="_blank" href="http://product.21-sun.com/agentstore/qianlima/">
            <h3 style="font-size:14px">千里马工程机械集团股份有限公司</h3>
            </a> 代理品牌：斗山、临工、山猫 </div>
        </li>
		

		
        <li>
          <div class="agent_name">
            <div class="logo_pic"><a   title="广西松宇企业投资集团有限公司"  alt="广西松宇企业投资集团有限公司"  target="_blank" href="http://product.21-sun.com/agentstore/gxsy/"><img style="padding-top:8px" src="/Static/images/temp/songyu.gif"></a></div>
          </div>
          <div class="agent_detail"> <a   title="广西松宇企业投资集团有限公司" target="_blank" href="http://product.21-sun.com/agentstore/gxsy/">
            <h3 style="font-size:14px">广西松宇企业投资集团有限公司</h3>
            </a> 代理品牌：斗山、加藤、柳工 </div>
        </li>
        <li style="border-bottom-width:0;">
          <div class="agent_name">
            <div class="logo_pic"><a title="合肥湘元工程机械有限公司"  alt="合肥湘元工程机械有限公司"  target="_blank" href="http://product.21-sun.com/agentstore/hfxy/"><img style="padding-top:8px" src="/Static/images/temp/xiangyuan.gif"></a></div>
          </div>
          <div class="agent_detail"> <a  title="合肥湘元工程机械有限公司" target="_blank" href="http://product.21-sun.com/agentstore/hfxy/">
            <h3 style="font-size:14px">合肥湘元工程机械有限公司</h3>
            </a> 代理品牌：三一 </div>
        </li>
      </ul>
    </div>
  </div>
</div>
<!--recommend end-->
<!--main end-->
<!--foot-->
<jsp:include page="/include/new_foot.htm" flush="true"/>
<!--点击查看联系方式-->
<div class="wrap_contact_detail">
  <div class="contact_detail_box">
    <div class="contact_detail">
      <div class="scroll_content">
        <ul class="fix"  id="office_list">
        </ul>
      </div>
      <a class="close" href="javascript:;">关闭</a> </div>
  </div>
</div>
<!--点击查看联系方式 end-->
<!--foot-->
<script type="text/javascript" src="/new_resources/js/sele_t.js"></script>
<script type="text/javascript"  src="/new_resources/js/brand_common.js"></script>
<script src="../Static/modules/seajs/sea.js" id="seajsnode"></script>
<script src="../seajs.config.js"></script>
<script>
var jrChannel='1#0';
seajs.use('app/agent.js');
</script>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
<script>
var map = new BMap.Map("map");                      // 创建Map实例
//var map = new BMap.Map("jxs_map");                // 创建Map实例
var point = new BMap.Point(108.984375,34.052659);    // 创建点坐标
map.centerAndZoom(point,5);                         // 初始化地图,设置中心点坐标和地图级别。
map.enableScrollWheelZoom();                        // 启用滚轮放大缩小。
map.addControl(new BMap.NavigationControl());       // 添加默认缩放平移控件
//var mapDatas = [];
var mapDatas = [
<%=mapDatas%>
];
for(var i=0;i<mapDatas.length;i++){
	addMarker({
		point:new BMap.Point(mapDatas[i].lng_lat.split(",")[0],mapDatas[i].lng_lat.split(",")[1]),
		title:mapDatas[i].title,
		content:mapDatas[i].content,
		zoom:mapDatas[i].zoom,
	    xb:i+1,
		url:mapDatas[i].url
	});
}
/*添加标注*/
function addMarker(arg){
	var zoom = arg.zoom;
	if(''==zoom){
		zoom=17;
	}
	if(isNaN(zoom)){
		zoom = 17;
	}
	zoom = parseInt(zoom,17);
	// 创建图标对象  
	var myIcon;
	var img = "/images/map/"+arg.xb+".png";
	if(img!=''){
		myIcon = new BMap.Icon(img, new BMap.Size(50, 24)); 
	 }
	var marker;
	if(myIcon!=null){
		marker= new BMap.Marker(arg.point,{icon: myIcon});
	}else{
		marker= new BMap.Marker(arg.point);
	}
	var opts = {
	  title:arg.title,
	  width:400
	}
	var infoWindow = new BMap.InfoWindow(arg.content,opts);  // 创建信息窗口对象
	marker.setTitle(arg.title);
	marker.addEventListener("click", function(){ 
        window.open(arg.url);	
	   //this.openInfoWindow(infoWindow);
	   //map.centerAndZoom(arg.point,zoom);
	});
	map.addOverlay(marker);
	marker.setAnimation(BMAP_ANIMATION_DROP);
}
//移到新位置
function goToNewPoint(lnglat){
	for(var i=0;i<mapDatas.length;i++){
		if(mapDatas[i].lng_lat==lnglat){
			var opts = {
			  title:mapDatas[i].name,
			  width:400
			}
			var infoWindow = new BMap.InfoWindow(mapDatas[i].content,opts);
			var ary=lnglat.split(","); 
			map.setZoom(parseInt(mapDatas[i].zoom,10));
			var p=new BMap.Point(ary[0],ary[1]); 
			map.panTo(new BMap.Point(ary[0],ary[1])); 
			map.openInfoWindow(infoWindow,p); 
			break;
		}
	}
}
</script>
<input type="hidden" name="the_area" id="the_area"  value="<%=province%>" />
<!--#include virtual="/include/common_foot.htm"-->
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>