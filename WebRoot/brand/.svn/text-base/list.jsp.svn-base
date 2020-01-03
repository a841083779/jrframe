<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ; // 栏目 
	String showcatalognum = catalognum ;
	if("".equals(catalognum)){
	// 	catalognum = "101" ;
	}
	String par_catalognum = "" ;
	if(catalognum.length()>=3){
		par_catalognum = catalognum.substring(0,3) ;
	}
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	if("".equals(CommonString.getFormatPara(catalogMap.get(catalognum)))){
		response.sendRedirect("/brand/index.shtm") ;
	}
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> subCatalogList = null ;
	String sub_sql = "select name,num from pro_catalog where num like '"+par_catalognum+"%' and len(num)>3 order by num" ;
	String catalogname = CommonString.getFormatPara(catalogMap.get(catalognum)) ;
	String sel_sql = "select factoryname,factoryid,usern,count(*) total ,logo from pro_catalog_for_factory where num like '"+catalognum+"%' and factoryname<>'' and factoryname is not null and factoryid<>0 and factoryid<>'' and factoryid is not null and is_show=1 and pro_is_show=1 and len(num)>=6 group by factoryname,factoryid,usern,logo order by total desc" ;
	List<Map> brandList = null ;  // 显示品牌列表
	if(!"".equals(catalognum)){
		brandList = dbHelper.getMapList(sel_sql) ;
		subCatalogList = dbHelper.getMapList(sub_sql) ;
	}
	String title = "工程机械品牌大全--铁臂商城" ; 
	String keywords = "工程机械品牌大全,工程机械" ;
	String description = "【工程机械品牌大全】请上铁臂商城，铁臂商城拥有所有的工程机械品牌，是最全的工程机械品牌库。" ;
	String nav_str = " &gt;&gt; <a href='?catalognum="+catalognum+"'>"+catalogname+"</a>" ; 
	if(catalognum.length()==3 && !"".equals(catalogname)){ // 一级类别  
		// nav_str = "" ; // 导航
		title = catalogname+"_"+catalogname+"品牌大全"+"-工程机械品牌大全-铁臂商城" ;
		keywords = catalogname+","+catalogname+"品牌,工程机械品牌大全,工程机械";
		description = "铁臂商城品牌库提供"+catalogname+"品牌大全，帮助您更好的寻找所需要的"+catalogname+"品牌，提供工程机械品牌查询服务。" ;
	}else if(catalognum.length()>3 && !"".equals(catalogname)){ 
		title = catalogname+"_"+catalogname+"品牌大全-"+catalogname+"品牌推荐-铁臂商城" ;
		keywords = catalogname+","+catalogname+"品牌,"+catalogname+"品牌推荐,工程机械品牌大全,工程机械";
		description = "铁臂商城品牌中心提供"+catalogname+"品牌大全，为您推荐"+catalogname+"品牌，包括世界国内外"+catalogname+"的新兴品牌，知名品牌。" ;
	} 
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=title %></title>
<meta name="keywords" content="<%=keywords %>" />
<meta name="description" content="<%=description %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<link href="../style/new_brand.css" rel="stylesheet" type="text/css" />
</head>
<body class="brandList">
<!--top--> 
<jsp:include page="/include/top.jsp" flush="true"/>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/brand/">品牌大全</a><%=nav_str %></h3>
</div>
<!--面包屑结束-->
<!--main--> 
<!--品牌索引-->
<!--品牌索引结束--> 
<div class="contain980 mb10">
  <div class="w210 l">
    <div id="leftId">	
    <!-- 左侧导航 -->
    </div>
  </div>
  <div class="w757 r mb10">
  
    <form id="theform" name="theform">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l"> <span onclick="sosuo();" class="reset">重置</span> 
          <%
          if(!"".equals(catalogname)){
        	  %>
        	 <span><em><%=catalogname %></em> <a onclick="sosuo('','')" class="delete" title="取消" href="javascript:void(0)"></a> </span>
        	  <%
          }
          %>
           </div>
          <h3 class="r"><%=catalogname %></h3>
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
            <input type="hidden" id="factory_id" name="factory" />
            <input type="hidden" id="catalognum" name="catalog" />
            <dd> 
            <!-- <a href="_index_new_list.jsp" <%if("".equals(showcatalognum)){%>class="select"<%} %>>不限</a>   -->
            <%
               	if(null!=subCatalogList && subCatalogList.size()>0){
               		int count = subCatalogList.size()>6?6:subCatalogList.size() ;
               		Map oneMap = null ;
               		for(int i=0;i<count;i++){
               			oneMap = (HashMap)subCatalogList.get(i) ;
               			%>
               			<a href="?catalognum=<%=CommonString.getFormatPara(oneMap.get("num")) %>" target="_self" <%if(CommonString.getFormatPara(oneMap.get("num")).equals(showcatalognum)){%>class="select"<%} %>><%=CommonString.getFormatPara(oneMap.get("name")) %></a> 
               			<%
               		}
               	}
            %>
              <div class="pbtn" id="changethis"></div>
              <div style="padding-left:0px; width:680px;" class="plmore">
                <div class="pllist"> 
                  <a class="plfl"><%=CommonString.getFormatPara(catalogMap.get(par_catalognum)) %></a> <br/>
				<%
				   if(null!=subCatalogList && subCatalogList.size()>0){
					   for(Map oneMap:subCatalogList){
						   %>
				  <a href="?catalognum=<%=CommonString.getFormatPara(oneMap.get("num")) %>" <%if(CommonString.getFormatPara(oneMap.get("num")).equals(showcatalognum)){%>class="select"<%} %>><%=CommonString.getFormatPara(oneMap.get("name")) %></a> 
						   <%
					   }
				   }
				%>
                </div>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 品牌 </dt>
            <dd>
              <%
              	if(null!=brandList && brandList.size()>0){
              		int sum = brandList.size()>9?9:brandList.size() ;
              		Map oneMap = null ;
              		for(int i=0;i<sum;i++){
              			oneMap = brandList.get(i) ;
              			%>
              			 <a href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a> 
              			<%
              		}
              	}
              %>
              <div class="pbtn" id="changethis"></div>
              <div style="padding-left: 0px; width:680px;" class="plmore">
                <div class="pllist"> 
                  <a class="plfl"><%=catalogname %></a><br/>
                 <%	
                 if(null!=brandList && brandList.size()>0){
                	 for(Map oneMap:brandList){
                		 %>
                  <a target="_target" href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a> 
                		 <%
                	 }
                 }
                 %>
                </div>
              </div>
            </dd>
          </li>          
          <!-- 广告投放 --> 
          
          <script type="text/javascript">
                    if('101001006'.indexOf("101001")!=-1){
                      jQuery("#grab").attr("style","display:;") ;
                    }
                       if('101001006'.indexOf("101002")!=-1){
                      jQuery("#loader").attr("style","display:;") ;
                    }
                       if('101001006'.indexOf("102")!=-1){
                      jQuery("#crane").attr("style","display:;") ;
                    }
                  </script>
        </ul>
      </div>
      <input type="hidden" id="order" name="order" />
      <input type="hidden" id="key_word" name="keyword" />
    </form>
    
    <div class="brandCondition Brand_newPart">
      <div class="contain980">
        <div class="letterPoint"><a id="sg1"></a></div>
        <div class="hbTitle">
          <h2><%if(!"".equals(catalogname)){
        	  out.println(catalogname) ;
          } %></h2>
        </div>
        <div class="brandtopborder"></div>
        <div class="brandcontain925">
		  <%	
		  	if(null!=brandList && brandList.size()>0){
		  		for(Map oneMap:brandList){
		  		%>
          <div class="blbg">
            <div class="blp"> <a href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"> <img width="80" height="30" style="display: inline;" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo")) %>"/> </a></div>
            <div class="bli">有<font><%=CommonString.getFormatPara(oneMap.get("total")) %></font>个系列<br/>
              [<a href="http://product.21-sun.com/agent/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_0.shtm" class="link13" target="_blank">代理商</a>]</div>
            <h3 class="bln"><a href="<%=CommonString.getFormatPara(oneMap.get("usern")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></h3>
          </div> 
		  		<%	
		  		}
		  	}
		  %>
        </div>
        <div class="brandbottomborder"></div>
      </div>
    </div>
  </div>
<div class="clear"></div>
</div>
<!--main end--> 
<!--foot--> 
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<!--end of foot--> 
</body>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
	  	//左侧查询
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"","catalog":"<%=catalognum%>","url":"/products/prolist.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})
</script>
</html>
