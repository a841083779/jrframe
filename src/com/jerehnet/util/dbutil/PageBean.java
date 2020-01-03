package com.jerehnet.util.dbutil;

import java.io.Serializable;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.common.Env;
import com.jerehnet.webservice.WEBDBHelper;

@SuppressWarnings("serial")
public class PageBean implements Serializable {
	private DBHelper dbHelper;

	public PageBean() {
		dbHelper = DBHelper.getInstance();
	}

	// 字段
	private String fields = "*";
	// 当前页
	private Integer nowPage = 1;
	// 分页大小
	private Integer pageSize = 20;
	// 表名
	private String tableName = "";
	// 多表联查时主表
	private String main = "";
	// 查询条件
	private String condition = "";
	// 排序条件
	private String orderBy = "";
	// 保持条件的参数
	private String params = "";
	// 是否显示SQL
	private Boolean isShowSql = Boolean.FALSE;
	// 总页数
	private Integer pageCount = 0;
	// 总条数
	private Integer total = 0;
	// 存放数据的List
	private List<Map> datas;

	public void setNowPage(String nowPage) {
		if (!"".equals(nowPage) && CommonString.isInt(nowPage)) {
			this.nowPage = Integer.parseInt(nowPage);
			if (this.nowPage < 1) {
				this.nowPage = 1;
			}
		} else {
			this.nowPage = 1;
		}
	}

	// 默认分页样式
	public String getPageBar() {
		Integer prevInt = (this.nowPage - 1) == 0 ? 1 : (this.nowPage - 1);
		Integer nextInt = (this.nowPage + 1) == this.total ? this.total : (this.nowPage + 1);
		StringBuffer pageBar = new StringBuffer();
		pageBar.append("<div class='paging'>");
		pageBar.append("共<font color='#ff6600'>" + this.total + "</font>条 ");
		pageBar.append("第<font color='#ff6600'>" + this.nowPage + "</font>页 ");
		pageBar.append(" / ");
		pageBar.append("共<font color='#ff6600' id='allTotal'>" + this.pageCount + "</font>页");
		if (this.nowPage > 1) {
			pageBar.append(" <a href='?nowPage=1" + this.params + "'>首页</a> ");
			pageBar.append("<a href='?nowPage=" + prevInt + this.params + "'>上一页</a>");
		} else {
			pageBar.append(" ");
		}
		int left = 0;
		int right = 0;
		int middle = this.nowPage;
		if (middle > 5) {
			left = middle - 5;
			if (middle >= (this.pageCount - 5)) {
				right = this.pageCount;
			} else {
				right = middle + 5;
			}
		} else if (middle <= 5 && this.pageCount > 10) {
			right = 10;
		} else {
			right = this.pageCount;
		}
		for (int i = left; i < right; i++) {
			if ((i + 1) == this.nowPage) {
				pageBar.append("<span class='current'>" + this.nowPage + "</span>");
			} else {
				pageBar.append("<a href='?nowPage=" + (i + 1) + this.params + "'>" + (i + 1) + "</a>");
			}
		}
		if (this.nowPage < this.pageCount) {
			pageBar.append("<a href='?nowPage=" + nextInt + this.params + "'>下一页</a>");
			pageBar.append(" <a href='?nowPage=" + this.pageCount + this.params + "'>尾页</a>");
		} else {
			pageBar.append("");
		}
		return pageBar.toString();
	}

	public String getUpPageBar() {
		StringBuffer uppage = new StringBuffer();
		Integer preInt = (getNowPage() - 1) == 0 ? 1 : (getNowPage() - 1);
		Integer nextInt = (getNowPage() + 1) == getPageCount() ? getPageCount() : (getNowPage() + 1);
		if (getNowPage() == 1) {
			uppage.append("<a href='javascript:;' class='pre noPre' title='上一页'>&nbsp;</a>");  
		} else {
			uppage.append("<a href='?offset=" + ((preInt - 1) * getPageSize()) + getParams() + "' class='pre noPre' title='上一页'>&nbsp;</a>");
		}
		uppage.append("<b>" + (getNowPage()) + "/" + (getPageCount()) + "</b>");
		if (getTotal() > 0) {
			if (getNowPage() == getPageCount()) {
				uppage.append("<a href='javascript:;' class='next'>&nbsp;</a>");
			} else {
				uppage.append("<a href='?offset=" + ((nextInt - 1) * getPageSize()) + getParams() + "' class='next'>&nbsp;</a>");
			}
		}
		return uppage.toString();
	}

	// 偏移量
	public Integer getOffset() {
		return this.pageSize * (this.nowPage - 1);
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public Integer getTotal() {
		return total;
	}

	public void setIsShowSql(Boolean isShowSql) {
		this.isShowSql = isShowSql;
	}

	public void setFields(String fields) {
		this.fields = fields;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public void setMain(String main) {
		this.main = main + ".";
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public void setOrderBy(String orderBy) {
		if (!"".equals(orderBy)) {
			this.orderBy = " order by " + orderBy;
		} else {
			this.orderBy = "";
		}
	}

	public void setParams(String params) {
		this.params = params;
	}

	public Integer getNowPage() {
		return nowPage;
	}

	public void setNowPage(Integer nowPage) {
		this.nowPage = nowPage;
	}

	public String getFields() {
		return fields;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public String getTableName() {
		return tableName;
	}

	public String getMain() {
		return main;
	}

	public String getCondition() {
		return condition;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public String getParams() {
		return params;
	}

	public Boolean getIsShowSql() {
		return isShowSql;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	/**
	 * 为LigerUI执行数据查询并返回匹配数据
	 * 
	 * @return
	 * @throws JSONException
	 */
	public String getJson() throws JSONException {
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray(this.getDatas());
		jsonObject.put("Rows", jsonArray);
		jsonObject.put("Total", this.getTotal());
		return jsonObject.toString();
	}

	public List<Map> getDatas(Connection connection) {
		List<Map> datas = new ArrayList<Map>(0);
		Map m = null;
		try {
			String sql = " select count(" + main + "id) as counts from " + this.tableName + " where 1=1 " + this.condition;
			if (this.isShowSql) {
				System.out.println(sql);
			}  
			// 总条数
			this.total = (Integer) dbHelper.getOne(sql, connection);
			// 总页数
			this.pageCount = (int) Math.ceil((double) this.getTotal() / this.pageSize);
			if (this.pageCount > 0 && this.nowPage > this.pageCount) {
				this.nowPage = this.pageCount;
			}
			if (Env.getInstance().get("dbtype").equals("mssql")) {
				sql = " select top " + this.pageSize + " " + this.fields + " from " + this.tableName + " where 1=1  " + this.condition + " and " + this.main
						+ "id not in ( select top " + this.getOffset() + " " + this.main + "id from " + this.tableName + " where 1=1 " + this.condition + this.orderBy + " ) "
						+ this.orderBy;
			}
			if (Env.getInstance().get("dbtype").equals("mysql")) {
				sql = " select " + this.fields + " from " + this.tableName + this.condition + this.orderBy + " limit " + this.getOffset() + "," + this.pageSize;
			}
			if (this.isShowSql) {
				System.out.println(sql);
			}
			datas = dbHelper.getMapList(sql, connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.datas = datas;
		return datas;
	}

	/**
	 * 获取数据
	 * 
	 * @return
	 */
	public List<Map> getDatas() {
		Connection connection = null;
		List<Map> datas = new ArrayList<Map>(0);
		Map m = null;
		try {
			connection = dbHelper.getConnection();
			connection.setAutoCommit(false);
			datas = getDatas(connection);
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBHelper.freeConnection(connection);
		}
		this.datas = datas;
		return datas;
	}

	/**
	 * 获取原始数据
	 * 
	 * @return
	 */
	public List<Map> getOriginalDatas() {
		return this.datas;
	}
	
	  public List<Map> getDatasByWebService(String wsdl)
	    throws MalformedURLException, Exception
	  {
	    return WEBDBHelper.getMapListByPage(this, wsdl);
	  }

}