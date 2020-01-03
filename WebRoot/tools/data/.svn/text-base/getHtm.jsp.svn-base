<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.file.HtmlParser,java.util.regex.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%	
	DBHelper dbHelper = DBHelper.getInstance() ;
    Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		// 无参数的数据，直接从页面中抓取，导入到paras
		List<Map> list = dbHelper.getMapList(" select file_name from pro_products where paras is null or len(convert(nvarchar(3000),paras)) < 20 ") ;
		//把卡特彼勒的参数导入到paras
		//List<Map> list = dbHelper.getMapList(" select file_name from pro_products where factoryid = '174' and is_show = 1 and paras like '%img%'  ") ;
		for(int i = 0;list!=null && i<list.size();i++){
			String contentHtm = "";
			try{
				contentHtm = HtmlParser.getHtmlContent("http://product.21-sun.com/proDetail/"+list.get(i).get("file_name"),"utf-8");
			}catch(Exception ex){
				Common.println(list.get(i).get("file_name").toString()+"---未找到链接");
			}
			if(contentHtm == null || contentHtm.equals("")){
				continue;
			}
			String paras = "";
			Pattern pagerCount_reg = Pattern.compile("<div id=\"content0\">([\\S\\s]+?)</div>", Pattern.CASE_INSENSITIVE);
			Matcher pagerCount_mat = pagerCount_reg.matcher(contentHtm);
			if (pagerCount_mat.find()) {
				paras = pagerCount_mat.group(1).trim();
			}
			String updateSql = " update pro_products set paras = '"+paras.replace("'","''")+"' where file_name = '"+list.get(i).get("file_name")+"' ";
			Common.println(updateSql);
			dbHelper.execute(updateSql, connection);
			connection.commit();
		}
				
	}catch(Exception ex){
		connection.rollback();
		ex.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	out.println("ok") ;
%>
