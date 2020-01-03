<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String resule="false";
	String sql="";
	String sql1="";
	String bigid = CommonString.getFormatPara(request.getParameter("bigid"));
	String cata = CommonString.getFormatPara(request.getParameter("cata"));
	
	Map keyParamMap = (Map) application.getAttribute("keyParamMap");
	Map paramListMap = (Map) application.getAttribute("paramListMap");
	Map salePolicyListMap = (Map) application.getAttribute("salePolicyListMap");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root1 = new HashMap();
				
			Map<String,String> postMap = new HashMap<String,String>();
			//本条产品信息
			list = dbHelper.getMapList(" select  * from  pro_machine_products  where brand_id!=	52 and  is_show=1 order by id desc");
			for(Map model:list){
				
			Map root = new HashMap();
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath);
			String fileName = CommonString.getFormatPara(model.get("file_name"));
			String  createName1 = absPath+"nj/proDetail/"+fileName;
			root.put("model",model);
			list1=dbHelper.getMapList(" select name,file_name from pro_machine_products where brand_id="+CommonString.getFormatPara(model.get("brand_id"))+" and catalog_num='"+CommonString.getFormatPara(model.get("catalog_num"))+"'",connection);
		
			root.put("thelist",list1);
	
			freemarkerUtils.generate("nj/template/detail.htm", root, createName1 ,request);
				
			
		    }	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	%>