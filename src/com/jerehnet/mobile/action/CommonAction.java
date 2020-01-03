package com.jerehnet.mobile.action;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;

import net.sf.json.*;

import javax.servlet.http.*;

import com.jerehnet.util.common.*;
import com.jerehnet.util.dbutil.DBHelper;

public class CommonAction  extends HttpServlet{
	
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();
	
	public void isBindingWX(HttpServletRequest request,HttpServletResponse response){
		int uid=0;
		Map factory=null,agent=null,personnel=null;
		HttpSession session = request.getSession();
		String  openId = CommonString.getFormatPara(session.getAttribute("wx_id"));
		try{
			factory=dbHelper.getMap(" select id from pro_agent_factory where flag=1 and open_id=?  ",new Object[]{openId});
			if(factory!=null){//厂商
				uid=CommonString.getFormatInt(CommonString.getFormatPara(factory.get("id")));
				response.sendRedirect("/weixin/factory/order_unfinished.jsp?id="+uid);
			}
			agent=dbHelper.getMap(" select id from pro_agent_factory where flag=2 and open_id=?  ",new Object[]{openId});
			if(agent!=null){//代理商
				uid=CommonString.getFormatInt(CommonString.getFormatPara(agent.get("id")));
				response.sendRedirect("/weixin/agent/order_unfinished.jsp?id="+uid);
			}
			personnel=dbHelper.getMap(" select id from pro_agent_personnel where  open_id=?  ",new Object[]{openId});
			if(personnel!=null){//业务员
				uid=CommonString.getFormatInt(CommonString.getFormatPara(personnel.get("id")));
				response.sendRedirect("/weixin/personnel/order_unfinished.jsp?id="+uid);
			}
			if(uid==0){//没绑定openID
				response.sendRedirect("/weixin/bindingWX.jsp?openId="+openId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 获取一个小时以后的时间
	 */
	public String getTime(String updateTime){
		Calendar c=Calendar.getInstance();
		c.add(Calendar.MINUTE,60);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			Date date =sdf.parse(updateTime);
			c.setTime(date);
			c.add(Calendar.HOUR_OF_DAY, 1);
		}catch(Exception e){
			e.printStackTrace();
			
		}
		return sdf.format(c.getTime());
	}
	
	/**
	 * 两时间比较 date1大于date2 return true
	 * @param DATE1
	 * @param DATE2
	 * @return
	 */
	public static boolean compareDate(String DATE1, String DATE2) {
        
        
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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
	/**
	 * 获取access_token
	 * @return
	 */  
	public String getAccessToken() {
		String appid = "wx1970a95c4c76db38";
	    String appsecret = "cb73118454e648d30d476a5b3ac13c09"; 
	    String appId=appid;  
	    String appSecret=appsecret;  

	    try{
	    	String returnData=Common.doGet("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appId+"&secret="+appSecret);  
		    JSONObject json=JSONObject.fromObject(returnData);  
		    if(json.containsKey("access_token")){  
		        if(json.get("access_token")!=null&&!json.get("access_token").equals("")){  
		            return json.get("access_token").toString();  
		        }  
		    }
		    return null;  
	    }catch(Exception e){
	    	e.printStackTrace();
	    	return null;
	    }  
	    
	}
	/**
	 * 消息推送
	 * @return
	 */
	public String sendWxMsg(int formId,String tempId){
		
		JSONObject jsonObject = new JSONObject();
		String sql=" select access_token,update_time from weixin_access_token where id=2 ";
		String sql_order=" select contact_address,factory_name,product_name,cata_name,person_id,user_name from pro_agent_products_form where id=? ";
		String accessToken="";String updateTime="";
		String address="";String title="";int personId=0;String userName="";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime=dateFormat.format(new Date());
		Map token=null;Map order=null;
		JSONObject jsonObject1 =null;
		try{
			order=dbHelper.getMap(sql_order,new Object[]{formId});
			if(order!=null){
				address=CommonString.getFormatPara(order.get("contact_address"));
				userName=CommonString.getFormatPara(order.get("user_name"));
				title=CommonString.getFormatPara(order.get("factory_name"))+CommonString.getFormatPara(order.get("product_name"))+CommonString.getFormatPara(order.get("cata_name"));
				personId=CommonString.getFormatInt(CommonString.getFormatPara(order.get("person_id")));
				if(personId!=0){
					Map personnel=dbHelper.getMap(" select open_id from  pro_agent_personnel where id=? ",new Object[]{personId});
					if(personnel!=null){
						if(!"".equals(CommonString.getFormatPara(personnel.get("open_id")))){//业务员绑定了微信
							//获取access_token
							token = dbHelper.getMap(sql,new Object[]{}) ;
							if(token!=null){
								updateTime=CommonString.getFormatPara(token.get("update_time"));
								accessToken=CommonString.getFormatPara(token.get("access_token"));

								if(!compareDate(getTime(updateTime),nowTime)){//超过设定的access_token的有效期，重新生成access_token
									accessToken=getAccessToken();
									dbHelper.execute("update weixin_access_token set access_token =?,update_time=GETDATE()  where id=2 ",new Object[]{accessToken});
								}
							}

							//推送模板消息
							String openId=CommonString.getFormatPara(personnel.get("open_id"));//"o8JXQ1L-s75IE1OD5WWLC9ZnshjE"
						    String jsonData = "{" +
						            "\"touser\":\""+openId+"\"," +//    o9hmcuJcYW1OiInZJmW0aDfBCiVg
						            "\"template_id\":\""+tempId+"\"," +
						            "\"url\":\"http://product.21-sun.com/weixin/personnel/order_unfinished.jsp?id="+CommonString.getFormatPara(order.get("person_id"))+"\","+
						            "\"topcolor\":\"#FF0000\"," +
						            "\"data\":{" +
						            "\"first\":{\"value\":\"【铁臂订单宝】您有一条新的订单消息提醒：\"}," +
						            "\"tradeDateTime\":{\"value\":\""+nowTime+"\",\"color\":\"#173177\"},"+
						            "\"orderType\":{\"value\":\"询价信息\",\"color\":\"#173177\"},"+
						            "\"customerInfo\":{\"value\":\""+userName+"【"+address+"】\",\"color\":\"#173177\"}," +
						            "\"orderItemName\":{\"value\":\"询价产品\"}," +
						            "\"orderItemData\":{\"value\":\""+title+"\",\"color\":\"#173177\"}," +
						            "\"remark\":{\"value\":\"感谢使用铁臂订单宝！\"}}}";
						    System.out.println(jsonData);
						    String reMsg1 = post("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+accessToken,jsonData);
						    jsonObject1 = JSONObject.fromObject(reMsg1);
						    System.out.println("errorcode:"+jsonObject1.get("errcode"));
						    if(0 != (Integer) jsonObject1.get("errcode")) throw new RuntimeException("通知用户失败");
						    jsonObject.put("success","true");
						    //jsonObject.put("errcode", jsonObject1.get("errcode"));
					  	    jsonObject.put("msg","提醒成功"); 
						}else{//返回 未找到接收订单的业务员
							jsonObject.put("success","true");
							//jsonObject.put("errcode", jsonObject1.get("errcode"));
					  	    jsonObject.put("msg","未找到接收订单的业务员!"); 
						}
					}else{
						jsonObject.put("success","true");
						//jsonObject.put("errcode", jsonObject1.get("errcode"));
				  	    jsonObject.put("msg","未找到接收订单的业务员!");
					}
				}else{
					jsonObject.put("success","true");
					//jsonObject.put("errcode", jsonObject1.get("errcode"));
			  	    jsonObject.put("msg","未找到接收订单的业务员!"); 
				}
			}else{
				jsonObject.put("success","true");
				//jsonObject.put("errcode", jsonObject1.get("errcode"));
	      	  	jsonObject.put("msg","提醒失败"); 
			}
			
			

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			//jsonObject.put("errcode", jsonObject1.get("errcode"));
      	  	jsonObject.put("msg","提醒失败");          
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	public void outParam(String a,int id){
		
		String StrData=a;
		JSONArray backBodyJson = JSONArray.fromObject(StrData ); // 首先把字符串转成 JSONArray 对象
		if(backBodyJson.size()>0){
			int keyId=265080;
			for(int i=0;i<backBodyJson.size();i++){
				JSONObject job = backBodyJson.getJSONObject(i); // 遍历 jsonarray 数组，把每一个对象转成 json 对象 
				if(!"".equals(job.get("value"))){
					keyId++;
					System.out.println("INSERT INTO ec_goods_param_value (PARAM_VALUE_ID, PARAM_ID, PARAM_VALUE, GOODS_ID, temp_param_name) VALUES ("+keyId+",'"+job.get("no")+"', '"+job.get("value")+"', '"+id+"', '"+job.get("name")+":');");
					System.out.println("");
				}

			}
		}
	}

	

}

