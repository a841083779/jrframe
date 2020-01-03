package com.mer;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.czbank.netpay.api.APIConstance;
import com.czbank.netpay.api.APITransaction;
import com.czbank.netpay.api.ApiException;
import com.czbank.netpay.api.B2COPReply;
import com.czbank.netpay.api.CzbankB2BBean;
import com.czbank.netpay.api.KeyStoreUtil;
import com.czbank.netpay.api.OpResult;
import com.czbank.netpay.api.OpResultSet;

public class SearchOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String pageindex=request.getParameter("pageindex"); 	//页数索引
		String begDate 	= request.getParameter("begDate"); 	//开始时间[yyyyMMddHHmmss]
		String endDate = request.getParameter("endDate"); 	//结束时间[yyyyMMddHHmmss]
		String flag = request.getParameter("flag"); 			//订单状态 0 所有 1 已支付 2 已撤销 3 部分退货 4退货处理中 5 全部退货 
		String merID = request.getParameter("merID");		//商户编号
		String orderid = request.getParameter("orderid"); 	//订单号，可为NULL
		
		String code;
		String msg ;
		
		ServletOutputStream out = response.getOutputStream();
		
		APITransaction client = new APITransaction();
		//String xml=client.QueryOrderXML(merID,begDate,endDate,orderid,flag,pageindex);
		//System.out.println(xml);
		//B2COPReply rep = client.QueryOrderRes(merID,begDate,endDate,orderid,flag,pageindex);
		//B2COPReply rep = client.Refund(merID,"001",orderid,"20090601","0.07");
		
		String interfaceName = "CZB_B2B_ORDER_QUERY";
		String interfaceVersion = "1_0";
		
		String oriMsg = interfaceName+interfaceVersion+merID+orderid;
		
		String serverurl = APIConstance.serverOrderQueryUrl;
		String signedData = KeyStoreUtil.signData(oriMsg);

		APITransaction api = new APITransaction();
		try {
			api.initialize("/sun21/webpro/sun21_03/21sun_product_2012_test/WEB-INF/classes/MerchantConfig.xml");
			//api.initialize("D:/workpace/21sun_product_2012_test/WEB-INF/classes/MerchantConfig.xml");
			//api.initialize("D:/workpace/jrframe/WebRoot/WEB-INF/classes/MerchantConfig.xml");
		} catch (ApiException e) {
			e.printStackTrace();
		}
		String body = "interfaceName="
				+ URLEncoder.encode(URLEncoder.encode(interfaceName, "gbk"),
						"gbk")
				+

				"&interfaceVersion="+ URLEncoder.encode(URLEncoder.encode(interfaceVersion, "gbk"),"gbk")
				+

				"&merId="+ URLEncoder.encode(URLEncoder.encode(merID, "gbk"), "gbk")
				+

				"&orderId="+ URLEncoder.encode(URLEncoder.encode(orderid, "gbk"), "gbk")
				+
				
				"&signMsg="+URLEncoder.encode(URLEncoder.encode(signedData, "gbk"), "gbk");

		String responseToken = api.executeForDemo(body, serverurl);

		System.out.println("返回报文" + responseToken);
		
		JSONArray arr = JSONArray.fromObject("[" + responseToken + "]");
		String orderstatus = new String();
		if (arr.size() > 0) {
			orderstatus = arr.getJSONObject(0).get("orderstatus").toString();
		}

		System.out.println("状态：" + orderstatus);
		out.print("orderstatus ："+orderstatus);
		//request.getRequestDispatcher("/order.jsp").forward(request,response);
	}
}
