<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String province = CommonString.getFormatPara(request.getParameter("province"));
	String count = CommonString.getFormatPara(request.getParameter("count"));
	 Connection connection = null;
	 DBHelper dbHelper = DBHelper.getInstance();
	
	try{
	    connection = dbHelper.getConnection();
		 String province_sql="select id,name,num,parent_num from   pro_agent_province_city  where parent_num=105";
         List <Map> province_list = dbHelper.getMapList(province_sql,connection);	
		
	
		
%>
 <div class="dl_sele_r_ls" id="area<%=count%>">
      <ul>
	  <%
			
			for (Map oneMap : province_list) {
			
			String parent_num= CommonString.getFormatPara(oneMap.get("parent_num"));
			String num= CommonString.getFormatPara(oneMap.get("num"));
			String name= CommonString.getFormatPara(oneMap.get("name"));
	  %>
        <li><a href="#"><span><%=num%></span><%=name%></a></li>
		<%}%>
      </ul>
    </div>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>