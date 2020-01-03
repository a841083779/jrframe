<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>

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
	
	String yes = CommonString.getFormatPara(request.getParameter("yes"));
	String no = CommonString.getFormatPara(request.getParameter("no"));
	String ids = CommonString.getFormatPara(request.getParameter("ids"));

	Map keyParamMap = (Map) application.getAttribute("keyParamMap");
	Map paramListMap = (Map) application.getAttribute("paramListMap");
	Map salePolicyListMap = (Map) application.getAttribute("salePolicyListMap");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		List <Map>list = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
				
			Map<String,String> postMap = new HashMap<String,String>();
			//本条产品信息

			list = dbHelper.getMapList(" select id  from pro_products where factoryid=174  order by id desc");
			for(Map model:list){
				String id = CommonString.getFormatPara(model.get("id"));
				Common.doPostHttpAsync("http://sowa.21-sun.com//writer/product.21-sun.com/product_create_one.jsp?id="+id,postMap);
				out.println(id+";");
		    }	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
		
	}
	%>