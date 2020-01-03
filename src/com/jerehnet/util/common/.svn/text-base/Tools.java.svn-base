package com.jerehnet.util.common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.httpclient.HttpConnection;
import org.json.JSONObject;

import com.jerehnet.action.PoolManager;
import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class Tools {
	public static void loadStaticVariable() {

	}

	@SuppressWarnings("unchecked")

	// 获取当前月有多少天
	public static int getMonthDays(String YYYYMM) throws ParseException {
		String strDate = YYYYMM;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		Calendar calendar = new GregorianCalendar();
		Date date = null;;
		try {
			date = sdf.parse(strDate);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		calendar.setTime(date);
		int day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		return day;
	}

	/**
	 * 根据字符长度获取空格
	 * 
	 * @param str
	 *            字符串
	 * @return Html的空格
	 */
	public static String getSpace(String str, int multiple) {
		StringBuffer sb = new StringBuffer();
		if (null != str) {
			for (int i = 0; i < str.length() * multiple; i++) {
				sb.append("&nbsp;");
			}
		}
		return sb.toString();
	}

	public static String UTF8ToGB(String strValue) {
		if (strValue == null || strValue.trim().length() == 0) {
			return null;
		}
		StringBuffer strbuf = new StringBuffer();
		String[] strarr = strValue.split(";");
		int il = strarr.length;
		for (int i = 0; i < il; i++) {
			int pos = strarr[i].indexOf("&#");
			if (pos >= 0) {
				if (pos > 0) {
					strbuf.append(strarr[i].substring(0, pos));
				}

				String tmp = strarr[i].substring(pos + 2);
				if (tmp.startsWith("00")) {
					tmp = tmp.substring(2);
				}

				try {
					int l = Integer.valueOf(tmp);
					if ((l > 10000) || (l < 1000)) {
						strbuf.append((char) l);
					} else {
						strbuf.append("&#").append(tmp).append(";");
					}
				} catch (NumberFormatException e) {
					strbuf.append(tmp);
				}
			} else {
				strbuf.append(strarr[i]);
			}
		}
		return strbuf.toString();
	}

	/**
	 * 
	 * @param format
	 * @param days
	 *            距离今日的天数
	 * @return
	 */
	public static String getYesterday(String format, int days) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -days);
		if (null == format || "".equals(format)) {
			format = "yyyy-MM-dd";
		}
		String yesterday = new SimpleDateFormat(format).format(cal.getTime());
		return yesterday;
	}

	/**
	 * 获得距离特定日期特定天数的日期
	 * 
	 * @param date
	 *            给定的日期
	 * @param days
	 *            差距天数
	 * @param format
	 *            日期格式化
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static String getAddDaysDate(String format, String date, int days, int flag) {
		if (flag == 0) {
			days = -days;
		}
		if (CommonString.getFormatPara(format).equals("")) {
			format = "yyyy-MM-dd";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format.toString());
		if (CommonString.getFormatPara(date).equals("")) {
			date = sdf.format(CommonDate.getToday(format));
		}
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(sdf.parse(date));
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		calendar.add(calendar.DATE, days);
		return sdf.format(calendar.getTime());
	}

	/**
	 * 获取本月的最早一天或最后一天
	 * 
	 * @param format
	 *            日期格式化
	 * @param flag
	 *            标识
	 * @return
	 */
	public static String getLastOrFirstDayInMonth(String format, int flag) {
		if ("".equals(CommonString.getFormatPara(format))) {
			format = "yyyy-MM-dd";
		}
		DateFormat fmt = new SimpleDateFormat(format);
		// 获取Calendar
		Calendar calendar = Calendar.getInstance();
		if (flag == 0) {
			calendar.set(Calendar.DATE, calendar.getActualMinimum(Calendar.DATE));
		}
		if (flag == 1) {
			calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));
		}
		return fmt.format(calendar.getTime());
	}

	public static long getQuot(String time1, String time2) {
		long quot = 0;
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date1 = ft.parse(time1);
			Date date2 = ft.parse(time2);
			quot = date2.getTime() - date1.getTime();
			quot = quot / 1000 / 60 / 60 / 24;
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return quot;
	}

	@SuppressWarnings("unchecked")
	public static Map sortMap(Map map) {
		Map oneMap = new LinkedHashMap() ; 
		ArrayList<Entry<String, String>> l = new ArrayList<Entry<String, String>>(map.entrySet());
		Collections.sort(l, new Comparator<Object>() {
			@SuppressWarnings("unchecked")
			public int compare(Object e1, Object e2) {
				int v1 = Integer.parseInt(((Entry<String, String>) e1).getValue().toString());
				int v2 = Integer.parseInt(((Entry) e2).getValue().toString());
				return  v2-v1;
			}
		});
		for (Entry<String, String> e : l) {
			oneMap.put(e.getKey(), e.getValue()) ;
		}
		return oneMap ;
	}
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		Map oneMap = new HashMap();
		oneMap.put("test0", "1");
		oneMap.put("test2", "2");
		oneMap.put("test3", "3");
		oneMap.put("test5", "5");
		oneMap.put("test4", "4");
		sortMap(oneMap);
	}
	@SuppressWarnings( { "unchecked", "static-access" })
	public static String getNo(String parNo, String table, String enumNo) {
		String no = "";
		Connection conn = null;
		DBHelper dbHelper = DBHelper.getInstance();
		String sql = "";
		try {
			sql = " SELECT no AS no FROM " + table + " ";
			sql += " WHERE no  IS NOT NULL AND isnumeric(no) = 1 ";
			sql += " AND parent_no = ? ";
			sql += "ORDER BY no";
			List list = dbHelper.getMapList(sql, new Object[] { parNo });
			long intNo = (long) 0;
			if (null != list && list.size() > 0) {
				intNo = Long.parseLong( (String) ((Map) list.get(list.size() - 1)).get("no"));
				intNo++;
				no = intNo + "";
			} else if (parNo.equals("0")) {
				intNo = (long) 101;
				no = intNo + "";
			} else {
				no = parNo + "001";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
		return no;
	}
	/**
	 * 递归获得类型参数：当前类别没有参数，获得上级类别的参数，直到有参数为止
	 * @param category
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Map> getCategoryParam(String category, String enumNo){
		DBHelper dbHelper = DBHelper.getInstance();
		String sql = "select * from pro_catalog_param where parent_no = '"+category+"' and is_show = 1 order by order_no desc,no asc";
		List list = null;
		try {
			list = dbHelper.getMapList(sql);
			if((list ==null || list.size()<=0)&&category.length()>=6){
				list = getCategoryParam(category.substring(0,category.length()-3),enumNo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 判断是否含有中文字符
	 * @param category
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static final boolean isChineseCharacter(String chineseStr) {  
        char[] charArray = chineseStr.toCharArray();  
        for (int i = 0; i < charArray.length; i++) {  
            if ((charArray[i] >= 0x4e00) && (charArray[i] <= 0x9fbb)) {  
                return true;  
            }  
        }  
        return false;  
    }  

	/**
	 * 根据ip获取省市
	 * @param ip
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static final String getMyProvinceAndCity(String ip) {
		String urlString = "";
		String[] areaArr = new String[10];
		if(ip.indexOf(",")>-1){
			String[] ipArr = ip.split(",");
			ip = ipArr[0];
		}
		urlString = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?ip="+ URLEncoder.encode(ip);
		JSONObject areaObj = new JSONObject();
		try {
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.connect();
			InputStream is = conn.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is,
					"gb2312"));
			String line = "";
			StringBuffer resultBuffer = new StringBuffer();
			while ((line = br.readLine()) != null) {
				resultBuffer.append(line);
			}
			br.close();
			is.close();
			conn.disconnect();
			areaArr = (resultBuffer.toString()).split("	");
			if(areaArr.length>7){
				areaObj.put("country", areaArr[3]);
				areaObj.put("province", areaArr[4]);
				areaObj.put("city", areaArr[5]);
				areaObj.put("provider", areaArr[7]);
			}else{
				areaObj.put("country", "");
				areaObj.put("province", "");
				areaObj.put("city", "");
				areaObj.put("provider", "");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return areaObj.toString();
	}
}