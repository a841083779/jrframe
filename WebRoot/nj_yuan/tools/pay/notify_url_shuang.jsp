<%
/* *
 功能：支付宝服务器异步通知页面
 版本：3.3
 日期：2012-08-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
 该页面调试工具请使用写文本函数logResult，该函数在com.alipay.util文件夹的AlipayNotify.java类文件中
 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jerehnet.alipay.util.*"%>
<%@ page import="com.jerehnet.alipay.config.*"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonApplication"%>
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
	//String out_trade_no="261026133365701";
	//支付宝交易号
	String trade_no = CommonString.getFormatPara(request.getParameter("trade_no"));
	//交易状态
	String trade_status = CommonString.getFormatPara(request.getParameter("trade_status"));
	//公用回传参数，里面存放的mem_no
	String add_user = CommonString.getFormatPara(request.getParameter("extra_common_param"));
	String info = CommonString.getFormatPara(request.getParameter("extra_common_param"));
	String infos[]=info.split("_");
	String user_id=infos[0];
	String pro_id=infos[1];
	if(add_user.equals("")){
		add_user = "front";
	}
    System.out.println("1");
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	if(AlipayNotify.verify(params)){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码

		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		
		if(trade_status.equals("TRADE_FINISHED")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			//注意：
			//该种交易状态只在两种情况下出现
			//1、开通了普通即时到账，买家付款成功后。
			//2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
		} else if (trade_status.equals("TRADE_SUCCESS")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
				Connection conn = null;
	            DBHelper dbHelper = DBHelper.getInstance();
				try{
				    conn = dbHelper.getConnection();
					dbHelper.execute("update pro_shuang_user set is_pay=1,pay_date='"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"' where order_num='"+out_trade_no+"'", conn);
					
					Map proMap = dbHelper.getMap("  select id from pro_shuang_user_pro where user_id= "+user_id+" and pro_id= "+pro_id);
					Map userMap = dbHelper.getMap("  select phone from pro_shuang_user where order_num= "+out_trade_no+"");

					if(proMap==null){
					    Random random =new Random(); 
				        String no=String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10))+String.valueOf(random.nextInt(10));
			            dbHelper.execute("insert into pro_shuang_user_pro (user_id,pro_id,buy_no) values ("+user_id+","+pro_id+",'"+no+"') ");
						try {
			                Map root = new HashMap() ;
				            root.put("phone",CommonString.getFormatPara(userMap.get("phone"))) ;
				            root.put("content","用户您好，谢谢您的参与。您的活动礼包凭证号码为"+no+"，请在购机时出示本凭证给销售方以获得优惠") ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
					}

				}catch(Exception e){
		               e.printStackTrace();
		               out.println("fail");
	           }finally{
		           DBHelper.freeConnection(conn);
	           }
			//注意：
			//该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
		}else{
			
		}

		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			
		out.println("success");	//请不要修改或删除

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{//验证失败
		out.println("fail");
	}
%>
