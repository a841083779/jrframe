package com.jerehnet.util.dbutil;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import com.jerehnet.util.common.Common;
import com.jerehnet.util.common.Env;

public class DBHelper implements Serializable {

	private static DBHelper dbHelper = null;

	public static synchronized DBHelper getInstance() {
//		if (null == dbHelper) {
//			dbHelper = new DBHelper();
//		}
//		return dbHelper;
		return new DBHelper();
	}

	// jndi名称
	private static String jndi_name = null;

	private static DataSource dataSource = null;

	private DBHelper() {

	}

	static {
		try {
			jndi_name = Env.getInstance().getProperty("jndi_name");
			// 初始化对象
			Context context = new InitialContext();
			// 获得连接对象
			dataSource = (DataSource) context.lookup("java:comp/env/"
					+ jndi_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据名称获取连接池内的链接
	 * 
	 * @return
	 * @throws NamingException
	 * @throws SQLException
	 */
	public Connection getConnection(String name) throws NamingException,
			SQLException {
		Context context = new InitialContext();
		DataSource dataSource = (DataSource) context.lookup("java:comp/env/"
				+ name);
		return dataSource.getConnection();
	}

	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}

	/**
	 * 根据参数获取数据库链接(直连)
	 * 
	 * @param url
	 *            数据库链接字符串
	 * @param user
	 *            用户名
	 * @param pwd
	 *            密码
	 * @param driver
	 *            驱动
	 * @return 数据库链接
	 */
	public Connection getConnection(String url, String user, String pwd,
			String driver) {
		Connection connection = null;
		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(url, user, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

	/**
	 * 通过sql获得Object数组
	 */
	public Object[] getArray(String sql) {
		Object[] objArr = new Object[] {};
		try {
			objArr = new QueryRunner(dataSource).query(sql, new ArrayHandler());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return objArr;
	}

	/**
	 * 获得Map集合
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public List getMapList(String sql) throws SQLException {
		//Common.println(sql) ;         
		return new QueryRunner(dataSource).query(sql, new MapListHandler());
	}  

	/**    
	 * 获得Map集合
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public List getMapList(String sql, Connection connection)
			throws SQLException {
		return new QueryRunner().query(connection, sql, new MapListHandler());
	}

	/**
	 * 获得Map集合
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public List getMapList(String sql, Object[] params) throws SQLException {
		return new QueryRunner(dataSource).query(sql, params, new MapListHandler());
	}

	/**
	 * 获得Map集合
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public List getMapList(String sql, Object[] params, Connection connection)
			throws SQLException {
		return new QueryRunner().query(connection, sql, params, new MapListHandler());
	}

	/**
	 * 获得单条结果
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Object getOne(String sql) throws SQLException {
		Object obj = null;
		Map map = this.getMap(sql);
		if (null != map) {
			for (Object o : map.keySet()) {
				obj = map.get(o);
			}
		}
		return obj;
	}

	/**
	 * 获得单条结果
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Object getOne(String sql, Connection connection) throws SQLException {
		Object obj = null;
		Map map = this.getMap(sql, connection);
		if (null != map) {
			for (Object o : map.keySet()) {
				obj = map.get(o);
			}
		}
		return obj;
	}

	/**
	 * 获得单条结果
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Object getOne(String sql, Object[] params) throws SQLException {
		Object obj = null;
		Map map = this.getMap(sql, params);
		if (null != map) {
			for (Object o : map.keySet()) {
				obj = map.get(o);
			}
		}
		return obj;
	}

	/**
	 * 获得单条结果
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Object getOne(String sql, Object[] params, Connection connection)
			throws SQLException {
		Object obj = null;
		Map map = this.getMap(sql, params, connection);
		if (null != map) {
			for (Object o : map.keySet()) {
				obj = map.get(o);
			}
		}
		return obj;
	}

	/**
	 * 获得单体Map
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Map getMap(String sql) throws SQLException {
		//System.out.println(sql);  
		return new QueryRunner(dataSource).query(sql, new MapHandler());
	}
 
	/**
	 * 获得单体Map  
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Map getMap(String sql, Connection connection) throws SQLException {
		return new QueryRunner().query(connection, sql, new MapHandler());
	}

	/**
	 * 获得单体Map
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Map getMap(String sql, Object[] params) throws SQLException {
		return new QueryRunner(dataSource).query(sql, params, new MapHandler());
	}

	/**
	 * 获得单体Map
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public Map getMap(String sql, Object[] params, Connection connection)
			throws SQLException {
		return new QueryRunner().query(connection, sql, params, new MapHandler());
	}

	/**
	 * 查询获取ResultSet
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public ResultSet executeQuery(String sql) throws SQLException {
		PreparedStatement preparedStatement = this.getConnection()
				.prepareStatement(sql);
		return preparedStatement.executeQuery();
	}

	/**
	 * 查询获取ResultSet
	 * 
	 * @param sql
	 * @param connection
	 *            数据库连接
	 * @return
	 * @throws SQLException
	 */
	public ResultSet executeQuery(String sql, Connection connection)
			throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		return preparedStatement.executeQuery();
	}

	/**
	 * 查询获取ResultSet
	 * 
	 * @param sql
	 * @param params
	 *            参数
	 * @return
	 * @throws SQLException
	 */
	public ResultSet executeQuery(String sql, Object[] params)
			throws SQLException {
		PreparedStatement preparedStatement = this.getConnection()
				.prepareStatement(sql);
		if (null != params) {
			for (int i = 0; i < params.length; i++) {
				preparedStatement.setObject((i + 1), params[i]);
			}
		}
		return preparedStatement.executeQuery();
	}

	/**
	 * 查询获取ResultSet
	 * 
	 * @param sql
	 * @param params
	 *            参数
	 * @return
	 * @throws SQLException
	 */
	public ResultSet executeQuery(String sql, Object[] params,
			Connection connection) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		if (null != params) {
			for (int i = 0; i < params.length; i++) {
				preparedStatement.setObject((i + 1), params[i]);
			}
		}
		return preparedStatement.executeQuery();
	}

	/**
	 * 执行增加、修改、删除操作
	 */
	public int execute(String sql) throws SQLException {
		Common.println(sql+"--*") ;
		Connection connection = null;
		PreparedStatement psmt = null;   
		int key = 0;
		try {
			connection = getConnection();
			connection.setAutoCommit(true);
			psmt = connection.prepareStatement(sql);
			key = psmt.executeUpdate();    
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) { 
			Common.println(e);
		} finally {
			freeConnection(connection);
		}
		return key;
	}

	public int execute(String sql, Connection connection) throws SQLException {
		PreparedStatement psmt = null;
		int key = 0;
		try {
			psmt = connection.prepareStatement(sql);
			key = psmt.executeUpdate();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		}
		return key;
	}

	/**
	 * 防注入方式执行增加、修改、删除操作
	 */
	public int execute(String sql, Object[] params) throws SQLException {
		Connection connection = null;
		PreparedStatement psmt = null;
		int key = 0;
		try {
			connection = getConnection();
			connection.setAutoCommit(true);
			psmt = connection.prepareStatement(sql);
			for (int i = 0; i < params.length; i++) {
				psmt.setObject(i + 1, params[i]);
			}
			key = psmt.executeUpdate();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		} finally {
			freeConnection(connection);
		}
		return key;
	}

	/**
	 * 防注入方式执行增加、修改、删除操作
	 */
	public int execute(String sql, Object[] params, Connection connection)
			throws SQLException {
		PreparedStatement psmt = null;
		int key = 0;
		try {
			psmt = connection.prepareStatement(sql);
			for (int i = 0; i < params.length; i++) {
				psmt.setObject(i + 1, params[i]);
			}
			key = psmt.executeUpdate();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		}
		return key;
	}

	/**
	 * 执行增加、修改、删除操作
	 */
	public int executeUpdate(String sql) throws SQLException {
		Connection connection = null;
		PreparedStatement psmt = null;
		ResultSet keyRs = null;
		int key = 0;
		try {
			connection = getConnection();
			connection.setAutoCommit(false);
			psmt = connection.prepareStatement(sql,
					Statement.RETURN_GENERATED_KEYS);
			key = psmt.executeUpdate();
			keyRs = psmt.getGeneratedKeys();
			if (null != keyRs && keyRs.next()) {
				Long tempKey = keyRs.getLong(1);
				key = tempKey.intValue();
			}
			if (null != keyRs) {
				keyRs.close();
			}
			connection.commit();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		} finally {
			freeConnection(connection);
		}
		return key;
	}

	/**
	 * 执行增加、修改、删除操作
	 */
	public int executeUpdate(String sql, Connection connection)
			throws SQLException {
		PreparedStatement psmt = null;
		ResultSet keyRs = null;
		int key = 0;
		try {
			connection.setAutoCommit(false);
			psmt = connection.prepareStatement(sql,
					Statement.RETURN_GENERATED_KEYS);
			key = psmt.executeUpdate();
			keyRs = psmt.getGeneratedKeys();
			if (null != keyRs && keyRs.next()) {
				Long tempKey = keyRs.getLong(1);
				key = tempKey.intValue();
			}
			if (null != keyRs) {
				keyRs.close();
			}
			connection.commit();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		}
		return key;
	}

	/**
	 * 防注入方式执行增加、修改、删除操作
	 */
	public int executeUpdate(String sql, Object[] params) throws SQLException {
		Connection connection = null;
		PreparedStatement psmt = null;
		ResultSet keyRs = null;
		int key = 0;
		try {
			connection = getConnection();
			connection.setAutoCommit(false);
			psmt = connection.prepareStatement(sql,
					Statement.RETURN_GENERATED_KEYS);
			for (int i = 0; i < params.length; i++) {
				psmt.setObject(i + 1, params[i]);
			}
			key = psmt.executeUpdate();
			keyRs = psmt.getGeneratedKeys();
			if (null != keyRs && keyRs.next()) {
				Long tempKey = keyRs.getLong(1);
				key = tempKey.intValue();
			}
			if (null != keyRs) {
				keyRs.close();
			}
			connection.commit();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		} finally {
			freeConnection(connection);
		}
		return key;
	}

	/**
	 * 防注入方式执行增加、修改、删除操作
	 */
	public int executeUpdate(String sql, Object[] params, Connection connection)
			throws SQLException {
		PreparedStatement psmt = null;
		ResultSet keyRs = null;
		int key = 0;
		try {
			connection.setAutoCommit(false);
			psmt = connection.prepareStatement(sql,
					Statement.RETURN_GENERATED_KEYS);
			for (int i = 0; i < params.length; i++) {
				psmt.setObject(i + 1, params[i]);
			}
			key = psmt.executeUpdate();
			keyRs = psmt.getGeneratedKeys();
			if (null != keyRs && keyRs.next()) {
				Long tempKey = keyRs.getLong(1);
				key = tempKey.intValue();
			}
			if (null != keyRs) {
				keyRs.close();
			}
			connection.commit();
			if(null!=psmt){
				psmt.close();
			}
		} catch (Exception e) {
			Common.println(e);
		}
		return key;
	}

	/**
	 * 批量增加的方法
	 * 
	 * @param sql
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public int[] executeBatch(String sql, Object[][] params)
			throws SQLException {
		return new QueryRunner(dataSource).batch(sql, params);
	}

	/**
	 * 批量增加的方法
	 * 
	 * @param sql
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public int[] executeBatch(String sql, Object[][] params,
			Connection connection) throws SQLException {
		return new QueryRunner().batch(connection, sql, params);
	}

	public static void freeConnection(Connection connection) {
		try {
			if (null != connection && !connection.isClosed()) {
				connection.close();
			}
		} catch (Exception e) {
			Common.println(e);
		}
	}

}
