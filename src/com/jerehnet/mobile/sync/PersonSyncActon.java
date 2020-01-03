package com.jerehnet.mobile.sync;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;

/**
 * 订单宝数据同步-业务员管理
 * 
 * @author sunyb
 * @date 2014-10-15
 */
public class PersonSyncActon extends BaseSyncActon{
	/**
	 * 
	 * @param usrn
	 * @param method
	 * @param jsonStr
	 * @return
	 */
	public String sync(String flag, String method, String jsonStr) {

		Connection connection = null;
		DBHelper dbHelper = DBHelper.getInstance();

		JSONObject jsonObject = new JSONObject();
		System.out.println("++++++++++++++++++++++++++++++++++++++++++:"+ jsonStr);
		try {
			/**
			 * 数据处理过程
			 */
			connection = dbHelper.getConnection();
			org.json.JSONObject objone = new org.json.JSONObject(jsonStr);

			
			String jsonString = "";
           //只查询业务员
			if (flag.equals("person")) {
				
				if (method.equals("person_list")) {
					String agentid = CommonString.getFormatPara(objone.getString("agentid"));
					
					
					String sql="";
					String totalsql="";
					
					if(jsonStr.indexOf("condition")<0){
						if(jsonStr.indexOf("page_index")<0||jsonStr.indexOf("page_index")<0){
					    	sql+="select id,uuid,name nickname,sex,usern username,phone tel,password,city as areaName ,city_num as areaId,agent_id as agentId from pro_agent_personnel where agent_id="+agentid+" order by id desc";             
					    }else{
					    	//分页
							int page_index = objone.getInt("page_index"); 
						    int page_size = objone.getInt("page_size"); 
					    	sql+= "select top  "+ page_size +" id,uuid,name nickname,sex,usern username,phone tel,password,city as areaName ,city_num as areaId,agent_id as agentId from pro_agent_personnel  where id not in(select TOP "+ page_size*(page_index-1) +" id from pro_agent_personnel where agent_id="+ agentid+" order by id desc) and agent_id='"+ agentid + "'  order by id desc"; 
					    }
						
						totalsql += "select id,uuid,name nickname,sex,usern username,phone tel,password,city as areaName ,city_num as areaId,agent_id as agentId from pro_agent_personnel  where agent_id='"+ agentid + "'  order by id desc";                  	
						
					}else{					
						   String whereStr=" and agent_id="+agentid+""; 
				 		   String condition = objone.getString("condition");
				 		   if(condition.matches("[0-9]+")){
				 		   		whereStr+="  and phone like '%"+ condition +"%' ";
				 		   }else{
				 		   		whereStr+="  and (name like '%"+ condition +"%' or usern like '%"+ condition +"%'  )";		 		    		
				 		   }
				 		   				
						   //int pid = objone.getInt("pid");
						   sql+="select id,uuid,name nickname,sex,usern username,phone tel,password,city as areaName ,city_num as areaId,agent_id as agentId  from pro_agent_personnel where 1=1 "+whereStr;             
						   totalsql += "select id,uuid,name nickname,sex,usern username,phone tel,password,city as areaName ,city_num as areaId,agent_id as agentId  from pro_agent_personnel where 1=1 "+whereStr;
							
					}
					
					
					
					//计数
		    		 List<Map<String,Object>> totallist = null ;  		 
		    		 totallist = dbHelper.getMapList(totalsql) ;
					
					
					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					if (list.size() > 0) {
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "业务人员列表面返回成功");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						System.out.println("sql:" + sql);
						newlist = dbHelper.getMapList(sql);
						json.addAll(getFormatList(newlist));
						jsonString = json.toString();
						jsonObject.put("resultObject", jsonString);
						jsonObject.put("totalCount", totallist.size());

					} else {
						jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");

					}
				}else if(method.equals("person_info")){
					String personid = CommonString.getFormatPara(objone.getString("personid"));
					String sql = "select id,uuid,name nickname,sex,usern username,phone tel,password,city as areaId,city_num from pro_agent_personnel where id='"+ personid + "'";

					List<Map<String, Object>> list = null;
					list = dbHelper.getMapList(sql);
					if (list.size() > 0) {
						jsonObject.put("resultCode", "0001");
						jsonObject.put("resultMessage", "业务人员详细页面返回成功");
						net.sf.json.JSONArray json = new net.sf.json.JSONArray();
						List<Map<String, Object>> newlist = new ArrayList<Map<String, Object>>();
						System.out.println("sql:" + sql);
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
				}else if(method.equals("person_update")){
					//String agentid = CommonString.getFormatPara(objone.getString("agentid"));  //代理商id
					String usern = CommonString.getFormatPara(objone.getString("usern"));      //账号
					String password = CommonString.getFormatPara(objone.getString("password")); //密码
					String name = CommonString.getFormatPara(objone.getString("name"));   //姓名
					String telephone = CommonString.getFormatPara(objone.getString("telephone"));   //电话
					//JSONObject agentArea = objone.getJSONObject("agentArea");   //管理区域
					org.json.JSONArray  agentarr=objone.getJSONArray("agentArea");
					String city_num="";
					String city="";
					for(int k=0;k<agentarr.length();k++){
						city_num+=agentarr.getJSONObject(k).getString("id")+",";
						String [] areaIds=  city_num.split(",");
						
						//city+=agentarr.getJSONObject(k).getJSONArray("name")+",";
					}
					
					for(int j=0;j<agentarr.length();j++){
						String areasql = "select area_id,area_name from comm_area where area_id="+agentarr.getJSONObject(j).getString("id");                  	
						 //计数
			    		 List<Map<String,Object>> arealist = null ;  		 
			    		 arealist = dbHelper.getMapList(areasql) ;	
			    		 city+=arealist.get(0).get("area_name")+",";
					}
					
					System.out.println("agentArea:"+agentarr);
					
					
					String personid = CommonString.getFormatPara(objone.getString("personid"));   //
					
					String updatesql= "update pro_agent_personnel set usern=?,password=?,name=?,phone=?,city_num=?,city=?  where id=?";
					int r = dbHelper.execute(updatesql,new Object []{usern,password,name,telephone,city_num,city,personid},connection);					
					
					String newsql="select id,uuid,name nickname,sex,usern username,phone tel,password,city as areaName ,city_num as areaId  from pro_agent_personnel where id="+personid;					
					
					if(r>0){
						
						jsonObject.put("resultCode","0001");
		            	jsonObject.put("resultMessage","业务员修改成功"); 			
		            	net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
		            	//System.out.println("sql:"+sql);
		            	newlist = dbHelper.getMapList(newsql) ; 
		            	json.addAll(getFormatList(newlist));
		            	jsonString = json.toString();           
		            	jsonObject.put("resultObject",jsonString);
		            	jsonObject.put("totalCount",newlist.size()); 

				    }else{
				    	jsonObject.put("resultCode", "0002");
						jsonObject.put("resultMessage", "失败");
						jsonObject.put("resultObject", "");
				    }
					
					
				} 
				
				else if(method.equals("person_add")){

					String agentid = CommonString.getFormatPara(objone.getString("agentid"));  //代理商id
					String usern = CommonString.getFormatPara(objone.getString("usern"));      //账号
					String password = CommonString.getFormatPara(objone.getString("password")); //密码
					String name = CommonString.getFormatPara(objone.getString("name"));   //姓名
					String telephone = CommonString.getFormatPara(objone.getString("telephone"));   //电话
					
					
					org.json.JSONArray  agentarr=objone.getJSONArray("agentArea");
					String city_num="";
					String city="";
					for(int k=0;k<agentarr.length();k++){
						city_num+=agentarr.getJSONObject(k).getString("id")+",";
						String [] areaIds=  city_num.split(",");
						//city+=agentarr.getJSONObject(k).getJSONArray("name")+",";
					}
					
					for(int j=0;j<agentarr.length();j++){
						String areasql = "select area_id,area_name from comm_area where area_id="+agentarr.getJSONObject(j).getString("id");                  	
						 //计数
			    		 List<Map<String,Object>> arealist = null ;  		 
			    		 arealist = dbHelper.getMapList(areasql) ;	
			    		 city+=arealist.get(0).get("area_name")+",";
					}
					
					
					System.out.println("agentArea:"+agentarr);
	
					int exist=0;
					int r=0;
					
					String newsql="select id from pro_agent_personnel where agent_id="+ agentid +" and usern='"+ usern +"' and password='"+ password +"'";
					
					Map proInfo = dbHelper.getMap("select id from pro_agent_personnel where agent_id=? and usern=? and password=?", new Object[] { agentid,usern,password }, connection);
				
					if(proInfo!=null){exist=1; }  
		            String  sql=""	;		
		            String uuid=CommonString.getUUID(); 
					if (exist!=1) {
						sql += " insert into pro_agent_personnel (uuid,add_date,agent_id,usern,password,name,phone,city,city_num) ";
						sql += " values (?,?,?,?,?,?,?,?,?) ";
						r = dbHelper.execute(sql,new Object []{uuid,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),agentid,usern,password,name,telephone,city,city_num},connection);					
						if(r>0){
						
							jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","业务员添加成功"); 			
			            	net.sf.json.JSONArray json = new net.sf.json.JSONArray();
			            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
			            	System.out.println("sql:"+sql);
			            	newlist = dbHelper.getMapList(newsql) ; 
			            	json.addAll(getFormatList(newlist));
			            	jsonString = json.toString();           
			            	jsonObject.put("resultObject",jsonString);
			            	jsonObject.put("totalCount",newlist.size()); 
	
					    }else{
					    	jsonObject.put("resultCode", "0002");
							jsonObject.put("resultMessage", "失败");
							jsonObject.put("resultObject", "");
					    }
					}else{
					    sql+= "update pro_agent_personnel set name=?,telephone=? where usern=? and password=?";
						System.out.println(sql);
						r=dbHelper.execute(sql,new Object [] {name,telephone,usern,password},connection);
						if(r>0){
							
							jsonObject.put("resultCode","0001");
			            	jsonObject.put("resultMessage","订单状态修改成功"); 			
			            	net.sf.json.JSONArray json = new net.sf.json.JSONArray();
			            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
			            	System.out.println("sql:"+sql);
			            	newlist = dbHelper.getMapList(newsql) ; 
			            	json.addAll(getFormatList(newlist));
			            	jsonString = json.toString();           
			            	jsonObject.put("resultObject",jsonString);
			            	jsonObject.put("totalCount",newlist.size()); 
							
						}else{
							jsonObject.put("resultCode", "0002");
							jsonObject.put("resultMessage", "失败");
							jsonObject.put("resultObject", "");
						}
					}
				

				}else {
					jsonObject.put("resultCode", "0002");
					jsonObject.put("resultMessage", "失败");
					jsonObject.put("resultObject", "");

				}
			}else{
				jsonObject.put("resultCode", "0002");
				jsonObject.put("resultMessage", "失败");
				jsonObject.put("resultObject", "");
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
