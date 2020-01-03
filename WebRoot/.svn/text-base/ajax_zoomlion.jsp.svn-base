<%@ page language="java" import="java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="jxl.Workbook,jxl.Sheet,java.io.*"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	File file = new File("D:/RU_element_20133.xls");
	//read excel
	jxl.Workbook rwb = null;
	int totle=0;//统计插入成功条数
	try {
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		InputStream is = new FileInputStream(file);
		rwb = Workbook.getWorkbook(is);
		Sheet rs = rwb.getSheet(0);
		int rsRows = rs.getRows();
		for (int i = 0; i < rsRows; i++) {
				String intro = rs.getCell(2, i).getContents();
				System.out.println(intro);
				int ret = dbHelper.execute(" insert into tttt(intro) values(?) " , new Object [] {intro},connection);
				if(ret>0){
					totle+=ret;
					System.out.println(i+"--"+totle+"成功!");
				}
		}
		out.print(totle);//totle count
		connection.commit();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		rwb.close();
	}
%>