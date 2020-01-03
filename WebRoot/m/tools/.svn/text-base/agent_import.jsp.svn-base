<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String agent_id = CommonString.getFormatPara(request.getParameter("agent_id"));
	String factoryid = "134";
	String sql = " select id from pro_products where is_show=1 and catalognum like '%"+catalognum+"%' ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});

	if(list != null && list.size() > 0){
	for(int i = 0;i < list.size(); i++){
	String insert_sql="insert into pro_agent_products(agent_id,product_id,factoryid,add_user_temp) values("+agent_id+","+CommonString.getFormatPara(list.get(i).get("id"))+","+factoryid+",'zengfc')";
	dbHelper.execute(insert_sql);
	}
	}
	out.println("ok");
%>
