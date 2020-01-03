<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	proList = dbHelper.getMapList("select top 6 id,name,factoryname,catalogname,file_name,img2 from pro_products where is_show=1  and catalognum like '"+catalognum+"%' order by view_count desc") ;
%>
    <%
        if(null != proList && proList.size()>0){
	%>
  <div class="p_2_1">
    <div class="hd">
      <h3>推荐产品</h3>
      <span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalognum%>" title="更多<%=catalogname%>推荐产品">更多 &gt;&gt;</a></span>
    </div>
    <div class="bd p_rec">
      <ul class="fix">
	<%      
        	for(Map oneMap:proList){
			String img=CommonString.getFormatPara(oneMap.get("img2"));
			if(img.indexOf("uploadfiles")==-1){
			img="http://product.21-sun.com/uploadfiles/"+img;
			}else{
			img="http://product.21-sun.com/"+img;
			}
    %>
	   <li><a target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="<%=img%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" /><strong class="n"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></strong></a>
        <div class="links"><a target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>参数"  href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")%>_parameter.shtm">参数</a><em class="w">|</em><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>图片"  target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")%>_pic.shtm">图片</a><em class="w">|</em><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>评论"  target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")%>_message.shtm">评论</a></div>
       </li>
      <%}%>
      </ul>
    </div>
  </div>
	<%}%>
</cache:cache>



