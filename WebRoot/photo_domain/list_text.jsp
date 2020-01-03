<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	if(!"".equals(factory) && "".equals(factoryid)){
		factoryid = factory ;
	}
	if(!"".equals(catalogid) && "".equals(catalog)){
		catalog = catalogid ;
	}
	DBHelper dbHelper = DBHelper.getInstance();
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
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
	Connection connection = null;
	
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keywords = CommonString.getFormatPara(request.getParameter("keywords")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	ArrayList<Map> allSubCataList = new ArrayList<Map>();
	for(Map subCata : catalogList){
		if(CommonString.getFormatPara(subCata.get("num")).length() == 6){
			allSubCataList.add(subCata);
		}
	}
	
	StringBuffer whereStr = new StringBuffer(" and img2 is not null ") ;
	if(!"".equals(factoryid)){
		whereStr.append(" and factoryid='"+factoryid+"'") ;
	}
	if(!"".equals(catalog)){
		whereStr.append(" and catalognum like '%"+catalog+"%'") ;
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
	
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(18) ; // 每页显示条数
	pageBean.setOrderBy(" view_count desc ");
	if(!"".equals(keywords)){
		pageBean.setCondition(" and img2 is not null and (name like '%"+keywords+"%' or catalogname like '%"+keywords+"%' or factoryname like '%"+keywords+"%') ") ;
	}else{
		pageBean.setCondition(whereStr.toString()) ;
	}
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;   
	String url = CommonString.getFormatPara(request.getQueryString()) ;
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
	String parentcatalogname = CommonString.getFormatPara(catalogMap.get(catalog.length()>6?catalog.substring(0,6):catalog));
    pageBean.setParams(url) ;
    pageBean.setFields(" id,img2,name,file_name,factoryname,catalogname,factoryid,catalognum") ;
    pageBean.setTableName("pro_products") ;
	//TDK
	String words="工程机械";
	String wordsSelect=(!"".equals(factoryid)&&!"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"):"")+(!"".equals(factoryid)&&"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)):"")+showtonandmeter+(catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))));
	if(!wordsSelect.equals("")){words=wordsSelect;}
	
	String titled="";String keywordsd="";String descriptiond="";
		String factory1=CommonString.getFormatPara(catalogMap.get(catalog));
		String catalog1=CommonString.getFormatPara(brandMap.get(factory));
		
		if(catalog1.equals("卡特彼勒")){catalog1="卡特";}
		if(catalog1.equals("玉柴重工")){catalog1="玉柴";}
		if(catalog1.equals("临工")){catalog1="山东临工";}
		
		if(factory.equals("")&&catalog.equals("")){
		titled="【多图】工程机械产品图片_工程机械产品图片大全 – 铁臂图库";
        keywordsd="工程机械产品图片,工程机械产品图片大全";
        descriptiond="铁臂图库为您提供大量高清工程机械产品图片,帮助您通过图片了解工程机械产品,买工程机械产品就上铁臂商城。";
        }else{
		titled="【多图】"+catalog1+""+factory1+"图片_"+catalog1+""+factory1+"图片大全_"+catalog1+""+factory1+"图库 - 铁臂图库";
        keywordsd=""+catalog1+""+factory1+"图片,"+catalog1+""+factory1+"图片大全,"+catalog1+""+factory1+",铁臂图库";
        descriptiond="铁臂商城图库提供最新最全的"+catalog1+""+factory1+"图片,帮助您全面了解"+catalog1+""+factory1+",买"+catalog1+""+factory1+"产品就上铁臂商城。";
		}
		//面包屑面包屑：铁臂图库》品牌》类别》品牌+类别》品牌+类别图片
		String maibao="";
		if(factory.equals("")&&catalog.equals("")){
		maibao="&gt;&gt;产品图片";
		}else 	if(!factory.equals("")&&catalog.equals("")){
		maibao="&gt;&gt; <a href=\"/list.jsp?factory="+factory+"\">"+catalog1+"</a>&gt;&gt;"+catalog1+"图片";
		}else 	if(factory.equals("")&&!catalog.equals("")){
		maibao="&gt;&gt; <a href=\"/list.jsp?catalog="+catalog+"\">"+factory1+"</a>&gt;&gt;"+factory1+"图片";
		}else if(!factory.equals("")&&!catalog.equals("")){
		maibao="&gt;&gt;  <a href=\"/list.jsp?factory="+factory+"\">"+catalog1+"</a>&gt;&gt; <a href=\"/list.jsp?catalog="+catalog+"\">"+factory1+"</a>&gt;&gt; <a href=\"/list.jsp?factory="+factory+"&amp;catalog="+catalog+"\">"+catalog1+""+factory1+"</a>&gt;&gt;"+catalog1+""+factory1+"图片";
		}
	
	try{
		connection = dbHelper.getConnection();
			//国内品牌
		List<Map> list = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+catalog+"%') order by view_count desc",connection) ;
		
		
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
  <h3 class="breadCrumbs"><a href="/">铁臂图库</a> <%=maibao%></h3>
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
        <jsp:param name="url" value="/list.jsp"></jsp:param>
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
    <form name="theform" id="theform" action="/list.jsp">
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
          <h1 class="r" style="font-size:14px;"><%="".equals(wordsSelect) ? "工程机械" :""%><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>图片大全</h1>
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
            <dd> <a  href="/list.jsp<%=factoryid.equals("")?"":"?factoryid="+factoryid+""%>"  <%if("".equals(catalog)){%>class='select'<%}%>>不限</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101001":"?factory="+factoryid+"&catalog=101001"%>" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101002":"?factory="+factoryid+"&catalog=101002"%>" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=102":"?factory="+factoryid+"&catalog=102"%>" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101003":"?factory="+factoryid+"&catalog=101003"%>" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=103":"?factory="+factoryid+"&catalog=103"%>" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=106001":"?factory="+factoryid+"&catalog=106001"%>" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101005":"?factory="+factoryid+"&catalog=101005"%>" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=105003":"?factory="+factoryid+"&catalog=105003"%>" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=113001":"?factory="+factoryid+"&catalog=113001"%>" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=104001":"?factory="+factoryid+"&catalog=104001"%>" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;;">
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
		  <%if(list!=null&&list.size()>0){%>
          <li class="cblist">
            <dt> 品牌 </dt>
            <dd>
             
              <a href="/list.jsp<%=catalog.equals("")?"":"?catalog="+catalog+""%>"  <%if("".equals(factoryid)){%> class='select' <%}%>>不限</a> 
          <%
		 for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
              <a <%if(id.equals(factoryid)){%> class='select' <%} %> href="/list.jsp?factory=<%=id%><%=catalog.equals("")?"":"&catalog="+catalog%>"><%=factoryname%></a> 
             <%}%>
            </dd>
          </li><%}%>
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
	<%if(factory.equals("")&&catalog.equals("") ){%>
   <div class="photoParts">
      <div class="hbTitle">
        <h2>热门品牌</h2>
        <span class="more"></span> </div>
      <div class="content">
        <ul class="pbList">
          <li><a href="http://photo.21-sun.com/list.jsp?factory=133" title="三一" style="cursor:pointer"><img src="../images/sany.jpg" alt="三一" width="100" height="50">三一</a></li>
          <li><a href="http://photo.21-sun.com/list.jsp?factory=209" title="徐工" style="cursor:pointer"><img src="../images/xcmg.jpg" alt="徐工" width="100" height="50">徐工</a></li>
          <li><a href="http://photo.21-sun.com/list.jsp?factory=134" title="中联" style="cursor:pointer"><img src="../images/photo_brandimg04.gif" alt="中联" width="100" height="50">中联</a></li>
          <li><a href="http://photo.21-sun.com/list.jsp?factory=136" title="柳工" style="cursor:pointer"><img src="../images/photo_brand_lg.gif" alt="柳工" width="100" height="50">柳工</a></li>
          <li><a href="http://photo.21-sun.com/list.jsp?factory=144" title="山推" style="cursor:pointer"><img src="../images/photo_brand_st.gif" alt="山推" width="100" height="50">山推</a></li>
          <li><a href="http://photo.21-sun.com/list.jsp?factory=137" title="临工" style="cursor:pointer"><img src="../images/photo_brand_lingong.gif" alt="临工" width="100" height="50">临工</a></li>
        </ul>
      </div>
    </div><%}%>
    <div class="pho_pic_val phopic_list_small">
        <div class="phopic_list">
        	<ul class="fix">
        		<%
					List<Map> main_picList = pageBean.getDatas() ;  // 根据条件查出的产品
        			if(null !=main_picList && main_picList.size()>0){
	        		    String catalogNo="";
	        		    int i = 1;
	                	for(Map oneMap:main_picList){
	        			   catalogNo=(String)CommonString.getFormatPara(oneMap.get("catalognum"));
	        			   if(catalogNo.length()>6){
	        			      catalogNo=catalogNo.substring(0,6);
	        			   }
	        			   parentcatalogname=CommonString.getFormatPara(catalogMap.get(catalogNo));
						  
							String id = CommonString.getFormatPara(oneMap.get("id"));
							String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
							String name = CommonString.getFormatPara(oneMap.get("name"));
							String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
							String factoryidM = CommonString.getFormatPara(oneMap.get("factoryid"));
							String catalognum = CommonString.getFormatPara(oneMap.get("catalognum"));
							String small_name="";
						    small_name=factoryname;
						    if(factoryname.equals("卡特彼勒")){small_name="卡特";}
						    if(factoryname.equals("玉柴重工")){small_name="玉柴";}
							 if(factoryname.equals("临工")){small_name="山东临工";factoryname="山东临工";}
							
							if(catalognum.length()>6){
							catalognum=catalognum.substring(0,6);
							}
							String img2 = CommonString.getFormatPara(oneMap.get("img2"));
							
			        Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			             int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
				%>
            	<li>
                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>图片"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=img2 %>"  style="width:225px;height:170px;" alt="<%=factoryname+name+catalogname %>图片"/></a></div>
                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><%=factoryname+name+catalogname %></a></div>
                    <div class="photolist_tag"><a href="/photo/list.jsp?factory=<%=factoryidM %>" target="_blank" title="<%=factoryname %>"><%=factoryname %></a><a href="/photo/list.jsp?factory=<%=factoryidM %>&catalog=<%=catalognum %>" target="_blank" title="<%=small_name+parentcatalogname %>"><%=small_name+parentcatalogname %></a></div><div class="num">共<%=x%>张图片</div>
                </li>
                <%
                		if(i!=1&&i!=18&&i%3==0){
                %>
                	</ul>
        		</div>
        		</div>
        		<div class="pho_pic_val phopic_list_small">
			        <div class="phopic_list">
			        	<ul class="fix">
                <%			
                		}
                		i++;
                		}
        	       }else{
				%>
				 <span class="textStyle">暂无信息</span>
				<%}%>
            </ul>
        </div>
        </div>
        <div class="w755 l">
	      	<div id="pagination" class="page">
	        	<tags:page pageBean="<%=pageBean %>"/>
	      	</div>   
    	</div>
    
  </div>
  <!--right end--> 
</div>
<!--main--> 
<!--产品图库-->
<div class="contain980 pho_tk_val mt10">
	<div class="pho_tk_t fix phopic_t">
    	<div class="l phott1">产品图库</div>
		 <div id="pagination" style="float: right;">
					<div> <a style="cursor:pointer;" id="showmore" onclick="showmore();">加载更多</a></div>
	  </div>
    </div>
    <div class="pho_tk_list fix" id="morebrand"  style="height:100px;overflow: hidden;">
    <%
    	if(allSubCataList.size() > 0){
    		for(int i=0; i<allSubCataList.size(); i++){
    %>
        <a title="<%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片" href="/list.jsp?catalog=<%=CommonString.getFormatPara(allSubCataList.get(i).get("num")) %>"><%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片</a>
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
<script>
function showmore(){
var m = $("#morebrand");  
m.css("height","auto"); 
//var mm = $("#morebrandhelp");  
//mm.css("height","auto"); 
 $("#showmore").hide(); 
}

</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
