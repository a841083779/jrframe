<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		//查询所有拥有浏览历史的产品ID
		String sql = " select product_id";
		sql += "  from pro_products_view_record ";
		sql += " group by product_id ";
		List<Map> list = dbHelper.getMapList(sql,connection);
		if(null!=list){
			//查询每一个产品的其它浏览记录
			List<Map> list1 = null;
			for(Map m : list){
				sql = "";
				sql += " select product_id,count(*) as counts from ";
				sql += " pro_products_view_record ";
				sql += " where product_id <> "+CommonString.getFormatPara(m.get("product_id"))+" and session_id in ( ";
				sql += " select session_id from ";
				sql += " dbo.pro_products_view_record ";
				sql += " where product_id = "+CommonString.getFormatPara(m.get("product_id"));
				sql += " ) ";
				sql += " group by product_id ";
				list1 = dbHelper.getMapList(sql,connection);
				if(null!=list1){
					Integer counts = 0;
					for(Map m1 : list1){
						//查询是否存在
						sql = " select count(*) from pro_products_view_relation where product_id = ? and other_product_id = ? ";
						counts = CommonString.getFormatInt(dbHelper.getOne(sql,new Object [] {
								CommonString.getFormatInt(m.get("product_id")),CommonString.getFormatInt(m1.get("product_id"))
						},connection));
						//如果存在
						if(counts>0){
							sql = " update pro_products_view_relation set counts = counts + "+CommonString.getFormatInt(m1.get("counts"));
							sql += "where product_id = "+CommonString.getFormatInt(m.get("product_id"));
							sql += " and other_product_id = "+CommonString.getFormatInt(m1.get("product_id"));
							dbHelper.execute(sql,connection);
						}else{//如果不存在
							sql = " insert into pro_products_view_relation ( product_id , other_product_id , counts ) ";
							sql += " values ( ? , ? , ? ) ";
							dbHelper.execute(sql,new Object [] {
									CommonString.getFormatInt(m.get("product_id")),
									CommonString.getFormatInt(m1.get("product_id")),
									CommonString.getFormatInt(m1.get("counts"))
							},connection);
						}
					}
				}
			}
		}
		sql = " truncate table pro_products_view_record ";
		dbHelper.execute(sql,connection);
	}catch(Exception e){
		
	}finally{
		DBHelper.freeConnection(connection);
	}
%>