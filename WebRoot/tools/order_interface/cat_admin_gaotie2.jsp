<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.Header"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="com.jerehnet.util.common.*"%>

<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>


<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.net.URLDecoder" %>
<%@page import="java.io.DataOutputStream"%>

<%@page import="java.io.*" %>
<%@page import="net.sf.json.*" %>
<% 
    int statusCode=0;
	request.setCharacterEncoding("utf-8");
	System.out.println("-------------------------开始输出");
	JSONObject jsonObject1 =null;
		String name = CommonString.getFormatPara(request.getParameter("name")); 
		String mobile_phone = CommonString.getFormatPara(request.getParameter("mobile_phone")); 
		String regDate=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
		String jsonPara=
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
	    "]";
	System.out.println("==================================================================https://api.cat-cn.com/api/clue/UserinfoClue?param="+jsonPara);
		
		String reMsg1 = post("https://api.cat-cn.com/api/clue/UserinfoClue?param="+jsonPara,"");
		//String reMsg1 = post("http://mall.21-sun.com/api/u/ecUserCenterCount.do?memberId=242","");
	    jsonObject1 = JSONObject.fromObject(reMsg1);
		out.println(jsonObject1);
%>

<%!
 public static String post(String url,String data){
        HttpURLConnection http = null;
        PrintWriter out = null;
        BufferedReader reader = null;
        try {
            //创建连接
            URL urlPost = new URL(url);
            http = (HttpURLConnection) urlPost
                    .openConnection();
            http.setDoOutput(true);
            http.setDoInput(true);
            http.setRequestMethod("POST");
            http.setUseCaches(false);
            http.setInstanceFollowRedirects(true);
            http.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded");

            http.connect();

            //POST请求
            OutputStreamWriter outWriter = new OutputStreamWriter(http.getOutputStream(), "utf-8");
            out = new PrintWriter(outWriter);
            out.print(data);
            out.flush();
            out.close();
            out = null;

            //读取响应
            reader = new BufferedReader(new InputStreamReader(
                    http.getInputStream()));
            String lines;
            StringBuffer sb = new StringBuffer("");
            while ((lines = reader.readLine()) != null) {
                lines = new String(lines.getBytes(), "utf-8");
                sb.append(lines);
            }
            reader.close();
            reader = null;
            System.out.println(sb.toString());
            return sb.toString();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }finally {
            if(null != http) http.disconnect();
            if(null != out) out.close();
            try{
                if(null != reader) reader.close();
            }catch (IOException e){
                e.printStackTrace();
            }
        }

    }
%>