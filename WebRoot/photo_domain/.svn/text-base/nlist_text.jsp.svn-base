<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	if(!"".equals(factory) && "".equals(factoryid)){
		factoryid = factory ;
	}
	if(!"".equals(catalogid) && "".equals(catalog)){
		catalog = catalogid ;
	}
	
	DBHelper dbHelper = DBHelper.getInstance();
	String type = CommonString.getFormatPara(request.getParameter("type"));
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
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
	
	//
	String factoryName = "";
	String catalogName = "";
	if(factoryid!=null && !factoryid.equals("")){
		factoryName = CommonString.getFormatPara(brandMap.get(factoryid));
	}
	if(catalog!=null && !catalog.equals("")){
		catalogName = CommonString.getFormatPara(catalogMap.get(catalog));
	}
	
	StringBuffer whereStr = new StringBuffer(" and image is not null and is_show=1  ") ;
	if(!"".equals(type)){
		whereStr.append(" and sort_num like '%"+type+"%'") ;
	}
	if(!"".equals(catalogName)){
		whereStr.append(" and keywords like '%"+catalogName+"%'") ;
	}
	if(!"".equals(factoryName)){
		whereStr.append(" and brand_keywords like '%"+factoryName+"%'") ;
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
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(16) ; // 每页显示条数
	if(order.equals("view")){
		pageBean.setOrderBy(" view_count desc ");
	}else{
		pageBean.setOrderBy(" pub_date desc ");
	}
	pageBean.setCondition(whereStr.toString()) ;

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
    pageBean.setFields(" id,image,title") ;
    pageBean.setTableName("pro_photo_group") ;
	
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
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
			//品牌
		List<Map> list = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+catalog+"%') order by view_count desc",connection) ;
		
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程机械图片大全_工程机械图片库 - 铁臂图库</title>
<meta name="renderer" content="webkit">
<meta name="keywords" content="工程机械图片,工程机械图片大全,工程机械,铁臂图库" />
<meta name="description" content="铁臂图库为您提供各种品牌工程机械高清图片，买工程机械就上铁臂商城。" />
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
<jsp:include page="/include/top_photo.jsp" flush="true">
<jsp:param value="<%=type %>" name="type"/>
</jsp:include>
<!--top end--> 

<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂图库</a> &gt;&gt; <%=sortName %></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="np_fix contain980"> 
  <!--right-->
  <div class="w980 r">
    <form name="theform" id="theform" action="/nlist.jsp">
      <div class="w980 border03 l Condition mb10">
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
          </div>
          <h1 class="r" style="font-size:14px;"><%="".equals(sortName) ? "工程机械图片" :""%><%=sortName %><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>大全</h1>
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
          	  <%if(list!=null&&list.size()>0&&!"".equals(catalog)){%>
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
          </li><%}else if(!factory.equals("")&&catalog.equals("")){%>
		   <li class="cblist">
            <dt> 品牌 </dt>
            <dd>
             
              <a href="/list.jsp<%=catalog.equals("")?"":"?catalog="+catalog+""%>"  >不限</a> 
              <a href="/list.jsp<%=catalog.equals("")?"":"?catalog="+catalog+""%>"   class='select' > <%=catalog1%></a> 
            </dd>
          </li>
		 
		  <%}%>
		   <li class="cblist" id="grab" style="display: none;">
            <dt> 吨位 </dt>
            <dd>
              <input type="hidden" name="tonandmeter" id="tonandmeter" />
              <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factory%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','grab_1_13')"
											<%if("grab_1_13".equals(tonandmeter)){%> class="select" <%}%>>小挖(1T～13T)</a>&nbsp; <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','grab_14_30')"
											<%if("grab_14_30".equals(tonandmeter)){%> class="select"
											<%}%>>中挖(14T～30T)</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','grab_30_1')"
											<%if("grab_30_1".equals(tonandmeter)){%> class="select" <%}%>>大挖(30T以上)</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="loader">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factory%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_1_3')"
											<%if("loader_1_3".equals(tonandmeter)){%> class="select"
											<%}%>>3T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_3_01')"
											<%if("loader_3_01".equals(tonandmeter)){%> class="select"
											<%}%>>3T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_3_5')"
											<%if("loader_3_5".equals(tonandmeter)){%> class="select"
											<%}%>>3T～5T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_5_1')"
											<%if("loader_5_1".equals(tonandmeter)){%> class="select"
											<%}%>>5T以上</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="crane">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factory%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','crane_1_16')"
											<%if("crane_1_16".equals(tonandmeter)){%> class="select"
											<%}%>>16T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','crane_20_70')"
											<%if("crane_20_70".equals(tonandmeter)){%> class="select"
											<%}%>>20T～70T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','crane_70_1')"
											<%if("crane_70_1".equals(tonandmeter)){%> class="select"
											<%}%>> 70T以上</a> </dd>
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
      </div>
      <input type="hidden" name="order" id="order" />
      <input type="hidden" name="keyword" id="key_word" />
    </form>
    <div class="pho_sort_list fix">
    	<div class="l psort_t1"><a href="nlist.jsp?order=date<%=url %>" <% if(order.equals("date")||order.equals("")){ %> class="cur"<%} %>>最新图片</a><a href="nlist.jsp?order=view<%=url %>" <% if(order.equals("view")){ %> class="cur"<%} %>>热门图片</a></div>
    	<%
    		if(type.equals("107004")){
    	%>
    	<!-- <div class="r psort_t2"><a href="#"><img src="../images/new_pro/upphoto.gif"/></a></div> -->
    	<%} %>
    </div>
    <div class="pho_pic_val phopic_list_small" style="width:980px;">
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
	        			String image = CommonString.getFormatPara(oneMap.get("image"));
	        			String title = CommonString.getFormatPara(oneMap.get("title"));
				%>
            	<li style="margin: 0 5px 0 11px;">
                	<div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
                    <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                </li>
                <%
                		if(i!=1&&i!=16&&i!=pageBean.getTotal()&&i%4==0){
                %>
                	</ul>
        		</div>
        		</div>
        		<div class="pho_pic_val phopic_list_small" style="width:980px;">
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
    <div class="w980">
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
    	<div class="l phott1">更多类别图片</div>
    </div>
    <div class="pho_tk_list fix">
    	<%
    	if(allSubCataList.size() > 0){
    		for(int i=0; i<allSubCataList.size(); i++){
    %>
        <a title="<%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片" href="/nlist.jsp?catalog=<%=CommonString.getFormatPara(allSubCataList.get(i).get("num")) %>"><%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片</a>
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
