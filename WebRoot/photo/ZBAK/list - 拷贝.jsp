<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
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
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keywords = CommonString.getFormatPara(request.getParameter("keywords")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	StringBuffer whereStr = new StringBuffer(" and img2 is not null ") ;
	if(!"".equals(factoryid)){
		whereStr.append(" and factoryid='"+factoryid+"'") ;
	}
	if(!"".equals(catalog)){
		whereStr.append(" and catalognum like '%"+catalog+"%'") ;
	}
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(24) ; // 每页显示条数
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
    pageBean.setParams(url) ;
    pageBean.setFields(" id,img2,name,file_name") ;
    pageBean.setTableName("pro_products") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>图片】-<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>价格表 - 中国工程机械商贸网</title>
<meta name="keywords" content="<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>图片,<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>,最新<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>价格表" />
<meta name="description" content="<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>：<%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>图片栏目为您提供<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>图片，<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>价格表，展示各种角度<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>图片，<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>价格，了解更多<%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>价格信息请来中国工程机械商贸网。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/photo/" >产品图库</a><%="".equals(factoryid)?"":" &gt;&gt; <a href='/brand/"+brandUsernMap.get(factoryid)+"/'>"+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +"</a>"%><%="".equals(catalog)?"":" &gt;&gt; "+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
  <div class="w210 l"> 
    <!--热门品牌-->
    <div id="leftId"> </div>
    <!--热门品牌结束--> 
  </div>
  <!--left end-->
  <cache:cache cron="* * */1 * *">
    <%
	   List<Map> main_picList = pageBean.getDatas() ;  // 根据条件查出的产品
  %>
    <!--right-->
    <div class="w757 r">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <%if(!"".equals(catalog) || !"".equals(factoryid)){%>
          <div class="l"> <span class="reset" onclick="sosuopic();">重置</span>
            <% if(!"".equals(catalog) &&!"".equals(catalog)){%>
            <span><em><%="".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuopic("","<%=factoryid %>","","","")'></a></span>
            <%}%>
            <% if(!"".equals(factoryid) &&!"".equals(factoryid)){%>
            <span><em><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuopic("<%=catalog %>","","","","")'></a></span>
            <%}%>
          </div>
          <%} %>
          <div class="r">共<font><%=pageBean.getTotal()%></font>张<font><%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))%></font>图片</div>
        </div>
        <form name="theform" id="theform" method="get">
          <input type="hidden" name="factoryid" id="factory_id"/>
          <input type="hidden" name="catalogid" id="catalogid" />
        </form>
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
            <dt>类别</dt>
            <input type="hidden" name="catalog" id="catalog" />
            <dd><a onclick="sosuopic('','<%=factoryid %>','');" href="javascript:void(0);" <%if("".equals(catalog)){%>class='select'<%} %>>不限</a> <a onclick="sosuopic('101001','<%=factoryid %>')" href="javascript:void(0)" <%if("101001".equals(catalog)){%>class='select'<%} %>>挖掘机</a> <a onclick="sosuopic('101002','<%=factoryid %>','')" href="javascript:void(0)" <%if("101002".equals(catalog)){%>class='select'<%} %>>装载机</a> <a onclick="sosuopic('101003','<%=factoryid %>','')" href="javascript:void(0)" <%if("101003".equals(catalog)){%>class='select'<%} %>>推土机</a> <a onclick="sosuopic('113001','<%=factoryid %>','')" href="javascript:void(0)" <%if("113001".equals(catalog)){%>class='select'<%} %>>破碎锤</a> <a onclick="sosuopic('101002008','<%=factoryid %>','')" href="javascript:void(0)" <%if("101002008".equals(catalog)){%>class='select'<%} %>>挖掘装载机</a> <a onclick="sosuopic('103001','<%=factoryid %>','')" href="javascript:void(0)" <%if("103001".equals(catalog)){%>class='select'<%} %>>混凝土泵车</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left:0px; width:100%;">
                <iframe id="catalog_iframe" src="/include/photo/catalog.jsp?catalog='<%=catalog %>'&factoy_id='<%=factoryid%>'" frameborder="0" scrolling="no" width="100%" height="670" allowtransparency="true"></iframe>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt>品牌</dt>
            <input type="hidden" name="factoryid" id="factory_id"/>
            <dd> <a onclick="sosuopic('<%=catalog %>','','');" href="javascript:void(0)" <%if("".equals(factoryid)){%>class="select"<%} %>>不限</a> <a onclick="sosuopic('<%= catalog%>',209,'')" href="javascript:;" <%if("209".equals(factoryid)){%>class="select"<%} %>>徐工</a> <a onclick="sosuopic('<%=catalog %>','133','')" href="javascript:void(0)" <%if("133".equals(factoryid)){%>class="select"<%} %>>三一</a> <a onclick="sosuopic('<%=catalog %>','174','')" href="javascript:void(0)" <%if("174".equals(factoryid)){%>class="select"<%} %>>卡特</a> <a onclick="sosuopic('<%=catalog %>','134','')" href="javascript:void(0)" <%if("134".equals(factoryid)){%>class="select"<%} %>>中联</a> <a onclick="sosuopic('<%=catalog %>','136','')" href="javascript:void(0)" <%if("136".equals(factoryid)){%>class="select"<%} %>>柳工</a> <a onclick="sosuopic('<%=catalog %>','192','')" href="javascript:void(0)" <%if("192".equals(factoryid)){%>class="select"<%} %>>斗山</a> <a onclick="sosuopic('<%=catalog %>','182','')" href="javascript:void(0)" <%if("182".equals(factoryid)){%>class="select"<%} %>>小松</a> <a onclick="sosuopic('<%=catalog %>','193','')" href="javascript:void(0)" <%if("193".equals(factoryid)){%>class="select"<%} %>>现代</a> <a onclick="sosuopic('<%=catalog %>','1147','')" href="javascript:void(0)" <%if("1147".equals(factoryid)){%>class="select"<%} %>>恒天九五</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left:0px; width:100%;">
                <iframe id="brand_iframe" src="/include/photo/brand.jsp?catalog='<%=catalog %>'&factory_id='<%=factoryid%>'&tonandmeter=''&order=''" frameborder="0" scrolling="no" width="100%" height="460" allowtransparency="true"></iframe>
              </div>
            </dd>
          </li>
        </ul>
      </div>
      <div class="w755 r border03">
        <div class="title12">
          <h3 style="float:left"><%=keywords%><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))%>图片</h3>
        </div>
        <ul class="list12">
          <%
        if(null !=main_picList && main_picList.size()>0){
        	for(Map oneMap:main_picList){
        		%>
          <li>
            <div class="photo"><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%="".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%><%=keywords %>" width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_middle.jpg',2);" title="<%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%="".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%><%=keywords %>"/></a></div>
            <h3><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank" title="<%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%="".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>"><%="".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%="".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%><%=keywords %></a></h3>
          </li>
          <%
        	}
        }else{
        %>
          <span class="textStyle">暂无信息</span>
          <%
		}
		%>
        </ul>
      </div>
      <div class="w755 l">
        <div id="pagination" class="page">
          <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
    </div>
  </cache:cache>
  <!--right end-->
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot--> 
<!--图片轮换--> 
<script src="/scripts/jquery.tools.min.js" type="text/javascript"></script> 
<script type="text/javascript">
	//左侧
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"<%=factoryid%>","catalog":"<%=catalog%>","url":"/photo/list.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})

	jQuery(document).ready(function() {
		jQuery("#chained").scrollable({circular: true, mousewheel: false}).navigator().autoscroll({
			interval: 8000
		});
	});
	function sosuopic(catalog,factoryid){
		jQuery("#catalogid").attr("value",catalog) ;
     	jQuery("#factory_id").val(jQuery.trim(factoryid)) ;
     	if(""==jQuery.trim(catalog)){
     	   jQuery("#catalogid").removeAttr("name") ;
     	   jQuery("#catalogid").remove() ;
     	}
     	if(""==jQuery.trim(factoryid)){
     		jQuery("#factory_id").removeAttr("name") ;
     	    jQuery("#factory_id").remove() ;
     	}
     	if(""==jQuery.trim(factoryid) && ""==jQuery.trim(catalog)){
     	    jQuery("#theform").attr("method","post") ;
     	}
		jQuery("#theform").attr("action","list.jsp") ;
    	jQuery("#theform").submit() ;
	}
</script> 
<!--图片轮换--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>