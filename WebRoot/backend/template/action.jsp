<%@ page language="java" import="org.json.*,java.sql.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	Connection connection = null;
	Map model = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	try{
		connection = dbHelper.getConnection();
		if(flag.equals("tables")){
			String tableSql = " select name from sysobjects where xtype='U'and name<>'dtproperties' ";
			tableSql += " and name not like '"+tablePrefix+"common_%' ";
			tableSql += " and name like '"+tablePrefix+"%'";
			tableSql += " order by name ";
			List tbs = dbHelper.getMapList(tableSql,connection);
			JSONObject jsonObject = new JSONObject();
			JSONArray jsonArray = new JSONArray(tbs);
			jsonObject.put("Rows", jsonArray);
			jsonObject.put("Total", tbs.size());
			out.print(jsonObject.toString());
		}
		if(flag.equals("list")){
			String name = CommonString.getFormatPara(request.getParameter("name"));
	    	String sql = " select a.name,a.length,b.name as type from syscolumns a,systypes b,sysobjects c where a.xtype=b.xtype and a.id=c.id and c.name= '"+name+"'";
	    	List columns =  dbHelper.getMapList(sql,connection);
	    	for(int i=0;i<columns.size();i++){
	    		model = (Map)columns.get(i);
	    	}
		}
		
		//数据库复制
		if (flag.equals("copy_database")) {
			int step = Integer.parseInt(CommonString.getFormatPara(request.getParameter("step")));
			switch (step) {
			case 1:
				String dbsource = CommonString.getFormatPara(request.getParameter("dbsource"));
				List tableList = dbHelper.getMapList("select name from sysobjects where type='U' and substring(name,0,charindex('_',name))='" + dbsource + "'");
				JSONArray jsonAry = new JSONArray(tableList);
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("Rows", jsonAry);
				jsonObj.put("Total", tableList.size());
				out.print(jsonObj.toString());
				break;
			case 2:
				String tableSource = CommonString.getFormatPara(request.getParameter("tableNames"));
				String newdbname = CommonString.getFormatPara(request.getParameter("newdbname"));
				List<String> tblSourceList = new ArrayList<String>();
				StringTokenizer st = new StringTokenizer(tableSource, "|");
				while (st.hasMoreElements()) {
					tblSourceList.add(st.nextElement().toString());
				}
				String sql = "";
				try {
					connection.setAutoCommit(false);
					for (String tblName : tblSourceList) {
						String newTableName = newdbname + tblName.substring(tblName.indexOf("_"), tblName.length());

						//复制源表的结构及数据到新表
						sql = "select * into " + newTableName + " from " + tblName;
						dbHelper.execute(sql);

						//获得源表主键列名称，并在新表中设置主键
						sql = "SELECT name FROM SysColumns WHERE id=Object_Id('" + tblName + "') and colid=(select top 1 colid from sysindexkeys where id=Object_Id('" + tblName + "'))";
						Map primaryKeyMap = dbHelper.getMap(sql);
						if (primaryKeyMap != null) {
							String primaryKeyName = primaryKeyMap.get("name").toString();
							//设置新表主键
							sql = "alter table " + newTableName + " add primary key (" + primaryKeyName + ")";
							dbHelper.execute(sql);
						}
					}
					connection.commit();
					out.print("复制成功");
				} catch (Exception e) {
					e.printStackTrace();
					out.print("复制失败");
				} 
				break;
			case 3:
				break;
			case 4:
				break;
			case 5:
				break;
			}
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}%>
