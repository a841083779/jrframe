<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
	    String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	    String proId = CommonString.getFormatPara(request.getParameter("proId"));
		String sql="";
		if(catalog.equals("101002")||catalog.equals("101001")){
		sql="select top 6 id,img2,catalogname,name,factoryname,file_name from pro_products where is_show=1 and id!="+proId+" and catalognum like '"+catalog+"%' and factoryid!="+factoryid+" and view_count>2500 order by newid()";
        }else{
		sql="select top 6 id,img2,catalogname,name,factoryname,file_name from pro_products where is_show=1 and id!="+proId+" and catalognum like '"+catalog+"%' and factoryid!="+factoryid+" order by view_count desc";
		}
%>
<cache:cache cron="* * */14 * *">
<%
       List<Map> list = dbHelper.getMapList(sql);
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){	
	  %>
                	<li>
                    	<p class="com_brand_img"><a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" target="_blank"  href="/list/<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm"><img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>"/></a></p>
                        <a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" target="_blank" href="/list/<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm">
						<p class="com_brand_name" style="height:20px;overflow:hidden"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%></p>
                        <p class="com_brand_cat"><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></p>
						</a>
                        <p class="com_brand_btn"><a href="javascript:;" onclick="chooseDifId(<%=CommonString.getFormatPara(list.get(i).get("id"))%>);"></a></p>
                        <p class="comb_vs_bg"></p>
                    </li>    
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