<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	PageBean pageBean = new PageBean() ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
		String whereStr = " and from_url like '%baidu%' ";

	pageBean.setTableName("pro_cat_ad") ;
	pageBean.setFields(" id,add_ip,add_date,from_url,visit_url ");
	pageBean.setCondition(whereStr);
	pageBean.setOrderBy(" id desc ");
	pageBean.setPageSize(10);
	Integer nowPage = 1;
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}; // 当前页
	pageBean.setNowPage(nowPage);
	pageBean.setIsShowSql(true);
	List<Map> newsList = pageBean.getDatas();
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特</title>
<meta name="Keywords" content="卡特挖机,卡特挖掘机,卡特彼勒公司,卡特电子商务平台 cat电商平台,挖掘机价格,挖掘机报价,挖机价格,挖机报价,挖掘机" />
<meta name="Description" content="卡特挖掘机电商平台是世界最大的挖掘机生产厂家之一卡特彼勒公司旗下的Cat电商平台卡特挖掘机价格查询中心。了解最新卡特挖机报价相关信息登录卡特挖掘机电商平台。" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body>

<!--top--begin-->

<!--top--end-->

<div class="wrap_list">

  <div class="list_con clearfix">

    <div class="news_list_right r" style="width:900px;background:url()">
    <table border="1" style="width:890px;">
	   <tr  style="width:890px;">
	   <td style="width:10%"><strong>访问时间</strong></td>
	   <td  style="width:10%"><strong>访问ip</strong></td>
	   <td  style="width:20%"><strong>访问地址</strong></td>
	   <td  style="width:60%"><strong>来源地址</strong></td>
	   </tr>
      	<%
        	if(null!=newsList && newsList.size()>0){
        		for(Map oneMap:newsList){
   
       %>
  	   <tr  style="width:890px;">
	   <td style="width:10%"><%=CommonString.getFormatPara(oneMap.get("add_date"))%></td>
	   <td style="width:10%"><%=CommonString.getFormatPara(oneMap.get("add_ip"))%></td>
	   <td style="width:20%"><%=CommonString.getFormatPara(oneMap.get("visit_url"))%></td>
	   <td style="width:60%"><%=CommonString.getFormatPara(oneMap.get("from_url"))%></td>
	   </tr>
      <%}} %>
      </table>
      	<% if(pageBean.getPageCount()>1){ %>
        <div id="pagination" class="paging">
      	<tags:cat_page pageBean="<%=pageBean%>" />
    	</div>
    	<%} %>
    </div>
  </div>

	
</div>

</body>
</html>