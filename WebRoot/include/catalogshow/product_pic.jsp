<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String whereStr="  is_show=1  and catalognum like '"+catalognum+"%'  and view_count>5000";
	if(!factoryid.equals("")&&!factoryid.equals("0")){
	whereStr+=" and  factoryid="+factoryid;
	}
	proList = dbHelper.getMapList("select top 4 id,name,factoryname,catalogname,file_name,img2 from pro_products where"+whereStr+" order by newid() ") ;
%>
    <%
        if(null != proList && proList.size()>0){
	%>
        <div class="comBox01 mb10">
        	<div class="hd fix">
              <h3><%=catalogname%>图片</h3>
              <a target="_blank" href="http://photo.21-sun.com/list.jsp?catalog=<%=catalognum%>" class="pc_more">更多</a>
            </div>
            <div class="bd fix">
            	<ul class="fix pc_hotpro">
	<%      
        	for(Map oneMap:proList){
			String img=CommonString.getFormatPara(oneMap.get("img2"));
			if(img.indexOf("uploadfiles")==-1){
			img="http://product.21-sun.com/uploadfiles/"+img;
			}else{
			img="http://product.21-sun.com/"+img;
			}
    %>

		 
		<li>
             <div class="pchot_img"><a href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" target="_blank"><img src="<%=img%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>"/></a></div>
            <div class="pchot_name"><a href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a></div>
        </li>
      <%}%>
                </ul>
            </div>
        </div>
	<%}%>
</cache:cache>



