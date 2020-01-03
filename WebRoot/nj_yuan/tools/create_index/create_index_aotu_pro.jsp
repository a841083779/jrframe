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
	String resule="false";
	String uuid="";
	try{
		List <Map>list = null;
		Map root = new HashMap();
			String sql = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = 'F977E6CE-B6C0-4F2A-B282-7170B597B59E' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_推土机
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_tuitu.htm");
				resule="true";
			}			
	    
			String sql1 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '562544C0-B689-4DE1-8B72-8DFC6F95EF5B' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql1);
			if(list != null && list.size() > 0){//热门品牌_叉车
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_chache.htm");
				resule="true";
			}	
	  
			String sql2 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = 'C6EA8121-CCB5-4FF0-87CD-B727FCC7E402' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql2);
			if(list != null && list.size() > 0){//热门品牌_压路
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_yalu.htm");
				resule="true";
			}	
	   
			String sql3 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '0360E36F-8442-48AF-8D1B-C5DF3D8ED705' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql3);
			if(list != null && list.size() > 0){//热门品牌_筑路
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_zhulu.htm");
				resule="true";
			}	
	    
			String sql4 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = 'F349F80C-9585-4BA1-AE25-B620125F51A2' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql4);
			if(list != null && list.size() > 0){//热门品牌_平底
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_pingdi.htm");
				resule="true";
			}	
	    
			String sql5 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '409F7023-3780-4342-BB8C-77F70E095D5B' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql5);
			if(list != null && list.size() > 0){//热门品牌_旋挖钻
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_xuanwazuan.htm");
				resule="true";
			}	
	    
			String sql6 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where   channel_uuid = '6EF085AD-BD86-4A1C-9A5A-06112D98090A' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql6);
			if(list != null && list.size() > 0){//热门品牌_地下
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_dixia.htm");
				resule="true";
			}	
	
			String sql7 = " select  title,url,img,order_no,sub_title,sort_flag from pro_index_data  where   channel_uuid = 'CAA8E310-0FB3-4071-AE99-20D80EEDE55A' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql7);
			if(list != null && list.size() > 0){//热门品牌_破碎设备
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_posui.htm");
				resule="true";
			}	

		
			String sql8 = " select top 10 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '80119796-1071-4C45-9751-CC0FC06B3FBC' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql8);
			if(list != null && list.size() > 0){//小挖
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_wajueji_F1_xiaowa.htm");
				resule="true";
			}	
		
		
			String sql9 = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = 'BD5DCD91-B79E-4C5B-964E-2720FF09D8E8' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql9);
			if(list != null && list.size() > 0){//中挖
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_wajueji_F1_zhongwa.htm");
				resule="true";
			}	
		
		
			String sql10 = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '31A275FF-2FBC-4CC8-A64C-9DEAF5BB4BA3' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql10);
			if(list != null && list.size() > 0){//大挖
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_wajueji_F1_dawa.htm");
				resule="true";
			}	
 
		
			String sql11 = " select top 8 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = 'DD365058-E99A-4DFB-9533-FF2F4E89BACD'and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql11);
			if(list != null && list.size() > 0){//装载机1
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F2_01.htm");
				resule="true";
			}	
		
		
			String sql12 = " select top 7 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '85EC635D-3011-4169-8FCD-3744717E7A4B'and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql12);
			if(list != null && list.size() > 0){//装载机2
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F2_02.htm");
				resule="true";
			}	
		
		
			String sql13 = " select top 7 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = 'EB159382-AED4-4FBE-9624-4ABAA4707B40' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql13);
			if(list != null && list.size() > 0){//装载机3
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F2_03.htm");
				resule="true";
			}	

		
			String sql14 = " select top 10 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '5B559042-3E60-439C-B294-CE7C6DA0BD72' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql14);
			if(list != null && list.size() > 0){//起重机1
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_qizhongji_F3_01.htm");
				resule="true";
			}	
		
		
			String sql15 = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '728F22B1-2CBC-4635-911B-8F55101C53CE' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql15);
			if(list != null && list.size() > 0){//起重机2
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_qizhongji_F3_02.htm");
				resule="true";
			}	

		
			String sql16 = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '60569883-FBA4-4AF7-9793-EFD9185697B0' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql16);
			if(list != null && list.size() > 0){//起重机3
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_qizhongji_F3_03.htm");
				resule="true";
			}	

		
			String sql17 = " select top 8 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where  channel_uuid = '1C0AB542-4A76-489D-AB54-D3E090FC8192' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql17);
			if(list != null && list.size() > 0){//混凝土
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_hunningtu.htm");
				resule="true";
			}	
		
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	
	%>