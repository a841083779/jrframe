<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList= null ;
	proList = dbHelper.getMapList(" select top 4 img2,file_name from pro_products where img2 is not null and img2 != '' and is_show = 1 order by newid() ") ;
%>
<div style="padding:15px 0 0 260px; line-height:24px; font-size:14px; font-weight:bold; font-family:微软雅黑; color:#000"">
<%
	for( int i = 0; proList != null && proList.size() > 0 && i < proList.size(); i ++ ){
%>
  <div style="background-image:url(images/4041.gif); width:104px; height:76px; float:left; margin-right:17px; text-align:center; padding-top:2px;"><a href="/proDetail/<%=CommonString.getFormatPara(proList.get(i).get("file_name"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(proList.get(i).get("img2")).toLowerCase()%>" width="100" height="74" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
<%
	}
%>
</div>
