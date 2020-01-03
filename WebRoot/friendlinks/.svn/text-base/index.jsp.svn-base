<%@ page language="java" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="java.util.List"%><%@page import="java.util.Map"%><%@page import="java.util.ArrayList"%><%@page import="com.jerehnet.util.common.CommonString"%><%
	DBHelper dbHepler = DBHelper.getInstance() ;
	List<Map> alllinks = dbHepler.getMapList(" select link_name,link_addr from link_list where is_show=0 and website_id=10 and link_name is not null and link_addr is not null ") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【工程机械产品中心】- 中国工程机械商贸网</title>
<meta name="keywords" content="工程机械,工程机械型号,工程机械价格,工程机械图片" />
<meta name="description" content="工程机械产品中心作为工程机械行业权威平台，是用户采购工程机械产品的首选网站。为您提供最新最全的工程机械产品报价、图片、型号、品牌。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/home.css" rel="stylesheet" type="text/css" />
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript">
jQuery(function(){
	jQuery(".friendLinksContain td").hover(function(){
		jQuery(this).toggleClass("fh");
	},function(){
		jQuery(this).removeClass("fh");
	});
})
</script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<style type="text/css">
.friendLinks { width:880px; margin:0 auto;}
.friendLinks h2 { font-size:30px; font-family:微软雅黑; font-weight:normal; line-height:60px; color:#3c3c3c;}
.friendLinks p { font-size:14px; line-height:24px; padding-bottom:15px;}
.friendLinksContain { border-collapse:collapse; border:#dcdcdc 1px dotted; background:#fafafc;}
.friendLinksContain td { width:143px; white-space:nowrap; border:#dcdcdc 1px dotted; font-size:13px;}
.friendLinksContain td span { display:block; width:125px; height:40px; line-height:40px; padding-left:18px; cursor:pointer;}
.friendLinksContain td.fh { background:#d5ebff;}
.grass { width:1000px; height:87px; clear:both; margin:0 auto; background:url(/images/grass.jpg) no-repeat;}
</style>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--top end-->
<div class="contain980">
  <div class="friendLinks">
    <h2 class="alignCenter">-- 友情链接 --</h2>
    <p>欢迎各商业网站链接中国工程机械商贸网！链接好后请通知我们。电话：0535-6792768，我们审核通过后将在一个工作日内做好贵网的链接。<br />
      同时欢迎各工程机械企业网站在首页链接本网，链接好后请通知我们，我们将在本栏目内链接贵公司网站。<br />
    邮箱：<a href="mailto:wangxin@21-sun.com">wangxin@21-sun.com</a> Q Q：1848839906 </p>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="friendLinksContain">
    <%
    	if(null!=alllinks && alllinks.size()>0){
    		List<Map> subList = new ArrayList() ;
    		for(int i=1;i<alllinks.size()+1;i++){
    			Map oneMap = alllinks.get(i-1) ;
    			subList.add(oneMap) ;
    			if(i%6==0&&i>0){
    				%>
    				<tr>
    				<%
    				for(int j=0;j<subList.size();j++){
    					Map oneSubMap = subList.get(j) ;
    			%>
    			<td><span onclick="window.open('<%=CommonString.getFormatPara(oneSubMap.get("link_addr")) %>');"><%=CommonString.getFormatPara(oneSubMap.get("link_name")) %></span></td>
    			<%
    				}
    				%>
    				</tr>
    				<%
    				subList.clear() ;
    			}
    		}
    	}
    %>
    </table>
  </div>
  <div class="grass"></div>
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<!--end of foot-->
</body>
</html>