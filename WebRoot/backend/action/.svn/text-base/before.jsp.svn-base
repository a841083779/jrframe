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
					//查询数据
					id = (Integer)dbHelper.getOne(" select id from pro_product_form where uuid =  "+idsArr[i],connection);
					//gaopeng add at 20131204-begin
					//把订单插入订单回收站表
					String sqlString = "insert into pro_product_form_del(";
					sqlString += "source_id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first";
					sqlString += ") select id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first";
					sqlString += " from pro_product_form WHERE uuid = "+idsArr[i];
					Integer rs = dbHelper.execute(sqlString, connection);
					//gaopeng add at 20131204-end
					
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