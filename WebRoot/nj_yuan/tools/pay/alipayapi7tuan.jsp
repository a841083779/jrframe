<%
/* *
 *功能：即时到账交易接口接入页
 *版本：3.3
 *日期：2012-08-14
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 *************************注意*****************
 *如果您在接口集成过程中遇到问题，可以按照下面的途径来解决
 *1、商户服务中心（https://b.alipay.com/support/helperApply.htm?action=consultationApply），提交申请集成协助，我们会有专业的技术工程师主动联系您协助解决
 *2、商户帮助中心（http://help.alipay.com/support/232511-16307/0-16307.htm?sh=Y&info_type=9）
 *3、支付宝论坛（http://club.alipay.com/read-htm-tid-8681712.html）
 *如果不想使用扩展功能请把扩展功能参数赋空值。
 **********************************************
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jerehnet.alipay.config.*,com.jerehnet.alipay.config.AlipayConfig"%>
<%@ page import="com.jerehnet.alipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝即时到账交易</title>
	</head>
	<%
		////////////////////////////////////请求参数//////////////////////////////////////
		String order_num = CommonString.getFormatPara(request.getParameter("order_num"));
		String pay_mode = CommonString.getFormatPara(request.getParameter("pay_mode"));
		String pay_gateway_no = CommonString.getFormatPara(request.getParameter("pay_gateway_no"));
 
	    DBHelper dbHelper = DBHelper.getInstance() ;
	    Map orderMap = dbHelper.getMap("select price from pro_online_order where order_no="+order_num);
	
		//支付类型
		String payment_type = "1";
		//必填，不能修改
		//服务器异步通知页面路径
		String notify_url = "http://product.21-sun.com/tools/pay/notify_url.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数

		//页面跳转同步通知页面路径
		String return_url = "http://product.21-sun.com/member/order_success_7tuan.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

		//卖家支付宝帐户
		String seller_email = AlipayConfig.account;
		//必填

		//商户订单号
		String out_trade_no = order_num;
		//商户网站订单系统中唯一订单号，必填

		//订单名称
		String subject ="7月优买团活动"+order_num;
		//必填

		//付款金额
		String total_fee = "499";
		//必填

		//客户端的IP地址
		String exter_invoke_ip = Common.getIp(request);
		//非局域网的外网IP地址，如：221.0.0.1
		
		//公用回传参数
		//String extra_common_param = CommonString.getFormatPara(order_num);
		String extra_common_param = "";
		//////////////////////////////////////////////////////////////////////////////////
		
		//把请求参数打包成数组
				Map<String, String> sParaTemp = new HashMap<String, String>();
				sParaTemp.put("service", "create_direct_pay_by_user");
		        sParaTemp.put("partner", AlipayConfig.partner);
		        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
				sParaTemp.put("payment_type", payment_type);
				sParaTemp.put("notify_url", notify_url);
				sParaTemp.put("return_url", return_url);
				sParaTemp.put("seller_email", seller_email);
				sParaTemp.put("out_trade_no", out_trade_no);
				sParaTemp.put("subject", subject);
				sParaTemp.put("total_fee", total_fee);
				sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
				sParaTemp.put("extra_common_param", extra_common_param);
				
				//建立请求
				String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
				out.println(sHtmlText);
	%>
	<body>
	</body>
</html>
