<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
	Map catalogMap = (Map)application.getAttribute("catalogMap");
	String sql1="select factoryname from from pro_products where factoryid = '"+factoryid+"' and catalognum is not null";
	String sql = " select substring(catalognum,1,6) as catalognum from pro_products where factoryid = '"+factoryid+"' and catalognum is not null group by substring(catalognum,1,6) order by catalognum asc ";
	String cacheKey = "pub_sub_left_foot_"+factoryid;
%>
<cache:cache cron="*/1 * * * *" key="<%=cacheKey%>">
<%	
	List<Map> list = DBHelper.getInstance().getMapList(sql);
	List<Map> list1 = dbHelper.getMapList("select factoryname from from pro_products where factoryid = '"+factoryid+"' and catalognum is not null",connection) ;
%>
<%
	for(int i = 0;list!=null && i<list.size();i++){		  
		String catalogName = catalogMap.get(list.get(i).get("catalognum"))==null?"":catalogMap.get(list.get(i).get("catalognum")).toString();
		if(catalogName != null && !catalogName.equals("")){
	  %>
<a target="_blank" href="http://product.21-sun.com/products/prolist_text.jsp?factory=<%=factoryid%>&catalog=<%=CommonString.getFormatPara(list.get(i).get("catalognum"))%>" title="<%=list1.get(0).factoryname%><%=catalogName%>"><%=list1.get(0).factoryname%><%=catalogName%></li>
<%
		}
	  }
	  %>
</cache:cache>