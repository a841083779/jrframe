<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="utf-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* * */1 * *">
<%
	String sql = " SELECT  id,title,image,allcount FROM(select top 8  id,title,image from pro_photo_group where is_show=1   order by newid()) AS a LEFT JOIN (SELECT group_id,COUNT(group_id) as allcount from  pro_photo GROUP BY group_id ) as b ON a.id=b.group_id  ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
        <%

			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
            	<li>
                	<div class="pholist_img"><a href="http://photo.21-sun.com/ndetail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(m.get("title")) %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("image")) %>" style="width:225px;height:170px;" alt="<%=CommonString.getFormatPara(m.get("title")) %>"></a></div>
                    <div class="pholist_name"><a href="http://photo.21-sun.com/ndetail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(m.get("title")) %>"><%=CommonString.getFormatPara(m.get("title")) %></a></div>
                    <div class="num">共<%=CommonString.getFormatInt(m.get("allcount")) %>张图片</div>
                </li>		
       <%}}%>
	  </cache:cache>  
	  

 