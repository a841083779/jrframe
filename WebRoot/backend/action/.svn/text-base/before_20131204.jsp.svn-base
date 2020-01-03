<%@ page language="java" import="java.util.*,java.io.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%><%
	String event = CommonString.getFormatPara(request.getParameter("eventBefore"));
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map model = null;
	List list = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		if(eventList.contains("deleteAgentForm")){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			if (null != ids && ids.length() > 0) {// 删除
				String [] idsArr = ids.split(",");
				Integer id = 0;
				for(int i=0;i<idsArr.length;i++){
					id = (Integer)dbHelper.getOne(" select id from pro_product_form where uuid =  "+idsArr[i],connection);
					dbHelper.execute(" delete from pro_agent_products_form where source_id = ? and source_id is not null and source_id <> '' and source_id <> 0 ",new Object [] {
						id
					},connection);
				}
			}
		}
		connection.commit();
	}catch(Exception e){
	connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}%>