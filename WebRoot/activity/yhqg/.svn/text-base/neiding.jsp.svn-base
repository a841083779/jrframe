<%@ page language="java" import="java.net.*,java.util.*,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	if("ok".equals(flag)){
		DBHelper dbHelper = DBHelper.getInstance();
		Connection connection = null;
		try{
			connection = dbHelper.getConnection();
			connection.setAutoCommit(false);
			//380二等奖
			String sql = "";
			//插入中奖信息
			sql = " insert into activities_record ( phone , type_id , items , code , rs , winning_items , add_ip , add_date ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					"18678603722",1,"DX380LC","65748",1,"DX380LC_2",Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
			},connection);
			//修改中奖结果
			sql = " update activities_winning set use_counts = 1 where id = 3 ";
			dbHelper.execute(sql,connection);
			//发送短信
			String smsText = "恭喜您获得本活动的二等奖，优惠码"+"65748"+"，价值四千小时的保养配件，请在72小时内至当地代理商处兑换0535-6792733";
			Map param = new HashMap();
			param.put("phone","18678603722");
			param.put("content",URLEncoder.encode(smsText,"utf-8"));
			param.put("source","195002");
			Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
			//发送短信
			
			//345一等奖
			sql = " insert into activities_reg ( uuid , phone , name , reg_date , password , type_id , reg_ip ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					CommonString.getUUID(),"13864503729","田靖航",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),"123456",1,Common.getIp(request)
			},connection);
			//插入中奖信息
			sql = " insert into activities_record ( phone , type_id , items , code , rs , winning_items , add_ip , add_date ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					"13864503729",1,"DX345LC","3827",1,"DX345LC_1",Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
			},connection);
			//修改中奖结果
			sql = " update activities_winning set use_counts = 1 where id = 7 ";
			dbHelper.execute(sql,connection);
			//发送短信
			smsText = "恭喜您获得本活动的一等奖，优惠码为"+"3827"+"，您可以八五折购买DX345LC，请在72小时内至当地代理商处兑换0535-6792733";
			param = new HashMap();
			param.put("phone","13864503729");
			param.put("content",URLEncoder.encode(smsText,"utf-8"));
			param.put("source","195002");
			//Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
			//发送短信
			
			//380一等奖
			sql = " insert into activities_reg ( uuid , phone , name , reg_date , password , type_id , reg_ip ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					CommonString.getUUID(),"13287152222","张良",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),"123456",1,Common.getIp(request)
			},connection);
			//插入中奖信息
			sql = " insert into activities_record ( phone , type_id , items , code , rs , winning_items , add_ip , add_date ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					"13287152222",1,"DX380LC","85745",1,"DX380LC_1",Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
			},connection);
			//修改中奖结果
			sql = " update activities_winning set use_counts = 1 where id = 8 ";
			dbHelper.execute(sql,connection);
			//发送短信
			smsText = "恭喜您获得本活动一等奖，优惠码"+"85745"+"，3年六千小时超长保修及一万五千元优惠券，请在72小时内至当地代理商处兑换0535-6792733";
			param = new HashMap();
			param.put("phone","13287152222");
			param.put("content",URLEncoder.encode(smsText,"utf-8"));
			param.put("source","195002");
			//Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
			//发送短信
			
			//其它一等奖
			sql = " insert into activities_reg ( uuid , phone , name , reg_date , password , type_id , reg_ip ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					CommonString.getUUID(),"13706422180","王勇",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),"123456",1,Common.getIp(request)
			},connection);
			//插入中奖信息
			sql = " insert into activities_record ( phone , type_id , items , code , rs , winning_items , add_ip , add_date ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
			dbHelper.execute(sql,new Object [] {
					"13706422180",1,"other1","48392",1,"other1_1",Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
			},connection);
			//修改中奖结果
			sql = " update activities_winning set use_counts = 1 where id = 9 ";
			dbHelper.execute(sql,connection);
			//发送短信
			smsText = "恭喜您获得本活动的一等奖，优惠码"+"48392"+"，价值五千小时的保养配件，请在72小时内至当地代理商处兑换0535-6792733";
			param = new HashMap();
			param.put("phone","13706422180");
			param.put("content",URLEncoder.encode(smsText,"utf-8"));
			param.put("source","195002");
			//Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
			//发送短信
			
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			e.printStackTrace();
		}finally{
			DBHelper.freeConnection(connection);
		}	
	}
%>