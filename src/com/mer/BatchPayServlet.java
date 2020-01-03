package com.mer;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.czbank.netpay.api.APIConstance;
import com.czbank.netpay.api.APITransaction;
import com.czbank.netpay.api.ApiException;
import com.czbank.netpay.api.CzbankB2BBean;
import com.czbank.netpay.api.KeyStoreUtil;

public class BatchPayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();

		String interfaceName = "CZB_CYT_BATCH_PAY";
		String interfaceVersion = "1_0";
		String merID = APIConstance.merchantId;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		String nowtime = sdf.format(new Date());
		String bussinessTime = nowtime;
		String bussinessnum = "CYT_BATCH_PAY_"+System.currentTimeMillis();
		String payNumber = "3";
		String paybatchNum = "CYTB"+System.currentTimeMillis();
		String payBusTypeNum = "01";
		String withholdAgreeNo = "CYTW1406619765359";
		String corCertType = "2";
		String corCertNum = "20140416";
		String corName = "20140416测试环境营业执照";
		String withholdMoney1 = "50.21";
		String withholdMoney2 = "100.24";
		String withholdMoney3 = "152.32";
		String withholdReason1 = "我是定金";
		String withholdReason2 = "我是运费";
		String withholdReason3 = "我是订单金额";
		
		String data1 = paybatchNum+"|"+ payBusTypeNum+"|"+ withholdAgreeNo+"|"+ corCertType+"|"+ corCertNum+"|"+ corName+"|"+ withholdMoney1+"|"+ withholdReason1;//第一条数据
		String data2 = paybatchNum+"|"+ payBusTypeNum+"|"+ withholdAgreeNo+"|"+ corCertType+"|"+ corCertNum+"|"+ corName+"|"+ withholdMoney2+"|"+ withholdReason2;//第二条数据
		String data3 = paybatchNum+"|"+ payBusTypeNum+"|"+ withholdAgreeNo+"|"+ corCertType+"|"+ corCertNum+"|"+ corName+"|"+ withholdMoney3+"|"+ withholdReason3;//第三条数据
		String oriMsg = interfaceName + interfaceVersion +bussinessTime + bussinessnum + merID + payNumber+ 
			paybatchNum+ payBusTypeNum + withholdAgreeNo + corCertType + corCertNum + corName + withholdMoney1 + withholdReason1+ 
			paybatchNum+ payBusTypeNum + withholdAgreeNo + corCertType + corCertNum + corName + withholdMoney2 + withholdReason2+ 
			paybatchNum+ payBusTypeNum + withholdAgreeNo + corCertType + corCertNum + corName + withholdMoney3 + withholdReason3;
		String serverurl = "http://10.0.33.177:8080/B2BPAY/cytServlet";
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

				"&bussinessTime="+ URLEncoder.encode(URLEncoder.encode(bussinessTime, "gbk"), "gbk")
				+

				"&bussinessnum="+ URLEncoder.encode(URLEncoder.encode(bussinessnum, "gbk"), "gbk")
				+

				"&payNumber="+ URLEncoder.encode(URLEncoder.encode(payNumber, "gbk"), "gbk")
				+

				"&data="+ URLEncoder.encode(URLEncoder.encode(data1, "gbk"), "gbk")
				+

				"&data="+ URLEncoder.encode(URLEncoder.encode(data2, "gbk"), "gbk")
				+

				"&data="+ URLEncoder.encode(URLEncoder.encode(data3, "gbk"),
						"gbk")
				+

				"&signmsg="+ URLEncoder.encode(URLEncoder.encode(signedData, "gbk"), "gbk");

		String responseToken = api.executeForDemo(body, serverurl);

		System.out.println("返回报文" + responseToken);

		JSONArray arr = JSONArray.fromObject("[" + responseToken + "]");
		String token = new String();
		if (arr.size() > 0) {
			token = arr.getJSONObject(0).get("token").toString();
		}
 
		request.setAttribute("token", token);
		
		request.getRequestDispatcher("/order.jsp").forward(request,response);
	}
}
