<%@ page language="java" import="com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="com.jerehnet.util.file.FileUtils"%>
<%@page import="com.jerehnet.util.images.ImageUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
 
<%
	String rs = "0";
	String add_user = "ershouhui_gcjx";
	String add_date = CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
	String add_ip = Common.getIp(request);
	String uuid = UUID.randomUUID().toString();
	String mem_no = "ershouhui_gcjx";
    String a="";
	String car_no = "";
	String engine = "";
	int cap_desc = 1;
	int elect_desc = 1;
	int power_desc = 1;
	int hyd_desc = 1;
	int vision_desc = 1;
	String detail ="[二手汇工程机械网]成立于2014年10月， 网址：http://www.ershouhui.com,现有员工360人，设有运营部，it部，销售部，销售管理部，检测部。在全国设有分公司。业务范围包括在线交易，线下寄售，在线评估，设备拍卖。二手汇秉承“真货源，可退货，为客户而生”的经营理念服务与全国的工程机械用户朋友们实现了PC端,手机网页版，手机APP的互联网全覆盖。网站主要为全国的工程机械终端用户买卖二手设备提供交易平台。每日新增在售设备近千台，满足了用户朋友买设备的选择要求。目前有来自全国各地的工程机械行业注册会员8万多人。网站交易额超过8亿元。";
	int source = 2;
	int checkbook = 1;
	int logistics = 3;
	int is_sale = 0;
	String linkman =  "二手汇工程机械网";
	String linkman_phone = "0351-5646000";
	String linkman_email = "";
	String linkman_address = "";
	String linkman_company ="二手汇工程机械网";

	
	//String jsonStr = CommonString.getFormatPara(request.getParameter("jsonStr")).replaceAll("http://","http").replaceAll("/","_").replace("@!slider-large-mark,","slider-large-mark");
 	//org.json.JSONObject obj = new org.json.JSONObject(jsonStr); 
	String jsonStr = CommonString.getFormatPara(request.getParameter("jsonStr")).replaceAll("http://","http").replaceAll("@!slider-large-mark","sliderlargemark");
	jsonStr=jsonStr.replaceAll("/","xiexian");
	int place=0;
	try{
	place = CommonString.getFormatInt(obj.getString("is_import"));  //0,1,2 国产合资进口
	}catch(Exception e){}
	if(place==1){place=2;}
	
	int arm_length = 0;
	try{
	arm_length=CommonString.getFormatInt(obj.getString("arm_length"));
	}catch(Exception e){}
	
	int horsepower=0;
	try{
	horsepower =  CommonString.getFormatInt(obj.getString("horsepower"));
	}catch(Exception e){}
	
	double tons=0.0;
    try{	
	tons =CommonString.getFormatDouble(obj.getString("tons"));
	}catch(Exception e){}
	
	
	double price = 0.0;
	try{	
	CommonString.getFormatDouble(obj.getString("price"));
	}catch(Exception e){}
	
	String img="";
    try{
	img = CommonString.getFormatPara(obj.getString("img")).replaceAll("http","http://").replaceAll("xiexian","/").replaceAll("slider-large-mark","@!slider-large-mark,");
	}catch(Exception e){}
	
	int from_id=0;
	try{
	from_id = CommonString.getFormatInt(obj.getString("pro_id"));
	}catch(Exception e){}
	
	String model_name="";
	try{
	model_name = CommonString.getFormatPara(obj.getString("model"));
	}catch(Exception e){}
	 
	String catalog=""; 
	try{
	catalog = CommonString.getFormatPara(obj.getString("catalog"));
	}catch(Exception e){}
	
	String province="";
	try{
    province= CommonString.getFormatPara(obj.getString("province"));
	}catch(Exception e){}
	
	int factorydate=0;
	try{
	factorydate = CommonString.getFormatInt(obj.getString("year"));
	}catch(Exception e){}
	
	int workingtime=0;
	try{
	workingtime = CommonString.getFormatInt(obj.getString("workingtime"));
	}catch(Exception e){}
	
	String brand="";
	try{
    brand=CommonString.getFormatPara(obj.getString("brand"));
	}catch(Exception e){}
	brand=brand.replace("三一重工","三一");
	int from_flag = 5; //表示来二手汇
	//zengfc
	int is_pub = 0;
	int is_review = 0;//表示审核通过
	String engine_chassis = "";
	int degree_old = 9;
	int certificate_of_approval = 1;
	int presence_of_overhaul = 1;
	int current_state = 0;
	int paving_width = 0;
	int moving_way = 0;
	int shovel_width = 0;
	String pub_date = add_date;
	String img1_1 = "";
	String[] imgAry = null;
 	String imgs = img;
	String singleimg="";
	if(!imgs.equals("")){
		imgAry = imgs.split("_");
		if(imgAry.length > 0){
			img1_1 = imgAry[0];
		}
	}
	int category_id=0;
	int province_id=0;
	int city_id=0;
	int brand_id=0;
	
	if(from_id > 0){
		DBHelper dbHelper = DBHelper.getInstance();
		Connection connection = null;
		try{
			connection = dbHelper.getConnection();
			Map model = dbHelper.getMap("select id from used_equipment where add_user = 'ershouhui_gcjx'  and   from_id=?",new Object [] { from_id },connection);
			
			if("泵车".equals(catalog)){
				category_id=61;
			}else  if("挖掘机".equals(catalog)){
				category_id=2;
			}else  if("装载机".equals(catalog)){
				category_id=10;
			}else  if("推土机".equals(catalog)){
				category_id=14;
			}else  if("压路机".equals(catalog)){
				category_id=151;
			}else  if("起重机".equals(catalog)){
				category_id=32;
			}else  if("搅拌运输车".equals(catalog)){
				category_id=71;
			}else  if("平地机".equals(catalog)){
				category_id=28;
			}else  if("自卸车".equals(catalog)){
				category_id=230;
			}else  if("破碎锤".equals(catalog)){
				category_id=234;
			}else{
				category_id=9999;
			}
			
			
			Map provinceMap = dbHelper.getMap("select top 1  area_id,parent_area_id from used_area where area_name like '%"+province+"%' ",new Object [] { },connection);
			if(provinceMap!=null){
					 province_id = CommonString.getFormatInt(provinceMap.get("area_id"));
			}
 
			brand_id=99999;
			Map brandMap = dbHelper.getMap("select top 1  id  from used_brand  where full_name like '%"+brand+"%' or name like '"+brand+"'  ",new Object [] { },connection);
			if(brandMap!=null){
					 brand_id = CommonString.getFormatInt(brandMap.get("id"));
			}	
			
			if(model!=null){  //存在该设备去更新
			a = CommonString.getFormatPara(model.get("id"));
			String sqlUpdate = "update used_equipment set";
			sqlUpdate += " model=?, place=?, workingtime=?, factorydate=?, tons=?,";
			sqlUpdate += "cap_desc=?, elect_desc=?, power_desc=?, hyd_desc=?, vision_desc=?, detail=?,";
			sqlUpdate += " source=?, checkbook=?, logistics=?, price=?, is_sale=?,";
			sqlUpdate += "linkman=?, linkman_phone=?, linkman_email=?, linkman_address=?, linkman_company=?, is_pub=?,";
			sqlUpdate += "category_id=?, province_id=?, city_id=?, arm_length=?, engine_chassis=?, degree_old=?, ";
			sqlUpdate += "certificate_of_approval=?, presence_of_overhaul=?, current_state=?, brand_id=?,img1_1=?,pub_date=?,car_no=?,engine=?,horsepower=?,paving_width=?,moving_way=?,shovel_width=?,from_flag=?,from_id=?,is_review=? where  add_user = 'ershouhui_gcjx' and  from_id=?";
			Integer keyId = dbHelper.executeUpdate(sqlUpdate,new Object[]{
				model_name,place,workingtime,factorydate,tons,cap_desc,elect_desc,power_desc,hyd_desc,vision_desc,
				detail,source,checkbook,logistics,price,is_sale,linkman,linkman_phone,linkman_email,linkman_address,linkman_company,
				is_pub,category_id,province_id,city_id,arm_length,engine_chassis,degree_old,certificate_of_approval,
				presence_of_overhaul,current_state,brand_id,img1_1,pub_date,car_no,engine,horsepower,paving_width,moving_way,shovel_width,from_flag,from_id,is_review,from_id
			},connection);
			rs = keyId.toString();
 

			if(imgAry!=null && imgAry.length>0){
 
			}
			
			}else{    //不存在该设备就去插入一条新的
			
			String sql = "insert into used_equipment (add_user, add_date, add_ip, uuid, mem_no,";
			sql += "model, place, workingtime, factorydate, tons,";
			sql += "cap_desc, elect_desc, power_desc, hyd_desc, vision_desc, detail,";
			sql += " source, checkbook, logistics, price, is_sale,";
			sql += "linkman, linkman_phone, linkman_email, linkman_address, linkman_company, is_pub,";
			sql += "category_id, province_id, city_id, arm_length, engine_chassis, degree_old, ";
			sql += "certificate_of_approval, presence_of_overhaul, current_state, brand_id,img1_1,pub_date,car_no,engine,horsepower,paving_width,moving_way,shovel_width,from_flag,from_id,is_review) ";
			sql += "values (?, ?, ?, ?, ?,";
			sql += "?, ?, ?, ?, ?,";
			sql += "?, ?, ?, ?, ?, ?,";
			sql += " ?, ?, ?, ?, ?,";
			sql += "?, ?, ?, ?, ?, ?, ?,";
			sql += "?, ?, ?, ?, ?, ?, ";
			sql += "?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?) ";
			Integer keyId = dbHelper.executeUpdate(sql,new Object[]{
				add_user,add_date,add_ip,uuid,mem_no,
				model_name,place,workingtime,factorydate,tons,cap_desc,elect_desc,power_desc,hyd_desc,vision_desc,
				detail,source,checkbook,logistics,price,is_sale,linkman,linkman_phone,linkman_email,linkman_address,linkman_company,
				is_pub,category_id,province_id,city_id,arm_length,engine_chassis,degree_old,certificate_of_approval,
				presence_of_overhaul,current_state,brand_id,img,pub_date,car_no,engine,horsepower,paving_width,moving_way,shovel_width,from_flag,from_id,is_review
			},connection);
			
 			if(imgAry!=null && imgAry.length>0){
				Object[][] params = new Object[imgAry.length][3];
				sql = " insert into used_equipment_image (equipment_id, small, original) ";
				sql += " values ( ? , ? , ? ) ";
				//保存图片
				for(int i=0; i<imgAry.length; i++){
					params[i][0] = keyId;
					params[i][1] = ""+imgAry[i];
					params[i][2] = ""+imgAry[i];
				}
				dbHelper.executeBatch(sql,params,connection);
			}
			rs = keyId.toString();
			

			}	
		}catch(Exception e){
			e.printStackTrace();
			//rs = e.getMessage();
		}finally{
			DBHelper.freeConnection(connection);
		}
	}
	if(Integer.parseInt(rs)>0){
			out.println("success:"+(a.equals("")?rs:a));
	}else{
			out.println("fail");
	}

%>