<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> commentList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	commentList = dbHelper.getMapList("select top 5 id,name1,factoryname,catalogname,content,username from pro_mobile_koubei_list where  catalognum like '"+catalognum+"%' order by id desc") ;
%>
    <%
        if(null != commentList && commentList.size()>0){
	%>
 <div class="p_2_2">
    <div class="comBox01 mb10">
      <div class="hd fix">
        <h3>产品评论</h3>
        <span class="more"><a title="更多<%=catalogname%>产品评论" href="http://koubei.21-sun.com/comment-<%=catalognum%>-0-0-0-0.htm">更多</a></span>
      </div>
      <div class="bd fix p_pl">
	       <ul>
	<%      
        	for(Map oneMap:commentList){
			String content=CommonString.getFormatPara(oneMap.get("content"));
			if(content.length()>15){
			content=content.substring(0,15)+"...";
			}
    %>
          <li> 
            <span class="ltitle"><%=CommonString.getFormatPara(oneMap.get("username")).equals("")?"用户":CommonString.getFormatPara(oneMap.get("username"))%></span> <span class="r"><!--date--></span> 
            <span class="linfo"><strong>对<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>评论</strong><p><%=content%></p></span>
          </li>
      <%}%>
        </ul>
      </div>
    </div>
  </div>
	<%}%>
</cache:cache>




