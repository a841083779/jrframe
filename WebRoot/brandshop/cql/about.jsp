﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<% 
   //公司信息
   DBHelper dbHelper = DBHelper.getInstance() ;
   String  company="select introduce from pro_agent_factory where id=138";
   List<Map> companyInfo = null ;
   companyInfo = dbHelper.getMapList(company) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特彼勒（青州）有限公司官方旗舰店</title>
<meta name="keywords" content="山工装载机,山工推土机，山工平地机，山工压路机，山工压实机，山工产品报价,山工产品,山工产品图片,山工产品介绍" />
<meta name="description" content="铁臂商城为您提供卡特彼勒（青州）介绍,卡特彼勒（青州）产品介绍,卡特彼勒（青州）产品报价,卡特彼勒（青州）产品图片,卡特彼勒（青州）产品展示等卡特彼勒（青州）产品信息，帮助您全面了解卡特彼勒（青州）" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>

<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<div class="sg_nav clearfix">
    	<div class=" wrap">
    	<h1><img src='images/logo.jpg' width="147" height="45"/></h1>
        <ul>
		<li><a href="/brandshop/cql/">首页</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101002" target="_blank">装载机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101003" target="_blank">推土机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101005" target="_blank">平地机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=106001" target="_blank">压路机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=106003" target="_blank">压实机</a></li>
        <li><a href="/brandshop/cql/about.jsp" target="_blank">关于我们</a></li>
        </ul>
        </div>
    </div>
<div class="sg_banner"></div>
<div class="wrap con clearfix">
    	<div class="con1 l" style="margin-bottom: 20px;">
        	<h3 class="sg_tit" style="background: url(images/t01.jpg) no-repeat center;"></h3>
            <div style="height: 755px;background:#fff; width:980px;20px 15px">   
               		
					<div style="padding-left:18px;padding-right:18px;">　　			
				<%
			  if(null!=companyInfo && companyInfo.size()>0){
				Map oneMap = null ;
				for(int i=0;i<companyInfo.size();i++){
					oneMap = (HashMap)companyInfo.get(i);
					String intro=(CommonString.getFormatPara(oneMap.get("introduce")));
		     %>
			    <%=intro%>
				<%}}%>
				</div>
				
				
            </div>
      </div>
      
    </div>
    <div class="side"><img src='images/code.jpg' /></div>
	
	<jsp:include page="/brandshop/include/foot.jsp" flush="true"></jsp:include>
<div style="display:none"><script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5865198'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/stat.php%3Fid%3D5865198' type='text/javascript'%3E%3C/script%3E"));</script></div> 

</body>
</html>