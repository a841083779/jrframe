package com.jerehnet.webservice;

import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

import com.jerehnet.util.dbutil.PageBean;

public class WEBDBHelper {
	@SuppressWarnings("unchecked")
	public static List<Map> getMapList(String sql, String wsdl)
			throws MalformedURLException, Exception {
		List<Map> maps = new ArrayList<Map>(0);
		Object[] results = WEBServiceUtil.executeDynamic(wsdl, "getMapList",
				new Object[] { sql });
		JSONArray jsonArray = new JSONArray(results[0].toString());
		JSONObject jsonObject = null;
		Map m = null;
		Object key = null;
		for (int i = 0; i < jsonArray.length(); i++) {
			jsonObject = jsonArray.getJSONObject(i);
			m = new HashMap();
			for (Iterator jo = jsonObject.keys(); jo.hasNext();) {
				key = jo.next();
				m.put(key + "", jsonObject.get(key + ""));
			}
			maps.add(m);
		}
		return maps;
	}

	@SuppressWarnings("unchecked")
	public static Map getMap(String sql, String wsdl)
			throws MalformedURLException, Exception {
		Map m = new HashMap();
		Object[] results = WEBServiceUtil.executeDynamic(wsdl, "getMap",
				new Object[] { sql });
		JSONObject jsonObject = new JSONObject(results[0].toString());
		Object key = null;
		for (Iterator jo = jsonObject.keys(); jo.hasNext();) {
			key = jo.next();
			m.put(key + "", jsonObject.get(key + ""));
		}
		return m;
	}

	/**
	 * 分页
	 * 
	 * @param pageBean
	 *            分业对象
	 * @param wsdl
	 * @throws Exception
	 * @throws MalformedURLException
	 */
	@SuppressWarnings("unchecked")
	public static List<Map> getMapListByPage(PageBean pageBean, String wsdl)
			throws MalformedURLException, Exception {
		List<Map> maps = new ArrayList<Map>(0);
		JSONObject pb = new JSONObject();
		pb.put("condition", pageBean.getCondition());
		pb.put("fields", pageBean.getFields());
		pb.put("main", pageBean.getMain());
		pb.put("nowPage", pageBean.getNowPage());
		pb.put("orderBy", pageBean.getOrderBy());
		pb.put("pageSize", pageBean.getPageSize());
		pb.put("params", pageBean.getParams());
		pb.put("tableName", pageBean.getTableName());
		Object[] results = WEBServiceUtil.executeDynamic(wsdl,
				"getMapListByPage", new Object[] { pb.toString() });
		JSONObject jsonObject = new JSONObject(results[0].toString());
		pageBean.setTotal(jsonObject.getInt("total"));
		pageBean.setPageCount(jsonObject.getInt("pageCount"));
		JSONArray jsonArray = new JSONArray(jsonObject.getString("list"));
		Map m = null;
		Object key = null;
		for (int i = 0; i < jsonArray.length(); i++) {
			jsonObject = jsonArray.getJSONObject(i);
			m = new HashMap();
			for (Iterator jo = jsonObject.keys(); jo.hasNext();) {
				key = jo.next();
				m.put(key + "", jsonObject.get(key + ""));
			}
			maps.add(m);
		}
		return maps;
	}

}
