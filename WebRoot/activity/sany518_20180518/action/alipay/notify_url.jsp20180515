<%@page import="com.alipay.api.internal.util.AlipaySignature"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.jerehnet.alipay.config.*"%>
<%@ page import="com.alipay.api.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,com.jerehnet.util.freemarker.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper"%>
<%
	//获取支付宝POST过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
		params.put(name, valueStr);
	}
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	
	//商户订单号

		String out_trade_no = CommonString.getFormatPara(request.getParameter("out_trade_no"));
		
		String total_amount = CommonString.getFormatPara(request.getParameter("total_amount"));
		//支付宝交易号

		String trade_no = CommonString.getFormatPara(request.getParameter("trade_no"));

		//交易状态
		String trade_status = CommonString.getFormatPara(request.getParameter("trade_status"));
		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		//计算得出通知验证结果
		//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
		//boolean verify_result = AlipaySignature.rsaCheckV1(params, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.CHARSET, "RSA2");

		
		//if(verify_result){//验证成功
			//////////////////////////////////////////////////////////////////////////////////////////
			//请在这里加上商户的业务逻辑程序代码
			
			

			//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
			if(trade_status.equals("TRADE_FINISHED")||trade_status.equals("TRADE_SUCCESS")){
				Connection conn = null;
	            DBHelper dbHelper = DBHelper.getInstance();
	            String createTime = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
				try{
				    conn = dbHelper.getConnection();
					
					Map m=dbHelper.getMap(" select top 1 * from activity_sany_pay where order_no='"+out_trade_no+"' or order_no2='"+out_trade_no+"'  ",conn);
					if(m!=null){
						if(CommonString.getFormatInt(CommonString.getFormatPara(m.get("order_state"))) == 0){//缴纳预付款
							dbHelper.execute("update activity_sany_pay set order_state=1 where order_no='"+out_trade_no+"' and order_state=0 ", conn);
						}else if(CommonString.getFormatInt(CommonString.getFormatPara(m.get("order_state"))) == 1){//定金
							dbHelper.execute("update activity_sany_pay set order_state=2 where order_no2='"+out_trade_no+"' and order_state=1 ", conn);
						}
						dbHelper.execute("insert into activity_sany_pay_log (parent_id,source,add_date,product_name,price,order_state,open_id) "
								+" values ("+CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")))+",'zfb',getDate(),'"+CommonString.getFormatPara(m.get("product_name"))+"',"+total_amount+",1,'"+CommonString.getFormatPara(m.get("open_id"))+"') ");
					}
					  
				}catch(Exception e){
		               e.printStackTrace();
		               out.println("fail");
	           }finally{
		           DBHelper.freeConnection(conn);
	           }
			}

			//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			out.clear();
			out.println("success");	//请不要修改或删除
			

			//////////////////////////////////////////////////////////////////////////////////////////
		//}else{//验证失败
		//	out.println("fail");
		//}
%>
