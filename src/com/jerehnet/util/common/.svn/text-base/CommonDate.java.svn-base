package com.jerehnet.util.common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CommonDate {
	/**
	 * 根据传入的格式，返回当前日期(字符串形式)
	 * @param format 格式
	 * @return 格式化后的值
	 */
	public static String getToday(String format) {
		String today = "";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		today = sdf.format(Calendar.getInstance().getTime());
		return today;
	}
	
	/**
	 * 格式化时间
	 * @param format 格式
	 * @param d 时间 (java.sql)
	 * @return
	 */
	public static String getFormatDate(String format, java.sql.Date d) {
		String today = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			Date now = new Date(d.getTime());
			today = sdf.format(now);
			sdf = null;
			now = null;
		} catch (Exception e) {
		}
		return today;
	}
	
	/**
	 * 格式化时间
	 * @param format 格式
	 * @param d 时间 (java.sql)
	 * @return
	 */
	public static String getFormatDate(String format, Object date) {
		if(date instanceof java.sql.Date){
			java.sql.Date d = (java.sql.Date)date;
			String today = "";
			try {
				SimpleDateFormat sdf = new SimpleDateFormat(format);
				Date now = new Date(d.getTime());
				today = sdf.format(now);
				sdf = null;
				now = null;
			} catch (Exception e) {
				
			}
			return today;
		}
		if(date instanceof java.util.Date){
			java.util.Date d = (java.util.Date)date;
			String today = "";
			try {
				SimpleDateFormat sdf = new SimpleDateFormat(format);
				Date now = new Date(d.getTime());
				today = sdf.format(now);
				sdf = null;
				now = null;
			} catch (Exception e) {
				
			}
			return today;
		}
		return "";
	}
	
	/**
	 * 格式化时间
	 * @param format 格式
	 * @param d 时间 (java.util)
	 * @return
	 */
	public static String getFormatDate(String format, java.util.Date d) {
		String today = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			today = sdf.format(d);
			sdf = null;
		} catch (Exception e) {
		}
		return today;
	}
	/**
	 * 格式化时间
	 * @param format 格式
	 * @param d 时间 (java.util)
	 * @return
	 */
	public static String getFormatDate(String format, String d) {
		Date date = null ;
		String today = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			if(d!=null && !"".equals(d)){
				date = sdf.parse(d) ;
			}else{
				date = sdf.parse(getToday("yyyy-MM-dd")) ;
			}
			today = sdf.format(date);
			sdf = null;
		} catch (Exception e) {
		}
		return today;
	}
	
	/**
	 * 日期处理模块 (将日期加上某些天或减去天数)返回字符串
	 * @param to 天数
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static String dateAdd(String to) {
		// 日期处理模块 (将日期加上某些天或减去天数)返回字符串
		int strTo;
		try {
			strTo = Integer.parseInt(to);
		} catch (Exception e) {
			System.out.println("日期标识转换出错! : \n:::" + to + "不能转为数字型");
			e.printStackTrace();
			strTo = 0;
		}
		Calendar strDate = Calendar.getInstance(); // java.util包,设置当前时间
		strDate.add(strDate.DATE, strTo); // 日期减 如果不够减会将月变动 //生成 (年-月-日)
		String meStrDate = strDate.get(strDate.YEAR) + "-"
				+ String.valueOf(strDate.get(strDate.MONTH) + 1) + "-"
				+ strDate.get(strDate.DATE);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		meStrDate = sdf.format(strDate.getTime());
		sdf = null;
		return meStrDate;
	}
	
	/**
	 * 日期处理模块 (将日期加上某些天或减去天数)返回字符串
	 * @param to
	 * @param formatStr
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static String dateAdd(String to, String formatStr) {
		// 日期处理模块 (将日期加上某些天或减去天数)返回字符串
		int strTo;
		try {
			strTo = Integer.parseInt(to);
		} catch (Exception e) {
			System.out.println("日期标识转换出错! : \n:::" + to + "不能转为数字型");
			e.printStackTrace();
			strTo = 0;
		}
		Calendar strDate = Calendar.getInstance(); // java.util包,设置当前时间
		strDate.add(strDate.DATE, strTo); // 日期减 如果不够减会将月变动 //生成 (年-月-日)
		String meStrDate = strDate.get(strDate.YEAR) + "-"
				+ String.valueOf(strDate.get(strDate.MONTH) + 1) + "-"
				+ strDate.get(strDate.DATE);

		SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
		meStrDate = sdf.format(strDate.getTime());
		sdf = null;

		return meStrDate;
	}
	
	/**
	 * 日期处理模块 (将日期加上小时或减去小时)返回字符串
	 * @param to
	 * @param formatStr
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static String hourAdd(String to, String formatStr) {
		// 日期处理模块 (将日期加上某些天或减去天数)返回字符串
		int strTo;
		try {
			strTo = Integer.parseInt(to);
		} catch (Exception e) {
			System.out.println("日期标识转换出错! : \n:::" + to + "不能转为数字型");
			e.printStackTrace();
			strTo = 0;
		}
		Calendar strDate = Calendar.getInstance(); // java.util包,设置当前时间
		strDate.add(strDate.HOUR, strTo); // 日期减 如果不够减会将月变动 //生成 (年-月-日)
		String meStrDate = strDate.get(strDate.YEAR) + "-"
				+ String.valueOf(strDate.get(strDate.MONTH) + 1) + "-"
				+ strDate.get(strDate.DATE);

		SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
		meStrDate = sdf.format(strDate.getTime());
		sdf = null;

		return meStrDate;
	}
	
	public static void main(String []args){
		System.out.println(hourAdd("-1","yyyy-MM-dd HH:mm:ss"));
	}

	public static String getWeekOfDate(Date dt) {
		String[] weekDays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0)
			w = 0;
		return weekDays[w];
	}

	public static int dayCount(String date) {
		SimpleDateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");
		int dayCount = 0;
		try {
			Date start = smdf.parse(date);
			Date end = new Date();
			long t = (end.getTime() - start.getTime()) / 1000;
			dayCount = new Double(t / (3600 * 24)).intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dayCount;
	}
	
	/**
	 * 判断字符串是否为数字
	 * @param source 字符串
	 * @return
	 */
	public static Boolean isDate(String source){
		Boolean bool = false;
		if(null!=source){
			try {
				DateFormat.getInstance().parse(source);
				bool = true;
			} catch (Exception e) {
				bool = false;
			}
		}
		return bool;
	}
	
	
}
