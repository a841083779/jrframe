<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="net.sf.json.JSONObject,com.jerehnet.util.dbutil.DBHelper,java.sql.Connection,com.jerehnet.mobile.statistics.*,com.jerehnet.mobile.sync.*,com.jerehnet.util.common.*,java.util.*"%>


<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));	 
    String method = CommonString.getFormatPara(request.getParameter("method")); 
    String jsonStr=CommonString.getFormatPara(request.getParameter("jsonStr")); 
    //System.out.println("flag:"+flag);
    //System.out.println("method:"+method);
    //System.out.println("jsonStr:"+jsonStr);
    
    AgentFactorySyncActon agentAction=new AgentFactorySyncActon();
    OrderSyncActon orderAction=new OrderSyncActon();
    PersonSyncActon personAction=new PersonSyncActon();
    MachineSyncActon machineAction=new MachineSyncActon();
    UserServiceAction userAction=new UserServiceAction();
    
    SyncStatisticsAction statistics =new SyncStatisticsAction();
    
    //SringBuffer ret_jsonStr=new SringBuffer();
    String ret_jsonStr="";
    if(flag.equals("agent")){
         ret_jsonStr+=agentAction.sync(flag,method,jsonStr);
    }else if(flag.equals("order")){
        ret_jsonStr+=orderAction.sync(flag,method,jsonStr);
    }else if(flag.equals("person")){
        ret_jsonStr+=personAction.sync(flag,method,jsonStr);
    }else if(flag.equals("statistics")){
        if(method.equals("area_order")){
            ret_jsonStr+=statistics.getAreaOrderPer(flag,method,jsonStr);
        }else if(method.equals("order_sum")){
            ret_jsonStr+=statistics.getOrderSum(flag,method,jsonStr);
        }else if(method.equals("person_order")){
            ret_jsonStr+=statistics.getPersonOrderNum(flag,method,jsonStr);
        }else if(method.equals("agent_order")){
        	ret_jsonStr+=statistics.getPersonOrderNum(flag,method,jsonStr);
        }else if(method.equals("agent_list")){
        	ret_jsonStr+=statistics.getPersonOrderNum(flag,method,jsonStr);
        }else if(method.equals("deal_products_list")){//成交竞品
        	ret_jsonStr+=statistics.getPersonOrderNum(flag,method,jsonStr);
        }else{
            ret_jsonStr+="";
        }
    }else if(flag.equals("base")){
       if(method.equals("machine_type_list")){
            ret_jsonStr+=machineAction.sync(flag,method,jsonStr);
       }else if(method.equals("getPwdInfo")){
    	    ret_jsonStr+=userAction.sync(flag,method,jsonStr);
       }
    }else if(flag.equals("http://xxldata.jerei.com/mobile/soft.jsp")){
    	String sql="";
    	String jsonString="";
    	Connection connection = null;
    	JSONObject jsonObject = new JSONObject();
		DBHelper dbHelper = DBHelper.getInstance();
		try {
			connection = dbHelper.getConnection();
			if(!jsonStr.equals("")&&jsonStr!=null){
				org.json.JSONObject objone = new org.json.JSONObject(jsonStr); 
				int  sid = objone.getInt("sid");
			    sql += "select id,sid,soft_name softName, soft_version softVersion,soft_version_remark softVersionRemark,soft_download_address softDownloadAddress,file_size fileSize from wcm_cms_mobile_soft where sid="+sid;	
			    Map<String, Object> map = null;
				map = dbHelper.getMap(sql);
			    if (null!=map&&!"".equals(map)) {
					
			    	//net.sf.json.JSONArray json = new net.sf.json.JSONArray();
			    	net.sf.json.JSONObject  json=new net.sf.json.JSONObject();
	            	List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>() ; 
	            	newlist = dbHelper.getMapList(sql) ; 
	            	//json.add(newlist.get(0));
	            	json.putAll(map);
	            	jsonString = json.toString();  
					jsonObject.put("resultCode", "0001");
					jsonObject.put("resultMessage", "下载成功");
					jsonObject.put("resultObject", jsonString);
				} else {
					jsonObject.put("resultCode", "0002");
					jsonObject.put("resultMessage", "失败");
					jsonObject.put("resultObject", "");

				}

			}
			ret_jsonStr=jsonObject.toString();
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("resultCode", "0002");
			jsonObject.put("resultMessage", "失败");
			jsonObject.put("resultObject", "");
		}finally{
			DBHelper.freeConnection(connection);	
		}
			
    }else{
    
    }
    out.println(ret_jsonStr.toString());
%>



 
