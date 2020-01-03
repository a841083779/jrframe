<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jerehnet.util.common.CommonDate"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));	
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
   Map brandUsernMap  = (HashMap)application.getAttribute("brandUsernMap") ;  // id 和 品牌代号对应
   if(null == brandUsernMap){
	   brandUsernMap = new HashMap() ;
   }
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	StringBuffer whereStr = new StringBuffer(" and pp.factoryname is not null") ;
	if(!"".equals(catalog)){
		whereStr.append(" and pp.catalognum like '%"+catalog+"%'") ;
	}
	if(!"".equals(factory)){
		whereStr.append(" and pp.factoryid="+factory) ;
	}
	String url = CommonString.getFormatPara(request.getQueryString()) ;  // 调整url，做分页处理
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(10) ;
	   Integer nowPage = 1 ;
	   if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	   }
	pageBean.setNowPage(nowPage) ;
	pageBean.setParams(url) ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pp.id,pp.factoryname,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count") ;
	// pageBean.setIsShowSql(true) ;
	pageBean.setTableName(" pro_comments pm left join pro_products pp on  pm.product_id=pp.id") ;
	pageBean.setMain("pm") ;
	pageBean.setOrderBy(" pm.add_date desc") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=url.equals("")?"工程机械":""%><%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>口碑_<%=url.equals("")?"工程机械":""%><%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>优缺点_评论_中国工程机械商贸网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="怎么样，好不好，质量，评论，口碑，优点，缺点，售后" />
<meta name="description" content="<%=url.equals("")?"工程机械":""%><%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>怎么样，最新<%=url.equals("")?"工程机械":""%><%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>优缺点，<%=url.equals("")?"工程机械":""%><%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>口碑，中国工程机械商贸网聚集<%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>评论，评测，突出<%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %><%=(catalog.length()>6)?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>用户使用感受，为您的抉择多一分把握。" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true">
			<jsp:param name="keyword" value="<%=keyword%>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
			<jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
</jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/products/prolist.jsp">产品大全</a>&nbsp;>>&nbsp;<a href="/products/procomments.jsp">产品评论</a>
  <%=("".equals(catalog)||"".equals(CommonString.getFormatPara(catalogMap.get(catalog))))?"":" &gt;&gt; <a href='?catalog="+(catalog.length()>6?catalog.substring(0,6):catalog)+"'>"+(catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalog))) +"</a>"%>
   <%="".equals(factory)?"":" &gt;&gt; <a href='/brand/"+("".equals(factory)?"":CommonString.getFormatPara(brandUsernMap.get(factory)))+"/'>"+("".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)))+"</a>"%> <%="".equals(catalog)?"":" &gt;&gt; "+("".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%> </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">
<!--left-->
<div class="w210 l"> 
  <div id="leftId"> </div>
  <div class="w208 border02 l leftPart02 mb10">
    <h2>推荐产品</h2>
    <%
    String sel_sql2 = " select top 8 id,factoryname,catalogname,name,img2,file_name,view_count from pro_products" ;
    String whereStr2 = " where img2 is not null" ;
    String conditionStr2 = " order by view_count desc" ;
    List<Map> recommenst_pros = null ;
    if(!catalog.equals("")){
    	whereStr2+= " and catalognum like '%"+catalog+"%'" ;
    }
    recommenst_pros = dbHelper.getMapList(sel_sql2+whereStr2+conditionStr2) ;
    %>
    <ul id="proSubLeftId" class="list03">
    <%
    if(null!=recommenst_pros && recommenst_pros.size()>0){
    	for(Map oneMap:recommenst_pros){
    		%>
      <li> <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img width="80" height="70" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"></a>
        <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%></a><span style="color:#999999"> (<%=CommonString.getFormatPara(oneMap.get("view_count")) %>)</span></h3>
      </li>
      <%
    	}
    }
    %>
    </ul>
  </div>
</div>
<!--left end--> 
<!--right-->
<div class="w757 r mb10">
<cache:cache cron="* * */1 * *"> 
  <form name="theform" id="theform">
    <div class="w755 border03 l Condition mb10">
      <div class="ConditionTop">
        <div class="l">
             <%if(!"".equals(catalog) || !"".equals(factory)){%>
            <span class="reset" onclick="sosuo();">重置</span>
            <%}%>
            <% if(!"".equals(catalog) &&!"".equals(catalog)){%>
            <span><em><%="".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("","<%=factory %>","","","")'></a></span>
            <%}%>
            <% if(!"".equals(factory) &&!"".equals(factory)){%>
            <span><em><%="".equals(factory)?"":CommonString.getFormatPara(brandMap.get(factory)) %></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("<%=catalog %>","","","","")'></a></span>
            <%}%> 
          </div>
        <h3 class="r" style="font-size:18px;">口碑筛选</h3>
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
          <dt>类别</dt>
          <input type="hidden" name="factory" id="factory_id"/>
          <input type="hidden" name="catalog" id="catalognum" />
          <dd><a onclick="sosuo('','','');" href="javascript:void(0);"  <%if("".equals(catalog)){%>class='select'<%} %>>不限</a> 
          <a onclick="sosuo('101001','<%=factory %>','')" href="javascript:void(0)" <%if("101001".equals(catalog)){%>class='select'<%} %>>挖掘机</a>
              <a onclick="sosuo('101002','<%=factory %>','')" href="javascript:void(0)" <%if("101002".equals(catalog)){%>class='select'<%} %>>装载机</a> 
              <a onclick="sosuo('102','<%=factory %>','')" href="javascript:void(0)" <%if("102".equals(catalog)){%>class='select'<%} %>>起重机械</a>
              <a onclick="sosuo('101003','<%=factory %>','')" href="javascript:void(0)" <%if("101003".equals(catalog)){%>class='select'<%} %>>推土机</a> 
             <a onclick="sosuo('103','<%=factory %>','')" href="javascript:void(0)" <%if("103".equals(catalog)){%>class='select'<%} %>>混凝土</a>
              <a onclick="sosuo('106001','<%=factory %>','')" href="javascript:void(0)" <%if("106001".equals(catalog)){%>class='select'<%} %>>压路机</a>
              <a onclick="sosuo('101005','<%=factory %>','')" href="javascript:void(0)" <%if("101005".equals(catalog)){%>class='select'<%} %>>平地机</a>
              <a onclick="sosuo('105003','<%=factory %>','')" href="javascript:void(0)" <%if("105003".equals(catalog)){%>class='select'<%} %>>旋挖钻</a>
              <a onclick="sosuo('113001','<%=factory %>','')" href="javascript:void(0)" <%if("113001".equals(catalog)){%>class='select'<%} %>>破碎锤</a>
              <a onclick="sosuo('104001','<%=factory %>','')" href="javascript:void(0)" <%if("104001".equals(catalog)){%>class='select'<%} %>>摊铺机</a>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left:0px; width:100%;">
              <iframe id="catalog_iframe" src="/include/products/catalog_comments.jsp?catalog='101001001'&factoy_id=''&tonandmeter=''&order=''" frameborder="0" scrolling="no" width="100%" height="670" allowtransparency="true"></iframe>
            </div>
          </dd>
        </li>
      <li class="cblist">
            <dt>品牌</dt>
            <dd> 
            <%if(!"".equals(catalog)) {
            	%>
            	 <a onclick="sosuo('<%=catalog %>','','');" href="javascript:void(0)" <%if("".equals(factory)){%>class="select"<%} %>>不限</a>
            <%	
                List<Map> recommend_brands = dbHelper.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='"+catalog+"' order by order_no desc") ;
            	  if(null !=recommend_brands && recommend_brands.size()>0){
            		  int i=0;
            		  for(Map oneMap:recommend_brands){
            			  i++ ;
            			  if(i==11){
            				  break ;
            			  }
            %>  <!-- 挖掘机 -->
             <a onclick="sosuo('<%= catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>','')" href="javascript:;" <%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factory)){%>class="select"<%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a> 
             <%}}}else{
            	 %>
            	 <a class="select" href="javascript:void(0)" onclick="sosuo('101001','','');">不限</a>
              <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','133','')">三一</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','182','')">小松</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','192','')">斗山</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','184','')">日立</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','183','')">神钢</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','175','')">沃尔沃</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','174','')">卡特彼勒</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','146','')">玉柴重工</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','136','')">柳工</a> 
               <!-- 挖掘机 -->
             <a href="javascript:;" onclick="sosuo('101001','1187','')">东方红</a> 
            	 <%
             }%>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left:0px; width:100%;">
                <iframe id="brand_iframe" src="/include/products/brand_comments.jsp?catalog='<%=catalog %>'&factory_id='<%=factory%>'&tonandmeter=''&order=''" frameborder="0" scrolling="no" width="100%" height="460" allowtransparency="true"></iframe>
              </div>
            </dd>
          </li>
        <script type="text/javascript">
            if('101001001'.indexOf("101001")!=-1){
              jQuery("#grab").attr("style","display:;") ;
            }
               if('101001001'.indexOf("101002")!=-1){
              jQuery("#loader").attr("style","display:;") ;
            }
               if('101001001'.indexOf("102")!=-1){
              jQuery("#crane").attr("style","display:;") ;
            }
          </script>
      </ul>
    </div>
    <input type="hidden" name="order" id="order"/>
    <input type="hidden" name="keyword" id="key_word" />
  </form>
  <!--评论列表-->
  <script type="text/javascript">
  jQuery(function(){
	  jQuery(".plList li").hover(function(){
		  jQuery(this).toggleClass("hover");
	  },function(){
		  jQuery(this).removeClass("hover");
	  });
  })
  </script>
  <div class="plList">
    <ul>    
         <%
		   List<Map> searchProducts = pageBean.getDatas() ;  // 根据条件查出的产品
		   if(searchProducts !=null && searchProducts.size()>0){
			   for(Map oneMap:searchProducts){
				   %>
				    <li>
			        <div class="plimg"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).substring(0,CommonString.getFormatPara(oneMap.get("file_name")).lastIndexOf("."))+"_message.shtm" %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("product_name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"  alt="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("product_name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" /></a></div>
			        <div class="content">
			          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).substring(0,CommonString.getFormatPara(oneMap.get("file_name")).lastIndexOf("."))+"_message.shtm" %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("product_name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h3> <span class="time"><%=CommonDate.getFormatDate("MM-dd HH:mm",CommonString.getFormatPara(oneMap.get("add_date"))) %></span>
			          <div class="plinfo01"><span class="plname"><%=CommonString.getFormatPara(oneMap.get("contact_address")) %>的网友评论</span></div>
                      <div class="w100 l">
                        <p class="textContent">
                          <%=CommonString.getFormatPara(oneMap.get("content")) %>
                        </p>
                        <div class="r plt">网友平均评分 <font><%=(Integer.parseInt(CommonString.getFormatPara(oneMap.get("score1")))+Integer.parseInt(CommonString.getFormatPara(oneMap.get("score2")))+Integer.parseInt(CommonString.getFormatPara(oneMap.get("score3"))) +Integer.parseInt(CommonString.getFormatPara(oneMap.get("score4"))))/4%></font> 分</div>
                      </div>
			          <div class="plinfo02">阅读 <%=CommonString.getFormatPara(oneMap.get("view_count")) %> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).substring(0,CommonString.getFormatPara(oneMap.get("file_name")).lastIndexOf("."))+"_message.shtm" %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("product_name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>">查看所有评论</a></div> 
			        </div>
			      </li>
				   <%
			   }
		   }else{
		    	%>
		    	  <li>
		        	该品牌下的产品暂无评论
		    	 </li>
		    	<%
		    }
		%>
    </ul>
  </div>
  <!--评论列表结束-->
  <div class="w755 l">
    <div id="pagination" class="page">
   <tags:page pageBean="<%=pageBean %>" />      
    </div>
  </div>
  <!--right end-->
    </cache:cache>
</div>  
<div class="clear"></div>

</div>
<!--main end--> 
<!--foot--> 
<div align="center">
  <table cellspacing="0" cellpadding="0" border="0" width="950" style="margin-top:7px">
    <tbody>
      <tr>
        <td class="td04"><p align="center"><span onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');" style="cursor: pointer;">广告服务</span> | <span onclick="window.open('http://aboutus.21-sun.net/contact/');" style="cursor: pointer;"> 联系方式</span> | <span onclick="window.open('http://aboutus.21-sun.net/');" style="cursor: pointer;"> 关于我们</span> | <span onclick="window.open('http://aboutus.21-sun.net/news/');" style="cursor: pointer;"> 本网动态</span> | <span onclick="window.open('http://aboutus.21-sun.net/contact/legal.jsp');" style="cursor: pointer;">法律声明</span> | <span onclick="window.open('http://aboutus.21-sun.net/map.htm');" style="cursor: pointer;">网站导航</span> | <span onclick="window.open('http://www.21-sun.com/guestbook/index.jsp');" style="cursor: pointer;"> 访问留言</span> <br/>
            主编:<a href="mailto:webmaster@21-sun.com" class="link09" rel="nofollow">webmaster@21-sun.com</a> 市场部:<a href="mailto:market@21-sun.com" class="link09" rel="nofollow">market@21-sun.com</a> 技术部:<a href="mailto:tech@21-sun.com" class="link09" rel="nofollow">tech@21-sun.com</a> 广告部:<a href="mailto:ads@21-sun.com" class="link09" rel="nofollow">ads@21-sun.com</a><br/>
            产品询价专线:0535-6792733 业务联系:(总机)0535-6722555 传真:0535-6723239<br/>
            <span onclick="window.open('http://www.21-sun.com');" style="cursor: pointer;">中国工程机械商贸网</span> Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script></p></td>
      </tr>
    </tbody>
  </table>
</div>
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}

/*jQuery("body").bind("contextmenu", function() {
  return false;
});*/
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<!--end of foot--> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script type="text/javascript">
  	//左侧查询
	jQuery.ajax({
		url:"/include/left_comments.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"<%=factory%>","catalog":"<%=catalog%>","url":"/products/procomments.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})
	//左侧同类产品排行
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"proSubLeft","catalog":"101001001","keyword":""},
		success:function(data){
		//	jQuery("#proSubLeftId").html(jQuery.trim(data));	
		}
	})
	//左侧同类品牌排行
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandSubLeft","catalog":"101001001","keyword":""},
		success:function(data){
		//	jQuery("#brandSubLeftId").html(jQuery.trim(data));	
		}
	})
    //jQuery('html, body').animate({scrollTop: 382}, 0);
    	  jQuery("#showorder a:eq(0)").removeClass("select") ;
    	  jQuery("#showorder a:eq(1)").addClass("select") ;
</script>
</body>
</html>
