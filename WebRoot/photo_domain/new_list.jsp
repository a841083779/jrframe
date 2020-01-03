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
	String type = CommonString.getFormatPara(request.getParameter("type")) ;
	String where="";
	if(factory.equals("")){
	where="";
	}else{
	where=" and factoryid='"+factory+"'  ";
	}
	where+=" order by view_count desc";
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
    List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	ArrayList<Map> allSubCataList = new ArrayList<Map>();
	for(Map subCata : catalogList){
		if(CommonString.getFormatPara(subCata.get("num")).length() == 6){
			allSubCataList.add(subCata);
		}
	}
	DBHelper dbHelper = DBHelper.getInstance();
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String initial=keyword+tonandmeter+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog));
	String showtonandmeter = "";
	String parentcatalogname = CommonString.getFormatPara(catalogMap.get(catalog.length()>6?catalog.substring(0,6):catalog));
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
	String sortName = "";
	if(type.equals("107001")){
		sortName = "行业图片";
	}else if(type.equals("107003")){
		sortName = "施工图片";
	}else if(type.equals("107004")){
		sortName = "维修图片";
	}else if(type.equals("107005")){
		sortName = "展会图片";
	}else if(type.equals("107006")){
		sortName = "趣味图片";
	}else if(type.equals("107007")){
		sortName = "更多图片";
	}
	
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		
		List<Map> list1 = dbHelper.getMapList(" select top 3 id,img2,add_date,factoryname,catalogname,name,file_name,factoryid,catalognum from pro_products where catalognum like '101001%'   and img2 is not null and img2 != '' "+where,connection) ;
		
		
		List<Map> list2 = dbHelper.getMapList(" select top 3 id,img2,add_date,factoryname,catalogname,name,file_name,factoryid,catalognum from pro_products where catalognum like '101002%'   and img2 is not null and img2 != '' "+where,connection) ;
		
		List<Map> list3 = dbHelper.getMapList(" select top 3 id,img2,add_date,factoryname,catalogname,name,file_name,factoryid,catalognum from pro_products where catalognum like '102%'   and img2 is not null and img2 != '' "+where,connection) ;
		
		List<Map> list4 = dbHelper.getMapList(" select top 3 id,img2,add_date,factoryname,catalogname,name,file_name,factoryid,catalognum from pro_products where catalognum like '101003%'    and img2 is not null and img2 != ''"+where,connection) ;
		
		List<Map> list5 = dbHelper.getMapList(" select top 3 id,img2,add_date,factoryname,catalogname,name,file_name,factoryid,catalognum from pro_products where catalognum like '106001%'    and img2 is not null and img2 != '' "+where,connection) ;
		
		
		String titled="";String keywordsd="";String descriptiond="";
		String factory1=CommonString.getFormatPara(catalogMap.get(catalog));
		String catalog1=CommonString.getFormatPara(brandMap.get(factory));
		if(factory.equals("")&&catalog.equals("")){
		titled="【多图】工程机械产品图片_工程机械产品图片大全 – 铁臂图库";
        keywordsd="工程机械产品图片,工程机械产品图片大全";
        descriptiond="铁臂图库为您提供大量高清工程机械产品图片，帮助您通过图片了解工程机械产品，买工程机械产品就上铁臂商城。";
        }else{
		titled="【多图】"+catalog1+""+factory1+"图片_"+catalog1+""+factory1+"图片大全_"+catalog1+""+factory1+"图库 - 铁臂图库";
        keywordsd=""+catalog1+""+factory1+"图片,"+catalog1+""+factory1+"图片大全, "+catalog1+""+factory1+",铁臂图库";
        descriptiond="铁臂商城图库提供最新最全的"+catalog1+""+factory1+"图片,帮助您全面了解"+catalog1+""+factory1+",买"+catalog1+""+factory1+"产品就上铁臂商城。";
		}
		//面包屑面包屑：铁臂图库》品牌》类别》品牌+类别》品牌+类别图片
		/nlist_"+factory+"_"+catalog+"_"+type+"_0.htm  <a href=\"/other_0_0_"+type+"_0.htm\">"+sortName+"</a>";
		String maibao="";
		if(factory.equals("")&&catalog.equals("")){
		maibao="&gt;&gt;工程机械产品图片";
		}else 	if(!factory.equals("")&&catalog.equals("")){
		maibao="&gt;&gt; <a href=\"/nlist_"+factory+"_0_"+type+"_0.htm \">"+catalog1+"</a>&gt;&gt;"+catalog1+"图片";
		}else 	if(factory.equals("")&&!catalog.equals("")){
		maibao="&gt;&gt; <a href=\"/nlist_"+factory+"_"+catalog+"_"+type+"_0.htm \">"+factory1+"</a>&gt;&gt;"+factory1+"图片";
		}else if(!factory.equals("")&&!catalog.equals("")){
		maibao="&gt;&gt;  <a href=\"/nlist_"+factory+"_0_"+type+"_0.htm\">"+catalog1+"</a>&gt;&gt; <a href=\"/nlist_0_"+catalog+"_"+type+"_0.htm \">"+factory1+"</a>&gt;&gt; <a href=\"/nlist_"+factory+"_"+catalog+"_"+type+"_0.htm \">"+catalog1+""+factory1+"</a>&gt;&gt;"+catalog1+""+factory1+"图片";
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=titled%></title>
<meta name="renderer" content="webkit">
<meta name="keywords" content="<%=keywordsd%>" />
<meta name="description" content="<%=descriptiond%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</head>
<body class="photobg">
<!--top--> 
<a class="shop_topbg"></a>
<jsp:include page="/include/top_photo_news.jsp" flush="true">
<jsp:param value="107002" name="type"/>
</jsp:include>
<!--top end--> 

<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂图库</a>&gt;&gt; <a href="new_list.jsp">产品图片</a><%=maibao%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="np_fix contain980 pho_main"> 
  <!--left-->
  <div class="w210 l"> 
    <!--热门品牌-->
     <jsp:include page="/include/left.jsp" flush="true">
	    <jsp:param name="flag" value="product"></jsp:param>
        <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
		<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="url" value="/new_list.jsp"></jsp:param>
    </jsp:include>
    <!--热门品牌结束--> 
    <!--同类热卖排行-->
    <div class="w208 border02 l leftPart02 mb10">
      <h2><%=keyword%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新关注 </h2>
      <ul class="list03">
        <jsp:include page="/include/photo/pro_left.jsp" flush="true">
        <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
        </jsp:include>
      </ul>
    </div>
    <!--同类热卖排行结束--> 
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r">
    <form name="theform" id="theform" action="/new_list.jsp">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l">
            <%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
            <span class="reset" onclick="sosuo();">重置</span>
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
          <h1 class="r" style="font-size:14px;"><%="".equals(initial) ? "工程机械" :""%><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>图片大全</h1>
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
              <%
											if (!"".equals(catalog)) {
										%>
              <a onclick="sosuo('<%=catalog%>','','<%=tonandmeter%>');"
											href="javascript:void(0)" <%if(factory.equals("")){%>
											class="select" <%} %>>不限</a>
              <%
											List<Map> recommend_brands = dbHelper
															.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog
																	+ "' order by order_no desc",connection);
													if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 11) {
																break;
															}
										%>
              <!-- 挖掘机 --> 
              <a
											onclick="sosuo('<%=catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>','<%=factory%>')"
											href="javascript:;"
											<%if(factory.equals(CommonString.getFormatPara(oneMap.get("factoryid")))){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
              <%
											}
													}
												} %>
             
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

        </ul>
      </div>
      <input type="hidden" name="order" id="order" />
      <input type="hidden" name="keyword" id="key_word" />
    </form>
    <style type="text/css">
		.mb20 { margin-bottom:20px;}
		.photoParts { width:755px; float:left; border:1px solid #DEE3E7; background:#fff;}
		.photoParts .content { width:100%; float:left; overflow:hidden;}
		ul.pbList { width:960px; float:left; padding:8px 0px;}
		ul.pbList li { width:125px; height:78px; float:left; border-right:#e3ecf1 1px solid;}
		ul.pbList li a { display:block; width:100px; height:78px; text-align:center; margin:0 auto; cursor:default;}
		ul.pbList li a img { display:block; width:100px; height:50px;}
		.modelList { width:100%; float:left;}
		.modelList .mll { width:100%; float:left; border-bottom:#dfe3e6 1px solid;}
		.modelList .mll .mt { width:735px; height:34px; line-height:34px; float:left; padding:0px 10px 0px; background:url(../images/mtbg.gif) top repeat-x; border-bottom:#dfe3e6 1px solid;}
		.modelList .mll .mt h3 { width:auto; float:left; font-size:14px; color:#396fb5;}
		.modelList .mll .mt span.more { width:auto; float:right; font-family:宋体;}
		.list12 { padding-top:5px;}
		.list12 li { position:relative; height:148px; background:url(../images/pbg_new.gif) no-repeat;}
		.list12 li span.blink { display:block; width:158px; height:20px; line-height:20px; position:absolute; left:0px; bottom:4px; padding-left:5px; color:#B7B7B7}
		.hbTitle span.more { width:auto; float:right; font:100 12px/28px 宋体; padding-right:10px;}
	</style>
    <div class="photoParts">
      <div class="hbTitle">
        <h2>热门品牌</h2>
        <span class="more"><a title="更多热门品牌" target="_blank" href="http://product.21-sun.com/brand/">更多&gt;&gt;</a></span> </div>
      <div class="content">
        <ul class="pbList">
          <li><a href="http://photo.21-sun.com/new_list.jsp?factory=133" title="三一" style="cursor:pointer"><img src="../images/sany.jpg" alt="三一" width="100" height="50">三一</a></li>
          <li><a href="http://photo.21-sun.com/new_list.jsp?factory=209" title="徐工" style="cursor:pointer"><img src="../images/xcmg.jpg" alt="徐工" width="100" height="50">徐工</a></li>
          <li><a href="http://photo.21-sun.com/new_list.jsp?factory=134" title="中联" style="cursor:pointer"><img src="../images/photo_brandimg04.gif" alt="中联" width="100" height="50">中联</a></li>
          <li><a href="http://photo.21-sun.com/new_list.jsp?factory=136" title="柳工" style="cursor:pointer"><img src="../images/photo_brand_lg.gif" alt="柳工" width="100" height="50">柳工</a></li>
          <li><a href="http://photo.21-sun.com/new_list.jsp?factory=144" title="山推" style="cursor:pointer"><img src="../images/photo_brand_st.gif" alt="山推" width="100" height="50">山推</a></li>
          <li><a href="http://photo.21-sun.com/new_list.jsp?factory=137" title="临工" style="cursor:pointer"><img src="../images/photo_brand_lingong.gif" alt="临工" width="100" height="50">临工</a></li>
        </ul>
      </div>
    </div>
    <div class="pho_pic_val phopic_list_small">
    	<div class="phopic_t fix">
        	<div class="l phott1">挖掘机</div>
            <div class="r phott2"><a href="new_news_detail.jsp?catalog=101001" title="更多挖掘机">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
        		<%
					
					for(int i = 0;list1 != null && i < list1.size();i++){
						Map m = list1.get(i);
						String catalogNo=(String)CommonString.getFormatPara(m.get("catalognum"));
				        if(catalogNo.length()>6){
				            catalogNo=catalogNo.substring(0,6);
				        }
				        String catalogName=CommonString.getFormatPara(catalogMap.get(catalogNo));
						String id = CommonString.getFormatPara(m.get("id"));
						String factoryname = CommonString.getFormatPara(m.get("factoryname"));
						String name = CommonString.getFormatPara(m.get("name"));
						String catalogname = CommonString.getFormatPara(m.get("catalogname"));
						String factoryidM = CommonString.getFormatPara(m.get("factoryid"));
						String catalognum = CommonString.getFormatPara(m.get("catalognum"));
						String img2 = CommonString.getFormatPara(m.get("img2"));
				%>
            	<li>
                	<div class="pholist_img"><a href="new_new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>图片"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:225px;height:170px;" alt="<%=factoryname+name+catalogname %>图片"/></a></div>
                    <div class="pholist_name"><a href="new_new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><%=factoryname+name+catalogname %></a></div>
					<%
			        Map sub_photoCount = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			       %>
					
                    <div class="photolist_tag"><a href="/photo/new_news_detail.jsp?factory=<%=factoryidM %>" target="_blank" title="<%=factoryname %>"><%=factoryname %></a><a href="/photo/new_news_detail.jsp?factory=<%=factoryidM %>&catalog=<%=catalognum %>" target="_blank" title="<%=factoryname+catalogname %>"><%=factoryname+catalogname %></a></div>
					<div class="num">共<%=sub_photoCount.get("count")%>张图片</div>
                </li>
                <%
				  		m = null;
					}
					list1 = null;
				%>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val phopic_list_small">
    	<div class="phopic_t fix">
        	<div class="l phott1">装载机</div>
            <div class="r phott2"><a href="new_news_detail.jsp?catalog=101002" title="更多装载机">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
					
					for(int i = 0;list2 != null && i < list2.size();i++){
						Map m = list2.get(i);
					    String catalogNo=(String)CommonString.getFormatPara(m.get("catalognum"));
				        if(catalogNo.length()>6){
				            catalogNo=catalogNo.substring(0,6);
				        }
						String id = CommonString.getFormatPara(m.get("id"));
						String factoryname = CommonString.getFormatPara(m.get("factoryname"));
						String name = CommonString.getFormatPara(m.get("name"));
						String catalogname = CommonString.getFormatPara(m.get("catalogname"));
						String factoryidM = CommonString.getFormatPara(m.get("factoryid"));
						String catalognum = CommonString.getFormatPara(m.get("catalognum"));
						String img2 = CommonString.getFormatPara(m.get("img2"));
				%>
            	<li>
                	<div class="pholist_img"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>图片"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:225px;height:170px;" alt="<%=factoryname+name+catalogname %>图片"/></a></div>
                    <div class="pholist_name"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><%=factoryname+name+catalogname %></a></div>
					<%
			        Map sub_photoCount2 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			       %>
					
                    <div class="photolist_tag"><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>" target="_blank" title="<%=factoryname %>"><%=factoryname %></a><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>&catalog=<%=catalognum %>" target="_blank" title="<%=factoryname+catalogname %>"><%=factoryname+catalogname %></a></div>
					<div class="num">共<%=sub_photoCount2.get("count")%>张图片</div>
                </li>
                <%
				  		m = null;
					}
					list1 = null;
				%>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val phopic_list_small">
    	<div class="phopic_t fix">
        	<div class="l phott1">起重机</div>
            <div class="r phott2"><a href="new_news_detail.jsp?catalog=102" title="更多起重机">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
					
					for(int i = 0;list3 != null && i < list3.size();i++){
						Map m = list3.get(i);
					    String catalogNo=(String)CommonString.getFormatPara(m.get("catalognum"));
				        if(catalogNo.length()>6){
				            catalogNo=catalogNo.substring(0,6);
				        }
						String id = CommonString.getFormatPara(m.get("id"));
						String factoryname = CommonString.getFormatPara(m.get("factoryname"));
						String name = CommonString.getFormatPara(m.get("name"));
						String catalogname = CommonString.getFormatPara(m.get("catalogname"));
						String factoryidM = CommonString.getFormatPara(m.get("factoryid"));
						String catalognum = CommonString.getFormatPara(m.get("catalognum"));
						String img2 = CommonString.getFormatPara(m.get("img2"));
				%>
            	<li>
                	<div class="pholist_img"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>图片"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:225px;height:170px;" alt="<%=factoryname+name+catalogname %>图片"/></a></div>
                    <div class="pholist_name"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><%=factoryname+name+catalogname %></a></div>
					<%
			        Map sub_photoCount3 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			       %>
					
                    <div class="photolist_tag"><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>" target="_blank" title="<%=factoryname %>"><%=factoryname %></a><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>&catalog=<%=catalognum %>" target="_blank" title="<%=factoryname+catalogname %>"><%=factoryname+catalogname %></a></div>
					<div class="num">共<%=sub_photoCount3.get("count")%>张图片</div>
                </li>
                <%
				  		m = null;
					}
					list1 = null;
				%>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val phopic_list_small">
    	<div class="phopic_t fix">
        	<div class="l phott1">推土机</div>
            <div class="r phott2"><a href="new_news_detail.jsp?catalog=101003" title="更多推土机">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
					
					for(int i = 0;list4 != null && i < list4.size();i++){
						Map m = list4.get(i);
					    String catalogNo=(String)CommonString.getFormatPara(m.get("catalognum"));
				        if(catalogNo.length()>6){
				            catalogNo=catalogNo.substring(0,6);
				        }
						String id = CommonString.getFormatPara(m.get("id"));
						String factoryname = CommonString.getFormatPara(m.get("factoryname"));
						String name = CommonString.getFormatPara(m.get("name"));
						String catalogname = CommonString.getFormatPara(m.get("catalogname"));
						String factoryidM = CommonString.getFormatPara(m.get("factoryid"));
						String catalognum = CommonString.getFormatPara(m.get("catalognum"));
						String img2 = CommonString.getFormatPara(m.get("img2"));
				%>
            	<li>
                	<div class="pholist_img"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>图片"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:225px;height:170px;" alt="<%=factoryname+name+catalogname %>图片"/></a></div>
                    <div class="pholist_name"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><%=factoryname+name+catalogname %></a></div>
					<%
			        Map sub_photoCount4 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			       %>
					
                    <div class="photolist_tag"><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>" target="_blank" title="<%=factoryname %>"><%=factoryname %></a><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>&catalog=<%=catalognum %>" target="_blank" title="<%=factoryname+catalogname %>"><%=factoryname+catalogname %></a></div>
					<div class="num">共<%=sub_photoCount4.get("count")%>张图片</div>
                </li>
                <%
				  		m = null;
					}
					list1 = null;
				%>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val phopic_list_small">
    	<div class="phopic_t fix">
        	<div class="l phott1">压路机</div>
            <div class="r phott2"><a href="new_news_detail.jsp?catalog=106001"  title="更多压路机">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
					
					for(int i = 0;list5 != null && i < list5.size();i++){
						Map m = list5.get(i);
					    String catalogNo=(String)CommonString.getFormatPara(m.get("catalognum"));
				        if(catalogNo.length()>6){
				            catalogNo=catalogNo.substring(0,6);
				        }
						String id = CommonString.getFormatPara(m.get("id"));
						String factoryname = CommonString.getFormatPara(m.get("factoryname"));
						String name = CommonString.getFormatPara(m.get("name"));
						String catalogname = CommonString.getFormatPara(m.get("catalogname"));
						String factoryidM = CommonString.getFormatPara(m.get("factoryid"));
						String catalognum = CommonString.getFormatPara(m.get("catalognum"));
						String img2 = CommonString.getFormatPara(m.get("img2"));
				%>
            	<li>
                	<div class="pholist_img"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>图片"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:225px;height:170px;" alt="<%=factoryname+name+catalogname %>图片"/></a></div>
                    <div class="pholist_name"><a href="new_detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><%=factoryname+name+catalogname %></a></div>
					<%
			        Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			       %>
					
                    <div class="photolist_tag"><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>" target="_blank" title="<%=factoryname %>"><%=factoryname %></a><a href="/photo/pro_list.jsp?factory=<%=factoryidM %>&catalog=<%=catalognum %>" target="_blank" title="<%=factoryname+catalogname %>"><%=factoryname+catalogname %></a></div>
					<div class="num">共<%=sub_photoCount5.get("count")%>张图片</div>
                </li>
                <%
				  		m = null;
					}
					list1 = null;
				%>
            </ul>
        </div>
    </div>
    
  </div>
  <!--right end--> 
</div>
<!--main--> 
<!--产品图库-->
<div class="contain980 pho_tk_val mt10">
	<div class="pho_tk_t fix phopic_t">
    	<div class="l phott1">更多品牌类别图片</div>
        <div class="r phott2"><a href="/photo/new_index.jsp"  title="更多品牌类别图片">更多&gt;&gt;</a></div>
    </div>
    <div class="pho_tk_list fix">
    	<%
    	if(allSubCataList.size() > 0){
    		for(int i=0; i<allSubCataList.size(); i++){
    %>
        <a title="<%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片" href="/photo/new_news_list.jsp?catalog=<%=CommonString.getFormatPara(allSubCataList.get(i).get("num")) %>"><%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片</a>
    <%
    		}
    	}
    %>
    </div>
</div>
<!--产品图库结束-->
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end-->
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
