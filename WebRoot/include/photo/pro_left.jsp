<%@ page language="java" import="java.util.Date,java.io.File,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.JSONObject,org.apache.commons.io.FileUtils" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<%
	//产品列表页左侧同类产品排行
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String sql = " select top 6 id,file_name,name,factoryname,catalogname,img2,view_count from pro_products where catalognum like '"+catalog+"%' and (factoryname+name+catalogname like '%"+keyword+"%') and img2 is not null and img2 != '' and is_show = 1 order by newid() ";
	String today = CommonDate.getToday("yyyy-MM-dd");
	String cacheKey = "photo_proLeft_"+catalog+today+keyword;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	try{
		connection = dbHelper.getConnection();
%>
<cache:cache key="<%=cacheKey%>" cron="* * */1 * *">
  <%
			List <Map>list = dbHelper.getMapList(sql,connection);
			for(int i = 0;list != null && i < list.size();i++){
				String url = "/detail_for_"+CommonString.getFormatPara(list.get(i).get("id"))+".htm";
					%>
  <li> <a target="_blank" href="<%=url%>" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>图片"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2")).toLowerCase()%>" width="80" height="70" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>图片" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
            <h3><a target="_blank" href="<%=url%>" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>图片"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>图片</a><span style="color:#999999"> </span></h3>
          </li>
  <%	
	}
  %>
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>