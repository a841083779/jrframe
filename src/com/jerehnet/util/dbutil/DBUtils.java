package com.jerehnet.util.dbutil;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jerehnet.util.common.Env;

public class DBUtils {
	/**
	 * 根据频道编号查询频道所有数据
	 * 
	 * @param no
	 *            频道编号
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static Map getRoot(String uuid) {
		DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		Connection connection = null;
		Map root = new HashMap();
		String sql = "";
		try {
			connection = dbHelper.getConnection();
			connection.setAutoCommit(false);
			sql = " select ccs.style,ccs.data_sql,ccs.data_key from ";
			sql += tablePrefix + "common_channel_subblock ccs , " + tablePrefix
					+ "common_acl_channel_subblock cas ";
			sql += " where ccs.uuid = cas.subblock_uuid ";
			sql += " and cas.channel_uuid = '" + uuid + "' ";
			sql += " and ccs.data_sql is not null and ccs.data_sql <> '' ";
			List<Map> subblocks = dbHelper.getMapList(sql, connection);
			List<Map> dataList = null;
			Map dataMap = null;
			if (null != subblocks && subblocks.size() > 0) {
				Integer style = 0;
				String dataKey = "";
				String dataSQL = "";
				for (Map map : subblocks) {
					style = (Integer) map.get("style");
					dataKey = (String) map.get("data_key");
					dataSQL = (String) map.get("data_sql");
					if (style.equals(0)) {
						try {
							dataList = dbHelper.getMapList(dataSQL, connection);
							root.put(dataKey, dataList);
						} catch (Exception e) {
							e.printStackTrace();
						}
					} else {
						try {
							dataMap = dbHelper.getMap(dataSQL, connection);
							root.put(dataKey, dataMap);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbHelper.freeConnection(connection);
		}
		return root;
	}

	/**
	 * 根据频道编号查询频道所有数据(为向前兼容提供的方法)
	 * 
	 * @param no
	 *            频道编号
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static Map getRootNo(String no) {
		DBHelper dbHelper = DBHelper.getInstance();
		Connection connection = null;
		Map root = new HashMap();
		String sql = "";
		try {
			connection = dbHelper.getConnection();
			connection.setAutoCommit(false);
			String tempNo = no;
			String likeNo = "";
			while (tempNo.length() > 0) {
				tempNo = tempNo.substring(0, tempNo.length() - 3);
				if (!"".equals(tempNo)) {
					likeNo = likeNo + " or channel_no like '%," + tempNo
							+ ",%' ";
				}
			}
			sql = " select no,style,data_sql,data_key from "
					+ Env.getInstance().getProperty("table_prefix")
					+ "common_channel_subblock where ( channel_no like '%,"
					+ no + ",%' " + likeNo
					+ " ) and data_sql is not null and data_sql <> '' ";
			List<Map> subblocks = dbHelper.getMapList(sql, connection);
			List<Map> dataList = null;
			Map dataMap = null;
			if ((subblocks != null) && (subblocks.size() > 0)) {
				Integer style = Integer.valueOf(0);
				String dataKey = "";
				String dataSQL = "";
				for (Map map : subblocks) {
					style = (Integer) map.get("style");
					dataKey = (String) map.get("data_key");
					dataSQL = (String) map.get("data_sql");
					if (style.equals(Integer.valueOf(0)))
						try {
							dataList = dbHelper.getMapList(dataSQL, connection);
							root.put(dataKey, dataList);
						} catch (Exception e) {
							e.printStackTrace();
						}
					else {
						try {
							dataMap = dbHelper.getMap(dataSQL, connection);
							root.put(dataKey, dataMap);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBHelper.freeConnection(connection);
		}
		return root;
	}

}
