<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%	
	String usern = CommonString.getFormatPara(request.getParameter("usern")); 
	String agentid = CommonString.getFormatPara(request.getParameter("agentid")); 
	String refer = CommonString.getFormatPara(request.getParameter("flag")) ;
	String sql = " select top 16 id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end from pro_agent_product_vi where agentid = ? and is_show = 1 order by img2 desc,id asc";
	if(refer.indexOf("agentshop02")!=-1){
		sql = " select top 16 id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end from pro_agent_product_vi where agentid = ? and is_show = 1 order by factoryid asc";
	}
	List<Map> list = DBHelper.getInstance().getMapList(sql,new Object[]{agentid});
	Map brandUsernMap = (Map)application.getAttribute("brandUsernMap");
%>

<div class="sContent">
  <ul class="slist">
    <%
	  if(list != null && list.size() > 0){
		for(int i = 0;list != null && i < list.size();i++){
    %>
    <li>
      <div class="img"><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>"><img src="http://product.21-sun.com//uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_small.gif',2);" width="176px" height="147px" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" /></a></div>
      <h3><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></a></h3>
      <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(list.get(i).get("id")) %>','<%=agentid%>','<%=CommonString.getFormatPara(list.get(i).get("factoryid"))%>')" class="btn">我要询价</a>
     <!-- <div class="w100 l pt5">
        <div class="star"><span class="star01"></span></div>
        (已有2769人评论) </div>-->
    </li>
    <%
				}
			}
	  	  %>
  </ul>
</div>
