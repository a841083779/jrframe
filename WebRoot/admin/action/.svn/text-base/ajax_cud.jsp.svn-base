<%@ page language="java" import="com.jerehnet.util.images.*,org.json.*,org.apache.commons.io.FileUtils,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.io.File" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
    String pro_id = CommonString.getFormatPara(request.getParameter("pro_id")) ;   // 产品id 
	Connection conn = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	String rs = "fail";
	try{
		conn = dbHelper.getConnection();
		conn.setAutoCommit(false);
		//登录
		if("login".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String password = CommonString.getFormatPara(request.getParameter("password"));
			adminInfo = dbHelper.getMap(" select * from "+tablePrefix+"common_user where usern = ? and password = ? ",new Object [] {usern,password},conn);
			if(null!=adminInfo){
				if(adminInfo.get("state").equals(0)){
					rs = "state0";
				}else{
					session.setAttribute("adminInfo",adminInfo);
					Map postMap = new HashMap();
					postMap.putAll(request.getParameterMap());
					postMap.put("uuid",adminInfo.get("uuid"));
					postMap.put("logFlag","101004");
					//Common.doPostHttpAsync(Common.getDomain(request)+"/admin/action/log.jsp",postMap);
					//修改最后登录信息
					String sql = " UPDATE "+tablePrefix+"common_user SET login_count = isnull(login_count,0)+1 , last_login_date = '"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"' , last_login_ip = '"+Common.getIp(request)+"' ";
					sql += " WHERE id = ? ";
					dbHelper.execute(sql,new Object [] {adminInfo.get("id")},conn);
					rs = "ok";
				}
			}
		}
		//设置角色权限
		if("set_power".equals(flag)){
			String role_uuid = CommonString.getFormatPara(request.getParameter("role_uuid"));
			String sql = " delete from "+tablePrefix+"common_role_resource where role_uuid = ? ";
			dbHelper.execute(sql,new Object [] {role_uuid},conn);
			String powerStr = CommonString.getFormatPara(request.getParameter("power"));
			String [] powerArr = powerStr.split(",");
			sql = " INSERT INTO "+tablePrefix+"common_role_resource ( add_user , add_date , add_ip , uuid , resource_uuid , role_uuid , usern ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ) ";
			if(null!=powerArr&&powerArr.length>0){
				Object [] [] params  = new Object [powerArr.length] [7];
				for(int i=0;i<powerArr.length;i++){
					params[i][0]=adminInfo.get("usern");
					params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
					params[i][2]=Common.getIp(request);
					params[i][3]=CommonString.getUUID();
					params[i][4]=powerArr[i].replaceAll("'","");
					params[i][5]=role_uuid;
					params[i][6]="";
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		//设置用户权限
		if("set_power_user".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String sql = " delete from "+tablePrefix+"common_role_resource where usern = ? ";
			dbHelper.execute(sql,new Object [] {usern},conn);
			String powerStr = CommonString.getFormatPara(request.getParameter("power"));
			String [] powerArr = powerStr.split(",");
			sql = " INSERT INTO "+tablePrefix+"common_role_resource ( add_user , add_date , add_ip , uuid , resource_uuid , role_uuid , usern ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ) ";
			if(null!=powerArr&&powerArr.length>0){
				Object [] [] params  = new Object [powerArr.length] [7];
				for(int i=0;i<powerArr.length;i++){
					params[i][0]=adminInfo.get("usern");
					params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
					params[i][2]=Common.getIp(request);
					params[i][3]=CommonString.getUUID();
					params[i][4]=powerArr[i].replaceAll("'","");
					params[i][5]="4CCDF227-7F10-4E09-A47C-085CCB4A45FF";
					params[i][6]=usern;
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		if("saveSort".equals(flag)){
			String sortId = CommonString.getFormatPara(request.getParameter("sortId"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String [] idArr =sortId.split(",");
			if(null!=idArr&&idArr.length>0){
				String sql = " update "+tableName+" set order_no = ? where uuid = ? ";
				Object [] [] params = new Object [idArr.length] [2];
				for(int i=0;i<idArr.length;i++){
					if(tableName.equals("pro_catalog")){
						params[i][0]=i;
					}else{
						params[i][0]=(idArr.length-i);	
					}
					params[i][1]=idArr[i];
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		if("writeTemplate".equals(flag)){
			String fileName = CommonString.getFormatPara(request.getParameter("fileName"));
			if(!"".equals(fileName)){
				String content = CommonString.getFormatPara(request.getParameter("content"));
				String absolutePath = Common.getAbsolutePath(request);
				File f = new File(absolutePath+"/template/"+fileName);
				FileUtils.writeStringToFile(f,content,"utf-8");
				//更新与模板相关的数据
				List<Map> commonTemplates = dbHelper.getMapList(" select channel_uuid from "+tablePrefix+"common_template where template_file_name = ? ",new Object [] {fileName},conn);
				List<Map> channels = dbHelper.getMapList(" select no as channel_uuid from "+tablePrefix+"common_channel where template_file_name = ? ",new Object [] {fileName},conn);
				Map params = null;
				Map channel = null;
				Set<Map> t_s = new HashSet<Map>();
				t_s.addAll(commonTemplates);
				t_s.addAll(channels);
				for(Map m : t_s){
					params = new HashMap();
					params.put("eventAfter", "channelTemplate");
					params.put("channel_uuid", m.get("channel_uuid"));
					Common.doPostHttpAsync(Common.getDomain(request)+"/admin/action/after.jsp", params);
				}
				rs = "ok";
			}
		}
		//保存设备图片
		if("saveMacImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+tablePrefix+"machine_image ( add_user , add_date , add_ip , uuid , channel_uuid , machine_id , title , img , small_img , order_no , is_show ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
			Object [][] params = new Object [imgArr.length()][11];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]=adminInfo.get("usern");
				params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
				params[i][2]=Common.getIp(request);
				params[i][3]=CommonString.getUUID();
				params[i][4]=channel_uuid;
				params[i][5]=machine_id;
				params[i][6]=jsonObject.getString("title");
				params[i][7]=jsonObject.getString("url");
				params[i][8]=Common.getSmallImg(jsonObject.getString("url"));
				params[i][9]=0;
				params[i][10]=1;
			}
			dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		
		// 保存产品图片
		if("saveProImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+tablePrefix+"product_pic ( product_id , name , placeflag , img_name , is_show , page_pic_flag,uuid  ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ) ";
			//system.out.println(pro_id) ;
			Object [][] params = new Object [imgArr.length()][7];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]= pro_id ;
				params[i][1]= jsonObject.getString("title") ;
				params[i][2]= 0 ;
				params[i][3]= jsonObject.getString("url") ;
				params[i][4]= 0 ;
				params[i][5]= 0 ;
				 params[i][6]= java.util.UUID.randomUUID().toString() ;
			}
			//system.out.println(sql+"--") ;
			 dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		
		//多删除
		if("groupDel".equals(flag)){
			String ids = CommonString.getFormatPara(request.getParameter("ids"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String sql = " delete from "+tableName+" where uuid in ("+ ids +")";
			dbHelper.execute(sql,conn);
			rs = "ok";
		}
		//通用修改
		if("commonUpdate".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String key =CommonString.getFormatPara(request.getParameter("key"));
			String value = CommonString.getFormatPara(request.getParameter("value"));
			String [] keyArr = key.split(",");
			String sql = " update " + tableName + " set "+key+" = ? where uuid = ? ";
			Object [] params = new Object [keyArr.length+1];
			String [] valArr = value.split(",");
			sql = " update "+tableName+" set ";
			for(int i=0;i<keyArr.length;i++){
				sql += keyArr[i]+" = ? , ";
				params[i]=valArr[i];
			}
			params[keyArr.length]=uuid;
			sql = sql.substring(0,sql.lastIndexOf(",")-1);
			sql += " where uuid = ? ";
			dbHelper.execute(sql,params,conn);
			rs = "ok";
		}
		//删除设备图片
		if("delMacImg".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" delete from "+tablePrefix+"machine_image where uuid = ? ",new Object [] {id},conn);
			rs = "ok";
		}
		
		//保存配件图片
		if("savePartsImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+tablePrefix+"parts_image ( add_user , add_date , add_ip , uuid , channel_uuid , machine_id , title , img , small_img , order_no , is_show ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
			Object [][] params = new Object [imgArr.length()][11];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]=adminInfo.get("usern");
				params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
				params[i][2]=Common.getIp(request);
				params[i][3]=CommonString.getUUID();
				params[i][4]=channel_uuid;
				params[i][5]=machine_id;
				params[i][6]=jsonObject.getString("title");
				params[i][7]=jsonObject.getString("url");
				params[i][8]=Common.getSmallImg(jsonObject.getString("url"));
				params[i][9]=0;
				params[i][10]=1;
			}
			dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		//删除配件图片
		if("delPartsImg".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" delete from "+tablePrefix+"parts_image where uuid = ? ",new Object [] {id},conn);
			rs = "ok";
		}
		//  代理商点击查看电话后执行的操作
		if("changeOrderState".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("idStr")) ;  // 
			String sql = "update pro_product_form set state=1 where uuid=?" ;
			if(!"".equals(uuid)){
				dbHelper.execute(sql,new Object[]{uuid}) ;
			}
		}
		conn.commit();
	}catch(Exception e){
	connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(conn);
	}
	out.print(rs);
%>