<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();

	JSONArray json = new JSONArray();// 数组[]
	JSONObject jo = new JSONObject(); // 对象{}
	jo.put("EX_PURCHASE_NO", "111111111111");
	jo.put("EX_SHOP_NO", "56");
	jo.put("EX_SHOP_NAME", "徐工重型机械有限公司");
	jo.put("TITLE", "测试数据");
	jo.put("EX_CAT", "全地面起重机");
	jo.put("EX_TYPE", "GR180-II地面起重机");
	jo.put("DESCRIPTION", "测试数据");
	jo.put("PUB_TIME", "2017-04-14 14:30:32.687");
	jo.put("EX_INFOFROM_ID", "1");
	jo.put("EX_INFOFROM_NAME", "21sun");
	jo.put("CONTACT", "王");
	jo.put("CONTACT_COMPANY", "新浪");
	jo.put("CONTACT_NUMBER", "12345678911");
	jo.put("CONTACT_EMAIL", "xxxx@163.com");
	jo.put("PROVINCE", "山东");
	jo.put("CITY", "烟台");
	jo.put("DISTRICT", "莱山");
		//String jsonObj = jo.toString();
		json.put(jo);
		String jsonArr = json.toString();

			Client client = new Client(new URL("http://120.27.225.220:8280/myWebservice/service/myWebservice?wsdl"));
			
			Object [] s =  client.invoke("pushThirdData", new Object[]{jsonArr,1});
			if(s != null && s.length > 0){
				out.println("s========"+s[0].toString());
			} 
		
			
			 	
	
	

%>
