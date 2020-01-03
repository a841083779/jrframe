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

		
		
		//页面生成
		if(cuuid.equals("33CCAA55-DF9B-451D-8A8F-B86F04CB6B54")){//挖掘机
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_wjj_pro.htm");
				resule="true";
			}	
		}else if(cuuid.equals("1EF73BDB-E00D-4E8E-BE7D-3F6B77983CEB")){//装载机 
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"'and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_zzj_pro.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0F6D41FD-6990-4099-8D2B-ADBB27804E58")){//起重机
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_qzj_pro.htm");
				resule="true";
			}	
		}else if(cuuid.equals("B354A4EB-072A-4445-A58A-DF23C9BF66E8")){//混凝土
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_hnt_pro.htm");
				resule="true";
			}
	
		}
		
		else if(cuuid.equals("80119796-1071-4C45-9751-CC0FC06B3FBC")){//挖掘机1F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list.htm",root,realPath+"create_index/index_wjj_pro_f1.htm");
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_wjj_pro_f11.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("BD5DCD91-B79E-4C5B-964E-2720FF09D8E8")){//挖掘机2F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_wjj_pro_f2.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("31A275FF-2FBC-4CC8-A64C-9DEAF5BB4BA3")){////挖掘机3F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_wjj_pro_f3.htm");
				resule="true";
			}
	
		}
		
		else if(cuuid.equals("DD365058-E99A-4DFB-9533-FF2F4E89BACD")){//装载机1F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list.htm",root,realPath+"create_index/index_zzj_pro_f1.htm");
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_zzj_pro_f11.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("85EC635D-3011-4169-8FCD-3744717E7A4B")){//装载机2F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_zzj_pro_f2.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("EB159382-AED4-4FBE-9624-4ABAA4707B40")){//装载机3F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_zzj_pro_f3.htm");
				resule="true";
			}
	
		}
		
		else if(cuuid.equals("5B559042-3E60-439C-B294-CE7C6DA0BD72")){//起重机1F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list.htm",root,realPath+"create_index/index_qzj_pro_f1.htm");
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_qzj_pro_f11.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("728F22B1-2CBC-4635-911B-8F55101C53CE")){//起重机2F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_qzj_pro_f2.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("60569883-FBA4-4AF7-9793-EFD9185697B0")){//起重机3F
		
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_qzj_pro_f3.htm");
				resule="true";
			}
	
		}
		
		
		
		else if(cuuid.equals("2A5F4F17-CDC6-4967-989F-20F5AEB23DF6")||cuuid.equals("B8D488E5-FF23-4AEC-B80C-A1C0A3031B67")){//混凝土泵车
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list.htm",root,realPath+"create_index/index_hnt_pro_f1.htm");
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_hnt_pro_f11.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("9A2BCE72-E4EA-4CB7-9264-65C438F80030")||cuuid.equals("B288AF03-69BA-427D-B7C8-9A380A98F179")){//混凝土搅拌车
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_hnt_pro_f2.htm");
				resule="true";
			}
	
		}
		else if(cuuid.equals("8717AC26-9CA4-4C6A-B859-0A0CC4CD648B")||cuuid.equals("D8DC4BDD-3CC7-4AB5-AE09-DEDD52A41E80")){//拖泵
			String sql = " select top 6 title,url,img,order_no,sub_title,summary from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_pro_list_f.htm",root,realPath+"create_index/index_hnt_pro_f3.htm");
				resule="true";
			}
		}
		
		
		else if(cuuid.equals("86D12C20-8C8B-475D-AA8E-8E0095B54ECB")){
		
			String sql = " select top  7   title,url from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/index_top_wajueji_rank.htm",root,realPath+"create_index/index_top_wajueji_rank.htm");
				resule="true";
			}
	
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>