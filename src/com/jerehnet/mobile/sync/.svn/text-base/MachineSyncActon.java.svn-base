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
 * 订单宝数据同步-设备操作
 * @author sunyb
 * @date   2014-10-28
 */
public class MachineSyncActon extends BaseSyncActon{
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
		    
		    
			String jsonString = "";

		    
		    if(flag.equals("base")){ 
		       if(method.equals("machine_type_list")){
		    	   String sql="";
		    	   if(!jsonStr.equals("")&&jsonStr!=null){
				    	org.json.JSONObject objone = new org.json.JSONObject(jsonStr); 
					    int page_index = objone.getInt("page_index"); 
					    int page_size = objone.getInt("page_size"); 
					    sql += "select top "+ page_size +" id,name machine_type_name,num number from pro_catalog where is_show=1 and parentid=1 and id not in(select top "+ page_size*(page_index-1) +" id from pro_catalog order by id) order by id"; 
		              	
				    }else{
				    	
				    	sql+="select id,name machine_type_name,num number from pro_catalog where is_show=1 and parentid=1";
				    }
		    	      
			    	sql="select id,name machine_type_name,num number from pro_catalog where (is_show=1 and parentid=1) or id =59 or id=105 or id=120 or id=160 or id=150 or id=136  order by id desc";
  	              
		    	    List<Map<String,Object>> list = null ; 
		              list = dbHelper.getMapList(sql) ;
		              if(list.size()>0){
		            	  jsonObject.put("resultCode","0001");
		            	  jsonObject.put("resultMessage","返回设备类型成功"); 
		            	  net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	  List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	 
		            	  System.out.println("sql:"+sql);
		            	  newlist = dbHelper.getMapList(sql);
                          json.addAll(getFormatList(newlist));                        
                          jsonString = json.toString();           
                          jsonObject.put("resultObject",jsonString);                  
		                  jsonObject.put("totalCount",newlist.size()); 
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
