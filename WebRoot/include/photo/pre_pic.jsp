<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类型
			if(catalog.length()>6){catalog=catalog.substring(0,6);}
			int id = CommonString.getFormatInt(request.getParameter("id")) ; // 编号	
			DBHelper dbHelper = DBHelper.getInstance() ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<%
			List<Map> proList = null ;
			String do_sql ="select top 1 id,catalogname,name,factoryname  from pro_products where id <"+id+" and catalognum like '%"+catalog+"%' order by id desc";
		    proList = dbHelper.getMapList(do_sql) ;
			if(null!=proList && proList.size()>0){
			  for(Map oneMap:proList){
			  %>
				<span>上一图集：</span>
			    <a title='<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>图片' href='detail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm'>
			    <%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>图片
			    </a>
				<%
			   }
		    }else
			{%>
			    <span>下一图集：</span><a>暂无信息</a>
			<%}
%>
</body>
</html>