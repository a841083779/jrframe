<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String factoryid  = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String factoryname  = CommonString.getFormatPara(request.getParameter("factoryname")) ;
	String url = CommonString.getFormatPara(request.getParameter("url"));
	String urlOne = CommonString.getFormatPara(request.getParameter("url"));
	String cacheKey = "left_sub"+factoryid+url;
	Map catalogMap = (Map)application.getAttribute("catalogMap");
%><cache:cache key="<%=cacheKey%>" cron="* * */1 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		
		String sql1 = " select substring(catalognum,1,6) as catalognum from pro_products where factoryid = '"+factoryid+"' and catalognum is not null and is_show = 1 group by substring(catalognum,1,6) order by catalognum asc ";
		List <Map>list1 = dbHelper.getMapList(sql1,connection);
%>
<%
     
	  System.out.println(urlOne);
     System.out.println("¿ªÊ¼");
	 System.out.println(url);
     System.out.println(url.indexOf("inquiry"));
	 System.out.println(url.indexOf("agent"));
	 
	for(int i = 0;list1!=null && i<list1.size();i++){
		String catalogName = catalogMap.get(list1.get(i).get("catalognum"))==null?"":catalogMap.get(list1.get(i).get("catalognum")).toString();
		if(catalogName != null && !catalogName.equals("")){
                url="";
				url = "0_0_"+factoryid+"_"+CommonString.getFormatPara(list1.get(i).get("catalognum"))+".shtm";	
	%>
<li><a href="<%=url%>"><%=factoryname%><%=catalogName%></a></li>
<%
	url = urlOne;
		}
	}
%>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>
</cache:cache>