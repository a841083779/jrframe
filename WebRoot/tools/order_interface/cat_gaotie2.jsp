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
	String regDate=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
		String jsonPara="{"+
	    "\"AppToken\": \"5c54ed1b9db71ab155347849bab330d1\","+
	    "\"Users\": ["+
	        "{"+
	            "\"ClientUserId\": 1,"+
	            "\"IOL_ID\": 0,"+
	            "\"UniqueId\": null,"+
	            "\"UTM_Channel\": \"\","+
	            "\"UTM_MEDIUM\": \"\","+
	            "\"UTM_CONTENT\": \"\","+
	            "\"UTM_CAMPAIGN\": \"\","+
	            "\"UTM_TERM\": \"\","+
	            "\"IsSem\":\"false\","+
	            "\"UserName\": \"测试\","+
	            "\"Mobile\": \"18318318383\","+
	            "\"Industry\": \"\","+
	            "\"MediaSource\": \"3rd Party(21sun)\","+
	            "\"DataSource\": \"Corp-Campaign\","+
	            "\"DataSourceCode\": \"CC1007\","+
	            "\"REPORT_GROUP\": \"wap\","+
	            "\"SixType\": \"\","+
	            "\"ThirdDetail\": \"21sun-m\","+
	            "\"RegTime\": \""+regDate+"\""+
	       " }"+
	    "]}";

			Client client = new Client(new URL("https://api.cat-cn.com/api/clue/UserinfoClue?param="+jsonPara));
			
			Object [] s =  client.invoke("pushThirdData", new Object[]{jsonPara,1});
			if(s != null && s.length > 0){
				out.println("s========"+s[0].toString());
			} 
		
			
			 	
	
	

%>
