<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,org.json.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
    String log="";
    try{
		String thisTime = CommonDate.hourAdd("-1","yyyy-MM-dd HH:mm:ss");
	    String yesTime = CommonDate.dateAdd("-1","yyyy-MM-dd HH:mm:ss");
		connection = dbHelper.getConnection();
	    //List <Map> proList =  dbHelper.getMapList(" select *  from pro_product_form where province='云南' and add_date > '"+yesTime+"' and add_date < '"+thisTime+"'  and factoryid!=136 and catanum in('101001001','101002007','101002008','101002009','101003001','101005002','102006','102007','102008','103002','103019','103020','104001','104005','106001002','107011','107012') " );   
	    List <Map> proList =  dbHelper.getMapList(" select *  from pro_product_form where id in (569175,569231,569249,569267,569279,569312,569561,569652,569683,569770,569803,570044,570128,570178,570182,570238,570239,570283,570329,570366,570384) " );   
		if(proList!=null&&proList.size()>0){ 
		for(Map m : proList){   
	        String catanum=CommonString.getFormatPara(m.get("catanum"));
			Map proMap = dbHelper.getMap(" select top 1  * from pro_products   where is_show=1 and  catalognum = '"+catanum+"' and factoryid=136 order 	by newid()");
			//Map proMap = dbHelper.getMap(" select top 1  * from pro_products   where  id=7652");
			if(proMap!=null){
	       	String sqlString = "insert into pro_agent_products_form(";
			sqlString += "add_user,add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			sqlString += ") select 'ynbt',add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+136+",'柳工',12626,agentname,catanum,'"+CommonString.getFormatPara(proMap.get("catalogname"))+"',"+CommonString.getFormatPara(proMap.get("id"))+",'"+CommonString.getFormatPara(proMap.get("name"))+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','我对这个机器感兴趣请联系我！',company,name,"+1+",id,call_result1,buy_type,'102001',355";
			sqlString += " from pro_product_form WHERE uuid = '"+CommonString.getFormatPara(m.get("uuid"))+"'";
			dbHelper.execute(sqlString,connection);	
			}
	    }	
		}
    out.println(log);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>