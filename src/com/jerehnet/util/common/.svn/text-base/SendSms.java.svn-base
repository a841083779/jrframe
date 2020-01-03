package com.jerehnet.util.common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class SendSms {
	public static Integer sendSMS(String phone, String content) {
		if (null == phone) {// 手机号或者内容为空
			return -1;
		}
		if (null == content) {// 手机号或者内容为空
			return -1;
		}
		String[] phones = phone.split(",");
		if (phones.length > 100) {
			return -5;
		}
		for (int i = 0; i < phones.length; i++) {
			if (phones[i] == null) {
				return -1;
			} else if (phones[i].getBytes().length != 11) {
				return -2;
			}
		}
		Integer contenLength = content.getBytes().length;
		if (contenLength >= 120) {
			return -3;
		}
		try {
			URL url = new URL("http://http.asp.sh.cn/MT.do?Username=gcjxw&Password=123456&Mobile=" + phone + "&Content=" + java.net.URLEncoder.encode(content,"gb2312") + "&Keyword=");
			HttpURLConnection urlconn = (HttpURLConnection) url.openConnection();
			urlconn.connect();
			InputStream urlStream = urlconn.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(urlStream));
			String result = reader.readLine();
			urlStream.close();
			if (null != result && "0".equals(result.trim())) {
				return 1;
			}
		} catch (Exception e) {
			return -4;
		}
		return 0;
	}
}
