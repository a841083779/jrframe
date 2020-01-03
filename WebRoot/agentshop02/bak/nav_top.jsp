<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
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
      <li><a href="/agentshop02/<%=usern%>/" <%if("0".equals(flag)){out.println("class='selected'");} %>><span>代理商首页</span></a></li>
      <li><a href="/agentshop02/<%=usern%>/introduce.htm" <%if("1".equals(flag)){out.println("class='selected'");} %>><span>公司简介</span></a></li>
      <li><a href="/agentshop02/<%=usern%>/agent_products.htm" <%if("2".equals(flag)){out.println("class='selected'");} %>><span>代理机型</span></a></li>
                        <%
      	if(newsCount>0){
      		%><li><a href="/agentshop02/<%=usern%>/agent_news.htm" <%if("3".equals(flag)){out.println("class='selected'");} %>><span>企业动态</span></a></li><%
      	}
      %>
      <%
       if(null!=personalList && personalList.size()>0){
    	   %>
         <li><a href="/agentshop02/<%=usern%>/agent_employee.htm" <%if("4".equals(flag)){out.println("class='selected'");} %>><span>企业员工</span></a></li>
    	   <%
       }
      %>
      <li><a href="/agentshop02/<%=usern%>/agent_message.htm" <%if("5".equals(flag)){out.println("class='selected'");} %>><span>在线询价</span></a></li>
      <li><a href="/agentshop02/<%=usern%>/contactus.htm" <%if("6".equals(flag)){out.println("class='selected'");} %>><span>联系我们</span></a></li>
    </ul>
    <!--<h3 class="Slogan">三一区域认证代理商，采购更放心！</h3>-->
  </div>
</div>
<%
}catch(Exception e){
	e.printStackTrace() ;
}finally{
	dbHelper.freeConnection(connection);
}
%>