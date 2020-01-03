<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%
	String event = CommonString.getFormatPara(request.getParameter("eventAfter"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map model = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		
		//生成产品的详细页
		if(eventList.contains("productsCreate")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			//本条产品信息
			model = dbHelper.getMap(" select * from "+request.getParameter("tableName")+" where id = ? ",new Object [] {id},connection);
			Map root = new HashMap();
			root.put("model", model);
			
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");
			
			String pageFlag1 = "paras";	
			String fileName = CommonString.getFormatPara(model.get("file_name"));
			String createName1 = absPath+"proDetail/"+fileName;
			root.put("cName1","/proDetail/"+fileName);
			
			String pageFlag2 = "intro";
			String fileName2 = fileName.substring(0,fileName.lastIndexOf(".shtm"))+"_"+pageFlag2+".shtm";
			String createName2 = absPath+"proDetail/"+fileName2;			
			root.put("cName2","/proDetail/"+fileName2);
			
			String pageFlag3 = "pic";
			String fileName3 = fileName.substring(0,fileName.lastIndexOf(".shtm"))+"_"+pageFlag3+".shtm";
			String createName3 = absPath+"proDetail/"+fileName3;			
			root.put("cName3","/proDetail/"+fileName3);
			
			String pageFlag4 = "agent";
			String fileName4 = fileName.substring(0,fileName.lastIndexOf(".shtm"))+"_"+pageFlag4+".shtm";
			String createName4 = absPath+"proDetail/"+fileName4;			
			root.put("cName4","/proDetail/"+fileName4);
			
			String pageFlag5 = "message";
			String fileName5 = fileName.substring(0,fileName.lastIndexOf(".shtm"))+"_"+pageFlag5+".shtm";
			String createName5 = absPath+"proDetail/"+fileName5;			
			root.put("cName5","/proDetail/"+fileName5);
			
			String pageFlag6 = "order";
			String fileName6 = fileName.substring(0,fileName.lastIndexOf(".shtm"))+"_"+pageFlag6+".shtm";
			String createName6 = absPath+"proDetail/"+fileName6;			
			root.put("cName6","/proDetail/"+fileName6);
						
			root.put("pageFlag",pageFlag1);
			freemarkerUtils.generate("/proDetail/detail.shtm", root, createName1 ,request);
						
			root.put("pageFlag",pageFlag2);
			freemarkerUtils.generate("/proDetail/detail.shtm", root, createName2 ,request);
			
			root.put("pageFlag",pageFlag3);
			freemarkerUtils.generate("/proDetail/detail.shtm", root, createName3 ,request);
			
			root.put("pageFlag",pageFlag4);
			freemarkerUtils.generate("/proDetail/detail.shtm", root, createName4 ,request);
			
			root.put("pageFlag",pageFlag5);
			freemarkerUtils.generate("/proDetail/detail.shtm", root, createName5 ,request);
			
			root.put("pageFlag",pageFlag6);
			freemarkerUtils.generate("/proDetail/detail.shtm", root, createName6 ,request);
		}
	
		connection.commit();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	request.getRequestDispatcher("/admin/action/after_own.jsp").forward(request,response);
%>