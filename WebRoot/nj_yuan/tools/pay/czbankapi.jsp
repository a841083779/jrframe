<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@ page language="java" import="com.jerehnet.alipay.config.*,com.jerehnet.alipay.util.*,java.util.*,com.jerehnet.util.dbutil.DBHelper,java.sql.Connection,com.jerehnet.util.common.CommonString" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购销通接口-跳转</title>
	</head>
	<%
		////////////////////////////////////请求参数//////////////////////////////////////
		String domain = request.getScheme() + "://" + request.getServerName();
		domain += request.getServerPort() != 80 ? ":" + request.getServerPort() : "";
		
		String order_num = CommonString.getFormatPara(request.getParameter("order_num"));
		String pay_mode = CommonString.getFormatPara(request.getParameter("pay_mode"));
		String pay_gateway_no = CommonString.getFormatPara(request.getParameter("pay_gateway_no"));
		
		Connection conn = null;
		DBHelper helper = DBHelper.getInstance();
		try{
			conn = helper.getConnection();
			//String updatePayMode = "update pro_online_order set pay_mode=?,pay_gateway_no=? where order_no=?";
			//Object[] paras = { pay_mode, pay_gateway_no, order_num };
			//helper.execute(updatePayMode, paras, conn);
			
			String orderQuery = "select * from pro_online_order where order_no='" + order_num + "'";
			Map orderMap = helper.getMap(orderQuery, conn);
			if(orderMap != null){
				//////////////////////////////////////////////////////////////////////////////////
				//订单时间
				String orderTime = CommonDate.getToday("yyyyMMddhhmmss");
				
				//订单编号
				String orderId = order_num;
				
				//订单类型
				String orderType = "01";
				
				//币种
				String currency = "01";
				
				//订单金额
				String amount = CommonString.getFormatPara(orderMap.get("price"));
				
				//是否返回新页面标志
				String pageUrlFlag = "1";
				
				//默认页面返回URL(非必填)
				String pageUrl = domain + "/SubReply.srv";
				
				//结果发送类型
				String resultType = "0";
				
				//通知结果URL(非必填)
				String merUrl = domain + "/SubReply.srv";
				
				//自动跳转时间
				String jumpSeconds = "20";
				
				//买方用户客户号(非必填)
				String payMerUserId = "0";
				
				//卖方用户客户号(非必填)
				String saleMerUserId = "0";
				
				//买方订金金额(非必填)
				String buyPrepaid = "0";
				
				//卖方订金金额(非必填)
				String salePrepaid = "0";
				
				//运费(非必填)
				String freight = "0";
				
				//分期付款期数
				String multiPayNum = "1";
				
				//分期付款每期金额
				String multiPayAmts = amount;
				
				//收货方式(非必填)
				String takeGoodsMethod = "0";
				
				//收货地址(非必填)
				String takeGoodsAddress = "0";
				
				//商户签名
				String signMsg = "1234";
				
				//不同商品的个数
				String orderNum = "1";
				//商品编号(多个用|分割 )下同
				String goodsId = "0";
				
				//商品名称
				String goodsName = "铁臂商城商品";
				
				//商品数量
				String goodsNum = "0";
				
				//商品单价
				String goodsPrice = amount;
				
				//商品运费金额
				String goodsFee = "0";
				
				//备注
				String remark = "1234";
				
				/*订单商品*/
				
				//////////////////////////////////////////////////////////////////////////////////
				
				//把请求参数组成form表单
		        StringBuffer sbHtml = new StringBuffer();
		
		        sbHtml.append("<form id=\"czbanksubmit\" name=\"czbanksubmit\" action=\"/getorder\" style=\"display:none;\" method=\"post\">");
		        //sbHtml.append("<form id=\"czbanksubmit\" name=\"czbanksubmit\" action=\"/ord\" style=\"display:none;\" method=\"post\">");
				/*传递参数*/
		        sbHtml.append("<input type=\"text\" name=\"orderTime\" value=\""+ orderTime +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"orderId\" value=\""+ orderId +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"orderType\" value=\""+ orderType +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"currency\" value=\""+ currency +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"amount\" value=\""+ amount +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"pageUrlFlag\" value=\""+ pageUrlFlag +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"pageUrl\" value=\""+ pageUrl +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"resultType\" value=\""+ resultType +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"merUrl\" value=\""+ merUrl +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"jumpSeconds\" value=\""+ jumpSeconds +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"payMerUserId\" value=\""+ payMerUserId +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"saleMerUserId\" value=\""+ saleMerUserId +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"buyPrepaid\" value=\""+ buyPrepaid +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"salePrepaid\" value=\""+ salePrepaid +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"freight\" value=\""+ freight +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"multiPayNum\" value=\""+ multiPayNum +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"multiPayAmts\" value=\""+ multiPayAmts +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"takeGoodsMethod\" value=\""+ takeGoodsMethod +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"takeGoodsAddress\" value=\""+ takeGoodsAddress +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"signMsg\" value=\""+ signMsg +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"orderNum\" value=\""+ orderNum +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"goodsId\" value=\""+ goodsId +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"goodsName\" value=\""+ goodsName +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"goodsNum\" value=\""+ goodsNum +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"goodsPrice\" value=\""+ goodsPrice +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"goodsFee\" value=\""+ goodsFee +"\" />");
		        sbHtml.append("<input type=\"text\" name=\"remark\" value=\""+ remark +"\" />");
		        /*传递参数*/
		        sbHtml.append("<input type=\"submit\" value=\"确认\" style=\"display:none;\"></form>");
		        sbHtml.append("<script>document.forms['czbanksubmit'].submit();</script>");
		        
				String sHtmlText = sbHtml.toString();
				out.println(sHtmlText);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBHelper.freeConnection(conn);
		}
	%>
	<body>
	</body>
</html>