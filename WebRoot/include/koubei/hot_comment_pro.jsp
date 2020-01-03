<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
%>
<cache:cache cron="* * */1 * *">
<%
       List<Map> list = dbHelper.getMapList("SELECT top 12 a.factoryname,a.name,a.catalogname,a.file_name,b.allcount,a.id,a.img2 from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 )as a LEFT  JOIN ( SELECT COUNT(product_id) as allcount,product_id  FROM pro_comments  GROUP BY product_id  ) as b ON a.id=b.product_id  ORDER BY  b.allcount desc");
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){			
	  %>
	     <li><a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>口碑" target="_blank" href="/list/<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm">
		 <img width="80" height="70" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>口碑" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>"></a>
		 <a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>口碑" target="_blank" href="/list/<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm">
            <h4><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>口碑</h4>
        </a></li>
      <%
			}
		}
	  %> 
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>