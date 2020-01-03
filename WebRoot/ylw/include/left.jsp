<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,jereh.system.*,java.text.*,jereh.database.*,jereh.user.*" errorPage=""%>
<%@ include file="../sysconfig/config.jsp"%>
<%
ConnManager pool = (ConnManager)application.getAttribute("poolAPP");
	if(pool==null){
		pool = new ConnManager();
	}
	Connection conn = pool.getConnection();
	String sortNo=request.getParameter("sortNo"); 
	if(sortNo==null){
		sortNo="";
	}
	String sql="";
	ResultSet rs ;
	try{
%>
<table border="0" cellpadding="0" cellspacing="0" width="220">
      <tr>
        <td class="ziti01" background="../images/img01.gif" width="215" height="31" style=" padding-left:20px;"><a class="n2" href="../products/">产品分类</a></td>
      </tr>
    </table>
  <table width="220" cellspacing="0" cellpadding="0" class="leftm" >
<% sql="select id,sort_no,sort_name from web_category where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products01'  and is_show=1  order by order_no";
	rs=DataManager.executeQuery(conn,sql);
	while(rs!=null&&rs.next()){
	String sno=rs.getString("sort_no");
	if(sno!=null&&sno.equals(sortNo)){
%>
    <tr>
      <td><a href="../products/?sortNo=<%=rs.getString("sort_no")%>" class="current"><%=rs.getString("sort_name")%></a> </td>
    </tr>
    <%}else{%>
     <tr>
      <td><a href="../products/?sortNo=<%=rs.getString("sort_no")%>"><%=rs.getString("sort_name")%></a> </td>
    </tr>
    <%}} %>
    </table>
    <%
      sql="select visualize_pic_small,pic_small_link from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='index00'";
	  rs=DataManager.executeQuery(conn,sql); 
	  while(rs!=null&&rs.next()){
	  	String visualize_pic_small=rs.getString("visualize_pic_small");
	  	String pic_small_link=rs.getString("pic_small_link");
	  	if(visualize_pic_small!=null&&!visualize_pic_small.equals("")){
	  %>
      <table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:15px; margin-top:15px; margin-left:26px">
        <tr>
          <td><%if(pic_small_link!=null&&!pic_small_link.equals("")){ %><a href="order/"><%} %>
          </a><a href="../order/">
          <img border="0" src="<%=visualize_pic_small %>" width="215" height="71"/></a><a href="order/">
          <%if(pic_small_link!=null&&!pic_small_link.equals("")){ %></a><%} %></td>
        </tr>
      </table>
     <%}} %>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{pool.freeConnection(conn);}	
%>