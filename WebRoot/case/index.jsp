<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="java.util.List"%><%@page import="java.util.Map"%><%@page import="com.jerehnet.util.common.CommonHtml"%><%@page import="com.jerehnet.util.common.Common"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%
	String url = CommonString.getFormatPara(request.getQueryString()) ;  // 调整url，做分页处理
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ; // 页码
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
	int pageSize=8 ;
	PageBean pageBean = new PageBean() ;
	pageBean.setTableName("pro_case_news") ;
	pageBean.setPageSize(pageSize) ;
	pageBean.setFields(" id,title,content,view_count,reply_count,pub_date,address,username") ;
	pageBean.setCondition(" and is_approval=1 ") ;
	pageBean.setOrderBy(" add_date desc") ;
	pageBean.setParams(url) ;
	Integer nowPage = 1 ;
	   if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	   }
	pageBean.setNowPage(nowPage) ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程机械产品案例 - 铁臂商城</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="工程机械产品案例,工程机械产品订单案例" />
<meta name="description" content="分享工程机械行业用户订单成交案例。这里是众多工程机械行业用户网上购机的首选平台,每天有上万的业内用户汇集在这里选机比价。" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body style="background-color:#ffd124;">
<!--top-->
<jsp:include page="/include/case/topcase.jsp" flush="true"></jsp:include>
<div class="caseBanner">
  <div class="contain980"><img src="/images/case_banner.jpg" width="980" height="320" /></div>
</div>
<div class="caseMain">
  <div class="contain980"><img src="/images/casebanner_shadow.gif" width="980" height="18" /></div>
  <!--面包屑-->
  <div class="contain980">
    <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/case/">产品案例</a></h3>
  </div>
  <!--面包屑结束--> 
  <div class="contain980 content">
    <!--left-->
   <jsp:include page="/include/case/left.jsp" flush="true"></jsp:include>
    <!--right-->
    <div class="caseRight">
      <ul class="list">   
      <%
      	List<Map> casesInfo = pageBean.getDatas() ;                                // 根据条件查出信息
      	for(Map oneMap:casesInfo){
      		%>
      		<li>
          <h3><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("title")) %></a></h3>
          <p class="text"><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("content"))).length()>80?CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("content"))).substring(0,80):CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("content")))%></a></p>
          <div class="w100 l">
            <div class="info">人气：<%=CommonString.getFormatPara(oneMap.get("view_count")) %>次 | 评论：<%=CommonString.getFormatPara(oneMap.get("reply_count")) %>次</div>
            <a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" class="readMore" target="_blank">阅读全文</a>
          </div>
        </li>
      		<%	}   %>
      </ul>
      <div class="w100 l">
        <div class="page" id="pagination">
          <div class="paging">
          <%
            if(null!=casesInfo && casesInfo.size()<pageBean.getTotal()){
            	%>
            	<tags:page pageBean="<%=pageBean %>" />    
            	<%
            }
          %>
          </div>
        </div>
      </div>
    </div>
  <div class="clear"></div>  
  </div>
  <div class="contain980"><img src="/images/zhengwen.gif" width="980" height="145" border="0" usemap="#Map" />
    <map name="Map" id="Map">
      <area shape="rect" coords="642,43,837,103" href="http://news.21-sun.com/online.htm" title="我要参与" target="_blank"/>
    </map>
  </div>
</div>
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
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<!--end of foot--> 
</body>
</html>