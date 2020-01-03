package com.jerehnet.util.common;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 表单生成类
 */
public class CommonForm {

	/**
	 * 创建下拉框
	 * 
	 * @param map
	 *            数据
	 * @param checkedValue
	 *            选择的值
	 * @return
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	public static String createSelect(Map map, String checkedValue) {
		if (null == map) {
			return "&nbsp;";
		}
		StringBuffer options = new StringBuffer();
		for (Object key : map.keySet()) {
			if (checkedValue.equals(key.toString())) {
				options.append("<option selected='selected' value='" + key
						+ "'>" + map.get(key) + "</option>");
			} else {
				options.append("<option value='" + key + "'>" + map.get(key)
						+ "</option>");
			}
		}
		return options.toString();
	}
	
	/**
	 * 创建下拉框
	 * 
	 * @param map
	 *            数据
	 * @param checkedValue
	 *            选择的值
	 * @return
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	public static String createSelect(List<Map> list, String checkedValue ,String field,String fieldName) {
		if (null == list) {
			return "&nbsp;";
		}
		StringBuffer options = new StringBuffer();
		for (Map m : list) {
			if (checkedValue.equals(m.get(field).toString())) {
				options.append("<option selected='selected' value='" + m.get(field).toString()
						+ "'>" + CommonForm.getSpace(m.get("num").toString(), 1)+ m.get(fieldName).toString() + "</option>");
			} else {
				options.append("<option value='" + m.get(field).toString() + "'>" +  CommonForm.getSpace(m.get("num").toString(), 1)+ m.get(fieldName).toString()
						+ "</option>");
			}
		}
		return options.toString();
	}

	/**
	 * 创建是否单选框
	 * 
	 * @param checkedValue
	 *            选中的值
	 * @param name
	 *            表单名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String createIsRadio(String checkedValue, String name) {
		Map sexMap = new HashMap();
		sexMap.put("1", "是");
		sexMap.put("0", "否");
		return createRadio(sexMap, checkedValue, name);
	}

	/**
	 * 创建性别单选框
	 * 
	 * @param checkedValue
	 *            选中的值
	 * @param name
	 *            表单名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String createSexRadio(String checkedValue, String name) {
		Map sexMap = new HashMap();
		sexMap.put("1", "男");
		sexMap.put("0", "女");
		return createRadio(sexMap, checkedValue, name);
	}

	/**
	 * 创建单选框
	 * 
	 * @param map
	 *            数据
	 * @param checkedValue
	 *            选中的值
	 * @param name
	 *            生成的input的名称
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public static String createRadio(Map map, String checkedValue, String name) {
		if (null == map) {
			return "&nbsp;";
		}
		StringBuffer radios = new StringBuffer();
		int i = 0;
		radios.append("<div class='jr_radio_group'>");
		for (Object key : map.keySet()) {
			if (checkedValue.equals(key.toString())) {
				radios.append("<input class='jr_radio' checked='checked' type='radio' name='"
						+ name
						+ "' id='"
						+ name
						+ i
						+ "' value='"
						+ key
						+ "' />");
				radios.append("<label for='" + name + i + "'>" + map.get(key)
						+ "</label>");
			} else if (i == 0) {
				radios.append("<input checked='checked' class='jr_radio' type='radio' name='"
						+ name
						+ "' id='"
						+ name
						+ i
						+ "' value='"
						+ key
						+ "' />");
				radios.append("<label for='" + name + i + "'>" + map.get(key)
						+ "</label>");
			} else {
				radios.append("<input class='jr_radio' type='radio' name='"
						+ name + "' id='" + name + i + "' value='" + key
						+ "' />");
				radios.append("<label for='" + name + i + "'>" + map.get(key)
						+ "</label>");
			}
			i++;
		}
		radios.append("</div>");
		return radios.toString();
	}

	/**
	 * 创建复选框
	 * 
	 * @param map
	 *            数据
	 * @param checkedValue
	 *            选中的值，用逗号分隔
	 * @param name
	 *            复选框名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String createCheckbox(Map map, String checkedValue,
			String name) {
		if (null == map) {
			return "&nbsp;";
		}
		StringBuffer checkboxs = new StringBuffer();
		String keyStr = "";
		int i = 0;
		checkboxs.append("<div class='jr_checkbox_group'>");
		for (Object key : map.keySet()) {
			keyStr = "," + key + ",";
			if (!"".equals(checkedValue) && keyStr.indexOf(checkedValue) != -1) {
				checkboxs
						.append("<input class='jr_checkbox' checked='checked' type='checkbox' name='"
								+ name
								+ "' id='"
								+ name
								+ i
								+ "' value='"
								+ key + "' />");
				checkboxs.append("<label for='" + name + i + "'>"
						+ map.get(key) + "</label>");
			} else {
				checkboxs
						.append("<input class='jr_checkbox' type='checkbox' name='"
								+ name
								+ "' id='"
								+ name
								+ i
								+ "' value='"
								+ key + "' />");
				checkboxs.append("<label for='" + name + i + "'>"
						+ map.get(key) + "</label>");
			}
			i++;
		}
		checkboxs.append("</div>");
		return checkboxs.toString();
	}

	/**
	 * 根据字符长度获取空格
	 * 
	 * @param str
	 *            字符串
	 * @return Html的空格
	 */
	public static String getHtmlSpaceByString(String str) {
		StringBuffer sb = new StringBuffer();
		if (null != str) {
			for (int i = 0; i < str.length() * 2; i++) {
				sb.append("&nbsp;");
			}
		}
		return sb.toString();
	}
	
	/**
	 * 根据字符长度获取空格
	 * 
	 * @param str
	 *            字符串
	 * @return Html的空格
	 */
	public static String getSpace(String str,int multiple) {
		StringBuffer sb = new StringBuffer();
		if (null != str) {
			for (int i = 0; i < str.length()*multiple; i++) {
				sb.append("&nbsp;");
			}
		}
		return sb.toString();
	}
	
	/**
	 * 条件查询
	 * @param request
	 * @param keys 键值对 
	 * @param main 前缀
	 * @return
	 */
	public static String getParams(HttpServletRequest request,Map<String,String> params,String main){
		StringBuffer conStr = new StringBuffer();
		String prefix = "";
		String field = "";
		String paramKey = null;
		String value = "";
		for(String key : params.keySet()){
			//得到前缀
			prefix = key.substring(0,key.indexOf("_")+1);
			//得到字段
			field = main+"."+key.substring(key.indexOf("_")+1);
			//得到Params里的键
			paramKey = params.get(key);
			value = CommonString.getFormatPara(request.getParameter(paramKey));
			if("".equals(value)){
				continue;
			}
			if(prefix.startsWith("eq_")){
				conStr.append(" AND "+field+" = '"+value+"' ");
			}else if(prefix.startsWith("like_")){
				conStr.append(" LIKE "+field+" '%"+value+"%' ");
			}else if(prefix.startsWith("ne_")){
				conStr.append(" AND "+field+" <> '"+value+"' ");
			}else if(prefix.startsWith("in_")){
				conStr.append(" AND "+field+" IN ("+value+") ");
			}else if(prefix.startsWith("not_")){
				conStr.append(" AND "+field+" NOT IN ("+value+") ");
			}else if(prefix.startsWith("gt_")){
				conStr.append(" AND "+field+" > '"+value+"' ) ");
			}else if(prefix.startsWith("ge_")){
				conStr.append(" AND "+field+" >= '"+value+"' ) ");
			}else if(prefix.startsWith("lt_")){
				conStr.append(" AND "+field+" < '"+value+"' ) ");
			}else if(prefix.startsWith("le_")){
				conStr.append(" AND "+field+" <= '"+value+"' ) ");
			}
		}
		return conStr.toString();
	}

	/**
	 * 条件查询
	 * @param request
	 * @param keys 键值对 
	 * @return
	 */
	public static String getParams(HttpServletRequest request,Map<String,String> params){
		StringBuffer conStr = new StringBuffer();
		String prefix = "";
		String field = "";
		String paramKey = null;
		String value = "";
		for(String key : params.keySet()){
			//得到前缀
			prefix = key.substring(0,key.indexOf("_")+1);
			//得到字段
			field = key.substring(key.indexOf("_")+1);
			//得到Params里的键
			paramKey = params.get(key);
			value = CommonString.getFormatPara(request.getParameter(paramKey));
			if("".equals(value)){
				continue;
			}
			if(prefix.startsWith("eq_")){
				conStr.append(" AND "+field+" = '"+value+"' ");
			}else if(prefix.startsWith("like_")){
				conStr.append(" LIKE "+field+" '%"+value+"%' ");
			}else if(prefix.startsWith("ne_")){
				conStr.append(" AND "+field+" <> '"+value+"' ");
			}else if(prefix.startsWith("in_")){
				conStr.append(" AND "+field+" IN ("+value+") ");
			}else if(prefix.startsWith("not_")){
				conStr.append(" AND "+field+" NOT IN ("+value+") ");
			}else if(prefix.startsWith("gt_")){
				conStr.append(" AND "+field+" > '"+value+"' ) ");
			}else if(prefix.startsWith("ge_")){
				conStr.append(" AND "+field+" >= '"+value+"' ) ");
			}else if(prefix.startsWith("lt_")){
				conStr.append(" AND "+field+" < '"+value+"' ) ");
			}else if(prefix.startsWith("le_")){
				conStr.append(" AND "+field+" <= '"+value+"' ) ");
			}
		}
		return conStr.toString();
	}
}
