<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
        String id = CommonString.getFormatPara(request.getParameter("group_id"));
		String products_ids = CommonString.getFormatPara(request.getParameter("products_ids"));
		String tableName = "pro_ymt_activity";
		 
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				model = dbHelper.getMap(" select * from pro_ymt_activity where id = ? ",new Object [] {id},connection);
				Map formMap = dbHelper.getMap(" select * from pro_products where id = ? ",new Object [] {CommonString.getFormatPara(model.get("pro_id"))},connection);
				
				//开始查产品
				
				Map proMap=null;
				String sql="";
				String pro_ids []=products_ids.split(",");
			    Object [] [] params=null;
			    int []par=null;
				for(int i=0;i<pro_ids.length;i++){
				String p_id=pro_ids[i];
				 proMap = dbHelper.getMap(" select * from pro_products where id = ? ",new Object [] {p_id},connection);
				
				sql = " INSERT INTO pro_ymt_products ( add_user , add_date , add_ip , uuid ,catalogid,factoryid,factoryname,catalogname,name,introduce,file_name,img2,page_hot_flag,is_show) ";
				sql += " VALUES ( ? , ? , ? , ? , ? , ?,?,?,?,?,?,? ,?,?) ";
				
					params=new Object [1] [14];
				    params[0][0]="XXXX";
					params[0][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
					params[0][2]=Common.getIp(request);
					params[0][3]=CommonString.getUUID();
					params[0][4]=id;
					params[0][5]=CommonString.getFormatPara(proMap.get("factoryid"));
					params[0][6]=CommonString.getFormatPara(proMap.get("factoryname"));
					params[0][7]=CommonString.getFormatPara(proMap.get("catalogname"));
					params[0][8]=CommonString.getFormatPara(proMap.get("name"));
					params[0][9]=CommonString.getFormatPara(proMap.get("introduce"));
					params[0][10]=CommonString.getFormatPara(proMap.get("file_name"));
					params[0][11]=CommonString.getFormatPara(proMap.get("img2"));
					params[0][12]=CommonString.getFormatPara(proMap.get("id"));
					params[0][13]=1;
					par=dbHelper.executeBatch(sql,params,connection);
				}
				%>
				<script>
				alert("选择成功");
				history.back();
				</script>
				<%
				
				
				
				
				
				
				


	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>