package com.jerehnet.mobile.action;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.jerehnet.mobile.sync.BaseSyncActon;
import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;
public class AppVersionAction  extends BaseSyncActon{
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();  
	JSONObject jsonObject = new JSONObject();
	
	
	
	
	/**
	 * IOS 版本号
	 * @return
	 */
	public String getIosVersionNum(){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		Map versionMap=null;
		
		try{
				versionMap = dbHelper.getMap(" select top 1 version_num from pro_app_version_update where flag='IOS' order by update_date desc ");
				jsonObject.put("success","true");
	          	jsonObject.put("versionNum",CommonString.getFormatPara(versionMap.get("version_num"))); 

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("versionNum",""); 

		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * Android 版本号
	 * @return
	 */
	public String getAndroidVersionNum(){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		Map versionMap=null;
		
		try{
				versionMap = dbHelper.getMap(" select top 1 version_num from pro_app_version_update where flag='Android' order by update_date desc ");
				jsonObject.put("success","true");
	          	jsonObject.put("versionNum",CommonString.getFormatPara(versionMap.get("version_num"))); 

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("versionNum",""); 

		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	
	
}

