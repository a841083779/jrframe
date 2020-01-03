package com.mer;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

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

public class GetOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		CzbankB2BBean cbb = new CzbankB2BBean();
		session.setAttribute("CzbankB2BBean", cbb);
		cbb.setOrderTime(request.getParameter("orderTime"));
		cbb.setOrderId(request.getParameter("orderId"));
		cbb.setOrderType(request.getParameter("orderType"));
		cbb.setCurrency(request.getParameter("currency"));
		cbb.setAmount(request.getParameter("amount"));
		cbb.setPageUrlFlag(request.getParameter("pageUrlFlag"));
		cbb.setPageUrl(request.getParameter("pageUrl"));
		cbb.setResultType(request.getParameter("resultType"));
		cbb.setMerUrl(request.getParameter("merUrl"));
		cbb.setJumpSeconds(request.getParameter("jumpSeconds"));
		cbb.setPayMerUserId(request.getParameter("payMerUserId"));
		cbb.setSaleMerUserId(request.getParameter("saleMerUserId"));
		cbb.setBuyPrepaid(request.getParameter("buyPrepaid"));
		cbb.setSalePrepaid(request.getParameter("salePrepaid"));
		cbb.setFreight(request.getParameter("freight"));
		cbb.setMultiPayNum(request.getParameter("multiPayNum"));
		cbb.setMultiPayAmts(request.getParameter("multiPayAmts"));
		cbb.setTakeGoodsMethod(request.getParameter("takeGoodsMethod"));
		cbb.setTakeGoodsAddress(request.getParameter("takeGoodsAddress"));
		cbb.setSignMsg(request.getParameter("signMsg"));
		cbb.setOrderNum(request.getParameter("orderNum"));
		cbb.setGoodsId(request.getParameter("goodsId"));
		cbb.setGoodsName(request.getParameter("goodsName"));
		cbb.setGoodsNum(request.getParameter("goodsNum"));
		cbb.setGoodsPrice(request.getParameter("goodsPrice"));
		cbb.setGoodsFee(request.getParameter("goodsFee"));
		cbb.setRemark(request.getParameter("remark"));
		
		String interfaceName = "CZB_B2B_GET_ORDER_TOKEN";
		String interfaceVersion = APIConstance.version;
		String merID = APIConstance.merchantId;
		String orderTime = cbb.getOrderTime();
		String orderId = cbb.getOrderId();
		String orderType = cbb.getOrderType();
		String currency = cbb.getCurrency();
		String amount = cbb.getAmount();
		String pageUrlFlag = cbb.getPageUrlFlag();
		String pageUrl = cbb.getPageUrl();
		String resultType = cbb.getResultType();
		String merUrl = cbb.getMerUrl();
		String jumpSeconds = cbb.getJumpSeconds();
		String payMerUserId = cbb.getPayMerUserId();
		String saleMerUserId = cbb.getSaleMerUserId();
		String buyPrepaid = cbb.getBuyPrepaid();
		String salePrepaid = cbb.getSalePrepaid();
		String freight = cbb.getFreight();
		String multiPayNum = cbb.getMultiPayNum();
		String multiPayAmts = cbb.getMultiPayAmts();
		String takeGoodsMethod = cbb.getTakeGoodsMethod();
		String takeGoodsAddress = cbb.getTakeGoodsAddress();
		String signMsg = cbb.getSignMsg();
		String orderNum = cbb.getOrderNum();
		String goodsId = cbb.getGoodsId();
		String goodsName = cbb.getGoodsName();
		String goodsNum = cbb.getGoodsNum();
		String goodsPrice = cbb.getGoodsPrice();
		String goodsFee = cbb.getGoodsFee();
		String remark = cbb.getRemark();
		
 
		String oriMsg = interfaceName + interfaceVersion + merID + orderTime
				+ orderId + orderType + currency + amount + pageUrlFlag
				+ pageUrl + resultType + merUrl + jumpSeconds + payMerUserId
				+ saleMerUserId + buyPrepaid + salePrepaid + freight
				+ multiPayNum + multiPayAmts + takeGoodsMethod
				+ takeGoodsAddress;
		String serverurl = APIConstance.serverURL;
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

				"&orderTime="+ URLEncoder.encode(URLEncoder.encode(orderTime, "gbk"), "gbk")
				+

				"&orderId="+ URLEncoder.encode(URLEncoder.encode(orderId, "gbk"), "gbk")
				+

				"&orderType="+ URLEncoder.encode(URLEncoder.encode(orderType, "gbk"), "gbk")
				+

				"&currency="+ URLEncoder.encode(URLEncoder.encode(currency, "gbk"), "gbk")
				+

				"&amount="+ URLEncoder.encode(URLEncoder.encode(amount, "gbk"), "gbk")
				+

				"&pageUrlFlag="+ URLEncoder.encode(URLEncoder.encode(pageUrlFlag, "gbk"),
						"gbk")
				+

				"&pageUrl="+ URLEncoder.encode(URLEncoder.encode(pageUrl, "gbk"), "gbk")
				+

				"&resultType="+ URLEncoder.encode(URLEncoder.encode(resultType, "gbk"), "gbk")
				+

				"&merUrl="+ URLEncoder.encode(URLEncoder.encode(merUrl, "gbk"), "gbk")
				+

				"&jumpSeconds="+ URLEncoder.encode(URLEncoder.encode(jumpSeconds, "gbk"),"gbk")
				+

				"&payMerUserId="+ URLEncoder.encode(URLEncoder.encode(payMerUserId, "gbk"),"gbk")
				+

				"&saleMerUserId="+ URLEncoder.encode(URLEncoder.encode(saleMerUserId, "gbk"),"gbk")
				+

				"&buyPrepaid="+ URLEncoder.encode(URLEncoder.encode(buyPrepaid, "gbk"), "gbk")
				+

				"&salePrepaid="+ URLEncoder.encode(URLEncoder.encode(salePrepaid, "gbk"),"gbk")
				+

				"&freight="+ URLEncoder.encode(URLEncoder.encode(freight, "gbk"), "gbk")
				+

				"&multiPayNum="+ URLEncoder.encode(URLEncoder.encode(multiPayNum, "gbk"),"gbk")
				+

				"&multiPayAmts="+ URLEncoder.encode(URLEncoder.encode(multiPayAmts, "gbk"),"gbk")
				+

				"&takeGoodsMethod="+ URLEncoder.encode(URLEncoder.encode(takeGoodsMethod, "gbk"),"gbk")
				+

				"&takeGoodsAddress="+ URLEncoder.encode(URLEncoder.encode(takeGoodsAddress, "gbk"),"gbk")
				+

				"&signMsg="+ URLEncoder.encode(URLEncoder.encode(signedData, "gbk"), "gbk")
				+

				"&orderNum="+ URLEncoder.encode(URLEncoder.encode(String.valueOf(orderNum),"gbk"), "gbk")
				+

				"&goodsId="+ URLEncoder.encode(URLEncoder.encode(goodsId, "gbk"), "gbk")
				+

				"&goodsName="+ URLEncoder.encode(URLEncoder.encode(goodsName, "gbk"), "gbk")
				+

				"&goodsNum="+ URLEncoder.encode(URLEncoder.encode(goodsNum, "gbk"), "gbk")
				+

				"&goodsPrice="+ URLEncoder.encode(URLEncoder.encode(goodsPrice, "gbk"), "gbk") +

				"&goodsFee="+ URLEncoder.encode(URLEncoder.encode(goodsFee, "gbk"), "gbk") +

				"&remark="+ URLEncoder.encode(URLEncoder.encode(remark, "gbk"), "gbk");

		String responseToken = api.executeForDemo(body, serverurl);
		
		System.out.println("返回报文" + responseToken);

		JSONArray arr = JSONArray.fromObject("[" + responseToken + "]");
		String token = new String();
		if (arr.size() > 0) {
			token = arr.getJSONObject(0).get("token").toString();
		}

		System.out.println("令牌：" + token);

		request.setAttribute("token", token);
		
		request.getRequestDispatcher("/order.jsp").forward(request,response);
	}
}
