package com.jerehnet.util.common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 前台页面生成帮助类
 * 
 * @author Administrator
 * 
 */
public class CommonHtml {
	/**
	 * 为字符串获取默认值
	 * 
	 * @param source
	 * @param defaultStr
	 * @return
	 */
	public static String getDefault(Object source, String defaultStr) {
		String rs = CommonString.getFormatPara(source);
		if ("".equals(rs)) {
			return defaultStr;
		}
		return rs;
	}

	/**
	 * 过滤html标签
	 * 
	 * @param str
	 *            要过滤的字符串
	 * @return
	 */
	public static String filterHTML(String str) {
		if (null == str || "".equals(str)) {
			return "暂无信息";
		}
		str = str.replaceAll("&nbsp;", "");
		str = str.replaceAll("<\\s*img\\s+([^>]*)\\s*>", "");
		str = str.replaceAll("<[^<|^>]+>", "");
		Pattern p = Pattern.compile("\\s*|\t|\r|\n|&nbsp;");
		Matcher m = p.matcher(str);
		str = m.replaceAll("");
		str = str.replaceAll("&nbsp;", "");
		str = str.replaceAll(" ", "");
		char[] cArr = str.toCharArray();
		Character.UnicodeBlock unicode = null;
		StringBuffer outString = new StringBuffer();
		for (char ch : cArr) {
			unicode = Character.UnicodeBlock.of(ch);
			if (!unicode.toString().equals("\\u3000")) {
				outString.append(ch);
			}
		}
		return outString.toString();
	}

	/**
	 * 过滤html标签
	 * 
	 * @param str
	 *            要过滤的字符串
	 * @param length
	 *            要截取的字符串长度
	 * @return
	 */
	public static String filterHTML(String str, Integer length) {
		if (null == str) {
			return "暂无信息";
		}
		str = filterHTML(str);
		if (str.length() > length) {
			return str.substring(0, length);
		}
		return str;
	}
	
	public static String getHTMLByURLByEncoding(String urlString,
			String encoding) {
		String outStr = "";
		try {
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.connect();
			InputStream is = conn.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is,
					encoding));
			String line = "";
			StringBuffer resultBuffer = new StringBuffer();
			while ((line = br.readLine()) != null) {
				resultBuffer.append(line);
			}
			br.close();
			is.close();
			conn.disconnect();
			outStr = resultBuffer.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outStr;
	}

	public static String getHTMLByURL(String urlString) {
		return getHTMLByURLByEncoding(urlString, "utf-8");
	}
}
