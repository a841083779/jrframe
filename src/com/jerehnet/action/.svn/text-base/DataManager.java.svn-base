package com.jerehnet.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.util.common.Common;

/**
 * 
 * 数据库数据操作
 * 
 * @author jereh
 * 
 */
public class DataManager {

	/**
	 * 数据插入、删除、修改,SQL直接执行模式
	 * 
	 * @param conn
	 * @param SQL
	 * @return int
	 */
	public static int dataOperation(Connection conn, String SQL) {
		int count = 0;
		Statement stmt = null;
		try {
			conn.setAutoCommit(true);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			count = stmt.executeUpdate(SQL);
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return count;
	}

	public static int dataOperation(PoolManager pool, String SQL) {
		int count = 0;
		Statement stmt = null;
		Connection conn = null;
		try {
			conn = pool.getConnection();
			conn.setAutoCommit(true);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			count = stmt.executeUpdate(SQL);
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return count;
	}

	/**
	 * 根据sql语句返回数据集
	 * 
	 * @param conn
	 * @param sql
	 * @return ResultSet
	 * @throws SQLException
	 */
	public static ResultSet executeQuery(Connection conn, String sql) {
		Common.println("mysql:" + sql);
		ResultSet rs = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	/**
	 * 返回一条数据集
	 * 
	 * @param conn
	 * @param tableName
	 * @param fieldN
	 * @param value
	 * @return
	 * @throws SQLException
	 */
	public static ResultSet getOneData(Connection conn, String tableName, String fieldN, String value) throws SQLException {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			String whereStr = "";
			if (fieldN != null) {
				String fieldName[] = fieldN.split(",");
				for (int i = 0; i < fieldName.length; i++) {
					whereStr += " and " + fieldName[i] + "=? ";
				}
			}
			if (!whereStr.equals("")) {
				whereStr = " where 1=1 " + whereStr;
			}

			if (!whereStr.equals("")) {
				String sql = "select * from " + tableName + whereStr;
				pstmt = conn.prepareStatement(sql);
				String[] values = value.split(",");
				if (values != null) {
					for (int i = 0; i < values.length; i++) {
						pstmt.setString(i + 1, String.valueOf(values[i]));
					}
				}
				rs = pstmt.executeQuery();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	/**
	 * 根据传入的表名，需要现实的字段，条件，返回数据集合
	 * 
	 * @param pool
	 * @param tablename
	 * @param fieldname
	 * @param tj
	 * @return String[][]
	 */
	public static String[][] fetchFieldValue(PoolManager pool, String tablename, String fieldname, String tj) {
		String result[][] = null;
		String strSQL = "";
		Connection conn = pool.getConnection();
		DataManager dataManager = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs = null;
		try {
			dataManager = new DataManager();
			if (tj.equals(""))
				strSQL = "select " + fieldname + " from " + tablename;
			else
				strSQL = "select " + fieldname + " from " + tablename + " where " + tj;
			rs = dataManager.executeQuery(conn, strSQL.toString());
			if (rs != null && rs.next()) {
				rsmd = rs.getMetaData();
				rs.last();
				result = new String[rs.getRow()][rsmd.getColumnCount()]; // 只选一列
				for (int i = 1; i <= result.length; i++) {
					rs.absolute(i);
					for (int k = 1; k <= rsmd.getColumnCount(); k++) {
						result[i - 1][k - 1] = rs.getString(k) != null ? rs.getString(k) : "";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
				rs = null;
			}
		}
		return result;
	}

	/**
	 * 
	 * @param pool
	 * @param tablename
	 * @param fieldname
	 * @param tj
	 * @return
	 */
	public static String[][] fetchFieldValue02(PoolManager pool, String tablename, String fieldname, String tj) {
		String result[][] = null;
		String strSQL = "";
		Connection conn = pool.getConnection();
		DataManager dataManager = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs = null;
		try {
			dataManager = new DataManager();
			if (tj.equals(""))
				strSQL = "select " + fieldname + " from " + tablename;
			else
				strSQL = "select " + fieldname + " from " + tablename + " where " + tj;
			Common.println(strSQL);
			rs = dataManager.executeQuery(conn, strSQL.toString());
			if (rs != null && rs.next()) {
				rsmd = rs.getMetaData();
				rs.last();
				result = new String[rs.getRow()][rsmd.getColumnCount()]; // 只选一列
				for (int i = 1; i <= result.length; i++) {
					rs.absolute(i);
					for (int k = 1; k <= rsmd.getColumnCount(); k++) {
						result[i - 1][k - 1] = rs.getString(k) != null ? rs.getString(k) : "";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
				rs = null;
			}
		}
		return result;
	}

	/**
	 * 根据表名，返回该表的所有字段
	 * 
	 * @param pool
	 * @param table
	 * @return
	 */
	public static String[] getAllFieldNames(PoolManager pool, String table) {
		DataManager datamanager = new DataManager();
		Connection conn = null;
		ResultSet rs = null;
		String[] result = null;
		StringBuffer tablestr = new StringBuffer("select * from " + table + " where id=0");
		try {
			conn = pool.getConnection();
			rs = datamanager.executeQuery(conn, tablestr.toString());
			ResultSetMetaData rsmd = rs.getMetaData();
			result = new String[rsmd.getColumnCount()];
			for (int i = 1; i <= rsmd.getColumnCount(); i++)
				result[i - 1] = rsmd.getColumnName(i);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
		}
		return result;
	}

	/**
	 * 根据页面的文本框名字来生成并执行INSERT，UPDATE事件
	 * 
	 * @param request
	 * @param pool
	 * @param tablename
	 * @return int
	 */
	public static int dataInsUpt(HttpServletRequest request, PoolManager pool, String tablename) {
		int result = 0;
		java.util.Enumeration argNames = request.getParameterNames();
		String argName, preName, endName;
		String fieldNames = "id";
		while (argNames.hasMoreElements()) {
			argName = String.valueOf(argNames.nextElement());
			if (argName.length() < 3) {
				continue;
			}
			preName = argName.substring(0, 3);
			endName = argName.substring(3);
			if (preName.equalsIgnoreCase("zd_")) {
				if (endName.equals("id"))
					continue;
				fieldNames += "," + endName;
			}
		}
		// 根据页面得到数据库表的字段
		String fieldNameArr[] = fieldNames.split(",");
		String[][] fieldValueArr = new String[fieldNameArr.length][];
		// 根据表字段，得到表单相应的值
		if (fieldValueArr != null) {
			for (int i = 0; i <= fieldValueArr.length - 1; i++) {
				fieldValueArr[i] = request.getParameterValues("zd_" + fieldNameArr[i]);
			}
		}
		if (fieldValueArr != null) {
			for (int k = 0; fieldValueArr[0] != null && k < fieldValueArr[0].length; k++) {
				String[] fieldV = new String[fieldValueArr.length];
				for (int m = 0; m < fieldValueArr.length; m++) {
					if (fieldValueArr[m] != null && fieldValueArr[m][k] != null) {
						if (fieldValueArr[m][k] != null)
							fieldValueArr[m][k] = fieldValueArr[m][k].trim();
						fieldV[m] = fieldValueArr[m][k];
					} else
						fieldV[m] = null;
				}
				if (fieldV[0].equals("0")) {
					result = DataManager.executeSQL(pool, 1, fieldV, tablename, fieldNames);
				} else {
					result = DataManager.executeSQL(pool, 2, fieldV, tablename, fieldNames);
				}
			}
		}
		return result;
	}

	/**
	 * 辅助dataInsUpt，执行INSERT,UPDATE SQL语句
	 * 
	 * @param pool
	 * @param flag
	 *            标识id 1 插入 2 更新
	 * @param fieldValue
	 * @param tablename
	 * @param fieldNames
	 * @return int
	 */
	public static int executeSQL(PoolManager pool, int flag, String fieldValue[], String tablename, String fieldNames) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = pool.getConnection();
			switch (flag) {
			case 1: {
				pstmt = conn.prepareStatement(createSQL(tablename, "", 0, fieldNames)); // 执行插入操作
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
					Common.println(".." + fieldValue[i]);
				}
				break;
			}
			case 2: {
				pstmt = conn.prepareStatement(createSQL(tablename, fieldValue[0], 2, fieldNames)); // update
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			default:
				break;
			}
			if (pstmt.executeUpdate() > 0) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
				pstmt = null;
			}
		}
		return result;
	}

	/**
	 * 辅助dataInsUpt，执行INSERT,UPDATE SQL语句
	 * 
	 * @param pool
	 * @param flag
	 *            标识id 1 插入 2 更新
	 * @param fieldValue
	 * @param tablename
	 * @param fieldNames
	 * @return int
	 */
	public static int myexecuteSQL(PoolManager pool, int flag, String fieldValue[], String tablename, String fieldNames) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = pool.getConnection();
			switch (flag) {
			case 1: {
				pstmt = conn.prepareStatement(createSQL(tablename, "", 0, fieldNames)); // 执行插入操作
				String[] myfieldNames = fieldNames.split(",");// 拆分列名字
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					} else if (myfieldNames[i].equals("add_date")) {
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fieldValue[i]);
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			case 2: {
				pstmt = conn.prepareStatement(createSQL(tablename, fieldValue[0], 2, fieldNames)); // update
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			default:
				break;
			}
			if (pstmt.executeUpdate() > 0) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
				pstmt = null;
			}
		}
		return result;
	}

	/**
	 * 根据传入的逗号分隔符字符串，分隔生成SQL语句
	 * 
	 * @param table
	 * @param id
	 * @param flag
	 * @param fieldNames
	 * @return
	 */
	public static String createSQL(String table, String id, int flag, String fieldNames) {
		String SQL = "";
		String[] fieldName = fieldNames.split(",");
		switch (flag) {
		case 0: {
			String nm = "";
			String va = "";
			for (int i = 1; i < fieldName.length; i++) {
				if (i == (fieldName.length - 1)) {
					va += "?";
					nm += fieldName[i];
				} else {
					va += "?,";
					nm += fieldName[i] + ",";
				}
			}
			SQL = " insert into " + table + "(" + nm + ") values(" + va + ")";
			Common.println(".." + SQL);
			break;
		}
		case 2: {
			SQL = " update " + table + " set ";
			for (int i = 1; i < fieldName.length; i++) {
				if (i == (fieldName.length - 1))
					SQL += fieldName[i] + "=?";
				else
					SQL += fieldName[i] + "=?,";
			}
			SQL += " where id=" + id;
			break;
		}
		default:
			break;
		}
		return SQL;
	}

	/**
	 * 根据传入的request，获取id数组，然后删除id值对应的数据
	 * 
	 * @param request
	 * @param conn
	 * @param talbeName
	 * @return
	 */
	public static int deleteDatas(HttpServletRequest request, Connection conn, String talbeName) {
		int result = 0;
		String[] id = request.getParameterValues("id");
		if (id != null && id.length > 0) {
			for (int i = 0; i < id.length; i++) {
				String SQL = "delete from " + talbeName + "  where  id=" + id[i];
				result += DataManager.dataOperation(conn, SQL);
			}
		}

		return result;
	}

	/**
	 * 删除单条数据
	 * 
	 * @param request
	 * @param conn
	 * @param talbeName
	 * @return
	 */
	public static int deleteData(String tablename, String id, PoolManager pool) {
		int result = 0;
		String sql = "delete from " + tablename + "  where  id='" + id + "'";
		Connection conn = null;
		try {
			conn = pool.getConnection();
			result = DataManager.dataOperation(conn, sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
		}
		return result;
	}

	/**
	 * 执行带参数的数据库语句
	 * 
	 * @param conn
	 * @param SQL
	 * @param paras
	 * @return
	 */
	public static int dataOperation(Connection conn, String SQL, Object[] paras) {
		int count = 0;
		PreparedStatement stmt = null;
		try {
			conn.setAutoCommit(true);
			stmt = conn.prepareStatement(SQL);
			for (int i = 0; i < paras.length; i++) {
				stmt.setObject(i + 1, paras[i]);
			}
			count = stmt.executeUpdate();
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return count;
	}

	// --------------------------main-------------------------------------------
	public static void main(String args[]) {

	}
}