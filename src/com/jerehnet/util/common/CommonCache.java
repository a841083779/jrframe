package com.jerehnet.util.common;

import java.util.Date;
import com.opensymphony.oscache.base.NeedsRefreshException;
import com.opensymphony.oscache.general.GeneralCacheAdministrator;

/**
 * 手动缓存帮助类
 * 
 * @author Administrator
 * 
 */
@SuppressWarnings("serial")
public class CommonCache extends GeneralCacheAdministrator {

	private static CommonCache commonCache = null;

	private CommonCache() {

	}

	public static CommonCache getInstance() {
		if (null == commonCache) {
			commonCache = new CommonCache(CommonString.getFormatInt(Env
					.getInstance().getProperty("lucene_cache")));
		}
		return commonCache;
	}

	public static CommonCache getInstance(int refreshPeriod) {
		return new CommonCache(refreshPeriod);
	}

	// 过期时间(单位为秒);
	private int refreshPeriod;

	/**
	 * 构造器
	 * 
	 * @param 过期时间
	 */
	private CommonCache(int refreshPeriod) {
		super();
		this.refreshPeriod = refreshPeriod;
	}

	// 添加被缓存的对象;
	public void put(String key, Object value) {
		// 调用父类putInCache（String key, Object content）方法
		this.putInCache(key, value);
	}

	// 删除被缓存的对象;
	public void remove(String key) {
		// 调用父类flushEntry（String key）方法
		this.flushEntry(key);
	}

	// 删除所有被缓存的对象;
	public void removeAll(Date date) {
		// 调用父类flushAll（Date date）方法
		this.flushAll(date);
	}

	public void removeAll() {
		// 调用父类flushAll（）方法
		this.flushAll();
	}

	// 获取被缓存的对象;
	public Object get(String key) throws Exception {
		try {
			return this.getFromCache(key, this.refreshPeriod);
		} catch (NeedsRefreshException e) {
			this.cancelUpdate(key);
			throw e;
		}

	}
}
