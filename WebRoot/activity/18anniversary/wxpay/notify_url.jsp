<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.pay.wxpay.common.Util"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Connection"%>

<%
    
         String out_trade_no=null;
        String return_code =null;
        try {
            InputStream inStream = request.getInputStream();
            ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = inStream.read(buffer)) != -1) {
                outSteam.write(buffer, 0, len);
            }
            outSteam.close();
            inStream.close();
            String resultStr  = new String(outSteam.toByteArray(),"utf-8");
            Map<String, Object> resultMap = Util.parseXmlToList(resultStr);
            String result_code = (String) resultMap.get("result_code");
            String is_subscribe = (String) resultMap.get("is_subscribe");
            String transaction_id = (String) resultMap.get("transaction_id");
            String sign = (String) resultMap.get("sign");
            String time_end = (String) resultMap.get("time_end");
            String bank_type = (String) resultMap.get("bank_type");

            out_trade_no = (String) resultMap.get("out_trade_no");
            return_code = (String) resultMap.get("return_code");

            request.setAttribute("out_trade_no", out_trade_no);
            //通知微信.异步确认成功.必写.不然微信会一直通知后台.八次之后就认为交易失败了.
            //response.getWriter().write(RequestHandler.setXML("SUCCESS", ""));
        }  catch (Exception e) {
            //暂时注销
//            try {
//                response.getWriter().write(RequestHandler.setXML("FAIL", "error"));
//            } catch (IOException e1) {
//                e1.printStackTrace();
//            }
        }
        if(return_code.equals("SUCCESS")){
			System.out.println("---------------success");
            //支付成功的业务逻辑
			
			   Connection conn = null;
	            DBHelper dbHelper = DBHelper.getInstance();
	            String createTime = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
				try{
				    conn = dbHelper.getConnection();
					Map m=dbHelper.getMap(" select * from anniversary18_wxpay_log where order_no='"+out_trade_no+"' ",conn);
					if(m!=null){
						dbHelper.execute("update anniversary18_wxpay_log set order_state=1,pay_time=getDate() where order_no='"+out_trade_no+"' ", conn);
						dbHelper.execute("update anniversary18_ad set ad_state=1 where id =(select ad_id from anniversary18_wxpay_log where order_no='"+out_trade_no+"' ) ", conn);
					}
					  
				}catch(Exception e){
		               e.printStackTrace();
		               out.println("fail");
	           }finally{
		           DBHelper.freeConnection(conn);
	           }
			
			
        }else{
            //支付失败的业务逻辑
			System.out.println("---------------fail");
        }
  
%>