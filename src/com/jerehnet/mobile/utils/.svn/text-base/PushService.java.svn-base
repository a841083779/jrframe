package com.jerehnet.mobile.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jerehnet.util.common.Common;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.common.Env;


public class PushService {

	/***************************************************************************
	 * 推送消息
	 * 
	 * @param message
	 * @param userId
	 * @param typeName
	 * @param pushUrl
	 */
	public static void pushMessage(final String pushStr, final String userId, final String typeName, final String message) {
		final Thread thread = new Thread() {
			
			@Override
			public void run() {
				System.out.println("1111111111111111111111111111111111111111");
				try {
					Map<String, String> params = new HashMap<String, String>();
					params.put("broadcast", "N");
					params.put("title", typeName);
					params.put("username", userId);
					params.put("message", message);
					params.put("uri", pushStr);
					
					System.out.println("***20141114pushStr:"+pushStr);					
					pushMessgeToMobile(params, CommonString.getFormatPara(Env.getInstance().getProperty("push_url")));
				} catch (Exception ex) {
					ex.printStackTrace();
				} finally {
				}
			}
		};
		thread.start();
	}

	/***************************************************************************
	 * 发送http请求给推送服务器
	 * 
	 * @param message
	 * @param userId
	 * @param typeName
	 * @param pushUrl
	 * @throws Exception 
	 * @throws IOException 
	 */
	public static String pushMessgeToMobile(Map<String, String> params, String pushUrl) throws IOException, Exception {
		params.put("action", "send");
		
		return Common.doPost(pushUrl, params);
	}

}
