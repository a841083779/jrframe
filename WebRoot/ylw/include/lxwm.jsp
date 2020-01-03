<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,jereh.system.*,java.text.*,jereh.database.*,jereh.user.*" errorPage=""%>
<%@ include file="../sysconfig/config.jsp"%>
<%
ConnManager pool = (ConnManager)application.getAttribute("poolAPP");
	if(pool==null){
		pool = new ConnManager();
	}
	Connection conn = pool.getConnection();
	String sql="";
	ResultSet rs ;
	String logo="";
	try{
		sql="select catalog_name,summary from web_infomation where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='contactus00'";
		rs=DataManager.executeQuery(conn,sql);
		while(rs!=null&&rs.next()){
%>
<table border="0" cellpadding="0" cellspacing="0" width="220" height="200" style="margin:10px 0;">
	<tr>
	  <td class="ziti01" background="../images/img01.gif" height="26" width="215" style=" padding-left:10px;">
	  <a class="n2" href="../contact/"><%=rs.getString("catalog_name")%></a>
	  </td>
	</tr>
	<tr>
	  <td background="../images/lxwmbj.gif" width="215" height="171" valign="top" style="padding-top:15px; padding-left:10px" class="n5">
		<%=rs.getString("summary")%></td>
	</tr>
</table>
<%	}
	}catch(Exception e){
		e.printStackTrace();
	}
	finally{pool.freeConnection(conn);}	
%>