<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */7 * * *">
<%
	String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
	String sql = " select id,title,content,view_count,reply_count,pub_date,address,username from pro_case_news where is_approval=1 and title like '%"+factoryname+"%' order by add_date desc";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});	
%>
   <div class="w757 r np_right mb10">
    <div class="w755 l border03 listTop" style="display:none">
      <div class="l" id="showorder"> <strong>排序</strong> <a href="javascript:;" onclick="javascript:sosuo('','','','',1,'');" class="select">默认</a> <a href="javascript:;" onclick="javascript:sosuo('','','','',0,'');">热度</a> </div>
      <div class="r"> <span><b> </b>&nbsp;&nbsp;共</span><b>14056</b><span>条&nbsp;|</span> 
        <a href="javascript:;" class="pre noPre" title="上一页">&nbsp;</a><b>1/1406</b><a href="?offset=10" class="next">&nbsp;</a> </div>
    </div>
    <div class="np_plist_gslist">
    	<ul class="np_fix">
        <%
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
       
        <li>
            	<h2><a target="_blank" href="/case/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm""><%=CommonString.getFormatPara(m.get("title")) %></a></h2>
                <div class="gs_list_sum"> <%=CommonHtml.filterHTML(CommonString.getFormatPara(m.get("content"))).length()>80?CommonHtml.filterHTML(CommonString.getFormatPara(m.get("content"))).substring(0,80):CommonHtml.filterHTML(CommonString.getFormatPara(m.get("content")))%></div>
                <div class="gs_list_rq">人气：<%=CommonString.getFormatPara(m.get("view_count")) %>次 | 评论：<%=CommonString.getFormatPara(m.get("reply_count")) %>次</div>
                <div class="gs_list_more"><a target="_blank" href="/case/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm">阅读全文</a></div>
       </li>
              


	   <%
				}
			}else{
		%>
		  暂无信息
		<%}%>
        </ul>
    </div>

  </div>
    </cache:cache>