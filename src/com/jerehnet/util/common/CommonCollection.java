package com.jerehnet.util.common;

import java.util.*;

/**
 * 集合操作类
 */
public class CommonCollection {

	/**
	 * 将集合中的行转化成Map形式
	 * 
	 * @param list
	 *            要转化的集合
	 * @param key
	 *            集合中转化为Key的属性
	 * @param value
	 *            集合中转化为Value的属性
	 * @return 转化后的集合
	 */
	@SuppressWarnings("unchecked")
	public static Map listToMap(List<Map> list, String key, String value) {
		Map map = new HashMap();
		for (Map m : list) {
			map.put(m.get(key), m.get(value));
		}
		return map;
	}
	
}
