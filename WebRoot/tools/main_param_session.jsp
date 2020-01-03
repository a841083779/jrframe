<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
   DBHelper dbHelper = DBHelper.getInstance();
		List proList = null;
		//String sqlCatalog = "select id,pro_id,param_id,param_value,param_name  from pro_main_param ";
		String sql="select id from  pro_products where is_show=1 order by id desc";
		Connection conn = null;
		HashMap<String, List<Map>> proParamMap = null;
		try {
			conn = dbHelper.getConnection();
			proList = dbHelper.getMapList(sql, conn);
			Map info = null;
			proParamMap = new HashMap<String, List<Map>>();
			for (int i = 0; i < proList.size(); i++) {
				info = (Map) proList.get(i);
				List <Map>   paramList = dbHelper.getMapList("select id,pro_id,param_id,param_value,param_name  from pro_main_param   where pro_id="+info.get("id").toString(), conn);
                if(paramList==null){
                	paramList=new ArrayList<Map>();
                }
				proParamMap.put(info.get("id").toString(), paramList);
			}
			out.println(proParamMap.size());
			application.setAttribute("proParamMap", proParamMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	%>