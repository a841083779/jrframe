package com.jerehnet.mobile.action;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.apache.commons.codec.digest.DigestUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import com.jerehnet.push.android.AndroidBroadcast;
import com.jerehnet.push.android.AndroidCustomizedcast;
import com.jerehnet.push.android.AndroidFilecast;
import com.jerehnet.push.android.AndroidGroupcast;
import com.jerehnet.push.android.AndroidUnicast;
import com.jerehnet.push.ios.IOSBroadcast;
import com.jerehnet.push.ios.IOSCustomizedcast;
import com.jerehnet.push.ios.IOSFilecast;
import com.jerehnet.push.ios.IOSGroupcast;
import com.jerehnet.push.ios.IOSUnicast;

import com.jerehnet.push.PushClient;

public class UmengAction {
	private PushClient client = new PushClient();
	/**
	 * 单播测试
	 * @param deviceToken
	 * @throws Exception
	 */
	public void sendIOSUnicast(String deviceToken) throws Exception {
		IOSUnicast unicast = new IOSUnicast("5929357c07fe656e96000fea","xie57zbzojh030fwj7jhhmqaps3luljr");
		// TODO Set your device token
		unicast.setDeviceToken( deviceToken );
		unicast.setAlert("IOS 单播测试:您有未处理的订单");
		unicast.setBadge( 0);
		unicast.setSound( "default");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		//测试模式对单播不生效
		unicast.setTestMode();
		//unicast.setProductionMode();
		// Set customized fields
		unicast.setCustomizedField("test", "helloworld");
		client.send(unicast);

	}
	
	/**
	 * alias别名
	 * @param alias
	 * @param aliasType
	 * @throws Exception
	 */
	public void sendIOSCustomizedcast(String alias,String aliasType) throws Exception {
		IOSCustomizedcast customizedcast = new IOSCustomizedcast("5929357c07fe656e96000fea","xie57zbzojh030fwj7jhhmqaps3luljr");
		// TODO Set your alias and alias_type here, and use comma to split them if there are multiple alias.
		// And if you have many alias, you can also upload a file containing these alias, then 
		// use file_id to send customized notification.
		customizedcast.setAlias(alias, aliasType);
		customizedcast.setAlert("您有未处理的订单，请及时确认。");
		customizedcast.setBadge( 0);
		customizedcast.setSound( "default");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		customizedcast.setTestMode();
		//customizedcast.setProductionMode();
		client.send(customizedcast);
	}


}

