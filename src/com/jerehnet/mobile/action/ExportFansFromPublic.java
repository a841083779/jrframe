package com.jerehnet.mobile.action;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.*;

import org.apache.http.*;

import com.jerehnet.util.dbutil.DBHelper;
import com.jerehnet.util.common.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.*;


public class ExportFansFromPublic {  
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();
    public void getUserList(String sub_token, String next_openid) throws Exception { 
    	
        Map token=null;String accesstoken="";
        try{
        	token = dbHelper.getMap("select access_token,update_time from weixin_access_token where id=2") ;
        	if(token!=null){
        		accesstoken=CommonString.getFormatPara(token.get("access_token"));
				sub_token=accesstoken;
        	}
        }catch(Exception e){
        	e.printStackTrace();
        }

		
		String returnData=Common.doGet("https://api.weixin.qq.com/cgi-bin/user/get?access_token="+accesstoken+"&next_openid="+next_openid);
        JSONObject json=JSONObject.fromObject(returnData); 
        //System.out.println("json:"+json);
        next_openid= json.get("next_openid").toString();
        System.out.println("next_openid:"+next_openid);
        JSONObject jo = (JSONObject)json.get("data");
        //System.out.println("jo:"+jo);
        JSONArray jsonArray = JSONArray.fromObject(jo.getString("openid"));
        //System.out.println(jsonArray.size());
        for (int i = 0; i < jsonArray.size(); i++) {
            String openId = (String) jsonArray.get(i);
            dbHelper.execute("insert into vx_fans (open_id) values (?)",new Object[]{openId});
        }
        

    }
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
	    
	public String sendWxMsg(String tempId){
		Map token=null;String accesstoken="";
		List<Map> fansList=null;
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonObject1 =null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime=dateFormat.format(new Date());
	    try{
	    	fansList=dbHelper.getMapList(" select top 500 id,open_id from vx_fans where is_push=0  order by NEWID() ");//is_push =0
	    	token = dbHelper.getMap("select access_token,update_time from weixin_access_token where id=2") ;
	    	if(token!=null){
	    		accesstoken=CommonString.getFormatPara(token.get("access_token"));
	    	}
	    	if(fansList!=null&&fansList.size()>0){
	    		for(Map m:fansList){
					String id=CommonString.getFormatPara(m.get("id"));
	    			String openId=CommonString.getFormatPara(m.get("open_id"));
	    			//消息推送
	    			String jsonData = "{" +
		            "\"touser\":\""+openId+"\"," +//    o9hmcuJcYW1OiInZJmW0aDfBCiVg
		            "\"template_id\":\""+tempId+"\"," +
		            "\"url\":\"https://www.wenjuan.com/s/3M7Bjqg\","+
		            "\"topcolor\":\"#FF0000\"," +
		            "\"data\":{" +
		            "\"first\":{\"value\":\"铁臂约惠团2019北京展报名领福利啦！！\"}," +
		            "\"keynote1\":{\"value\":\"智能手表、现金补贴......参团领福利确定不想要吗？\"}," +
		            "\"keynote2\":{\"value\":\"2019年9月4日-7日\"}," +
		            "\"keynote3\":{\"value\":\"中国（北京）国际展览中心新馆\"}," +
		            "\"remark\":{\"value\":\"铁臂约惠团名额仅剩18个！！一定不要错过！！\"}}}";
				    System.out.println(jsonData);
				    String reMsg1 = post("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+accesstoken,jsonData);
				    jsonObject1 = JSONObject.fromObject(reMsg1);
				    System.out.println("errorcode:"+jsonObject1.get("errcode"));
				    if(0 != (Integer) jsonObject1.get("errcode")) throw new RuntimeException("通知用户失败");
				    jsonObject.put("success","true");
				    //jsonObject.put("errcode", jsonObject1.get("errcode"));
			  	    jsonObject.put("msg","提醒成功");
					dbHelper.execute("update vx_fans set is_push=1 where id=? ",new Object[]{id});
					System.out.println(id+";");
	    		}
	    	}
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
	    return "";
	}
    

}  