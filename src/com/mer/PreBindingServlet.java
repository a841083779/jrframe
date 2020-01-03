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
import com.czbank.netpay.api.KeyStoreUtil;

public class PreBindingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();

		String interfaceName = "CZB_CYT_PRA_BINDING";
		String interfaceVersion = "1_0";
		String merID = APIConstance.merchantId;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		String nowtime = sdf.format(new Date());
		String bussinessTime = nowtime;
		String bussinessnum = "CYT_BATCH_PAY_"+System.currentTimeMillis();
		String corCertType = request.getParameter("corCertType");
		String corCertNum =  request.getParameter("corCertNum");
		String corName =  "20140416测试环境营业执照";//request.getParameter("corName");
		String merOperName =  "我是经办员啊";//request.getParameter("merOperName");
		String merOperMobile =  request.getParameter("merOperMobile");
		String busType = "01";
		String busNum = "CYTW"+System.currentTimeMillis();
		String oriMsg = interfaceName + interfaceVersion  + bussinessTime
				+ bussinessnum + merID + corCertType + corCertNum + corName + merOperName + merOperMobile
				+ busType + busNum;
				
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

				"&corCertType="+ URLEncoder.encode(URLEncoder.encode(corCertType, "gbk"), "gbk")
				+

				"&corCertNum="+ URLEncoder.encode(URLEncoder.encode(corCertNum, "gbk"), "gbk")
				+

				"&corName="+ URLEncoder.encode(URLEncoder.encode(corName, "gbk"), "gbk")
				+

				"&merOperName="+ URLEncoder.encode(URLEncoder.encode(merOperName, "gbk"),
						"gbk")
				+
				
				"&merOperMobile="+ URLEncoder.encode(URLEncoder.encode(merOperMobile, "gbk"),
						"gbk")
				+
				"&busType="+ URLEncoder.encode(URLEncoder.encode(busType, "gbk"),
						"gbk")
				+
				"&busNum="+ URLEncoder.encode(URLEncoder.encode(busNum, "gbk"),
						"gbk")
				+

				"&signmsg="+ URLEncoder.encode(URLEncoder.encode(signedData, "gbk"), "gbk");

		String responseToken = api.executeForDemo(body, serverurl);

		System.out.println("返回报文" + responseToken);

		JSONArray arr = JSONArray.fromObject("[" + responseToken + "]");
		String token = new String();	String errno = new String();	String errmsg = new String();
		if (arr.size() > 0) {
			token = arr.getJSONObject(0).get("token").toString();
			errno = arr.getJSONObject(0).get("errno").toString();
			errmsg = arr.getJSONObject(0).get("errmsg").toString();
		}


		request.setAttribute("errno", errno);
		request.setAttribute("errmsg", errmsg);
		request.setAttribute("token", token);
		
		request.getRequestDispatcher("/prebindingResult.jsp").forward(request,response);
	}
}
