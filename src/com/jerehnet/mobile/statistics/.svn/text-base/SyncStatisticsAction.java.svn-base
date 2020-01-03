package com.jerehnet.mobile.statistics;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.jerehnet.mobile.sync.BaseSyncActon;
import com.jerehnet.mobile.utils.BusinessDate;
import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;

/*******************************************************************************
 * 订单宝数据统计功能-区域订单占比、订单总量、业务员处理
 * 
 * @author sunyb
 * @date 2014-10-20
 * 
 */
public class SyncStatisticsAction extends BaseSyncActon{
	
	/**
	 * 获得区域订单占比
	 * @param flag
	 * @param method
	 * @param jsonStr
	 * @return
	 */
	public String getAreaOrderPer(String flag, String method, String jsonStr){

		Connection connection = null;
		DBHelper dbHelper = DBHelper.getInstance();
		JSONObject jsonObject = new JSONObject();
		try {
			/**
			 * 数据处理过程
			 */
			connection = dbHelper.getConnection();
			org.json.JSONObject objone = new org.json.JSONObject(jsonStr);

			String distcode = CommonString.getFormatPara(objone.getString("distcode"));
			String catanum = CommonString.getFormatPara(objone.getString("catanum"));
			String buytime = CommonString.getFormatPara(objone.getString("buytime"));
			
			String jsonString = "";
  
			if (flag.equals("statistics")) {
				//区域统计饼状图
				if (method.equals("area_order")) {
					List<Map<String, Object>> sum_list = null;
					
					String sql="";
					String sum_sql="";
					/*String sum_sql="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
						+	" contact_address like '"+ distcode +"%' and cata_num like '%"+ catanum +"%' and buy_time like '%"+ buytime +"%' ";
					sum_list = dbHelper.getMapList(sum_sql);
					
					String sql = "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
						+	" contact_address like '"+ distcode +"%' and cata_num like '%"+ catanum +"%' and buy_time like '%"+ buytime +"%' " 
						+	"group by factory_name order by count(factory_name) desc";*/
					
					if(buytime.equals("year")){
						   /*sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) as month_no,count(*) as num " 
						+	"from pro_agent_products_form where agent_id="+ agentid +"  and cata_num like '"+ catanum +"%' and " 
						+	"contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' "
						+	"group by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) " 
						+	"order by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)";*/
						
						sum_sql+="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
							+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' ";
						sum_list = dbHelper.getMapList(sum_sql);
						
						 sql += "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
							+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' " 
							+	"group by factory_name order by count(factory_name) desc";
						
						
					}else if(buytime.equals("halfyear")){
						/*if(Integer.parseInt(CommonDate.getToday("MM"))>6){
						   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) as month_no,count(*) as num from pro_agent_products_form where agent_id="+ agentid +"  and cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)>6 group by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)";
						}else{
						   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) as month_no,count(*)  as num  from pro_agent_products_form where agent_id="+ agentid +"  and cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)<7 group by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)";					
						}*/
						if(Integer.parseInt(CommonDate.getToday("MM"))>6){
							sum_sql+="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
								+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)>6  ";
							sum_list = dbHelper.getMapList(sum_sql);
							
							 sql += "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
								+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%'   and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)>6  " 
								+	"group by factory_name order by count(factory_name) desc";
						}else{
							sum_sql+="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
								+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)<7  ";
							sum_list = dbHelper.getMapList(sum_sql);
							
							 sql += "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
								+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)<7  " 
								+	"group by factory_name order by count(factory_name) desc";
							
						}
						
					}else if(buytime.equals("week")){
						//   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) as day_no,count(*) as num from pro_agent_products_form where  substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)>"+ BusinessDate.dateToWeek().get(0).substring(8, 10) +" and substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)< "+ BusinessDate.dateToWeek().get(8).substring(8, 10) +" and  agent_id="+ agentid +"  and cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)='"+ CommonDate.getToday("MM") +"' group by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)";				
						sum_sql+="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)>"+ BusinessDate.dateToWeek().get(0).substring(8, 10) +" and substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)< "+ BusinessDate.dateToWeek().get(8).substring(8, 10) +"" 
							+	" and  contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' ";
						sum_list = dbHelper.getMapList(sum_sql);
						
						 sql += "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
							+	" substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)>"+ BusinessDate.dateToWeek().get(0).substring(8, 10) +" and substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)< "+ BusinessDate.dateToWeek().get(8).substring(8, 10) +"  and contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' " 
							+	"group by factory_name order by count(factory_name) desc";
					}else if(buytime.equals("month")){
						//   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) as day_no,count(*) as num from pro_agent_products_form where agent_id="+ agentid +"  and cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)='"+ CommonDate.getToday("MM") +"' group by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)";
						sum_sql+="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)='"+ CommonDate.getToday("MM") +"' and " 
							+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' ";
						sum_list = dbHelper.getMapList(sum_sql);
						
						 sql += "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
							+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)='"+ CommonDate.getToday("MM") +"'  " 
							+	"group by factory_name order by count(factory_name) desc";
					}else{
						//   sql+="select  CONVERT(varchar(4) ,add_date, 111 ) as year_no,count(*)  as num  from pro_agent_products_form where agent_id="+ agentid +"  and cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' group by CONVERT(varchar(4) ,add_date, 111 ) order by CONVERT(varchar(4) ,add_date, 111 )";
						sum_sql+="select  count(*) as sum_count from pro_agent_products_form where factory_name is not null and factory_id is not null and " 
							+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' ";
						sum_list = dbHelper.getMapList(sum_sql);
						
						 sql += "select top 10  factory_name,substring((cast(cast((count(factory_name)) as float)/"+ sum_list.get(0).get("sum_count") +"*100 as varchar(10))),1,4)+'%' as percentage  from pro_agent_products_form where factory_name is not null and factory_id is not null and" 
							+	" contact_address like '%"+ distcode +"%' and cata_num like '%"+ catanum +"%' " 
							+	"group by factory_name order by count(factory_name) desc";
					}
					
					System.out.println("zengtest01:"+sum_sql);
					System.out.println("zengtest02:"+sql);

					//System.out.println("sql:" + sql);

					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					if (list.size() > 0) {
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						
						newlist = dbHelper.getMapList(sql);
						json.addAll(getFormatList(newlist));
						jsonString = json.toString();
						jsonObject.put("resultObject", jsonString);
						jsonObject.put("totalCount", newlist.size());

					} else {
						jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");

					}
				} else {
					jsonObject.put("resultCode", "0002");
					jsonObject.put("resultMessage", "失败");
					jsonObject.put("resultObject", "");

				}
			}

			/**
			 * 传出结果拼接字符串:resultCode,resultMessage,resultObject
			 */

			System.out.println("测试返回字符串:" + jsonObject.toString());

		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("resultCode", "0002");
			jsonObject.put("resultMessage", "失败");
			jsonObject.put("resultObject", "");
		} finally {
			DBHelper.freeConnection(connection);
		}

		return jsonObject.toString();
	}
	/**
	 * 获得订单总量
	 * @param flag
	 * @param method
	 * @param jsonStr
	 * @return
	 */
	//线形图，订单总量
	public String getOrderSum(String flag, String method, String jsonStr){

		Connection connection = null;
		DBHelper dbHelper = DBHelper.getInstance();

		JSONObject jsonObject = new JSONObject();

		
		
		try {
			/**
			 * 数据处理过程
			 */
			connection = dbHelper.getConnection();
			org.json.JSONObject objone = new org.json.JSONObject(jsonStr);
			
			
			String distcode = CommonString.getFormatPara(objone.getString("distcode"));
			String catanum = CommonString.getFormatPara(objone.getString("catanum"));
			String buytime = CommonString.getFormatPara(objone.getString("buytime"));
			String agentid = CommonString.getFormatPara(objone.getString("agentid"));
			
			String sql = "";
			//System.out.println("buytime:"+buytime);
			//此处判断是厂商还是代理商 		
			String flag_factory_agent_sql="select flag from pro_agent_factory where id="+agentid; 
			List<Map<String, Object>>  flag_factory_agent_list= dbHelper.getMapList(flag_factory_agent_sql);
			String flag_factory_agent=CommonString.getFormatPara(flag_factory_agent_list.get(0).get("flag"));   //flag: 1  厂商 2 代理商 
			String whereStr="";
			if(flag_factory_agent.equals("1")){
				whereStr+=" factory_id="+agentid+" and ";
			}else if(flag_factory_agent.equals("2")){
				whereStr+=" agent_id="+agentid+" and ";
			}else{
				whereStr+=" ";
			}
			
			if(buytime.equals("year")){
				   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) as month_no,count(*) as num " 
				+	"from pro_agent_products_form where "+ whereStr +" cata_num like '"+ catanum +"%' and " 
				+	"contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' "
				+	"group by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) " 
				+	"order by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)";
			}else if(buytime.equals("halfyear")){
				if(Integer.parseInt(CommonDate.getToday("MM"))>6){
				   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) as month_no,count(*) as num from pro_agent_products_form where  "+ whereStr +"  cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)>6 group by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)";
				}else{
				   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) as month_no,count(*)  as num  from pro_agent_products_form where  "+ whereStr +"  cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)<7 group by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)";					
				}
			}else if(buytime.equals("week")){
				   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) as month_no,count(*) as num from pro_agent_products_form where "+ whereStr +" substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)>"+ BusinessDate.dateToWeek().get(0).substring(8, 10) +" and substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)< "+ BusinessDate.dateToWeek().get(8).substring(8, 10) +" and cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)='"+ CommonDate.getToday("MM") +"' group by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)";				
			}else if(buytime.equals("month")){
				   sql+="select  substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) as month_no,count(*) as num from pro_agent_products_form where  "+ whereStr +"  cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' and CONVERT(varchar(4) ,add_date, 111 )='"+ CommonDate.getToday("yyyy") +"' and substring(CONVERT(varchar(12) ,add_date, 111 ),6,2)='"+ CommonDate.getToday("MM") +"' group by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2) order by substring(CONVERT(varchar(12) ,add_date, 111 ),9,2)";
			}else{
				   sql+="select  CONVERT(varchar(4) ,add_date, 111 ) as year_no,count(*)  as num  from pro_agent_products_form where  "+ whereStr +"  cata_num like '"+ catanum +"%' and contact_address like '%"+ distcode +"%' group by CONVERT(varchar(4) ,add_date, 111 ) order by CONVERT(varchar(4) ,add_date, 111 )";
			}
			
			String jsonString = "";
			System.out.println("sql:" + sql);
			if (flag.equals("statistics")) {
				if (method.equals("order_sum")) {
					

					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					if (list.size() > 0) {
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						
						newlist = dbHelper.getMapList(sql);
						json.addAll(getFormatList(newlist));
						jsonString = json.toString();
						jsonObject.put("resultObject", jsonString);
						jsonObject.put("totalCount", newlist.size());

					} else {
						jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");

					}
				} else {
					jsonObject.put("resultCode", "0002");
					jsonObject.put("resultMessage", "失败");
					jsonObject.put("resultObject", "");

				}
			}

			/**
			 * 传出结果拼接字符串:resultCode,resultMessage,resultObject
			 */

			System.out.println("测试返回字符串:" + jsonObject.toString());

		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("resultCode", "0002");
			jsonObject.put("resultMessage", "失败");
			jsonObject.put("resultObject", "");
		} finally {
			DBHelper.freeConnection(connection);
		}

		return jsonObject.toString();
	}
	/**
	 * 业务员处理统计
	 * @param flag
	 * @param method
	 * @param jsonStr
	 * @return
	 */
	public String getPersonOrderNum(String flag, String method, String jsonStr){

		Connection connection = null;
		DBHelper dbHelper = DBHelper.getInstance();

		JSONObject jsonObject = new JSONObject();
		try {
			/**
			 * 数据处理过程
			 */
			connection = dbHelper.getConnection();
			org.json.JSONObject objone = new org.json.JSONObject(jsonStr);
            
			
			
			
						
			String jsonString = "";

			//String whereStr="";
			
		    
			if (flag.equals("statistics")) {			
				if (method.equals("person_order")) {//代理商登陆统计人员
					String agentid = CommonString.getFormatPara(objone.getString("agentid"));
					System.out.println("*******代理商登陆统计人员*******");
					//String sql = "select id,name,phone from pro_agent_personnel where agent_id="+agentid;
					String sql="";
					String totalsql="";
					if(jsonStr.indexOf("condition")<0){
						if(jsonStr.indexOf("page_index")<0||jsonStr.indexOf("page_index")<0){
					    	sql+="select id,name,phone,agent_id as agentId from pro_agent_personnel where agent_id="+agentid+" order by id desc";             
					    }else{
					    	//分页
							int page_index = objone.getInt("page_index"); 
						    int page_size = objone.getInt("page_size"); 
					    	sql+= "select top  "+ page_size +" id,name,phone,agent_id as agentId from pro_agent_personnel where id not in(select TOP "+ page_size*(page_index-1) +" id from pro_agent_personnel where agent_id="+ agentid+" order by id desc ) and agent_id="+agentid+" order by id desc";	                    	
					    }
						
						totalsql += "select id,name,phone,agent_id as agentId from pro_agent_personnel where  agent_id="+agentid+" order by id desc ";
						
					}else{					
						   //int pid = objone.getInt("pid");
						   String whereStr=""; 
				 		   String condition = objone.getString("condition");
				 		   if(condition.matches("[0-9]+")){
				 		   		whereStr+=" and  phone like '%"+ condition +"%'";
				 		   }else{
				 		   		whereStr+=" and name like '%"+ condition +"%'";		 		    		
				 		   }
						
						   sql+="select id,name,phone,agent_id as agentId from pro_agent_personnel where agent_id="+agentid+" and 1=1  "+whereStr;             
						   totalsql += "select id,name,phone,agent_id as agentId from pro_agent_personnel where agent_id="+agentid+" and 1=1 "+whereStr;							
					}
					
					
					
					//计数
		    		 List<Map<String,Object>> totallist = null ;  		 
		    		 totallist = dbHelper.getMapList(totalsql) ;

					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	
					if (list.size() > 0) {
						
						for(int i=0;i<list.size();i++){
					    	  list.get(i).put("agentId", agentid);

		            		   String order_state_sql="select order_state as flag,count(order_state) num from pro_agent_products_form where order_state not in(102002,102003,102004,102005,102006,102007) and person_id="+ list.get(i).get("id") +" group by order_state";	
						       
		            		   String order_102002_sql="select 102002 as flag,count(*) num from  pro_agent_products_form where person_id="+ list.get(i).get("id") +" and order_state  in(102002,102003,102004,102005,102006,102007)";		            		   
		            		   
		            		   List<Map<String,Object>> order_state_list = null ;
						       order_state_list = dbHelper.getMapList(order_state_sql);	
						       
						       /*
						       List<Map<String,Object>> order_102002_list = null ;
					    	   order_102002_list = dbHelper.getMapList(order_102002_sql);
					    	   if(Integer.parseInt(CommonString.getFormatPara(order_102002_list.get(0).get("num")))>0){
					    		   Map<String,Object> newMap=new HashMap<String,Object>();
						    	   newMap.put("num",order_102002_list.get(0).get("num"));
						    	   newMap.put("flag", "102002");
						    	   order_state_list.add(newMap);   
					    	   }*/
		            		   //list.get(i).put("order_state_list", order_state_list);
						     Map order_state_map =new HashMap();
						     for(int k=0;k<order_state_list.size();k++){
						    	 order_state_map.put(order_state_list.get(k).get("flag"), order_state_list.get(k).get("num"));
						     }
						      
						       
						       
					    	 //未处理
					    	   if(!CommonString.getFormatPara(order_state_map.get("102001")).equals("")){  
					    		   list.get(i).put("untreated", CommonString.getFormatPara(order_state_map.get("102001"))); 
					    	   }else{
					    		   list.get(i).put("untreated", 0); 
					    	   }
					    	   List<Map<String,Object>> order_102002_list = null ;
					    	   order_102002_list = dbHelper.getMapList(order_102002_sql);
					    	   //跟踪中 
					    	   if(Integer.parseInt(CommonString.getFormatPara(order_102002_list.get(0).get("num")))>0){  
					    		   list.get(i).put("tracking", order_102002_list.get(0).get("num")); 
					    	   }else{
					    		   list.get(i).put("tracking", 0); 
					    	   }  
					    	 //成交
					    	   if(!CommonString.getFormatPara(order_state_map.get("102008")).equals("")){  
					    		   list.get(i).put("strike", CommonString.getFormatPara(order_state_map.get("102008"))); 
					    	   }else{
					    		   list.get(i).put("strike", 0); 
					    	   } 
					    	 //流失
					    	   if(!CommonString.getFormatPara(order_state_map.get("102009")).equals("")){  
					    		    
					    		   list.get(i).put("runOff", CommonString.getFormatPara(order_state_map.get("102009"))); 
					    	   }else{
					    		   list.get(i).put("runOff", 0);
					    	   }
						       
						       //orderlist.add(list.get(i));
			            }
						
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						System.out.println("sql:" + sql);
						newlist = dbHelper.getMapList(sql);
						json.addAll(getFormatList(list));
						jsonString = json.toString();
						jsonObject.put("resultObject", jsonString);
						jsonObject.put("totalCount", newlist.size());

					} else {
						jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");

					}
					
				}else if(method.equals("agent_order")){//厂商登陆统计代理商
					System.out.println("*******厂商登陆统计代理商1111*******");
						
					String factoryid = CommonString.getFormatPara(objone.getString("factoryid"));
					String sql="";
					String totalsql="";
					if(jsonStr.indexOf("condition")<0){
						if(jsonStr.indexOf("page_index")<0||jsonStr.indexOf("page_index")<0){
					    	//sql+="select id,name,phone,agent_id as agentId from pro_agent_personnel where agent_id="+agentid+" order by id desc";
							sql+="select name,telphone as phone,id from pro_agent_factory  where is_cooperate=1 and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc";         
					    }else{
					    	//分页
							int page_index = objone.getInt("page_index"); 
						    int page_size = objone.getInt("page_size"); 
					    	//sql+= "select top  "+ page_size +" id,name,phone,agent_id as agentId from pro_agent_personnel where id not in(select TOP "+ page_size*(page_index-1) +" id from pro_agent_personnel where agent_id="+ agentid+" order by id desc ) and agent_id="+agentid+" order by id desc";	                    	
							sql+= "select top "+ page_size +" id,name,telphone as phone from pro_agent_factory  where is_cooperate=1 and id not in(select TOP "+ page_size*(page_index-1) +" id from pro_agent_factory where is_cooperate=1 and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc ) and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc";	                    							   
					    }
						
						totalsql += "select name,telphone as phone,id from pro_agent_factory  where is_cooperate=1 and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc";
						
					}else{					
						   //int agentid = objone.getInt("agentid");
						   String whereStr=""; 
				 		   String condition = objone.getString("condition");
				 		   if(condition.matches("[0-9]+")){
				 		   		whereStr+=" and  telphone like '%"+ condition +"%'";
				 		   }else{
				 		   		whereStr+=" and name like '%"+ condition +"%'";		 		    		
				 		   }
						   sql+="select name,telphone as phone,id from  pro_agent_factory where is_cooperate=1 and 1=1 and agent_fac like '%"+ factoryid +"%' "+whereStr;             
						   totalsql += "select name,telphone as phone,id from pro_agent_factory where is_cooperate=1 and 1=1 and agent_fac like '%"+ factoryid +"%'"+ whereStr;
							
					}
					System.out.println("---zengtest:"+sql);
					//计数
		    		List<Map<String,Object>> totallist = null ;  		 
		    		totallist = dbHelper.getMapList(totalsql) ;

					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	
					if (list.size() > 0) {
						
						for(int i=0;i<list.size();i++){
					    	 list.get(i).put("agentId", factoryid);
		                     String order_state_sql="select order_state as flag,count(order_state) num from pro_agent_products_form where person_id is not null and person_id !='' and  order_state not in(102002,102003,102004,102005,102006,102007) and agent_id="+ list.get(i).get("id") +" group by order_state";	
						       
		            		 String order_102002_sql="select 102002 as flag,count(*) num from  pro_agent_products_form where person_id is not null and person_id !='' and  agent_id="+ list.get(i).get("id") +" and order_state  in(102002,102003,102004,102005,102006,102007)";		            		   
		            		   
		            		 List<Map<String,Object>> order_state_list = null ;
						     order_state_list = dbHelper.getMapList(order_state_sql);	
						       
						     Map order_state_map =new HashMap();
						     for(int k=0;k<order_state_list.size();k++){
						    	 order_state_map.put(order_state_list.get(k).get("flag"), order_state_list.get(k).get("num"));
						     }       
					    	 //未处理
					    	   if(!CommonString.getFormatPara(order_state_map.get("102001")).equals("")){  
					    		   list.get(i).put("untreated", CommonString.getFormatPara(order_state_map.get("102001"))); 
					    	   }else{
					    		   list.get(i).put("untreated", 0); 
					    		   
					    	   }
					    	   List<Map<String,Object>> order_102002_list = null ;
					    	   order_102002_list = dbHelper.getMapList(order_102002_sql);
					    	   //跟踪中 
					    	   if(Integer.parseInt(CommonString.getFormatPara(order_102002_list.get(0).get("num")))>0){  
					    		   list.get(i).put("tracking", order_102002_list.get(0).get("num")); 
					    	   }else{
					    		   list.get(i).put("tracking", 0);
					    		   
					    	   }  
					    	 //成交
					    	   if(!CommonString.getFormatPara(order_state_map.get("102008")).equals("")){  
					    		   list.get(i).put("strike", CommonString.getFormatPara(order_state_map.get("102008"))); 
					    	   }else{
					    		   list.get(i).put("strike", 0);
					    	   }  
					    	 //流失
					    	   if(!CommonString.getFormatPara(order_state_map.get("102009")).equals("")){  
					    		    
					    		   list.get(i).put("runOff", CommonString.getFormatPara(order_state_map.get("102009"))); 
					    	   }else{
					    		   list.get(i).put("runOff", 0);
					    	   }
					
			            }
						
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						System.out.println("sql:" + sql);
						newlist = dbHelper.getMapList(sql);
						json.addAll(getFormatList(list));
						jsonString = json.toString();
						jsonObject.put("resultObject", jsonString);
						jsonObject.put("totalCount", newlist.size());

					} else {
						jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");

					}
				}else if(method.equals("agent_list")){
					//厂商登陆统计代理商
					System.out.println("*******厂商登陆统计代理商*******");
					//2014.11.17 	
					String factoryid = CommonString.getFormatPara(objone.getString("factoryid"));
					String sql="";
					String totalsql="";
					if(jsonStr.indexOf("condition")<0){
						if(jsonStr.indexOf("page_index")<0||jsonStr.indexOf("page_index")<0){
					    	//sql+="select id,name,phone,agent_id as agentId from pro_agent_personnel where agent_id="+agentid+" order by id desc";
							sql+="select name  username ,name,concatus nickname,telphone as tel,id,city as areaName from pro_agent_factory  where is_cooperate=1 and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc";         
					    }else{
					    	//分页
							int page_index = objone.getInt("page_index"); 
						    int page_size = objone.getInt("page_size"); 
					    	//sql+= "select top  "+ page_size +" id,name,phone,agent_id as agentId from pro_agent_personnel where id not in(select TOP "+ page_size*(page_index-1) +" id from pro_agent_personnel where agent_id="+ agentid+" order by id desc ) and agent_id="+agentid+" order by id desc";	                    	
							sql+= "select top "+ page_size +" id,name username,name,concatus nickname,telphone as tel,city  as areaName from pro_agent_factory  where is_cooperate=1 and id not in(select TOP "+ page_size*(page_index-1) +" id from pro_agent_factory where is_cooperate=1 and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc ) and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc";	                    							   
					    }
						
						totalsql += "select name username,name,concatus nickname,telphone as tel,id from pro_agent_factory  where is_cooperate=1 and flag=2 and agent_fac like '%"+ factoryid +"%' order by id desc";
						
					}else{					
						   //int agentid = objone.getInt("agentid");
						   String whereStr=""; 
				 		   String condition = objone.getString("condition");
				 		   if(condition.matches("[0-9]+")){
				 		   		whereStr+=" and  telphone like '%"+ condition +"%'";
				 		   }else{
				 		   		whereStr+=" and name like '%"+ condition +"%'";		 		    		
				 		   }
						   sql+="select name username,name,concatus nickname,telphone as tel,id,city  as areaName from  pro_agent_factory where is_cooperate=1 and 1=1 and agent_fac like '%"+ factoryid +"%' "+whereStr;             
						   totalsql += "select name username,name,concatus nickname,telphone as tel,id from pro_agent_factory where is_cooperate=1 and 1=1 and agent_fac like '%"+ factoryid +"%'"+ whereStr;
							
					}
					System.out.println("20141204sql:"+sql);
					
					//计数
		    		List<Map<String,Object>> totallist = null ;  		 
		    		totallist = dbHelper.getMapList(totalsql) ;

					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	
					if (list.size() > 0) {
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						System.out.println("sql:" + sql);
						newlist = dbHelper.getMapList(sql);
						json.addAll(getFormatList(list));
						jsonString = json.toString();
						jsonObject.put("resultObject", jsonString);
						jsonObject.put("totalCount", newlist.size());

					} else {
						jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");

					}			
					
				} else {
					jsonObject.put("resultCode", "0002");
					jsonObject.put("resultMessage", "失败");
					jsonObject.put("resultObject", "");

				}
			}

			/**
			 * 传出结果拼接字符串:resultCode,resultMessage,resultObject
			 */

			System.out.println("测试返回字符串:" + jsonObject.toString());

		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("resultCode", "0002");
			jsonObject.put("resultMessage", "失败");
			jsonObject.put("resultObject", "");
		} finally {
			DBHelper.freeConnection(connection);
		}

		return jsonObject.toString();
	}
	
}