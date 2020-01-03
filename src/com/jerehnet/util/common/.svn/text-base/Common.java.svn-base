package com.jerehnet.util.common;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import com.jerehnet.action.PoolManager;
import com.jerehnet.util.dbutil.DBHelper;

public class Common {

	/**
	 * 输出异常信息
	 * 
	 * @param throwable
	 */
	public static void println(Throwable throwable) {
		throwable.printStackTrace();
	}

	/**
	 * 控制台输出信息
	 * 
	 * @param str
	 */
	public static void println(String str) {
		System.out.println(str);
	}

	/**
	 * 传入汉子，返回每个汉字的第一个字母
	 * 
	 * @param str
	 * @return
	 */
	public static String getSingleSpell(String str) {
		str = CommonString.getFormatPara(str);
		str = CnToFullSpell.getFirstSpell(str);
		return str;
	}

	/**
	 * 得到异常信息字符串数组(用做将异常信息在页面输出)
	 * 
	 * @return
	 */
	public static String getStackTraceElement(Throwable throwable) {
		StringBuffer stringBuffer = new StringBuffer();
		StackTraceElement[] ste = throwable.getStackTrace();
		for (int i = 0; i < ste.length; i++) {
			stringBuffer.append(ste[i].toString() + "<br />\r\n");
		}
		return stringBuffer.toString();
	}

	/**
	 * 获取验证码图片(SESSION中存的值为rand)
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public static void getAuthImg(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		int width = 60, height = 20;
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		OutputStream os = response.getOutputStream();
		Graphics g = image.getGraphics();
		Random random = new Random();
		g.setColor(getRandColor(200, 250));
		g.fillRect(0, 0, width, height);
		g.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		g.setColor(getRandColor(160, 200));
		for (int i = 0; i < 155; i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			g.drawLine(x, y, x + xl, y + yl);
		}
		String sRand = "";
		for (int i = 0; i < 4; i++) {
			String rand = String.valueOf(random.nextInt(10));
			sRand += rand;
			g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
			g.drawString(rand, 13 * i + 6, 16);
		}
		HttpSession session = request.getSession();
		session.setAttribute("rand", sRand);
		g.dispose();
		ImageIO.write(image, "JPEG", os);
		os.close();
	}

	/**
	 * 创建一个Cookie
	 * 
	 * @param response
	 * @param key索引键值
	 * @param value存储值
	 * @param time有效时间
	 *            ，这里是秒
	 */
	@SuppressWarnings("deprecation")
	public static void createCookie(HttpServletResponse response, String key, String value, int time) {
		Cookie cookie = null;
		try {
			value = java.net.URLEncoder.encode(value);
			cookie = new Cookie(key, value);
			cookie.setMaxAge(time);
			cookie.setPath("/");
			response.addCookie(cookie);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			cookie = null;
		}
	}

	/**
	 * 读取一个Cookie
	 * 
	 * @param request
	 * @param key索引键值
	 * @return value存储值
	 */
	@SuppressWarnings("deprecation")
	public static String getCookies(HttpServletRequest request, String key) {
		Cookie cookies[] = null;
		String r = null;

		try {
			cookies = request.getCookies();
			for (int i = 0; cookies!=null && i < cookies.length; i++) {
				if (cookies[i].getName().equals(key)) {
					r = java.net.URLDecoder.decode(cookies[i].getValue());
					break;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			cookies = null;
		}
		return r;
	}

	private static Color getRandColor(int fc, int bc) {
		Random random = new Random();
		if (fc > 255) {
			fc = 255;
		}
		if (bc > 255) {
			bc = 255;
		}
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}

	/**
	 * 获取IP
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("finally")
	public static String getIp(HttpServletRequest request, int flag) {
		String result = "";
		int port = 80;
		try {
			port = request.getServerPort();
			if (flag == 1) {
				if (port == 80)
					result = request.getHeader("X-Real-IP");
				else
					result = request.getRemoteAddr();
			} else {
				result = request.getRemoteAddr();
			}

		} catch (Exception e) {
			;
		} finally {
			return result;
		}
	}

	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 获取域名
	 * 
	 * @param request
	 * @return
	 */
	public static String getDomain(HttpServletRequest request) {
		String domain = "";
		Integer port = request.getServerPort();
		String portStr = "";
		if (port != 80) {
			portStr += ":" + port;
		}
		domain += request.getScheme() + "://" + request.getServerName() + portStr;
		return domain;
	}

	/**
	 * 进行301重定向跳转
	 * 
	 * @param response
	 * @param url
	 *            跳转向的地址
	 * @throws IOException
	 */
	public static void do301(HttpServletResponse response, String url) throws IOException {
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", url);
		response.setHeader("Connection", "close");
	}

	/**
	 * 进行302重定向跳转
	 * 
	 * @param response
	 * @param url
	 *            跳转向的地址
	 * @throws IOException
	 */
	public static void do302(HttpServletResponse response, String url) throws IOException {
		response.sendRedirect(url);
	}

	/**
	 * 携带数据进行跳转
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 * @param url
	 *            要跳转的地址
	 * @throws ServletException
	 * @throws IOException
	 */
	public static void doForward(HttpServletRequest request, HttpServletResponse response, String url) throws ServletException, IOException {
		request.getRequestDispatcher(url).forward(request, response);
	}

	/**
	 * 执行Get请求
	 * 
	 * @param url
	 *            要请求的地址
	 * @return 返回请求地址结果
	 * @throws HttpException
	 * @throws IOException
	 */
	public static String doGet(String url) throws Exception {
		return doPost(url, null);
	}

	/**
	 * 执行POST请求(维持session)
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @return 返回请求地址结果
	 * @throws HttpException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public synchronized static String doPost(String url, Map params, Cookie[] cookies) throws Exception, IOException {
		HttpClient httpClient = new HttpClient();
		String result = "fail";
		PostMethod postMethod = new UTF8PostMethod(url);
		String cookieStr = "";
		if (null != cookies) {
			for (Cookie cookie : cookies) {
				cookieStr += cookie.getName() + "=" + cookie.getValue() + ";";
			}
		}
		if (null != params && params.size() > 0) {
			Object value = null;
			for (Object key : params.keySet()) {
				value = params.get(key);
				if (null == value) {
					continue;
				}
				if (value instanceof String[]) {
					value = ((String[]) value)[0];
				} else if (value instanceof String) {
					value = (String) value;
				}
				postMethod.addParameter(new NameValuePair(CommonString.getFormatPara(key), CommonString.getFormatPara(value)));
			}
		}
		if (!"".equals(cookieStr)) {
			postMethod.setRequestHeader("cookie", cookieStr);

		}
		int statusCode = httpClient.executeMethod(postMethod);
		if (statusCode == HttpStatus.SC_MOVED_PERMANENTLY || statusCode == HttpStatus.SC_MOVED_TEMPORARILY) {
			result = "ok";
		}
		result = new String(postMethod.getResponseBody(), "UTF-8");
		return result;
	}

	/**
	 * 执行POST请求
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @return 返回请求地址结果
	 * @throws HttpException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public synchronized static String doPost(String url, Map params) throws Exception, IOException {
		return doPost(url, params, null);
	}

	/**
	 * 异步 POST请求
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void doPostHttpAsync(String url, Map params) throws Exception {
		doPostHttpAsync(url, params, null);
	}

	/**
	 * 异步 POST请求(维持session)
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void doPostHttpAsync(String url, Map params, Cookie[] cookies) throws Exception {
		Async async = new Async(url, params, cookies);
		async.start();
	}

	/**
	 * 获取项目物理路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getAbsolutePath(HttpServletRequest request) {
		return request.getSession().getServletContext().getRealPath("/");
	}

	/**
	 * 获得最新的角色编号
	 * 
	 * @return
	 * @throws SQLException
	 */
	public static String getNewestRoleNo() throws SQLException {
		String sql = " SELECT TOP 1 convert(INT,role_no) AS maxno FROM ";
		sql += " " + Env.getInstance().getProperty("table_prefix") + "common_role ";
		sql += " WHERE isnumeric(role_no) = 1 ";
		sql += " ORDER BY maxno DESC ";
		Integer maxno = (Integer) DBHelper.getInstance().getOne(sql);
		maxno++;
		String no = maxno + "";
		int len = no.length();
		if (len == 1) {
			no = "00" + no;
		} else if (len == 2) {
			no = "0" + no;
		}
		return no;
	}

	@SuppressWarnings( { "static-access", "unchecked" })
	public static String getNo(String parNo, String table) {
		return getNo(parNo, table, "parent_no");
	}

	public static String getSelfNo(String parNo, String table, String field) {
		String no = "";
		Connection conn = null;
		DBHelper dbHelper = DBHelper.getInstance();
		String sql = "";
		try {
			conn = dbHelper.getConnection();
			sql = " SELECT convert(INT,no) AS no FROM " + table + " ";
			sql += " WHERE no IS NOT NULL AND isnumeric(no) = 1 ";
			sql += " AND substring(" + field + ",1,3) = '" + parNo + "' ";
			sql += "ORDER BY no";
			List list = dbHelper.getMapList(sql, conn);
			Integer intNo = 0;
			if (null != list && list.size() > 0) {
				intNo = (Integer) ((Map) list.get(list.size() - 1)).get("no");
				intNo++;
				no = intNo + "";
			} else if (parNo.equals("0")) {
				intNo = 101;
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

	@SuppressWarnings( { "unchecked", "static-access" })
	public static String getNo(String parNo, String table, String field) {
		String no = "";
		Connection conn = null;
		DBHelper dbHelper = DBHelper.getInstance();
		String sql = "";
		try {
			conn = dbHelper.getConnection();
			sql = " SELECT convert(INT,no) AS no FROM " + table + " ";
			sql += " WHERE no IS NOT NULL AND isnumeric(no) = 1 ";
			sql += " AND " + field + " = ? ";
			sql += "ORDER BY no";
			List list = dbHelper.getMapList(sql, new Object[] { parNo }, conn);
			Integer intNo = 0;
			if (null != list && list.size() > 0) {
				intNo = (Integer) ((Map) list.get(list.size() - 1)).get("no");
				intNo++;
				no = intNo + "";
			} else if (parNo.equals("0")) {
				intNo = 101;
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
	 * 
	 * @param parNo
	 * @param table
	 *            表名
	 * @param parField
	 *            父亲id 字段名字
	 * @param field
	 *            当前字段名字
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static String getNo(String parNo, String table, String parField, String field) {
		String no = "";
		Connection conn = null;
		DBHelper dbHelper = DBHelper.getInstance();
		String sql = "";
		try {
			conn = dbHelper.getConnection();
			sql = " SELECT convert(INT," + field + ") AS " + field + " FROM " + table + " ";
			sql += " WHERE " + field + " IS NOT NULL AND isnumeric(" + field + ") = 1 ";
			sql += " AND " + parField + " = ? ";
			sql += "ORDER BY " + field + "";
			List list = dbHelper.getMapList(sql, new Object[] { parNo }, conn);
			Integer intNo = 0;
			if (null != list && list.size() > 0) {
				intNo = (Integer) ((Map) list.get(list.size() - 1)).get(field);
				intNo++;
				no = intNo + "";
			} else if (parNo.equals("0")) {
				intNo = 101;
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

	@SuppressWarnings( { "unchecked", "static-access" })
	public static String getNo(String parNo, String table, String parField, String field, String factoryid) {
		String no = "";
		Connection conn = null;
		DBHelper dbHelper = DBHelper.getInstance();
		String sql = "";
		try {
			conn = dbHelper.getConnection();
			sql = " SELECT convert(INT," + field + ") AS " + field + " FROM " + table + " ";
			sql += " WHERE " + field + " IS NOT NULL AND isnumeric(" + field + ") = 1 ";
			sql += " AND " + parField + " = ? ";
			sql += " AND factoryid = ?";
			sql += "ORDER BY " + field + "";
			List list = dbHelper.getMapList(sql, new Object[] { parNo, factoryid }, conn);
			Integer intNo = 0;
			if (null != list && list.size() > 0) {
				intNo = (Integer) ((Map) list.get(list.size() - 1)).get(field);
				intNo++;
				no = intNo + "";
			} else if (parNo.equals("0")) {
				intNo = 101;
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
	 * 根据频道获取数据树信息
	 * 
	 * @param maps
	 *            频道集合
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getTreeData(List<Map> channels) {
		StringBuffer tree = new StringBuffer();
		@SuppressWarnings("unused")
		List<Map> children = null;
		tree.append("{\"Rows\":[");
		String isHave = "";
		List<Map> oneMaps = new ArrayList<Map>(0);
		String parentUUID = "";
		for (Map map : channels) {
			parentUUID = map.get("parent_uuid") == null ? "" : (String) map.get("parent_uuid");
			if ("4CCDF227-7F10-4E09-A47C-085CCB4A45FF".equals(parentUUID)) {
				oneMaps.add(map);
			}
		}
		for (Map map : oneMaps) {
			tree.append("{");
			StringBuffer a = new StringBuffer();
			for (Object key : map.keySet()) {
				if (!"intro".equals(key)) {
					a.append("\"" + key + "\"");
					a.append(":");
					a.append("\"" + CommonString.getFormatPara(map.get(key)) + "\",");
				}
			}
			isHave = getChildren((String) map.get("uuid"), channels);
			if (!"".equals(isHave)) {
				a.append(isHave);
			} else {
				if (null != a && a.length() > 1) {
					a.setLength(a.length() - 1);
				}
			}
			tree.append(a);
			tree.append("},");
		}
		if (null != tree && tree.length() > 1) {
			tree.setLength(tree.length() - 1);
		}
		tree.append("]}");
		return tree.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");
	}

	/**
	 * 根据频道获取数据树信息
	 * 
	 * @param maps
	 *            频道集合
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getTreeData(List<Map> channels, String parentField, String field) {
		StringBuffer tree = new StringBuffer();
		@SuppressWarnings("unused")
		List<Map> children = null;
		tree.append("{\"Rows\":[");
		String isHave = "";
		List<Map> oneMaps = new ArrayList<Map>(0);
		String parentUUID = "";
		for (Map map : channels) {
			parentUUID = map.get(parentField).toString();
			if ("0".equals(parentUUID)) {
				oneMaps.add(map);
			}
		}
		for (Map map : oneMaps) {
			tree.append("{");
			StringBuffer a = new StringBuffer();
			for (Object key : map.keySet()) {
				if (!"intro".equals(key)) {
					a.append("\"" + key + "\"");
					a.append(":");
					a.append("\"" + CommonString.getFormatPara(map.get(key)) + "\",");
				}
			}
			isHave = getChildren(map.get(field).toString(), channels, parentField, field);
			if (!"".equals(isHave)) {
				a.append(isHave);
			} else {
				if (null != a && a.length() > 1) {
					a.setLength(a.length() - 1);
				}
			}
			tree.append(a);
			tree.append("},");
		}
		if (null != tree && tree.length() > 1) {
			tree.setLength(tree.length() - 1);
		}
		tree.append("]}");
		return tree.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");
	}

	/**
	 * 根据频道获取数据树信息(为向前兼容提供的方法)
	 * 
	 * @param maps
	 *            频道集合
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getTreeNo(List<Map> channels) {
		StringBuffer tree = new StringBuffer();
		@SuppressWarnings("unused")
		List<Map> children = null;
		tree.append("{\"Rows\":[");
		String isHave = "";
		List<Map> oneMaps = new ArrayList<Map>(0);
		String parentNo = "";
		for (Map map : channels) {
			parentNo = map.get("parent_no") == null ? "" : (String) map.get("parent_no");
			if ("0".equals(parentNo)) {
				oneMaps.add(map);
			}
		}
		for (Map map : oneMaps) {
			tree.append("{");
			StringBuffer a = new StringBuffer();
			for (Object key : map.keySet()) {
				if (!"intro".equals(key)) {
					a.append("\"" + key + "\"");
					a.append(":");
					a.append("\"" + CommonString.getFormatPara(map.get(key)) + "\",");
				}
			}
			isHave = getChildrenNo((String) map.get("no"), channels);
			if (!"".equals(isHave)) {
				a.append(isHave);
			} else {
				if (null != a && a.length() > 1) {
					a.setLength(a.length() - 1);
				}
			}
			tree.append(a);
			tree.append("},");
		}
		if (null != tree && tree.length() > 1) {
			tree.setLength(tree.length() - 1);
		}
		tree.append("]}");
		return tree.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");
	}

	/**
	 * 获得子栏目
	 * 
	 * @param no
	 *            父栏目编号
	 * @param channels
	 *            所有频道
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getChildrenNo(String no, List<Map> channels) {
		StringBuffer child = new StringBuffer();
		List<Map> children = new ArrayList<Map>(0);
		String parentNo = "";
		for (Map map : channels) {
			parentNo = map.get("parent_no") == null ? "" : (String) map.get("parent_no");
			if (parentNo.equals(no)) {
				children.add(map);
			}
		}
		String isHave = "";
		if (null != children && children.size() > 0) {
			child.append("\"children\":[");
			StringBuffer a = new StringBuffer();
			for (Map map : children) {
				a.append("{");
				StringBuffer b = new StringBuffer();
				for (Object key : map.keySet()) {
					if (!key.toString().equals("intro")) {
						b.append("\"" + key + "\":\"" + CommonString.getFormatPara(map.get(key)) + "\",");
					}
				}
				isHave = getChildrenNo((String) map.get("no"), channels);
				if (!"".equals(isHave)) {
					b.append(isHave);
				} else {
					if (null != b && b.length() > 1) {
						b.setLength(b.length() - 1);
					}
				}
				a.append(b);
				a.append("},");
			}
			if (null != a && a.length() > 1) {
				a.setLength(a.length() - 1);
			}
			child.append(a);
			child.append("]");
		}
		return child.toString();
	}

	/**
	 * 获得子栏目
	 * 
	 * @param no
	 *            父栏目编号
	 * @param channels
	 *            所有频道
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getChildren(String no, List<Map> channels) {
		StringBuffer child = new StringBuffer();
		List<Map> children = new ArrayList<Map>(0);
		String parentUUID = "";
		for (Map map : channels) {
			parentUUID = map.get("parent_uuid") == null ? "" : (String) map.get("parent_uuid");
			if (parentUUID.equals(no)) {
				children.add(map);
			}
		}
		String isHave = "";
		if (null != children && children.size() > 0) {
			child.append("\"children\":[");
			StringBuffer a = new StringBuffer();
			for (Map map : children) {
				a.append("{");
				StringBuffer b = new StringBuffer();
				for (Object key : map.keySet()) {
					if (!key.toString().equals("intro")) {
						b.append("\"" + key + "\":\"" + CommonString.getFormatPara(map.get(key)) + "\",");
					}
				}
				isHave = getChildren((String) map.get("uuid"), channels);
				if (!"".equals(isHave)) {
					b.append(isHave);
				} else {
					if (null != b && b.length() > 1) {
						b.setLength(b.length() - 1);
					}
				}
				a.append(b);
				a.append("},");
			}
			if (null != a && a.length() > 1) {
				a.setLength(a.length() - 1);
			}
			child.append(a);
			child.append("]");
		}
		return child.toString();
	}

	/**
	 * 获得子栏目
	 * 
	 * @param no
	 *            父栏目编号
	 * @param channels
	 *            所有频道
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getChildren(String no, List<Map> channels, String parentField, String field) {
		StringBuffer child = new StringBuffer();
		List<Map> children = new ArrayList<Map>(0);
		String parentUUID = "";
		for (Map map : channels) {
			parentUUID = map.get(parentField).toString() == null ? "" : (String) map.get(parentField).toString();
			if (parentUUID.equals(no)) {
				children.add(map);
			}
		}
		String isHave = "";
		if (null != children && children.size() > 0) {
			child.append("\"children\":[");
			StringBuffer a = new StringBuffer();
			for (Map map : children) {
				a.append("{");
				StringBuffer b = new StringBuffer();
				for (Object key : map.keySet()) {
					if (!key.toString().equals("intro")) {
						b.append("\"" + key + "\":\"" + CommonString.getFormatPara(map.get(key)) + "\",");
					}
				}
				isHave = getChildren(map.get(field).toString(), channels, parentField, field);
				if (!"".equals(isHave)) {
					b.append(isHave);
				} else {
					if (null != b && b.length() > 1) {
						b.setLength(b.length() - 1);
					}
				}
				a.append(b);
				a.append("},");
			}
			if (null != a && a.length() > 1) {
				a.setLength(a.length() - 1);
			}
			child.append(a);
			child.append("]");
		}
		return child.toString();
	}

	/**
	 * Map对象转换为日志记录字符窜
	 * 
	 * @param model
	 *            要记录的数据
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String mapToLog(Map model) {
		StringBuffer log = new StringBuffer(",");
		for (Object key : model.keySet()) {
			log.append("[" + key + "=" + model.get(key) + "],");
		}
		return log.toString();
	}

	/**
	 * 获取小图片
	 * 
	 * @param img
	 * @return
	 */
	public static String getSmallImg(String img) {
		if (null == img || img.indexOf("/") < 0) {
			return "";
		}
		img = img.substring(0, img.lastIndexOf("/")) + "/small" + img.substring(img.lastIndexOf("/"));
		return img;
	}

	/**
	 * 字符防注入
	 * 
	 * @param str
	 * @return
	 */
	public static String securityFilter(String str) {
		Common.println("str=" + str);
		if (null != str) {
			str = str.replace("00:00:00.0", "").replace(":00.0", "").replace("'", "").replace("\"", "").replaceAll("\\b[sS][cC][rR][iI][pP][tT]\\b", "").replaceAll(
					"\\b[aA][nN][dD]\\b ", "").replaceAll("\\b[oO][rR]\\b ", "").replace("--", "").replaceAll("\\b[iI][fF][rR][aA][mM][eE]\\b", "").replaceAll(".*([';]+|(--)+).*",
					" ").trim();
		}
		return str;
	}

	// 根据IP获得省市
	public static String[] getAreaInfoList(String ip) {
		String urlString = "";
		String[] areaArr = new String[10];
		String[] newAreaArr = new String[2];
		urlString = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?ip=" + ip;
		try {
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.connect();
			InputStream is = conn.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is, "gb2312"));
			String line = "";
			StringBuffer resultBuffer = new StringBuffer();
			while ((line = br.readLine()) != null) {
				resultBuffer.append(line);

			}
			br.close();
			is.close();
			conn.disconnect();
			areaArr = (resultBuffer.toString()).split("	");
			newAreaArr[0] = areaArr[4];
			newAreaArr[1] = areaArr[5];
		} catch (Exception e) {
			// TODO: handle exception
		}

		return newAreaArr;
	}
	
	// 过滤关键词
	public static Boolean filterKeyWords(HttpServletRequest request) {
		Map userInfo = (HashMap) request.getSession()
				.getAttribute("memberInfo");  
		String mem_no = "";
		String add_ip = "";
		if (userInfo != null) {
			if (userInfo.get("mem_no") != null) {
				mem_no = (String) userInfo.get("mem_no");
			}
			if (userInfo.get("add_ip") != null)
				add_ip = (String) userInfo.get("add_ip");
			else {
				add_ip = request.getRemoteAddr();
			}
		}
		Boolean isFilter = Boolean.valueOf(false); 
		PoolManager web21sun = PoolManager.getInstance(); 
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement preparedStatement = null;
		String realKeyWords = "";
		try {
			String filter_keywords = "";
			String sql = "";
			Object filterObj = request.getSession().getServletContext().getAttribute("filter_keywords");
			if (!CommonString.getFormatPara(filterObj).equals("")) {
				filter_keywords = CommonString.getFormatPara(filterObj);
			}else {
				conn = web21sun.getConnection();
				conn.setAutoCommit(false);
				sql = " select keyword from comm_filter_keywords where is_use = 1 ";
				preparedStatement = conn.prepareStatement(sql);
				rs = preparedStatement.executeQuery();
				String kw = "";
				while (rs.next()) {
					kw = rs.getString("keyword");
					kw = CommonString.getFormatPara(kw).replace("|", "@@").replace("-", "\\-").replace(".", "\\.").replace("?", "\\?").replace("[", "\\[").replace("]", "\\]").replace("{", "\\{").replace("}", "\\}").replace("+", "\\+").replace("*", "\\*");
					if ((kw != null) && (!"".equals(kw))) {
						filter_keywords += kw + "|";
					}
				}
				if (!filter_keywords.equals("")) {
					filter_keywords = filter_keywords.substring(0, filter_keywords.length() - 1);
				}
				request.getSession().getServletContext().setAttribute("filter_keywords", filter_keywords);
				if (rs != null) {
					rs.close();
				}
			}
			
			if (!filter_keywords.equals("")) {
				filter_keywords = filter_keywords.replace("|", ")|(").replace("@@", "\\|");
				
				Pattern filterKeywordsPatt = Pattern.compile("(" + filter_keywords + ")", Pattern.CASE_INSENSITIVE);
				Matcher filterKeywordsMat = null;
				
				//判断ip是否被封
				filterKeywordsMat = filterKeywordsPatt.matcher(add_ip);
				if (filterKeywordsMat.find()) {
					realKeyWords = filterKeywordsMat.group().trim();
					isFilter = true;
				}
				
				//如果没封ip，判断是否包含关键词
				if (!isFilter) {
					String keywords = "";
					for (Object key : request.getParameterMap().values()) {
						if (key == null)
							continue;
						if ((key instanceof String[])) {
							keywords = ((String[]) key)[0];
						}
						if ((key instanceof String)) {
							keywords = key.toString();
						}
						keywords = keywords.replaceAll(" ", "");
						keywords = CommonString.getFormatPara(keywords);
						filterKeywordsMat = filterKeywordsPatt.matcher(keywords);
						if (filterKeywordsMat.find()) {
							realKeyWords = filterKeywordsMat.group().trim();
							isFilter = true;
							break;
						}
					}
				}
			}
			if (isFilter) {
				sql = " insert into comm_filter_records ( add_date , ip , mem_no , keywords ) ";
				sql = sql + " values ('"
						+ CommonDate.getToday("yyyy-MM-dd HH:mm:ss") + "','"
						+ add_ip + "','" + mem_no + "','" + realKeyWords
						+ "') ";
				if (conn == null) {
					conn = web21sun.getConnection();
					conn.setAutoCommit(false);
				}
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.execute();
				// request.getSession().removeAttribute("memberInfo");
			}
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			
			if (conn != null) {
				conn.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			web21sun.freeConnection(conn);
		}
		return isFilter;
	}

}
