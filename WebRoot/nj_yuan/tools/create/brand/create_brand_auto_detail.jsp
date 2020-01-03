<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
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
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	 FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 	
	String resule="false";
	String sql="";
	String sql1="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
		
		/*测试定时器*/
		try {
		Map roots = new HashMap() ;
		roots.put("to","songlf@21-sun.com") ;
		roots.put("title","品牌页面生成前100") ;
		roots.put("content","品牌页面生成前100");
		String srt=Common.doPost("http://service.21-sun.com/http/utils/sendmail.jsp", roots) ;
	   } catch (Exception e) {}
		
	        String usern = "" ; // 品牌代号
	        List<Map> allbrandMap = dbHelper.getMapList("select  top 100 usern from pro_agent_factory where is_show=1 and  flag = 1 and usern<>'tdbenniu' and usern<>'lovol' order by view_count desc") ;
			
				if(null != allbrandMap && allbrandMap.size()>0){

					for(Map oneMap:allbrandMap){
						usern = CommonString.getFormatPara(oneMap.get("usern")) ;
						out.print("usern="+usern);
						Map brandModel = dbHelper.getMap(" select name from pro_agent_factory  where usern = ? ",new Object [] {usern});
						List<Map> newsList =null;
						if(brandModel!=null){
							newsList= WEBDBHelper.getMapList("select top 9 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+CommonString.getFormatPara(brandModel.get("name"))+"%' ","Web21sunDBHelper");
						}
						root.put("newsList",newsList) ;
						root.put("usern",usern) ;
						freemarkerUtils.generate("brand/detail.htm",root,realPath+"/brand/"+usern+"/index.htm") ;  // 生成所有的品牌详显页
						freemarkerUtils.generate("brand/product.htm",root,realPath+"/brand/"+usern+"/product.htm") ;  // 生成一个品牌产品页
						freemarkerUtils.generate("brand/news.htm",root,realPath+"/brand/"+usern+"/news.htm") ;  // 生成一个品牌新闻页
						freemarkerUtils.generate("brand/picture.htm",root,realPath+"/brand/"+usern+"/picture.htm") ;  // 生成一个品牌图片页
						freemarkerWebserviceUtils.generate("brand/video.htm",root,realPath+"/brand/"+usern+"/video.htm") ;  // 生成一个品牌视频页
						freemarkerUtils.generate("brand/inquiry.htm",root,realPath+"/brand/"+usern+"/inquiry.htm") ;  // 生成一个品牌询价页
						resule="true";
					}
					   /*测试定时器*/
						try {
						Map roots = new HashMap() ;
						roots.put("to","songlf@21-sun.com") ;
						roots.put("title","品牌详细页生成方法") ;
						roots.put("content","品牌详细页生成方法");
						String srt=Common.doPost("http://service.21-sun.com/http/utils/sendmail.jsp", roots) ;
					   } catch (Exception e) {}
				  }
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>