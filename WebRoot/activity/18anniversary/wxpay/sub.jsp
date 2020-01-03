<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.pay.wxpay.WXPay"%>
<%@page import="com.pay.wxpay.common.Signature"%>
<%@page import="com.pay.wxpay.common.Util"%>
<%@page import="com.pay.wxpay.protocol.unifiedorder_protocol.UnifiedorderReqData"%>
<%@page import="com.pay.wxpay.protocol.unifiedorder_protocol.UnifiedorderResData"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.json.*"%>
<%
		String path= "http://" + request.getServerName()+":"+request.getServerPort();
 		String openId = CommonString.getFormatPara(request.getParameter("openId"));
		String title = CommonString.getFormatPara(request.getParameter("title"));
		String orderNo = CommonString.getFormatPara(request.getParameter("orderNo"));
		double price = Double.parseDouble(CommonString.getFormatPara(request.getParameter("price")));

		JSONObject obj = new JSONObject();
		Map<String, Object> signMap = new HashMap<String, Object>();
        Map<String,Object> result = new HashMap();
        String mchID = "1503495131";
        String key = "5Y04zUYuLnl8QkVSg70hpeCPi6QIyC85";
        String appid = "wx1970a95c4c76db38";
        String notifyUrl=path+"/activity/18anniversary/wxpay/notify_url.jsp";
        WXPay.initSDKConfiguration(key, appid, mchID);
        String body = title;
        String deviceInfo = "";
        String tradeType = "JSAPI";//App支付
        String attach = null;

        int totalFee = (int) (price * 100);
		System.out.println(totalFee);
        String spbillCreateIp = "119.180.98.134";
        Timestamp d = new Timestamp(System.currentTimeMillis());
        UnifiedorderReqData unifiedorderReqData = new UnifiedorderReqData(deviceInfo, body, attach, orderNo, totalFee, spbillCreateIp, notifyUrl, tradeType,openId );

        System.out.println("请求数据：");
        Util.printModel(unifiedorderReqData);
        Date date= new Date();
        String timestamp = String.valueOf(date.getTime()/1000);


        String orderSign="";
        try {
            UnifiedorderResData unifiedorderResData = WXPay.requestUnifiedorderService(unifiedorderReqData);
            if (unifiedorderResData != null) {
                String prepayId = unifiedorderResData.getPrepay_id();
                String returnCode = unifiedorderResData.getReturn_code();
                String resultCode = unifiedorderResData.getResult_code();

                Map<String, Object> map = new HashMap<String, Object>();
                map.put("appid","wx1970a95c4c76db38");
                map.put("noncestr",unifiedorderResData.getNonce_str());
                map.put("package","Sign=WXPay");
                map.put("partnerid", "1503495131");
                map.put("prepayid", unifiedorderResData.getPrepay_id());
                map.put("timestamp", timestamp);
                //orderSign= Signature.getReadySign(map);
                orderSign= Signature.getSign(map);
                System.out.println("======"+orderSign);
                //result.put("orderSign",orderSign);
                unifiedorderResData.setSign(orderSign);
                System.out.println("返回数据：");
                Util.printModel(unifiedorderResData);
                result=Util.printModelStr(unifiedorderResData);

                //开始唤起应用支付
                signMap.put("appId","wx1970a95c4c76db38");
                signMap.put("timeStamp",timestamp);
                signMap.put("nonceStr",unifiedorderResData.getNonce_str());
                signMap.put("package", "prepay_id="+unifiedorderResData.getPrepay_id());
                signMap.put("signType", "MD5");
                String paySign = Signature.getSign(signMap);
				signMap.put("paySign",paySign);
				
				

			obj.put("appId","wx1970a95c4c76db38");
			obj.put("timeStamp",timestamp);
			obj.put("nonceStr",unifiedorderResData.getNonce_str());
			obj.put("package", "prepay_id="+unifiedorderResData.getPrepay_id());
			obj.put("signType", "MD5");
			obj.put("paySign",paySign);
				System.	out.print("========"+obj.toString());

            } else {
                System.out.println("返回为空");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        //result.put("orderSign",orderSign);
        //result.put("timestamp",timestamp );
        //System.out.println("最后结果：");
		//System.out.println(result);
		
		
		
		out.print(obj.toString());

%>
