package com.jerehnet.mobile.sync;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;


/**
 * 订单宝数据同步-订单列表列表页、详细页、修改
 * @author sunyb
 * @date   2014-10-15
 */
public class OrderSyncActon extends BaseSyncActon{
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
	Map<String,String>ret_map=new HashMap<String,String>(); 
	
	
	
	net.sf.json.JSONObject jsonObject = new net.sf.json.JSONObject();   

	   
	   try{ 
		    /** 
		              数据处理过程            
		    **/ 
		    connection = dbHelper.getConnection();    
		    
		    org.json.JSONObject obj = new org.json.JSONObject(jsonStr); 

			String jsonString = "";
			 
		    if(flag.equals("order")){ 
		        
		    	 if(method.equals("personnel_order_list")){
		    		 String personid = CommonString.getFormatPara(obj.getString("personid"));
		    		 int page_index = obj.getInt("page_index"); 
		 		     int page_size = obj.getInt("page_size"); 
		 		     
		 		     
		 		     String whereStr="";
		 		     if(jsonStr.indexOf("state")<0){
		 		    	    whereStr+="";
		 		     }else{
		 		    	int state = obj.getInt("state");  
		 		    	/*if(state==102001){//未接收
			 		    	whereStr+=" order_state= 102001 and ";
			 		     }else if(state==102008){//成交
			 		    	whereStr+=" order_state= 102008 and "; 
			 		     }else if(state==102009){//流失 
			 		    	whereStr+=" order_state= 102009 and "; 
			 		     }else if(state==102002){//跟踪中
			 		    	whereStr+=" order_state in(102002,102003,102004,102005,102006,102007) and "; 
			 		     }else{
			 		    	whereStr+="";
			 		     }	 */
		 		    	if(state==102001||state==102008||state==102009||state==102003||state==102004||state==102005||state==102006||state==102007){
		 		    		whereStr+=" order_state= '"+ state +"' and ";
		 		    	}else if(state==102002){
		 		    		whereStr+=" order_state in('102002','102003','102004','102005','102006','102007') and ";     		
		 		    	}else{
		 		    		whereStr+="  ";
		 		    	}
		 		     }
		 		 //姓名     电话
		 		    if(jsonStr.indexOf("key")<0){
		 		    	whereStr+=" ";
		 		     }else{
		 		    	String key = obj.getString("key");
		 		    	if(key.matches("[0-9]+")){
		 		    		whereStr+="  form.contact_tel like '%"+ key +"%' and ";
		 		    	}else{
		 		    		whereStr+="  form.user_name like '%"+ key +"%'  and ";		 		    		
		 		    	}
		 		     }
		 		    
		    		 
		    		 String sql="select top  "+ page_size +" "+personid+"  as receiveManId, form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
		    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
		    		 		"person.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
		    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from " 
		    		 +		"pro_agent_products_form form,pro_agent_personnel person,pro_products products where "+whereStr+" products.id=form.product_id and person.id=form.person_id " 
		    		 +		"and   person.id='"+personid+"' and form.id not in( select TOP "+ page_size*(page_index-1) +" form.id " 
		    		 +		"FROM pro_agent_products_form form,pro_agent_personnel person where "+whereStr+" person.id=form.person_id and   " 
		    		 +		"person.id='"+personid+"' ORDER BY order_state desc,form.id desc)  order by order_state desc,form.id desc";
		    		 
		    		 
		    		 String totalsql="select  form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
	    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
	    		 		"person.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
	    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from " 
	    		 +		"pro_agent_products_form form,pro_agent_personnel person,pro_products products where "+whereStr+" products.id=form.product_id and person.id=form.person_id " 
	    		 +		"and   person.id='"+personid+"'  order by order_state desc,form.id desc";
		    		 //计数
		    		 List<Map<String,Object>> totallist = null ;  		 
		    		 totallist = dbHelper.getMapList(totalsql) ;
		    		 
		    		 System.out.println("hehe");
		    		 
		    		 List<Map<String,Object>> list = null ;  		 
		    		 list = dbHelper.getMapList(sql) ;
		    		 List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	  
		    		 
		    		 
		              list = dbHelper.getMapList(sql) ; 
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","获取订单列表成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  System.out.println("sql:"+sql);
		            	  newlist = dbHelper.getMapList(sql) ; 
		            	  
		            	 /* for(int i=0;i<list.size();i++){
		            		  orderlist.add(list.get(i));
		            		  Map<String,Object> map=new HashMap<String,Object>();
		            		  
		            		  String order_state_sql="select * from pro_order_state where parent_id="+list.get(i).get("id");	
						      List<Map<String,Object>> order_state_list = null ;
						      order_state_list = dbHelper.getMapList(order_state_sql) ;
		            		  
			            	  map.put("order_state_list", order_state_list);
			            	  orderlist.add(map);
		            	  }*/
		            	  
                          json.addAll(getFormatList(newlist));                        
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);
     	                  jsonObject.put("totalCount",totallist.size()); 
		                 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              } 
		    		  
		    	 }else if(method.equals("agent_order_list")){
		    		 
		    		 String agentid = CommonString.getFormatPara(obj.getString("agentid")); 
		    		 int page_index = obj.getInt("page_index"); 
		 		     int page_size = obj.getInt("page_size"); 
		 		     
		 		     
		 		     String whereStr="";
		 		     if(jsonStr.indexOf("state")<0){
		 		    	    whereStr+="";
		 		     }else{
			 		    	int state = obj.getInt("state");  
			 		    	
			 		    	if(state==102001||state==102008||state==102009||state==102003||state==102004||state==102005||state==102006||state==102007){
			 		    		whereStr+=" order_state= '"+ state +"' and ";
			 		    	}else if(state==102002){
			 		    		whereStr+=" order_state in('102002','102003','102004','102005','102006','102007') and ";     		
			 		    	}else{
			 		    		whereStr+="  ";
			 		    	}
			 		     }
		 		    
		 		    //订单人  电话   跟踪人
			 		 if(jsonStr.indexOf("key")<0){
		 		    	whereStr+=" ";
		 		     }else{
		 		    	String key = obj.getString("key");
		 		    	if(key.matches("[0-9]+")){
		 		    		whereStr+="  form.contact_tel like '%"+ key +"%' and ";
		 		    	}else{
		 		    		whereStr+="  (form.user_name like '%"+ key +"%' or person.name like '%"+ key +"%') and ";		 		    		
		 		    	}
		 		     }
			 		 		 		     
		    		 String sql="select top  "+ page_size +"  "+agentid+" as receiveAgentId ,  form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
		    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
		    		 		"person.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
		    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from  pro_agent_products_form form,pro_agent_personnel " +
		    		 		"person,pro_products products where "+ whereStr +" products.id=form.product_id and person.id=form.person_id and   " +
		    		 		"form.agent_id='"+ agentid +"' and form.id not in (select top "+ page_size*(page_index-1) +" form.id from pro_agent_products_form form," +
		    		 		" pro_products products  where  "+ whereStr +" products.id=form.product_id " +
		    		 		" and   form.agent_id='"+ agentid +"' ORDER BY order_state desc,form.id desc) order by order_state desc,form.id desc";
		    		 
		    		 
		    		 String totalsql="select   form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
	    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
	    		 		"person.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
	    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from  pro_agent_products_form form,pro_agent_personnel " +
	    		 		"person,pro_products products where "+ whereStr +" products.id=form.product_id  and   " +
	    		 		"form.agent_id='"+ agentid +"'  order by order_state desc,form.id desc";
		    		 
		    		 
		    		 System.out.println("zzzzzsql:"+sql);
		    		 System.out.println("zzzzzsql:"+totalsql);

		    		 //计数
		    		 List<Map<String,Object>> totallist = null ;  		 
		    		 totallist = dbHelper.getMapList(totalsql) ;
		    		 
		    		 List<Map<String,Object>> list = null ;
		    		 list = dbHelper.getMapList(sql) ;
		    		 List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	    		 
		    		 System.out.println("sql:"+sql); 
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","获取订单列表成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  
		            	
		            	  newlist = dbHelper.getMapList(sql) ; 
		            	  
		            	  
//		            	  for(int i=0;i<list.size();i++){
//				            	 
//		            		   
//		            		   String order_state_sql="select id,flag,record_date,parent_id,receive_man_id from pro_order_state where parent_id="+list.get(i).get("id");	
//						       List<Map<String,Object>> order_state_list = null ;
//						       order_state_list = dbHelper.getMapList(order_state_sql);	            		   
//		            		   list.get(i).put("order_state_list", order_state_list);
//		            		   orderlist.add(list.get(i));
//			            	 
//		            	  
//			              }	            	 
                          json.addAll(getFormatList(newlist));                        
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);
     	                  jsonObject.put("totalCount",totallist.size()); 
		                 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              }  
		              //厂 商订单列表
		    	 }else if(method.equals("factory_order_list")){

		    		 
		    		 System.out.println("===");
		    		 String factoryid = CommonString.getFormatPara(obj.getString("factoryid")); 
		    		 System.out.println("===");
		    		 int page_index = obj.getInt("page_index"); 
		 		     int page_size = obj.getInt("page_size"); 
		 		     
		 		     
		 		     String whereStr=" person_id is not null and person_id !='' and  ";
		 		     if(jsonStr.indexOf("state")<0){
		 		    	    whereStr+="";
		 		     }else{
			 		    	int state = obj.getInt("state");  
			 		    	
			 		    	if(state==102001||state==102008||state==102009||state==102003||state==102004||state==102005||state==102006||state==102007){
			 		    		whereStr+=" order_state= '"+ state +"' and ";
			 		    	}else if(state==102002){
			 		    		whereStr+=" order_state in('102002','102003','102004','102005','102006','102007') and ";     		
			 		    	}else{
			 		    		whereStr+="  ";
			 		    	}
			 		     }
		 		    
		 		    //订单人  电话   跟踪人
			 		 if(jsonStr.indexOf("key")<0){
		 		    	whereStr+=" ";
		 		     }else{
		 		    	String key = obj.getString("key");
		 		    	if(key.matches("[0-9]+")){
		 		    		whereStr+="  form.contact_tel like '%"+ key +"%' and ";
		 		    	}else{
		 		    		whereStr+="  (form.user_name like '%"+ key +"%' or fac.name like '%"+ key +"%') and ";		 		    		
		 		    	}
		 		     }
			 		 /*		 		     
		    		 String sql="select top  "+ page_size +"  form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
		    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
		    		 		"fac.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
		    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from  pro_agent_products_form form,pro_agent_factory " +
		    		 		"fac,pro_products products where "+ whereStr +" products.id=form.product_id and fac.id=form.agent_id and   " +
		    		 		"form.person_id in (select  id  from pro_agent_personnel where agent_id in(select id from pro_agent_factory where agent_fac like '%"+ factoryid +"%')) and form.id not in (select top "+ page_size*(page_index-1) +" form.id from pro_agent_products_form form," +
		    		 		"pro_agent_factory fac,pro_products products  where  "+ whereStr +" products.id=form.product_id " +
		    		 		"and fac.id=form.factory_id and   form.person_id in (select  id  from pro_agent_personnel where agent_id in(select id from pro_agent_factory where agent_fac like '%"+ factoryid +"%')) ORDER BY order_state desc,form.id desc) order by order_state desc,form.id desc";
		    		 */
		    		 String sql="select top  "+ page_size +" "+factoryid+" as receiveFactoryId ,form.agent_id as receiveAgentId , form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
	    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
	    		 		"fac.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
	    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from  pro_agent_products_form form,pro_agent_factory " +
	    		 		"fac,pro_products products where "+ whereStr +" products.id=form.product_id and fac.id=form.agent_id    and  form.factory_id= " +factoryid+
	    		 		" and form.id not in (select top "+ page_size*(page_index-1) +" form.id from pro_agent_products_form form," +
	    		 		"pro_agent_factory fac,pro_products products  where  "+ whereStr +" products.id=form.product_id  and  form.factory_id=  " +factoryid+
	    		 		"and fac.id=form.agent_id  ORDER BY order_state desc,form.id desc) order by order_state desc,form.id desc";
		    		 
		    		 String totalsql="select   form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
	    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
	    		 		"fac.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
	    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from  pro_agent_products_form form,pro_agent_factory " +
	    		 		"fac,pro_products products where "+ whereStr +" products.id=form.product_id and fac.id=form.agent_id   and  form.factory_id=  " +factoryid+
	    		 		"  order by order_state desc,form.id desc";
		    		
		    		 
		    		 System.out.println("---zengtest:"+sql);
		    		 System.out.println("---totalsql:"+totalsql);
		    		 //计数
		    		 List<Map<String,Object>> totallist = null ;  		 
		    		 totallist = dbHelper.getMapList(totalsql) ;
		    		 
		    		 List<Map<String,Object>> list = null ;
		    		 list = dbHelper.getMapList(sql) ;
		    		 List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	    		 
		    		 System.out.println("sql:"+sql); 
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","获取订单列表成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  
		            	
		            	  newlist = dbHelper.getMapList(sql) ; 
		            	  
		            	  
//		            	  for(int i=0;i<list.size();i++){
//				            	 
//		            		   
//		            		   String order_state_sql="select id,flag,record_date,parent_id,receive_man_id from pro_order_state where parent_id="+list.get(i).get("id");	
//						       List<Map<String,Object>> order_state_list = null ;
//						       order_state_list = dbHelper.getMapList(order_state_sql);	            		   
//		            		   list.get(i).put("order_state_list", order_state_list);
//		            		   orderlist.add(list.get(i));
//			            	 
//		            	  
//			              }	            	 
                          json.addAll(getFormatList(newlist));                        
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);
     	                  jsonObject.put("totalCount",totallist.size()); 
		                 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              }  
		    	 
		    	 }else if(method.equals("order_info")){
		    		  
		    		 String orderid = CommonString.getFormatPara(obj.getString("orderid")); 
		    		 String sql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
		    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,person.name as receive_man,products.img2 as machine_img," +
		    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date,form.contact_address as address " +
		    		 		"from pro_agent_products_form form,pro_agent_personnel person,pro_products products " +
		    		 		"where products.id=form.product_id and person.id=form.person_id  and   form.id="+orderid;
		    		 
		    		 
		    		 String totalsql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
	    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,person.name as receive_man,products.img2 as machine_img," +
	    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date,form.contact_address as address " +
	    		 		"from pro_agent_products_form form,pro_agent_personnel person,pro_products products " +
	    		 		"where products.id=form.product_id and person.id=form.person_id  and   form.id="+orderid;
		    		 
		    		 List<Map<String,Object>> list = null ; 
		    		 List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	    
		              list = dbHelper.getMapList(sql) ; 
		              if(list.size()>0){
		            	  
		              for(int i=0;i<list.size();i++){
		            	 
	            		   
	            		   String order_state_sql="select id,flag,CONVERT(varchar(100), record_date, 20) as record_date,parent_id,receive_man_id from pro_order_state where parent_id="+list.get(i).get("id")+" order by id desc";	
					       List<Map<String,Object>> order_state_list = null ;
					       order_state_list = dbHelper.getMapList(order_state_sql);	            		   
	            		   list.get(i).put("order_state_list", getFormatList(order_state_list));
	            		   orderlist.add(list.get(i));
		            	  /*orderlist.add(list.get(i));
	            		   Map<String,Object> map=new HashMap<String,Object>();
	            		   String order_state_sql="select * from pro_order_state where parent_id="+list.get(i).get("id");	
					       List<Map<String,Object>> order_state_list = null ;
					       order_state_list = dbHelper.getMapList(order_state_sql);
		            	   map.put("order_state_list", order_state_list);
		            	   orderlist.add(map);*/
	            	  
		              }
		            	  
		            	  
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","获取订单详细成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  System.out.println("sql:"+sql);
		            	  newlist = dbHelper.getMapList(sql) ; 
                          json.addAll(getFormatList(orderlist));                        
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);
     	                  jsonObject.put("totalCount",newlist.size()); 
		                 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              }
		    		 
		    	 }else if(method.equals("factory_order_info")){
		    		
		    		 String orderid = CommonString.getFormatPara(obj.getString("orderid")); 
		    		 String sql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
		    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,factory.name as receive_man,products.img2 as machine_img," +
		    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date,form.contact_address as address " +
		    		 		"from pro_agent_products_form form,pro_agent_factory factory,pro_products products " +
		    		 		"where products.id=form.product_id and factory.id=form.agent_id  and   form.id="+orderid;
		    		 
		    		 System.out.println("1234:"+sql);
		    		 String totalsql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
	    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,person.name as receive_man,products.img2 as machine_img," +
	    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date,form.contact_address as address " +
	    		 		"from pro_agent_products_form form,pro_agent_personnel person,pro_products products " +
	    		 		"where products.id=form.product_id and person.id=form.person_id  and   form.id="+orderid;
		    		 
		    		 List<Map<String,Object>> list = null ; 
		    		 List<Map<String,Object>> orderlist = new ArrayList<Map<String,Object>>() ;	    
		              list = dbHelper.getMapList(sql) ; 
		              if(list.size()>0){
		            	  
		              for(int i=0;i<list.size();i++){
		            	 
	            		   
	            		   String order_state_sql="select id,flag,CONVERT(varchar(100), record_date, 20) as record_date,parent_id,receive_man_id from pro_order_state where parent_id="+list.get(i).get("id")+" order by id desc";	
					       List<Map<String,Object>> order_state_list = null ;
					       order_state_list = dbHelper.getMapList(order_state_sql);	            		   
	            		   list.get(i).put("order_state_list", getFormatList(order_state_list));
	            		   orderlist.add(list.get(i));
		            	  /*orderlist.add(list.get(i));
	            		   Map<String,Object> map=new HashMap<String,Object>();
	            		   String order_state_sql="select * from pro_order_state where parent_id="+list.get(i).get("id");	
					       List<Map<String,Object>> order_state_list = null ;
					       order_state_list = dbHelper.getMapList(order_state_sql);
		            	   map.put("order_state_list", order_state_list);
		            	   orderlist.add(map);*/
	            	  
		              }
		            	  
		            	  
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","获取订单详细成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	  System.out.println("sql:"+sql);
		            	  newlist = dbHelper.getMapList(sql) ; 
                          json.addAll(getFormatList(orderlist));                        
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);
     	                  jsonObject.put("totalCount",newlist.size()); 
		                 
		              }else{ 
		            	  jsonObject.put("resultCode","0002"); 
		            	  jsonObject.put("resultMessage","失败"); 
		            	  jsonObject.put("resultObject",""); 
		                 
		              }
		    		 		    		 
		    	 }
		    	 
		    	 
		    	 else if(method.equals("order_update")){
		    				    		 
		    		 String orderid = CommonString.getFormatPara(obj.getString("orderid")); 
		    		 String formdate = CommonString.getFormatPara(obj.getString("formdate"));
		    		 String personid = CommonString.getFormatPara(obj.getString("personid"));
		    		 String contacttel = CommonString.getFormatPara(obj.getString("contacttel"));
		    		 String contactaddr = CommonString.getFormatPara(obj.getString("contactaddr"));
		    		 String orderstate = CommonString.getFormatPara(obj.getString("orderstate"));
		    		 
		    		 
		    		 
		    		 
		    		 String updatesql= "update pro_agent_products_form set form_date=?,person_id=?,contact_tel=?,contact_address=?,order_state=?  where id=?";
				     System.out.println(updatesql);
					 
				     String sql="select form.id,form.uuid,factory_id,factory_name,form.agent_id,form.agent_name," 
			    		 +		"cata_num,cata_name,product_id,product_name,form_date person_id,person.name,order_state," 
			    		 +		"form.contact_address,form.contact_tel  from pro_agent_products_form form,pro_agent_personnel" 
			    		 +		" person where person.id=form.person_id and   form.id="+orderid;
				     
				     
				     int r=dbHelper.execute(updatesql,new Object [] {formdate,personid,contacttel,contactaddr,orderstate,orderid},connection);
					 if(r>0){
						    jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","订单修改成功"); 
			
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
			             jsonObject.put("resultMessage","订单修改失败"); 
			             jsonObject.put("resultObject","");
				     }
		    	  //修改pro_agent_products_form表一条记录，插入pro_order_state表一条记录	 
		         }else if(method.equals("order_submit")){
	    		 
		    		 String orderid = CommonString.getFormatPara(obj.getString("orderid"));
		    		 String orderstate = CommonString.getFormatPara(obj.getString("orderstate"));
		    		 //
		    		 String updatesql="";
		    		 int r1=0;
		    		 if(jsonStr.indexOf("receive_man_id")<0){
		    			 updatesql+= "update pro_agent_products_form set order_state=?,last_record_date=? where id=?";	 
			    		 r1=dbHelper.execute(updatesql,new Object [] {orderstate,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),orderid},connection);
		    		 }else{
		    			 String receive_man_id = CommonString.getFormatPara(obj.getString("receive_man_id"));
			    		 
			    		 updatesql+= "update pro_agent_products_form set order_state=?,last_record_date=?,person_id=? where id=?";	 
			    		 r1=dbHelper.execute(updatesql,new Object [] {orderstate,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),receive_man_id,orderid},connection);
		    		 }
		    		 
		    		 
		    		 System.out.println(updatesql); 
		    		 
		    		 
					 
				     String sql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
	    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,person.name as receive_man,products.img2 as machine_img," +
	    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date  " +
	    		 		"from pro_agent_products_form form,pro_agent_personnel person,pro_products products " +
	    		 		"where products.id=form.product_id and person.id=form.person_id  and   form.id="+orderid;
				     
				     				     
				     
				     List<Map<String,Object>> getColumnValuelist = null ;	    
				     getColumnValuelist = dbHelper.getMapList(sql) ; 
				     
				     
				     String insertsql="insert into pro_order_state (flag,record_date,parent_id,receive_man_id) values (?,?,?,?) "; 
		    		 System.out.println(insertsql); 
				     int r2 = dbHelper.execute(insertsql,new Object []{orderstate,getColumnValuelist.get(0).get("last_record_date"),orderid,getColumnValuelist.get(0).get("receive_man_id")},connection);	
				     
					 if(r1>0&&r2>0){
						    jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","订单状态修改成功"); 
			
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
			             jsonObject.put("resultMessage","订单状态修改失败"); 
			             jsonObject.put("resultObject","");
				     }
		    		 
		         }else if(method.equals("order_list_submit")){
	    		 
		    		 String orderid = CommonString.getFormatPara(obj.getString("orderid"));
		    		 String orderstate = CommonString.getFormatPara(obj.getString("orderstate"));
		    		 
		    		 String updatesql= "update pro_agent_products_form set order_state=?,last_record_date=? where id=?";
		    		 System.out.println(updatesql); 
		    		 int r1=dbHelper.execute(updatesql,new Object [] {orderstate,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),orderid},connection);
		    		 
					 
				     String sql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
	    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,person.name as receive_man,products.img2 as machine_img," +
	    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date  " +
	    		 		"from pro_agent_products_form form,pro_agent_personnel person,pro_products products " +
	    		 		"where products.id=form.product_id and person.id=form.person_id  and   form.id="+orderid;
				     

				     //int page_index = obj.getInt("page_index"); 
		 		     //int page_size = obj.getInt("page_size"); 
				     
				     int page_index = 1; 
		 		     int page_size = 20; 
		 		     
		 		     
		 		     String whereStr=" order_state=10021  and";
		 		     		 		     
		    		 String list_sql="select top  "+ page_size +"  form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name," +
		    		 		"(factory_name+cata_name+product_name) as machine_no,CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id," +
		    		 		"person.name as receive_man,products.img2 as machine_img,form.contact_tel as link_tel," +
		    		 		"form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date from  pro_agent_products_form form,pro_agent_personnel " +
		    		 		"person,pro_products products where "+ whereStr +" products.id=form.product_id and person.id=form.person_id and   " +
		    		 		" form.id not in (select top "+ page_size*(page_index-1) +" form.id from pro_agent_products_form form," +
		    		 		"pro_agent_personnel person,pro_products products  where  "+ whereStr +" products.id=form.product_id " +
		    		 		"and person.id=form.person_id  ORDER BY form.id) order by form.id";
				     
				     
				     				     
				     
				     List<Map<String,Object>> getColumnValuelist = null ;	    
				     getColumnValuelist = dbHelper.getMapList(sql) ; 
				     
				     
				     String insertsql="insert into pro_order_state (flag,record_date,parent_id,receive_man_id) values (?,?,?,?) "; 
		    		 System.out.println(insertsql);
				     int r2 = dbHelper.execute(insertsql,new Object []{orderstate,getColumnValuelist.get(0).get("last_record_date"),orderid,getColumnValuelist.get(0).get("receive_man_id")},connection);	
				     
					 if(r1>0&&r2>0){
						    jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","订单状态修改成功"); 
			
			            	net.sf.json.JSONArray json = new net.sf.json.JSONArray();
			            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
			            	System.out.println("sql:"+sql);
			            	newlist = dbHelper.getMapList(list_sql) ; 
			            	json.addAll(getFormatList(newlist));
			            	jsonString = json.toString();           
			            	jsonObject.put("resultObject",jsonString);
			            	jsonObject.put("totalCount",newlist.size()); 
				     }else{
				    	 jsonObject.put("resultCode","0002"); 
			             jsonObject.put("resultMessage","订单状态修改失败"); 
			             jsonObject.put("resultObject","");
				     }
		    		 
		         }else if(method.equals("order_check")){
	    		 
		    		 String orderid = CommonString.getFormatPara(obj.getString("orderid"));
		    		 String orderstate = CommonString.getFormatPara(obj.getString("orderstate"));
		    		 
		    		 String updatesql= "update pro_agent_products_form set order_state=?,last_record_date=? where id=?";
		    		 System.out.println(updatesql); 
		    		 int r=dbHelper.execute(updatesql,new Object [] {orderstate,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),orderid},connection);
		    		 
					 
				     String sql="select form.id,(convert(varchar(100),form.id)+CONVERT(varchar(100),form.add_date, 112)) as order_no,form.agent_id,form.agent_name,(factory_name+cata_name+product_name) as machine_no," +
	    		 		"CONVERT(varchar(100), form_date, 20) create_date, person_id receive_man_id,person.name as receive_man,products.img2 as machine_img," +
	    		 		"form.contact_tel as link_tel,form.user_name as link_man, order_state as flag,CONVERT(varchar(100), last_record_date, 20) as last_record_date  " +
	    		 		"from pro_agent_products_form form,pro_agent_personnel person,pro_products products " +
	    		 		"where products.id=form.product_id and person.id=form.person_id  and   form.id="+orderid;

					 if(r>0){
						    jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","订单状态修改成功"); 
			
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
			             jsonObject.put("resultMessage","订单状态修改失败"); 
			             jsonObject.put("resultObject","");
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
		             传出结果拼接字符串:state,message,resultCode  
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
