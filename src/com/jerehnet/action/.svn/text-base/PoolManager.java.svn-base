package com.jerehnet.action;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * 
 * @author jereh
 * 
 * 连接池的连接释放操作
 * 
 */

public class PoolManager {

	DataSource ds = null;

	private static PoolManager instance;

	/**
	 * 返回惟一实例,如果是第一次调用些方法,则创建该实例
	 * 
	 * @return
	 */
	public static synchronized PoolManager getInstance() {
		if (instance == null) {
			instance = new PoolManager();
		}
		return instance;

	}

	/**
	 * 构造函数实现类的初始化 功能：注册驱动程序，根据最小连接数生成连接
	 * 
	 */
	public PoolManager() {
		try {
			InitialContext ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/web21sun_pro");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 从连接池获得一个可用连接,如没有空闲的连接且当前连接数小于最大连接数 限制,则创建新的连接
	 * 
	 * @return Connection 返回一个连接
	 */
	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = ds.getConnection();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return conn;
	}

	/**
	 * 将不再使用的连接返回给连接池
	 * 
	 * @param conn
	 */
	public void freeConnection(Connection conn) {
		try {
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}