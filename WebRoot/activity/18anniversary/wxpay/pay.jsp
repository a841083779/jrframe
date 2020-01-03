<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.pay.wxpay.WXPay"%>
<%@page import="com.pay.wxpay.common.Signature"%>
<%@page import="com.pay.wxpay.common.Util"%>
<%@page import="com.pay.wxpay.protocol.unifiedorder_protocol.UnifiedorderReqData"%>
<%@page import="com.pay.wxpay.protocol.unifiedorder_protocol.UnifiedorderResData"%>
<%@page import="java.sql.Timestamp"%>


<%
  
        Map<String,Object> result = new HashMap();
        String mchID = "1503495131";
        String key = "5Y04zUYuLnl8QkVSg70hpeCPi6QIyC85";
        String appid = "wx1970a95c4c76db38";
        String notifyUrl="http://www.21-sun.com/";
        WXPay.initSDKConfiguration(key, appid, mchID);
        String body = "21sunTest";
        String deviceInfo = "";
        String tradeType = "JSAPI";//App支付
        String attach = null;
        Double totalReceivableAmount = 0.01;
        String orderNo = Util.createOrderNo("");
        Random random=new Random();
        int a=random.nextInt(100);
        orderNo = "20180224001"+a+a;
        System.out.println("orderNo:" + orderNo);
        int totalFee = (int) (totalReceivableAmount * 100);
        totalFee = 1;////////////////////////////////

        String spbillCreateIp = "119.180.98.134";
        Timestamp d = new Timestamp(System.currentTimeMillis());
        UnifiedorderReqData unifiedorderReqData = new UnifiedorderReqData(
                deviceInfo, body, attach, orderNo, totalFee, spbillCreateIp, notifyUrl, tradeType,
                "oBp9ht-DUjhS_oq4nYrT3unzVsIY");

        System.out.println("请求数据：");
        Util.printModel(unifiedorderReqData);
        Date date= new Date();
        String timestamp = String.valueOf(date.getTime()/1000);


        String orderSign="";
        try {
            UnifiedorderResData unifiedorderResData = WXPay
                    .requestUnifiedorderService(unifiedorderReqData);
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




            } else {
                System.out.println("返回为空");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        result.put("orderSign",orderSign);
        result.put("timestamp",timestamp );

        System.out.println("最后结果：");
		System.out.println(result);
  
%>