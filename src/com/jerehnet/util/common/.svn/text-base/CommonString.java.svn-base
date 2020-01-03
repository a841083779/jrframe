package com.jerehnet.util.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class CommonString {
	/** *定义一个常量存储所有禁用字符* */
	public static final String allDenyStr = "'ampls-ampls";
	public static final String[] denyStr = allDenyStr.split("ampls");

	/**
	 * 对字符串进行处理
	 * 
	 * @param str
	 *            需要处理的字符串(Object类型)
	 * @return 处理后的字符串
	 */
	public static String getFormatPara(String str) {
		String formatStr = "";
		if (str != null) {
			formatStr = str.toString();
			formatStr = formatStr.replace("00:00:00.0", "")
					.replace(":00.0", "").trim();
		}
		return formatStr;
	}
	
	/**
	 * 对字符串进行过滤
	 * 
	 * @param str
	 *            需要处理的字符串(Object类型)
	 * @return 处理后的字符串
	 */
	public static String getFilterStr(String str) {
		String filterStr = "";
		if (str != null) {
			filterStr = str.toString();
			filterStr = filterStr.replace("00:00:00.0", "").replace(":00.0", "").replace("'", "").replace("\"", "").replace("<", "").replace(">", "").replace("script", "").replace(" or ", "").replace(
					" and ", "").replace("iframe", "").replace(" href ", "").replaceAll(".*([';]+|(--)+).*", " ").trim();
		}
		return filterStr;
	}

	/**
	 * 对字符串进行处理
	 * 
	 * @param str
	 *            需要处理的字符串(Object类型)
	 * @return 处理后的字符串
	 */
	public static String getFormatPara(Object str) {
		String formatStr = "";
		if (str != null) {
			formatStr = str.toString();
			formatStr = formatStr.replace("00:00:00.0", "")
					.replace(":00.0", "").trim();
		}
		return formatStr;
	}

	/**
	 * 根据时间生成随机串 100
	 * 
	 * @return 随机串
	 */
	public static String generateDateRandom() {
		String formatDate = new SimpleDateFormat("yyMMddHHmmss")
				.format(new Date());
		int random = new Random().nextInt(100);
		return formatDate + random;
	}

	/**
	 * 根据时间生成随机串
	 * 
	 * @param length
	 *            后缀长度
	 * @return 随机串
	 */
	public static String generateDateRandom(int length) {
		String formatDate = new SimpleDateFormat("yyMMddHHmmss")
				.format(new Date());
		int random = new Random().nextInt(length);
		return formatDate + random;
	}

	/**
	 * 正则表达式方式判断是否为数字
	 * 
	 * @param str
	 *            要判断的字符串
	 * @return
	 */
	public static boolean isInt(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	/**
	 * 给关键词加上链接
	 * 
	 * @param source
	 *            全文字符串
	 * @param oldstring
	 *            要替换的字符串
	 * @param color
	 *            颜色 如:#000或者red
	 * @return
	 */
	public static String ignoreCaseReplace(String source, String oldstring,
			String color) {
		String str;
		if (oldstring != null && !oldstring.trim().equals("")) {
			Pattern p = Pattern.compile(oldstring, Pattern.CASE_INSENSITIVE);
			Matcher m = p.matcher(source);
			str = m.replaceAll("<font color='" + color + "'>$0</font>");
		} else {
			str = source;
		}
		return str;
	}

	/**
	 * 获取内容中的所有图片
	 * 
	 * @param str
	 *            内容
	 * @return 过滤后的图片数组
	 */
	public static String[] getPicFromContent(String str) {
		if (str == null || str.length() == 0) {
			return null;
		}
		String returnStr = "";
		Matcher m = Pattern.compile("src=\"?(.*?)(\"|>|\\s+)",
				Pattern.CASE_INSENSITIVE).matcher(str);
		while (m.find()) {
			if (m.group(1).indexOf(".gif") == -1
					&& m.group(1).indexOf(".GIF") == -1
					&& m.group(1).indexOf(".JPG") == -1
					&& m.group(1).indexOf(".jpg") == -1) {
				continue;
			}
			if (m.group(1) == null || m.group(1).equals("")) {
				continue;
			}
			returnStr += m.group(1).replace("'", "").replace("\"", "") + ",";
		}
		return returnStr.split(",");
	}

	/**
	 * 获取内容中的一张图片
	 * 
	 * @param str
	 *            内容
	 * @return 获取的图片
	 */ 
	public static String getOnePicFromContent(String str) {  
		if (str == null || str.length() == 0) {
			return str;
		}
		String returnStr = "";   
		int n = 1;  
	// 	Matcher m = Pattern.compile(".*?<img\\s*.*?\\s*src=\\\"(.*)\\\"\\s*.*?>.*",Pattern.CASE_INSENSITIVE).matcher(str);
		Matcher m = Pattern.compile("<img[^>]*?src\\s*=\\s*[\'\"\"]?([^\'\"\"\\s>]*)[^>]*>",Pattern.CASE_INSENSITIVE).matcher(str);
		while (m.find()) {
			if (m.group(1).indexOf(".gif") == -1
					&& m.group(1).indexOf(".GIF") == -1
					&& m.group(1).indexOf(".JPG") == -1
					&& m.group(1).indexOf(".jpg") == -1) {
				continue;
			}
			if (n == 2) {
				break;
			}
			returnStr += m.group(1).replace("'", "").replace("\"", "") + ",";
			n = 2;
		}
		if (null != returnStr && returnStr.indexOf(",") != -1) {
			returnStr = returnStr.replace(",", "");
		}
		System.out.println(returnStr+"---");
		return returnStr;
	}

	/**
	 * 截取字符串，以半角字符来截取
	 * 
	 * @param str
	 * @param length
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static String substringByte(String str, int length) {
		int reInt = 0;
		String reStr = "";
		if (str == null)
			return "";
		char[] tempChar = str.toCharArray();
		for (int kk = 0; (kk < tempChar.length && length > reInt); kk++) {
			String s1 = str.valueOf(tempChar[kk]);
			byte[] b = s1.getBytes();
			reInt += b.length;
			reStr += tempChar[kk];
		}
		return reStr;
	}
	
	/**
	 * 截取字符串，以半角字符来截取
	 * 
	 * @param str
	 * @param length
	 * @param endStr 结束的字符串
	 * @return
	 */
	public static String substringByte(String str,int length,String endStr){
		if(null==str){
			return "";
		}
		String tempStr = substringByte(str,length);
		if(tempStr.length()<str.length()){
			str = tempStr + endStr;
		}
		return str;
	}
	
	/**
	 * 截取字符串，以半角字符来截取
	 * 
	 * @param str
	 * @param length
	 * @return
	 */
	public static String substringByte(String str,int length,Boolean isFilterHtml){
		if(null==str){
			return "";
		}
		if(isFilterHtml){
			str = str.replaceAll("</?[^>]+>", "");
			str = str.replaceAll("<[^<|^>]+>","");
			str = str.replace("&nbsp;", "");
			str = str.replace("\"", "");
			str = str.replace("'", "");
			str = str.replace("'", "");
			str = str.replaceAll("\\s*|\t|\r|\n", "");
		}
		str = substringByte(str,length);
		return str;
	}

	/**
	 * 过滤所有SQL注入
	 * 
	 * @param filterStr
	 * @return
	 */
	public static String filterStrForSQL(String filterStr) {
		return filterStrForSQL(filterStr, false);
	}

	public static String filterStrForSQL(String filterStr, boolean flag) {
		try {
			if (flag) {
				@SuppressWarnings("unused")
				int t = Integer.parseInt(filterStr);
			} else {
				for (int i = 0; i < denyStr.length; i++) {
					if (filterStr.indexOf(denyStr[i]) != -1) {
						filterStr = filterStr.replace(denyStr[i], "0");
					}
				}
			}
			return filterStr;
		} catch (Exception ex) {
			return "0";
		}
	}

	/**
	 * 获取项目物理路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getRealPath(HttpServletRequest request) {
		return request.getSession().getServletContext().getRealPath("/");
	}

	/**
	 * 获取UUID
	 * 
	 * @return
	 */
	public static String getUUID() {
		return UUID.randomUUID().toString();
	}
	
	
	/**
	 * 把传入的整数经过处理,返回.
	 * 
	 * @param str
	 * @return
	 */
	public static Integer getFormatInt(Object strObj) {
		Integer formatStr = 0;
		try {
			String str = "";
			if (null!=strObj) {
				str = strObj.toString();
			}
			if (str.indexOf(".") > -1) {
				str = str.substring(0, str.indexOf("."));
			}
			formatStr = Integer.parseInt(str);
		} catch (Exception e) {
			
		}
		return formatStr;
	}

}
