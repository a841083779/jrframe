package com.alipay.refund;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.alipay.config.AlipayConfig;

public class AlipayTradeRefund {
    private static final String ALIPAY_TRADE_REFUND = "https://openapi.alipay.com/gateway.do";

    public void test() throws Exception {
        String appId = "2088911993814690";
        String privateKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMklSVxIsxD5juiGoxx4vNV7FDIa8t3Z3WpHQUCPnATtsYUiTk/+xUel9ng59uLHFEb1kwKgJ9q46K2T/VrL0O8iHY2l5ZGRZUnpiN6ghTDtEc8HaH6fYCpnauVPPe3ycP/dsTKxK8+TXXAf84Lg4+CQYFSxICTojlWF7nClPgRPAgMBAAECgYBAE1WsRSht1uHUZtddAYU+CEglsfn9/CIRcgNyWo0b8NAlFgmWaBVWPqMmJ2jjUwG9nQsowfYQMelFKiiCHP1AL1FDqoRCEw5WP3HQ4ip/AHN0OxFjuK5Y1bKZ/WtFp3TZ9WKoQ1CGbYrZHdK6NEMJIuCiAgzTM4BhmFZdS/xTGQJBAPOJ+jQuuZgnfl4/L3bKfMTKp3mUqMZ39fL635pdsvqg7sgiWjjg0rsG1Szso4OP0yBWqKDhYbOO1G9sTUKCCg0CQQDTcAP3OiD6vp57moNmKl/azJWgUtzyQJwYYRDtIdIK+Pf6+mDEA+TfF2jZf6fj2uVm/bSdOhNDeQKbE5kcmTzLAkEAlQsgIMdntgKVh8BLn/uUGCueCv47vBq2XpnCNoqZemD7QWgkpyKQVP19gRzhhSaEIwpl8O9+B5Gl2PsC3W0QEQJBAJktosHeK/xcUsarVxySAGWsJ45B2e3rXurOj4usH9ZxLn52G9qGE66H8B76O7B4ag+mJ85sP353Uar1lMxCO+cCQAe28fEhWabgeeAkGeBSDhcPlCa6q8M+CqpCYsjpSe9ZfYjEANFqruP47pB0neWde6wHaXcThkKW1ngCoGjv1rM=";
        AlipayClient alipayClient = new DefaultAlipayClient(ALIPAY_TRADE_REFUND, appId, privateKey, "json", AlipayConfig.getInput_charset(), AlipayConfig.ali_public_key);

        String outTradeNo = "ZF2016030900000002";
        AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        request.setBizContent("{\"out_trade_no\":\"" + outTradeNo + "\",\"trade_no\":\"\",\"refund_amount\":0.01,\"refund_reason\":\"正常退款\",out_request_no\":\"HZ01RF001\",\"operator_id\":\"OP001\",\"store_id\":\"NJ_S_001\",\"terminal_id\":\"NJ_T_001\"} ");
        AlipayTradeRefundResponse response = alipayClient.execute(request);
        System.out.println();
    }

    public static void main(String[] args) {
        try {
            new AlipayTradeRefund().test();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
