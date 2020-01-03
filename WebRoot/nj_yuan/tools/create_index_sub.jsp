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
	String cuuid = CommonString.getFormatPara(request.getParameter("cuuid"));
	String resule="false";
	try{
		List <Map>list = null;
		Map root = new HashMap();
	 if(cuuid.equals("85D91C47-9AC6-421E-91B1-EC9FDA12403E")){
			//铁臂图说-产品图片
			String sql = " select top 9 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '85D91C47-9AC6-421E-91B1-EC9FDA12403E' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//限时促销 
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_limit.htm",root,realPath+"create/index_new/index_limit.htm");
				freemarkerUtils.generate("index_new/index_limit_9.htm",root,realPath+"create/index_new/index_limit_9.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("FDF72BD2-3636-46EC-8061-936AFCA00950")){ //配件
		
			String sql = " select top 5 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = 'FDF72BD2-3636-46EC-8061-936AFCA00950' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_parts.htm",root,realPath+"create/index_new/index_parts.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0DD5B746-76D3-44E0-8A4B-D7ED4C725653")){//挖掘机F1_小挖 
		
			String sql = " select top 9 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '0DD5B746-76D3-44E0-8A4B-D7ED4C725653' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_F0.htm",root,realPath+"create/index_new/index_wajueji_F0_xiaowa.htm");
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"create/index_new/index_wajueji_F1_xiaowa.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0DD5B746-76D3-44E0-8A4B-D7ED4C725653")){//挖掘机F1_中挖 
		
			String sql = " select top 9 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '0DD5B746-76D3-44E0-8A4B-D7ED4C725653' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"create/index_new/index_wajueji_F1_zhongwa.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0DD5B746-76D3-44E0-8A4B-D7ED4C725653")){//挖掘机F1_大挖 
		
			String sql = " select top 9 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '0DD5B746-76D3-44E0-8A4B-D7ED4C725653' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"create/index_new/index_wajueji_F1_dawa.htm");
				resule="true";
			}	
		}else if(cuuid.equals("193A6145-AFE1-412C-9DFB-4458337F1C41")){//装载机F2_(T≤3) 
		
			String sql = " select top 7 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '193A6145-AFE1-412C-9DFB-4458337F1C41' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_F0.htm",root,realPath+"create/index_new/index_zhuangzaiji_F0.htm");
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"create/index_new/index_zhuangzaiji_F2_01.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0DD5B746-76D3-44E0-8A4B-D7ED4C725653")){//装载机F2_(3＜T≤5) 
		
			String sql = " select top 7 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '0DD5B746-76D3-44E0-8A4B-D7ED4C725653' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"create/index_new/index_zhuangzaiji_F2_02.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0DD5B746-76D3-44E0-8A4B-D7ED4C725653")){//装载机F2_(T＞5) 
		
			String sql = " select top 7 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '0DD5B746-76D3-44E0-8A4B-D7ED4C725653' and is_pub = 1 and order_no!='0'  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"create/index_new/index_zhuangzaiji_F2_03.htm");
				resule="true";
			}	
		}
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}

	out.println(resule) ;	
	%>