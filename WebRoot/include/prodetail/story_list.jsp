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
      <div class="l" id="showorder"> <strong>����</strong> <a href="javascript:;" onclick="javascript:sosuo('','','','',1,'');" class="select">Ĭ��</a> <a href="javascript:;" onclick="javascript:sosuo('','','','',0,'');">�ȶ�</a> </div>
      <div class="r"> <span><b> </b>&nbsp;&nbsp;��</span><b>14056</b><span>��&nbsp;|</span> 
        <a href="javascript:;" class="pre noPre" title="��һҳ">&nbsp;</a><b>1/1406</b><a href="?offset=10" class="next">&nbsp;</a> </div>
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
                <div class="gs_list_rq">������<%=CommonString.getFormatPara(m.get("view_count")) %>�� | ���ۣ�<%=CommonString.getFormatPara(m.get("reply_count")) %>��</div>
                <div class="gs_list_more"><a target="_blank" href="/case/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm">�Ķ�ȫ��</a></div>
       </li>
              


	   <%
				}
			}else{
		%>
		  ������Ϣ
		<%}%>
        </ul>
    </div>

  </div>
    </cache:cache>