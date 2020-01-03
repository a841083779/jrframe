<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String keyword="";
	if(catalog.length()>6){catalog=catalog.substring(0,6);}
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
	String sql = "SELECT top 15 name,id FROM pro_agent_factory AS a INNER JOIN (SELECT factoryid,SUM(view_count) as counts FROM pro_products WHERE catalognum LIKE '"+catalog+"%'  GROUP BY factoryid) AS b ON a.id=b.factoryid ORDER BY b.counts desc";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="* * */9 * *">

     <%
			if(list != null && list.size() > 0){
			   int i=0;
				for(Map m : list){
             				
     %>

<li <%if(i<=2){%> class="top3"<%}%>>
<em><%=i+1%></em><h4><a title='<%=CommonString.getFormatPara(m.get("name")).replace("¿¨ÌØ±ËÀÕ","¿¨ÌØ")%><%=catalogName%>' target="_blank" href="/products/prolist.jsp?factory=<%=CommonString.getFormatPara(m.get("id"))%>&catalog=<%=catalog%>"><%=CommonString.getFormatPara(m.get("name")).replace("¿¨ÌØ±ËÀÕ","¿¨ÌØ")%><%=catalogName%></a></h4></li>
    
	<%
	i++;}}
	%>
  
</cache:cache>