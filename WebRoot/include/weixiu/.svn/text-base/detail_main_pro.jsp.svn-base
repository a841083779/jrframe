<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factory"));
	String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
	Map catalogMap = (Map)application.getAttribute("catalogMap");
	String sql = " select substring(catalognum,1,6) as catalognum from pro_products where factoryid = '"+factoryid+"' and catalognum is not null group by substring(catalognum,1,6) order by catalognum asc ";
%>
<cache:cache cron="* * * */1 *" >
<%	
	List<Map> list = DBHelper.getInstance().getMapList(sql);
%>
<%
	for(int i = 0;list!=null && i<list.size();i++){		  
		String catalogName = catalogMap.get(list.get(i).get("catalognum"))==null?"":catalogMap.get(list.get(i).get("catalognum")).toString();
		if(catalogName != null && !catalogName.equals("")){
	  %>
	              <li><a target="_blank" title="<%=factoryname%><%=catalogName%>" href="/pro-<%=list.get(i).get("catalognum")%>-0-<%=factoryid%>.htm"><%=catalogName%></a></li>

<%
		}
	  }
	  %>
</cache:cache>