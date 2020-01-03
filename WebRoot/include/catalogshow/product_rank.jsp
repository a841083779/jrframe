<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String whereStr="  is_show=1  and catalognum like '"+catalognum+"%'";
	if(!factoryid.equals("")&&!factoryid.equals("0")){
	whereStr+=" and  factoryid="+factoryid;
	}
	proList = dbHelper.getMapList("select top 6 id,name,factoryname,catalogname,file_name,img2 from pro_products where"+whereStr+" order by view_count desc") ;
%>
    <%
        if(null != proList && proList.size()>0){
	%>
        <div class="comBox01 mb10">
            <div class="hd fix">
              <h3><%=catalogname%>关注排行</h3>
            </div>
            <div class="bd fix">
              <ul class="list03">
	<%      
        	for(Map oneMap:proList){
			String img=CommonString.getFormatPara(oneMap.get("img2"));
			if(img.indexOf("uploadfiles")==-1){
			img="http://product.21-sun.com/uploadfiles/"+img;
			}else{
			img="http://product.21-sun.com/"+img;
			}
    %>
	    <li><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank"><img width="80" height="70" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" src="<%=img%>"></a>
             <h3><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a><span style="color:#999999"> </span></h3>
        </li>

      <%}%>
              </ul>
            </div>
          </div>
	<%}%>
</cache:cache>





