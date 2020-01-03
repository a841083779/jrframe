<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
String usern = CommonString.getFormatPara(request.getParameter("usern"));
DBHelper dbHelper = DBHelper.getInstance();
Connection connection = null;
try{
	connection = dbHelper.getConnection();
	Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
	if(map == null){
		Common.do302(response,"/agent");
		return;
	}
	Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
			map.get("id")
		},connection);
	String agentId = CommonString.getFormatPara(map.get("id")) ;  // 代理商 id 
	List personalList = dbHelper.getMapList("select * from pro_agent_personnel where agent_id=?",new Object[]{agentId}) ;
%>
<div class="sTop02">
  <div class="contain980 h37px">
  <%
  	if(newsCount>0){
  		%><ul class="shopNav" style="width: 930px;"><%
  	}else{
  		%><ul class="shopNav"  style="width: 930px;"><%
  	}
  %>
      <li><a href="/" >代理商首页</a></li>
      <li><a href="/introduce.htm">公司简介</a></li>
      <li><a href="/agent_products.htm">代理机型</a></li>
                        <%
      	if(newsCount>0){
      		%><li><a href="/agent_news.htm">企业动态</a></li><%
      	}
      %>
      <%
       if(null!=personalList && personalList.size()>0){
    	   %>
         <li><a href="/domainshop/<%=usern%>/agent_employee.htm">企业员工</a></li>
    	   <%
       }
      %>
      <li><a href="/agent_message.htm">在线询价</a></li>
      <li><a href="/contactus.htm">联系我们</a></li>
    </ul>
    <!--<h3 class="Slogan">三一区域认证代理商，采购更放心！</h3>-->
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".sTop01 ").offset().top},1); 
</script>
<%
}catch(Exception e){
	e.printStackTrace() ;
}finally{
	dbHelper.freeConnection(connection);
}
%>