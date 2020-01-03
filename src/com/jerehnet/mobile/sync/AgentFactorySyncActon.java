package com.jerehnet.mobile.sync;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;

/**
 * 订单宝数据同步-代理商厂商人员登陆注册
 * @author sunyb
 * @date   2014-10-15
 */
public class AgentFactorySyncActon extends BaseSyncActon{
   /**
    * 
    * @param usrn
    * @param method
    * @param jsonStr
    * @return
    */
	public String sync (String flag,String method,String jsonStr){
	   
	  
	 
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();  
	 
	
	JSONObject jsonObject = new JSONObject();     
	   try{ 
		    /** 
		              数据处理过程            
		    **/ 
		    connection = dbHelper.getConnection();    	    
		    org.json.JSONObject objone = new org.json.JSONObject(jsonStr); 
		    	   
		 
		    
			String usern = CommonString.getFormatPara(objone.getString("usern")); 
			String password = CommonString.getFormatPara(objone.getString("password")); 
			String jsonString = "";

		    
		    if(flag.equals("agent")){ 
		    	//代理商登录
		       if(method.equals("factory_login")){
		              String sql = "select f.id as id, f.id as agentId,f.usern as username,f.passw_bak as password," +
		              		"f.uuid,f.full_name as nickname,f.telphone as tel,f.city_num ," +
		              		"(case f.flag when 2 then 101002  when 1 then 101003 end)as flag," +
		              		"(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and   agent_id=f.id and order_state=102001) as unreceive_order_count," +
		              		"(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and   agent_id=f.id and order_state in(102002,102003,102004,102005,102006,102007)) as underway_order_count, " +
		              		"(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and   agent_id=f.id and order_state=102008) as transation_order_count," +
		              		"(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and   agent_id=f.id and order_state=102009) as run_off_order_count " +
		              		"from pro_agent_factory f where flag=2 and  usern='"+ usern +"' and passw_bak='"+ password +"'"; 
		              		              
		    	    List<Map<String,Object>> list = null ; 
		              list = dbHelper.getMapList(sql) ;
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","登录成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  
		            	  
		            	  if(list.get(0).get("city_num")!=null&&!"".equals(list.get(0).get("city_num"))){
		            		  String areaIdVal=com.jerehnet.mobile.utils.getDistcodeJson.getJson(CommonString.getFormatPara(list.get(0).get("city_num")));				            	   
		            		  list.get(0).put("areaId", areaIdVal);
		            	  }
		            	  
		            	  
		            	  
		            	  System.out.println("sql:"+sql);
		            	  newlist = dbHelper.getMapList(sql) ; 
		            	  
		            	  
		                  
                          //json.addAll(getFormatList(newlist));
		            	  json.addAll(getFormatList(list));
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);                  

		                  jsonObject.put("totalCount",newlist.size()); 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              } 
		              //厂商登录
		       }else if(method.equals("agent_factory_login")){
 
		            /*String sql = "select f.id as id, f.agent_fac as agentId,f.usern as username,f.passw_bak as password," +
		              		"f.uuid,f.full_name as nickname,f.telphone as tel,f.city_num ," +
		              		"(case f.flag when 2 then 101002  when 1 then 101003 end)as flag," +
		              		"(select count(*) from pro_agent_products_form where factory_id=f.id and order_state=102001) as unreceive_order_count," +
		              		"(select count(*) from pro_agent_products_form where factory_id=f.id and order_state in(102002,102003,102004,102005,102006,102007)) as underway_order_count, " +
		              		"(select count(*) from pro_agent_products_form where factory_id=f.id and order_state=102008) as transation_order_count," +
		              		"(select count(*) from pro_agent_products_form where factory_id=f.id and order_state=102009) as run_off_order_count " +
		              		"from pro_agent_factory f where  flag=1 and  usern='"+ usern +"' and passw_bak='"+ password +"'";*/ 
		    	   
		    	   String agent_fac_sql="select id  from pro_agent_factory  where  flag=1 and  usern='"+ usern +"' and passw_bak='"+ password +"'";
		    	   List<Map<String, Object>>  agent_fac_list= dbHelper.getMapList(agent_fac_sql);
		    	   String agent_fac=CommonString.getFormatPara(agent_fac_list.get(0).get("id"));
		    	   
		    	   //zengfc厂家登陆
		            String sql="select f.id as id, f.agent_fac as agentId,f.usern as username,f.passw_bak as password,f.uuid," +
		             "f.full_name as nickname,f.telphone as tel,f.city_num ,(case f.flag when 2 then 101002  when 1 then 101003 end)as flag," +
		             "(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and   order_state=102001 and factory_id="+agent_fac+") as unreceive_order_count," +
		             "(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and    order_state in(102002,102003,102004,102005,102006,102007) and factory_id="+agent_fac+")" +
		             " as underway_order_count,(select count(*) from pro_agent_products_form where  person_id is not null and person_id !='' and    order_state=102008 and factory_id="+agent_fac+") as transation_order_count," +
		             "(select count(*) from pro_agent_products_form where person_id is not null and person_id !='' and    order_state=102009 and factory_id="+agent_fac+") as run_off_order_count from pro_agent_factory f where  " +
		             "flag=1 and  usern='"+ usern +"' and passw_bak='"+ password +"'"; 
		    	   
		            System.out.println("agent_factory_login:"+sql); 
		    	    List<Map<String,Object>> list = null ; 
		              list = dbHelper.getMapList(sql) ;
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","登录成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  
		            	  //厂商登录全查省级单位  2014.11.17
		            	  /*
		            	  if(list.get(0).get("city_num")!=null&&!"".equals(list.get(0).get("city_num"))){
		            		  String areaIdVal=com.jerehnet.mobile.utils.getDistcodeJson.getJson(CommonString.getFormatPara(list.get(0).get("city_num")));				            	   
		            		  list.get(0).put("areaId", areaIdVal);
		            	  }*/
		            	  String province_sql="select area_id,area_name from comm_area where parent_area_id=0";
		            	  List<Map<String,Object>> province_list = null ; 
		            	  province_list = dbHelper.getMapList(province_sql) ;
		            	  String areaIdVal="[";
		            	  for(int k=0;k<province_list.size();k++){
		            		  areaIdVal+=(com.jerehnet.mobile.utils.getDistcodeJson.getJson(CommonString.getFormatPara(province_list.get(k).get("area_id")))+",").replace("[", "").replace("]", "");
		            	  }
		            	  areaIdVal+="]";
		            	  list.get(0).put("areaId", areaIdVal);
		            	  System.out.println("测试一下"+areaIdVal);
		            	  System.out.println("zengsql:"+sql);
		            	  newlist = dbHelper.getMapList(sql) ; 
		            	  
		            	  
		                  
                       //json.addAll(getFormatList(newlist));
		               json.addAll(getFormatList(list));
                       jsonString = json.toString();           
                       jsonObject.put("resultObject",jsonString);                  

		                  jsonObject.put("totalCount",newlist.size()); 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              } 
		              //业务员厂商登录
		       }else if(method.equals("personnel_login")){
		              String sql = "select p.id,p.uuid,p.agent_id,p.usern as username," +
		              		"p.city_num as area_id,p.name as nickname,p.password,p.phone as tel,101001 as flag,p.city_num," +
		              		"(select count(*) from pro_agent_products_form where person_id=p.id and order_state=102001) as unreceive_order_count," +
		              		"(select count(*) from pro_agent_products_form where person_id=p.id and order_state in(102002,102003,102004,102005,102006,102007)) as underway_order_count, " +
		              		"(select count(*) from pro_agent_products_form where person_id=p.id and order_state=102008) as transation_order_count," +
		              		"(select count(*) from pro_agent_products_form where person_id=p.id and order_state=102009) as run_off_order_count " +
		              		"from pro_agent_personnel as p where p.usern='"+ usern +"' and p.password='"+ password +"'"; 
		              //System.out.println("AAA:"+sql);
		    	      List<Map<String,Object>> list = null ; 
		                  list = dbHelper.getMapList(sql) ; 
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","登录成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 

		            	  if(list.get(0).get("city_num")!=null&&!"".equals(list.get(0).get("city_num"))){
		            		  String areaIdVal=com.jerehnet.mobile.utils.getDistcodeJson.getJson(CommonString.getFormatPara(list.get(0).get("city_num")));				            	   
		            		  
		            		  list.get(0).put("areaId", areaIdVal);
		            	  }
		            	   
		            	  
		            	  System.out.println("sql:"+sql);
		            	  newlist = dbHelper.getMapList(sql) ;
		            	  
                          //json.addAll(getFormatList(newlist));
                          json.addAll(getFormatList(list));
            
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);
                       
		                  jsonObject.put("totalCount",newlist.size()); 

		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		              }  
		       }else if(method.equals("factory_reg")){

		    	    int r=0;
		    	    int exist=0;
					Map proInfo = dbHelper.getMap("select usern,passw_bak as password,uuid,full_name as name from pro_agent_factory where usern=?", new Object[] { usern }, connection);
					if(proInfo!=null){exist=1; }  
					String sql = "select usern,passw_bak as password,uuid,full_name as name from pro_agent_factory where usern='"+ usern +"' and passw_bak='"+ password +"'"; 		
		            String uuid=CommonString.getUUID(); 
		            
		            System.out.println("usern:"+usern);
		            System.out.println("password:"+password); 
		            
					if (exist!=1) {
						System.out.println("insertsql");
						String insertsql = " insert into pro_agent_factory (uuid,add_date,usern,passw_bak,name) ";
						insertsql += " values (?,?,?,?,?) ";
						r = dbHelper.execute(insertsql,new Object []{uuid,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),usern,password,usern},connection);					
						if(r>0){
							jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","厂商代理商注册功能"); 
			
			            	net.sf.json.JSONArray json = new net.sf.json.JSONArray();
			            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
			            	System.out.println("sql:"+sql);
			            	newlist = dbHelper.getMapList(sql) ; 
			            	json.addAll(getFormatList(newlist));
			            	jsonString = json.toString();           
			            	jsonObject.put("resultObject",jsonString);
			            	jsonObject.put("totalCount",newlist.size()); 
			            	
						}else{
							jsonObject.put("resultCode","0002"); 
			            	jsonObject.put("resultMessage","注册失败"); 
			            	jsonObject.put("resultObject","");
					    }
					}
		       }else if(method.equals("personnel_reg")){

		    	    int r=0;
		    	    int exist=0;
					Map proInfo = dbHelper.getMap("select uuid,agent_id,name,sex,phone,view_count,usern,password from pro_agent_personnel where usern=?", new Object[] { usern }, connection);
					if(proInfo!=null){exist=1; }  
					 String sql = "select uuid,agent_id,name,sex,phone,view_count,usern,password from pro_agent_personnel where usern='"+ usern +"' and password='"+ password +"'"; 		
		            String uuid=CommonString.getUUID(); 
		            
		            System.out.println("usern:"+usern);
		            System.out.println("password:"+password);
		            
		            
					if (exist!=1) {
						System.out.println("insertsql");
						String insertsql = " insert into pro_agent_personnel (uuid,add_date,usern,password) ";
						insertsql += " values (?,?,?,?) ";
						r = dbHelper.execute(insertsql,new Object []{uuid,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),usern,password},connection);					
						if(r>0){
							jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","代理人员注册成功"); 
			
			            	net.sf.json.JSONArray json = new net.sf.json.JSONArray();
			            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
			            	System.out.println("sql:"+sql);
			            	newlist = dbHelper.getMapList(sql) ; 
			            	json.addAll(getFormatList(newlist));
			            	jsonString = json.toString();           
			            	jsonObject.put("resultObject",jsonString);
			            	jsonObject.put("totalCount",newlist.size()); 
			            	
						}else{
							jsonObject.put("resultCode","0002"); 
			            	jsonObject.put("resultMessage","注册失败"); 
			            	jsonObject.put("resultObject","");
					    }
					}
		    	   
		       }else{
		    	   jsonObject.put("resultCode","0002"); 
		    	   jsonObject.put("resultMessage","失败"); 
		    	   jsonObject.put("resultObject",""); 
	           }
		    }else{ 
		    	jsonObject.put("resultCode","0002"); 
		    	jsonObject.put("resultMessage","失败"); 
		    	jsonObject.put("resultObject","");
		    } 
		/** 
		             传出结果拼接字符串:resultCode,resultMessage,resultObject  
		**/ 
		System.out.println("测试返回字符串:"+jsonObject.toString());     
		 
		}catch(Exception e){ 
				e.printStackTrace();
				jsonObject.put("resultCode","0002"); 
		    	jsonObject.put("resultMessage","失败"); 
		    	jsonObject.put("resultObject",""); 
		}finally{ 
				DBHelper.freeConnection(connection); 
		} 

	   return jsonObject.toString();
   }
}
