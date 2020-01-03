package com.jerehnet.webservice;

import java.net.MalformedURLException;

public class WEBSMS {
	/**
	 * 发送短信
	 * 
	 * @param phone
	 *            手机号，如果是多个用逗号隔开，最多不超过100个手机号
	 * @param content
	 *            发送内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Integer sendSMS(String phone, String content)
			throws MalformedURLException, Exception {
		String method = "sendSMS";
		Object[] param = new Object[] { phone, java.net.URLEncoder.encode(content,"gb2312") };
		Object[] results = WEBServiceUtil.executeDynamic("SendSMS", method,
				param);
		return (Integer) results[0];
	}
}
