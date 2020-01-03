package com.jerehnet.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class MyHttpServletRequestWrapper extends HttpServletRequestWrapper {

	public MyHttpServletRequestWrapper(HttpServletRequest request) {
		super(request);
	}

	/**
	 * 获得被装饰对象的引用和采用的字符编码
	 * 
	 * @param request
	 * @param charset
	 */
	public MyHttpServletRequestWrapper(HttpServletRequest request, String charset) {
		super(request);
	}

	/**
	 * 实际上就是调用被包装的请求对象的getParameter方法获得参数，然后再进行编码转换
	 */
	public String getParameter(String name) {
		String value = "";
		String url = this.getRequestURI();
		if (url.indexOf("/backend/") != -1 || url.indexOf("/admin/") != -1 || url.indexOf("/action/") != -1) {
			value = super.getParameter(name);
		} else {
			value = super.getParameter(name);
			value = this.securityFilter(value);
		}
		return value;
	}

	/**
	 * 字符防注入
	 * 
	 * @param str
	 * @return
	 */
	public static String securityFilter(String str) {
		if (null != str) {
			str = str.replace("00:00:00.0", "").replace(":00.0", "").replace("'", "").replace("\"", "").replaceAll("\\b[sS][cC][rR][iI][pP][tT]\\b", "")
					.replaceAll("\\b[aA][nN][dD]\\b ", "").replaceAll("\\b[oO][rR]\\b ", "").replace("--", "").replaceAll("\\b[iI][fF][rR][aA][mM][eE]\\b", "")
					.replaceAll(".*([';]+|(--)+).*", " ").trim();
		}
		return str;
	}

}
