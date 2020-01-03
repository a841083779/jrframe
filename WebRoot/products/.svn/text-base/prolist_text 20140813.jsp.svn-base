<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
   	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String catalog = CommonString.getFormatInt(request.getParameter("catalog")).toString();
	String inner = CommonString.getFormatInt(request.getParameter("inner")).toString();
	String catalogName="";
	String catalog_first="";
	String catalog_detail="";
	if(catalog.length()>3){catalog_first=catalog.substring(0,3);}else{catalog_first=catalog;}
	if(catalog.length()>6){catalog_detail=catalog.substring(0,6);}else{catalog_detail=catalog;}
	catalog = CommonString.getFilterStr(catalog);
	if(catalog.equals("0")){
		catalog = "";
	}
	Map brandMap = (Map) application.getAttribute("brandMap");
	if(catalog.indexOf("10500315")!=-1){
		Common.do301(response,"/products/prolist_text.jsp?catalog=105003") ;
	}
	String factoryid = CommonString.getFormatInt(request.getParameter("factoryid")).toString();
	String factory = CommonString.getFormatInt(request.getParameter("factory")).toString();
	if(factory.equals("0")){
		factory = "";
	}
	if(factoryid.equals("0")){
		factoryid = "";
	}
	if (!"".equals(factory)) {  
		factoryid = factory;
	}
	DBHelper dbHelper = DBHelper.getInstance();
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	Map seoTitleKeywordMap = (HashMap)application.getAttribute("seoTitleKeywordMap") ;
	String seoTitle = null ;
	seoTitle = CommonString.getFormatPara(seoTitleKeywordMap.get(catalog)) ;
	String province = "";
	String city = "";
	String ip  = Common.getIp(request);
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String objStr = Tools.getMyProvinceAndCity(ip);
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<cache:cache cron="*/1 * * * *">
<%
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
		} else if("loader_5_1".equals(tonandmeter)){
			showtonandmeter = "5T以上";
		}else if ("crane_1_16".equals(tonandmeter)) {
			showtonandmeter = "16T以下";
		} else if ("crane_20_70".equals(tonandmeter)) {
			showtonandmeter = "20T~70T";
		} else if ("crane_70_1".equals(tonandmeter)) {
			showtonandmeter = "70T以上";
		} else {
			showtonandmeter = "";
		}
		List<Map> catalogList = (List) application.getAttribute("catalogList"); 
		Map catalogMap = (Map) application.getAttribute("catalogMap");
		Map brandUsernMap = (HashMap) application.getAttribute("brandUsernMap"); // id 和 品牌代号对应
		if (null == brandUsernMap) {
			brandUsernMap = new HashMap();
		}
		//和卡特广告会重复
		StringBuffer whereStr = new StringBuffer(" and is_show=1 and id !=20163");
		if (!"".equals(catalog)) {
			whereStr.append(" and catalognum like '%" + catalog + "%'");
			catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
		}
		if (!"".equals(factoryid)) {  
			whereStr.append(" and factoryid=" + factoryid);
		}
		if (!keyword.equals("")) {
			whereStr.append(" and  factoryname+name+catalogname like '%" + keyword + "%'");
		}
		//拆分吨位
		String[] parttonandmeters = null;
		String firsttonandmeter = "";
		String sectonandmeter = "";
		if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
			parttonandmeters = tonandmeter.split("_");
			firsttonandmeter = parttonandmeters[1];
			sectonandmeter = parttonandmeters[2];
			if ("0".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter < " + firsttonandmeter);
			} else if ("1".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter >" + firsttonandmeter);
			} else if ("01".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter =" + firsttonandmeter);
			} else {
				whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
			}
		}
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(8); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		if("".equals(order)){
		pageBean.setOrderBy(" view_count desc"); // 点击量排序
		}
		if(!"".equals(factoryid) && "".equals(order)){
			pageBean.setOrderBy(" view_count desc,order_no desc") ;
		}
		if (("".equals(order) || "1".equals(order)) &&"".equals(factoryid)) {
		 	pageBean.setOrderBy(" view_count desc,order_no_all desc"); // 默认排序
		}
		if ("0".equals(order)) {
			pageBean.setOrderBy(" view_count desc"); // 点击量排序
		}
		String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
		String hot_url="";
		if(!nowPage.equals("")){hot_url="offect="+Integer.parseInt(offset)+url;}
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum ");
		pageBean.setTableName("pro_products");
		//TDK
		String newTitle="工程机械";
		String newDesc="工程机械";
		String newTitleEnd="工程机械";
		String keywords1="";String keywords2="";String keywords3="";String keywords4="";String keywords5="";
		if(!"".equals(factoryid)){keywords1=CommonString.getFormatPara(brandMap.get(factoryid))+"价格表,";}
        if(!"".equals(catalog)){keywords2=CommonString.getFormatPara(catalogMap.get(catalog))+"价格表,";}
		if(!"".equals(catalog)&&!"".equals(factoryid)){keywords3=CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+CommonString.getFormatPara(catalogMap.get(catalog))+"价格表";}
		if(!"".equals(catalog)&&!"".equals(factoryid)&&!"".equals(showtonandmeter)){keywords5=showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog))+",";}
		String newKeyWord=keywords5+keywords4+keywords2+keywords1+keywords3;
		if(newKeyWord.equals("")){newKeyWord="工程机械,工程机械价格表,工程机械产品大全";}
		else if(newKeyWord.endsWith(",")){newKeyWord=newKeyWord.substring(0,newKeyWord.length()-1);}
		
		if(!"".equals(factoryid)&&!"".equals(catalog)){
		       newTitle=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newDesc=("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newTitleEnd=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		}else if(!"".equals(factoryid)||!"".equals(catalog)){
		
		   newTitle=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   newDesc=("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   if("".equals(catalog)){
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog))+"产品";
		   }else{
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   }
		}

		//国内品牌
		List<Map> list = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where catalognum='"+catalog+"') and is_inner=1",connection) ;
		
		//国外品牌
		List<Map> list1 = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where catalognum='"+catalog+"') and is_inner=0",connection) ;
		
	
	String sql_all = " select substring(catalognum,1,6) as catalognum from pro_products where factoryid = '"+factoryid+"' and catalognum is not null group by substring(catalognum,1,6) order by catalognum asc ";
	List<Map> list_factory = DBHelper.getInstance().getMapList(sql_all);
	%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【底价】<%=newTitle%>_<%=newTitle%>价格表_<%=newTitleEnd%>大全 - 铁臂商城</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=newKeyWord%>" />
<meta name="description" content="铁臂商城<%=newDesc%>专区,为您提供<%=newDesc%>价格、<%=newDesc%>型号、<%=newDesc%>图片等详细信息,帮您全面了解<%=newDesc%>,买<%=newDesc%>产品就上铁臂商城。" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="mobile-agent" content="format=html5;url=http://m.product.21-sun.com/index.jsp?factory=<%=factoryid%>&catalog=<%=catalog%>">
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script>
<script type="text/javascript">uaredirect("http://m.product.21-sun.com/index.jsp?factory=<%=factoryid%>&catalog=<%=catalog%>");</script>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type='text/javascript' src='http://js.adm.cnzz.net/js/abase.js'></script>

</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true">
<jsp:param name="keyword" value="1"></jsp:param>
<jsp:param name="catalog" value="1"></jsp:param>
<jsp:param name="factoryid" value="1"></jsp:param>
</jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">铁臂商城</a> &gt;&gt; <a href="/products/">产品大全</a>
  <%="".equals(factoryid)?"":" &gt;&gt; <a href='/products/prolist_text.jsp?factoryid="+factoryid+"'>"+CommonString.getFormatPara(brandMap.get(factoryid))+"</a>"%>
  <%="".equals(catalog)?"":" &gt;&gt; <a href='/products/prolist_text.jsp?catalog="+catalog+"'>"+CommonString.getFormatPara(catalogMap.get(catalog))+"</a>"%>
  <%=("".equals(catalog)||"".equals(factoryid))?"":" &gt;&gt; <a href='/products/prolist_text.jsp?factoryid="+factoryid+"&catalog="+catalog+"'>"+CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+CommonString.getFormatPara(catalogMap.get(catalog))+"</a>"%>
   </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
  <div class="w210 l np_left">
    
	<div id="leftId">
      <div class="npro_tab">
      	<ul class="np_fix">
		    <!--class="cur" -->
        	<li ><a href="/products/list_param.jsp">参数</a></li>
            <li><a href="/products/list_message.jsp">口碑</a></li>
            <li><a href="/products/list_pic.jsp">图片</a></li>
            <li><a href="/products/list_tech.jsp">维修</a></li>
            <li><a href="/products/list_video.jsp">实拍</a></li>
            <li><a href="/products/list_story.jsp">品牌故事 </a></li>
        </ul>
      </div>  
	  <jsp:include page="/include/left_brandlist.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
         <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
		 <jsp:param name="url" value="/products/prolist_text.jsp"></jsp:param>
       </jsp:include>
    </div>
	
	
  <!--同类品牌排行-->
  <div class="w208 border02 l leftPart02 mb10">
    <h2><%=keyword%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>品牌排行 </h2>
    <ul class="list003">
	   <jsp:include page="/include/products/left_rank.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
         <jsp:param name="catalogName" value="<%=catalogName%>"></jsp:param>
       </jsp:include>
    </ul>
  </div>
  <!--同类品牌排行结束--> 
  
  <!--同类热卖排行-->
  <%if(!catalog.equals("")){%>
  <div class="w208 border02 l leftPart02 mb10">
    <h2><%=keyword%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>关注排行 </h2>
    <ul class="list03" >
	  <jsp:include page="/include/products/left_pro_rank.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
       </jsp:include>
    </ul>
  </div>
  <%}%>
  <!--同类热卖排行结束--> 
  
  
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r np_right mb10">
    <%List<Map> searchProducts = pageBean.getDatas(connection); // 根据条件查出的产品%>
<form name="theform" id="theform">
    <div class="w755 border03 l Condition mb10">
      <div class="ConditionTop">
        <div class="l">
          <%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
          <span class="reset" onClick="sosuo();">重置</span>
          <%
										}
									%>
          <%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
          <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("","<%=factoryid%>","","","<%=order%>")'></a> </span>
          <%
										}
									%>
          <%
										if (!"".equals(factoryid) && !"".equals(factoryid)) {
									%>
          <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
          <%
										}
									%>
          <%
										if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {
									%>
          <span><em><%=showtonandmeter%></em> <a
										href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
          <%
										}
									%>
        </div>
        <h1 class="r" style="font-size:14px;"><%="".equals(keywords1+keywords2)?"工程机械":""%><%=keyword%><%=showtonandmeter%><%if(!"".equals(factoryid)&&"".equals(catalog)){%><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%}%><%if(!"".equals(factoryid)&&!"".equals(catalog)){%><%=CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%><%}%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></h1>
      </div>
        <div class="new_selectBox">
        <div class="sel01">
          <a href="/products/prolist_text.jsp?catalog=101" <%if("101".equals(catalog_first)){%> class='selected' <%}%>>土方机械</a>
          <a href="/products/prolist_text.jsp?catalog=102" <%if("102".equals(catalog_first)){%> class='selected' <%} %>>起重机械</a>
          <a href="/products/prolist_text.jsp?catalog=103" <%if("103".equals(catalog_first)){%> class='selected' <%} %>>混凝土机械</a>
          <a href="/products/prolist_text.jsp?catalog=104" <%if("104".equals(catalog_first)){%> class='selected' <%} %>>路面机械（筑路机械）</a>
          <a href="/products/prolist_text.jsp?catalog=105" <%if("105".equals(catalog_first)){%> class='selected' <%} %>>桩工机械</a>
          <a href="/products/prolist_text.jsp?catalog=106" <%if("106".equals(catalog_first)){%> class='selected' <%} %>>压实机械</a>
          <a href="/products/prolist_text.jsp?catalog=107" <%if("107".equals(catalog_first)){%> class='selected' <%} %>>叉车</a>
          <a href="/products/prolist_text.jsp?catalog=110" <%if("110".equals(catalog_first)){%> class='selected' <%} %>>地下及矿山机械</a>
          <a href="/products/prolist_text.jsp?catalog=113" <%if("113".equals(catalog_first)){%> class='selected' <%} %>>破碎设备</a>
          <a href="/products/prolist_text.jsp?catalog=109" <%if("109".equals(catalog_first)){%> class='selected' <%} %>>桥梁机械</a>
          <a href="/products/prolist_text.jsp?catalog=119" <%if("119".equals(catalog_first)){%> class='selected' <%} %>>煤炭机械</a>
          <a href="/products/prolist_text.jsp?catalog=111" <%if("111".equals(catalog_first)){%> class='selected' <%} %>>港口机械</a>
          <a href="/products/prolist_text.jsp?catalog=118" <%if("118".equals(catalog_first)){%> class='selected' <%} %>>专用车</a>
        </div>
        <div class="sel02">
          <strong class="sn">类　　别：</strong>
          <div class="sel02_1">
		  <input type="hidden" name="factory" id="factory_id" />
          <input type="hidden" name="catalog" id="catalognum" />
		    <jsp:include page="/include/products/catalog_new.jsp" flush="true">
            <jsp:param value="<%=catalog_detail%>" name="catalog"/>
			<jsp:param value="<%=catalog_first%>" name="catalog_first"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            </jsp:include>   
		  </div>
		   <%if(catalog.length()>3){%>
		    <%
		String sql_catalog="select * from pro_catalog_new where parentid="+catalog_detail;
	
		List<Map> list_catalog = DBHelper.getInstance().getMapList(sql_catalog);
		if(list_catalog!=null&&list_catalog.size()>0){
		 %>
          <div class="sel02_2">
		
            <div class="sel02_2_1">
			 <jsp:include page="/include/products/catalog_detail.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
			<jsp:param value="<%=catalog_detail%>" name="catalog_detail"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            </jsp:include>   
			</div>
			
			 <%if(catalog.length()>6){%>
            <div class="sel02_2_2" id="grab" style="display: none;">
				<a href="/products/prolist_text.jsp?tonandmeter=grab_1_13<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("grab_1_13".equals(tonandmeter)){%> class="selected" <%}%>>小挖(1T～13T)</a>
				<a href="/products/prolist_text.jsp?tonandmeter=grab_14_30<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("grab_14_30".equals(tonandmeter)){%> class="selected"<%}%>>中挖(14T～30T)</a>
				<a href="/products/prolist_text.jsp?tonandmeter=grab_30_1<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("grab_30_1".equals(tonandmeter)){%> class="selected" <%}%>>大挖(30T以上)</a>
            </div>
			 <div class="sel02_2_2" id="loader" style="display: none;">
				<a href="/products/prolist_text.jsp?tonandmeter=loader_1_3<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("loader_1_3".equals(tonandmeter)){%> class="selected" <%}%>>3T以下</a>
				<a href="/products/prolist_text.jsp?tonandmeter=loader_3_01<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("loader_3_01".equals(tonandmeter)){%> class="selected"<%}%>>3T</a>
				<a href="/products/prolist_text.jsp?tonandmeter=loader_3_5<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("loader_3_5".equals(tonandmeter)){%> class="selected" <%}%>>3T～5T</a>
				<a href="/products/prolist_text.jsp?tonandmeter=loader_5_1<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("loader_5_1".equals(tonandmeter)){%> class="selected" <%}%>>5T以上</a>
            </div>
			<div class="sel02_2_2" id="crane" style="display: none;">
				<a href="/products/prolist_text.jsp?tonandmeter=crane_1_16<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("crane_1_16".equals(tonandmeter)){%> class="selected" <%}%>>16T以下</a>
				<a href="/products/prolist_text.jsp?tonandmeter=crane_20_70<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("crane_20_70".equals(tonandmeter)){%> class="selected"<%}%>>20T～70T</a>
				<a href="/products/prolist_text.jsp?tonandmeter=crane_70_1<%=catalog.equals("")?"":"&catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=order.equals("")?"":"&order="+order%>"<%if("crane_70_1".equals(tonandmeter)){%> class="selected" <%}%>>70T以上</a>
            </div>
			<%}%>
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
			
          </div>
		  <%}}%>
        </div>
		<%if(list!=null&&list.size()>0){%>
        <div class="sel02">
          <strong class="sn">国内品牌：</strong>
          <div class="sel02_1">
		 <%
		 for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
		 <a href="/products/prolist_text.jsp?factoryid=<%=id%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>&inner=1" <%if(id.equals(factoryid)){%> class='selected' <%}%>><%=factoryname%></a>
		 <%}%>
		  </div>  <div class="pbtn"></div>
		  		 <%if(!factoryid.equals("")&&inner.equals("1")){%>
          <div class="sel02_2">
            <div class="sel02_2_1"><strong class="sn">主营产品：</strong>
			<%
	for(int i = 0;list_factory!=null && i<list_factory.size();i++){		  
		String catalogNames = catalogMap.get(list_factory.get(i).get("catalognum"))==null?"":catalogMap.get(list_factory.get(i).get("catalognum")).toString();
		if(catalogNames != null && !catalogNames.equals("")){
	  %>
	  	  
<a target="_blank" href="/products/prolist_text.jsp?factoryid=<%=factoryid%>&catalog=<%=catalog%>" title="<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogNames%>"><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogNames%></a>
<%}}%>
			</div>
          </div>
		  <%}%>
        </div>
		<%}%>
		
        <div class="sel02">
		<%if(list1!=null&&list1.size()>0){%>
          <strong class="sn">国外品牌：</strong>
          <div class="sel02_1"> <%
		 for(int i = 0;list1 != null && i < list1.size();i++){
						Map m = list1.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
		 <a href="/products/prolist_text.jsp?factoryid=<%=id%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>&inner=0"  <%if(id.equals(factoryid)){%> class='selected' <%}%>><%=factoryname%></a>
		 <%}%></div>
		 <%}%>
		 <%if(!factoryid.equals("")&&inner.equals("0")){%>
          <div class="sel02_2">
            <div class="sel02_2_1"><strong class="sn">主营产品：</strong>
			<%
	for(int i = 0;list_factory!=null && i<list_factory.size();i++){		  
		String catalogNames = catalogMap.get(list_factory.get(i).get("catalognum"))==null?"":catalogMap.get(list_factory.get(i).get("catalognum")).toString();
		if(catalogNames != null && !catalogNames.equals("")){
	  %>
	  	  
<a target="_blank" href="/products/prolist_text.jsp?factoryid=<%=factoryid%>&catalog=<%=catalog%>" title="<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogNames%>"><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogNames%></a>
<%}}%>
			</div>
          </div>
		  <%}%>
        </div>
      </div>
    </div>
    <input type="hidden" name="order" id="order" />
    <input type="hidden" name="keyword" id="key_word" />
  </form>  
  <!--广告开始-->
  <div style="clear:both; padding:0px 0px 10px; position:relative;">
  	<%
  		if(catalog.startsWith("101001")){ //挖掘机-卡特广告
  	%>
	<!-- 广告位：卡特挖掘机-->
    <div style="display:none"><img src="http://g.cn.miaozhen.com/x.gif?k=1010533&p=3zOGt0&rt=2&ns=[M_ADIP]&ni=[M_IESID]&na=[M_MAC]&v=[M_LOC]&o=" width="1" height="1" border="0" /></div>
    <a href="http://e.cn.miaozhen.com/r.gif?k=1010533&p=3zOGt0&ae=1000153&rt=2&ns=[M_ADIP]&ni=[M_IESID]&na=[M_MAC]&o=http://www.catwaji.com/NPI2014/950GC/index.aspx?utm_source=21sun&utm_medium=paid&utm_content=banner81&utm_campaign=950gc" target="_blank" style="display:block; width:757px; height:70px; position:absolute; left:0px; top:0px; background:url(about:blank);"></a>
	<embed src="http://product.21-sun.com/images/cat_757x70.swf" width="757" type="application/x-shockwave-flash" height="70" quality="High" bgcolor="#ffffff" name="index" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" pluginspage="http://www.macromedia.com/go/getflashplayer" wmode="transparent" play="false" />
   	<%
  		}else if(catalog.startsWith("101002")||catalog.startsWith("106")||catalog.startsWith("101003")||catalog.startsWith("101005")){ //装载机-山工广告
  	%>
  	<a href="http://product.21-sun.com/brandshop/cql/" target="_blank"><img src="/images/shangong_new.jpg" width="757" height="70" /></a>
  	<%
  		}else{
  	%>
  	<a href="/tuan/" target="_blank"><img src="/images/ymt_ad.gif" width="757" height="70" /></a>
  	<%
  		}
  	%>
  </div>
   <!--广告结束-->
<div class="w755 l border03 listTop">
    <div class="l" id="showorder"> <strong>排序</strong> <a class="lw" onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','<%=tonandmeter%>','',0,'<%=keyword%>');" <%if(!order.equals("1")){%>style="color:#FF9C00" <%}%> >火爆销售</a><a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','<%=tonandmeter%>','',1,'<%=keyword%>');"
								<%if(order.equals("1")){%>class="select" <%}%> style="padding-left: 10px;">评论最多</a>  </div>
    <div class="r"> <span><b><%=keyword%><%=showtonandmeter%>
	<%if(!"".equals(factoryid)&&"".equals(catalog)){%><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%}%>
	<%if(!"".equals(factoryid)&&!"".equals(catalog)){%><%=CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%><%}%><%="".equals(catalog) ?"":CommonString.getFormatPara(catalogMap.get(catalog))%> </b>&nbsp;&nbsp;共</span><b><%=pageBean.getTotal()%></b><span>款机型&nbsp;|</span> 
      <!--  <a href="javascript:void(0);" class="pre noPre"></a> <b>1/11</b> <a href="#" class="next"></a> --> 
      <%=pageBean.getUpPageBar()%> </div>
</div>
  
 <div class="plist">
    <ul id="showproducts">
      <!-- *************3个产品****************** -->
	  <jsp:include page="/include/products/pro_rec.jsp">
						 	<jsp:param value="<%=catalog %>" name="catalognum"/>
						 	<jsp:param value="<%=factoryid %>" name="factoryid"/> 
						 	<jsp:param value="<%=offset %>" name="offset"/> 
						</jsp:include>	
      <!-- 付费会员选取产品 -->			
             <%	  
							if (searchProducts != null && searchProducts.size() > 0) {
										for (Map oneMap : searchProducts) {
							%>
      <li> <a href="/proDetail/<%=oneMap.get("file_name")%>"
									target="_blank"> <img
										src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"
										onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"
										width="130" height="90" class="plimg"
										alt="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%>"
										title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%>" /> </a>
        <div class="w618 r">
          <h2> <a title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")+ (String) oneMap.get("catalogname"))%>" href="/proDetail/<%=oneMap.get("file_name")%>"
											target="_blank"><%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%></a> </h2>
          <span class="info"> <a
										href="?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum")).length() >= 6 ? CommonString
								.getFormatPara(oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))%>"><%=CommonString.getFormatPara((String) oneMap.get("factoryname")).replace("卡特彼勒","卡特")
								+ CommonString.getFormatPara(catalogMap.get((((String) oneMap.get("catalognum")).length() >= 6) ? CommonString.getFormatPara(
										oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))))%></a><em>|</em><a
										href="/proDetail/<%=((String)oneMap.get("file_name")).replace(".shtm","")%>_order.shtm"
										target='_blank'>订单</a><em>|</em> 
<a href="/proDetail/<%=((String)oneMap.get("file_name")).replace(".shtm","")%>_pic.shtm" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/<%=((String)oneMap.get("file_name")).replace(".shtm","")%>_parameter.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm")%>" target="_blank">评论</a>
<a href="javascript:;" onClick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="plbtn">询最低价<i>提交后收到最低价短信</i></a> </span>
<div class="plInfo"><%=CommonString.substringByte(CommonHtml.filterHTML((String)oneMap.get("introduce")), 180) + (CommonHtml.filterHTML((String)oneMap.get("introduce")).equals("")?"":"...")%><a style="color:#2e65b7;"
											href="/proDetail/<%=oneMap.get("file_name")%>"
											target="_blank">[查看详情]</a>  </div>
        </div>
      </li>
      <%
								}
									} else {
							%>
      <p style="padding: 10px 15px;"> 暂无符合条件的产品 </p>
      <%}%>
    </ul>
  </div>
  
  
  <!--代理商-->
           <%
                             
                             // factoryid  品牌
                             // province 当前省份
                             // catalog 机型
                          //    province = "山东" ;
                             // 选出所有的代理商
                             if(!"".equals(city)){
                            	 String sql = "";
                                 sql += " SELECT id,usern,name,is_qijiandian,is_made FROM ";
                                 sql += "  pro_agent_factory ";
                                 sql += " WHERE (is_shop ='2' OR is_shop='3' ) AND id IN ( ";
                                 sql += " SELECT distinct pap.agent_id FROM ";
                                 sql += " pro_agent_products pap , pro_products pp , pro_agent_ad_area paaa , comm_area ca ";
                                 sql += " WHERE pap.product_id = pp.id AND pap.agent_id = paaa.agent_id AND paaa.area_id = ca.area_id ";
                                 sql += " AND pp.catalognum LIKE '"+catalog+"%' AND ca.area_name LIKE '%"+city+"%' ";
                                 sql += "  ) ";
                                 List<Map> adsList = dbHelper.getMapList(sql,connection);
                                 if(null!=adsList&&adsList.size()>0){
                                	 %>
  <div class="w755 border03 l Condition mt10 move_daili">
  <ul class="ConditionBottom">

        <li class="cblist" id="prolistads">
          <dt><%=city %>代理</dt>
          <dd >
<%
                    	 String adsId = "";
                    	 for(Map oneMap : adsList){  
                    		 adsId += CommonString.getFormatPara(oneMap.get("id"))+",";
                    		 if("1".equals(CommonString.getFormatPara(oneMap.get("is_qijiandian")))&&"1".equals(CommonString.getFormatPara(oneMap.get("is_made")))){
                    			 %>
                    			 <a style="color:#2e65b7;" href="/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                    			 <%
                    		 }else if("1".equals(CommonString.getFormatPara(oneMap.get("is_qijiandian")))&&!"1".equals(CommonString.getFormatPara(oneMap.get("is_made")))){
                    			 %>
                    			 <a style="color:#2e65b7;" href="/agentshop/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                    			 <%
                    		 }else if("2".equals(CommonString.getFormatPara(oneMap.get("is_qijiandian")))&&!"1".equals(CommonString.getFormatPara(oneMap.get("is_made")))){
                    			 %>
                    			 <a style="color:#2e65b7;" href="/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                    			 <%
                    		 }else{
                    		%>
                          <a style="color:#2e65b7;" href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                          <% 
                    		 }
                    	 }
                    	 if(!"".equals(adsId)){
                    		 if(adsId.indexOf(",")!=-1){
                    			 adsId = adsId.substring(0,adsId.length()-1);
                    			 %>
                   <script type="text/javascript">
                                	     jQuery.ajax({
                                	       url:'/action/ajax.jsp' ,
                                	       type:'post',
                                	       data:{adsId:'<%=adsId %>',flag:'viewCountProAds','cata_num':'<%=catalog %>'}
                                	     }) ;
                                	     </script>
            <%
                                		 }
                                	 }
                                	 %>
		  
        	</dd>
	
        </li>
      </ul>
  </div>
  <!--代理商结束-->
 		        <%
                                 }
                             }
                             %> 
  
  
  	<div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
    <div class="w755 l">
    <div id="pagination" class="page">
    <tags:page pageBean="<%=pageBean%>" />
    </div>
  </div>
  </div>
  <!--right end-->
  <div class="clear"></div>
  
<!--最新订单-->
<div class="contain980 mb10">
  <div class="title04">
    <h2><%if(!"".equals(factoryid)&&"".equals(catalog)){%><%= CommonString.getFormatPara(brandMap.get(factoryid))%><%}%><%if(!"".equals(factoryid)&&!"".equals(catalog)){%><%= CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%><%}%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新订单 </h2>
    <span><a title="更多<%if(!"".equals(factoryid)&&"".equals(catalog)){%><%= CommonString.getFormatPara(brandMap.get(factoryid))%><%}%><%if(!"".equals(factoryid)&&!"".equals(catalog)){%><%= CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%><%}%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>订单"
						href="/inquiry/?<%="".equals(factoryid) ? "" : "factory=" + factoryid + "&"%><%="".equals(catalog) ? "" : "catalog=" + catalog%>"
						target="_blank">更多&gt;&gt;</a> </span> </div>
  <div class="list04">
    <div id="MarqueeDiv"
						style="width: 978px; height: auto; overflow: hidden;">
      <ul>
        <jsp:include page="/include/products/order_sub_foot.jsp"
								flush="true">
        <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
        </jsp:include>
      </ul>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!--最新订单结束--> 
</div>
<!--main end--> 
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
#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<!--对联广告-->
<%
  		if(catalog.startsWith("101001")){ //挖掘机-约翰迪尔左侧对联
  	%>
<div id="ads01" class="ads_hover" style="width:114px; height:313px;">
<a href="http://product.21-sun.com/brandshop/johndeere/" target="blank" style="display:block;"><img src="http://ad.21-sun.com/homepic/john_deere/excavator_114_313.jpg" width="114" height="313" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads01').className='hide';" style="cursor:pointer; margin-top:1px; float:left;" />
</div>
<% }%>
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/koubei/index.jsp" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/kb_dl20140702.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script>

</script>
</body>
</cache:cache>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
