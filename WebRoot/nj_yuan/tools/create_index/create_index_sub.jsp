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
	 if(cuuid.equals("6F4CB239-D4AE-4185-AC1E-247726FD17B8")){
			
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//banner图 
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_banner.htm",root,realPath+"index_new/index_new/index_banner.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("F977E6CE-B6C0-4F2A-B282-7170B597B59E")){
			String sql = " select  title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_推土机
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_tuitu.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_tuitu.htm");
				resule="true";
			}			
	    }else if(cuuid.equals("562544C0-B689-4DE1-8B72-8DFC6F95EF5B")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_叉车
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_chache.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_chache.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("C6EA8121-CCB5-4FF0-87CD-B727FCC7E402")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_压路
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_yalu.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_yalu.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("0360E36F-8442-48AF-8D1B-C5DF3D8ED705")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_筑路
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_zhulu.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_zhulu.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("F349F80C-9585-4BA1-AE25-B620125F51A2")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_平底
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_pingdi.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_pingdi.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("409F7023-3780-4342-BB8C-77F70E095D5B")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_旋挖钻
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_xuanwazuan.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_xuanwazuan.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("6EF085AD-BD86-4A1C-9A5A-06112D98090A")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_底下
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_dixia.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_dixia.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("CAA8E310-0FB3-4071-AE99-20D80EEDE55A")){
			String sql = " select  title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//热门品牌_破碎设备
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_posui.htm");
				freemarkerUtils.generate("index_new/index_hot_brand_pro.htm",root,realPath+"index_new/index_new/index_hot_brand_pro_posui.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("86D12C20-8C8B-475D-AA8E-8E0095B54ECB")){
			String sql = " select top 9 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//限时促销 
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_limit.htm",root,realPath+"index_new/index_new/index_limit.htm");
				freemarkerUtils.generate("index_new/index_limit_9.htm",root,realPath+"index_new/index_new/index_limit_9.htm");
				resule="true";
			}	
	    }else if(cuuid.equals("80119796-1071-4C45-9751-CC0FC06B3FBC")){//挖掘机F1_小挖 
		
			String sql = " select top 10 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_F0.htm",root,realPath+"index_new/index_new/index_wajueji_F0.htm");
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_wajueji_F1_xiaowa.htm");
				resule="true";
			}	
		}else if(cuuid.equals("BD5DCD91-B79E-4C5B-964E-2720FF09D8E8")){//挖掘机F1_中挖 
		
			String sql = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_wajueji_F1_zhongwa.htm");
				resule="true";
			}	
		}else if(cuuid.equals("31A275FF-2FBC-4CC8-A64C-9DEAF5BB4BA3")){//挖掘机F1_大挖 
		
			String sql = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_wajueji_F1_dawa.htm");
				resule="true";
			}	
		}else if(cuuid.equals("DD365058-E99A-4DFB-9533-FF2F4E89BACD")){//装载机F2_(T≤3) 
		
			String sql = " select top 8 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"'and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_F0.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F0.htm");
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F2_01.htm");
				resule="true";
			}	
		}else if(cuuid.equals("85EC635D-3011-4169-8FCD-3744717E7A4B")){//装载机F2_(3＜T≤5) 
		
			String sql = " select top 7 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"'and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F2_02.htm");
				resule="true";
			}	
		}else if(cuuid.equals("EB159382-AED4-4FBE-9624-4ABAA4707B40")){//装载机F2_(T＞5) 
		
			String sql = " select top 7 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_zhuangzaiji_F2_03.htm");
				resule="true";
			}	
		}else if(cuuid.equals("5B559042-3E60-439C-B294-CE7C6DA0BD72")){//起重机F3_(<16T)
		
			String sql = " select top 10 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_F0.htm",root,realPath+"index_new/index_new/index_qizhongji_F0.htm");
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_qizhongji_F3_01.htm");
				resule="true";
			}	
		}else if(cuuid.equals("728F22B1-2CBC-4635-911B-8F55101C53CE")){//起重机F3_(20-70T) 
		
			String sql = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_qizhongji_F3_02.htm");
				resule="true";
			}	
		}else if(cuuid.equals("60569883-FBA4-4AF7-9793-EFD9185697B0")){//起重机F3_(≥70T)
		
			String sql = " select top 9 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_wajueji_F1.htm",root,realPath+"index_new/index_new/index_qizhongji_F3_03.htm");
				resule="true";
			}	
		}else if(cuuid.equals("1C0AB542-4A76-489D-AB54-D3E090FC8192")){//混凝土F4
		
			String sql = " select top 8 title,url,img,order_no,sub_title,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				
				freemarkerUtils.generate("index_new/index_F0.htm",root,realPath+"index_new/index_new/index_hunningtu_F0.htm");
				freemarkerUtils.generate("index_new/index_zhuangzaiji_F2.htm",root,realPath+"index_new/index_new/index_hunningtu.htm");
				resule="true";
			}	
		}else if(cuuid.equals("A35559CB-49D5-4447-B04C-5318ACAB2BE5")){ //配件
		
			String sql = " select top 5 title,url,img,order_no,sub_title,cate from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_parts.htm",root,realPath+"index_new/index_new/index_parts.htm");
				resule="true";
			}	
		}else if(cuuid.equals("12C67B70-40BE-47B9-B8BA-B93354839F6D")){ //维修专区
		
			String sql = " select top 6 title,url,img,order_no,sub_title,intro from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_weixiu.htm",root,realPath+"index_new/index_new/index_weixiu.htm");
				resule="true";
			}	
		}
		
		
			//新页面后台管理生成
		if(cuuid.equals("33CCAA55-DF9B-451D-8A8F-B86F04CB6B54")){//挖掘机
		
			String sql = " select top 6 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_floor_pro.htm",root,realPath+"index_new/index_page/index_wajueji_F1.htm");
				resule="true";
			}	
		}else if(cuuid.equals("1EF73BDB-E00D-4E8E-BE7D-3F6B77983CEB")){//装载机 
		
			String sql = " select top 6 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"'and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_floor_pro.htm",root,realPath+"index_new/index_page/index_zhuangzaiji_F2.htm");
				resule="true";
			}	
		}else if(cuuid.equals("0F6D41FD-6990-4099-8D2B-ADBB27804E58")){//起重机
		
			String sql = " select top 6 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_floor_pro.htm",root,realPath+"index_new/index_page/index_qizhongji_F3.htm");
				resule="true";
			}	
		}else if(cuuid.equals("B354A4EB-072A-4445-A58A-DF23C9BF66E8")){//混凝土
		
			String sql = " select top 6 title,url,img,order_no,sub_title from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1   order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_floor_pro.htm",root,realPath+"index_new/index_page/index_hunningtu_F4.htm");
				resule="true";
			}	
		}
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>