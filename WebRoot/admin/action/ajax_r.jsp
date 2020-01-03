<%@ page language="java" import="java.util.Date,java.io.File,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.JSONObject,org.apache.commons.io.FileUtils" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	String rs = "fail";
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		//更新application
		if("updateApp".equals(flag)){
			CommonApplication.updateApplication(request,tableName);
		}
		//产品文件名称
		if("file_name".equals(flag)){
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String htmlName = name;
			htmlName = htmlName.replace(" ","").replace("　","").replace("|","-").replace("/","-").replace("\\","-").replace("_","-");
			htmlName = Common.getSingleSpell(htmlName);
			
			List <Map>products = dbHelper.getMapList("select id from pro_products where file_name = '"+htmlName+".shtm'");
			if(products == null || products.size() <= 0){
				rs = htmlName+".shtm";
			}else{
				int random = new Random().nextInt(100);
				rs = htmlName+"-"+random+".shtm";
			}
		}
		//频道树
		if("channel_tree".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}
			
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeData(channels);
		}
		//产品类别
		if("catalog".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}
			
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeData(channels,"parentid","id");
		}
		//频道树
		if("eunm_tree".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}else{
				sql += " order by order_no desc , id asc ";
			}
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeNo(channels);
		}
		//获得编号
		if("get_no".equals(flag)){
			rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName);
		}
		if("get_no_catalog".equals(flag)){
			rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName,"parentid","num");
		}
		//获得键枚举
		if("get_enum".equals(flag)){
			Map enumMap = (Map)application.getAttribute("enumMap");
			JSONObject jsonObject = new JSONObject(enumMap);
			rs = CommonString.getFormatPara(request.getParameter("callback"))+"("+jsonObject.toString()+")";
		}
		//获得文件的内容
		if("get_file_html".equals(flag)){
			String absolutePath = Common.getAbsolutePath(request);
			String fileName = CommonString.getFormatPara(request.getParameter("fileName"));
			File f = new File(absolutePath+"/template/"+fileName);
			rs = FileUtils.readFileToString(f,"utf-8");
		}
		//获取表的字段
		if("get_field_by_table".equals(flag)){
			String sql = " select a.name from syscolumns a,systypes b,sysobjects c ";
			sql += " where a.xtype=b.xtype and a.id=c.id and c.name= '"
					+ tableName + "' ";
			sql += " and b.name <> 'sysname' ";
			sql += " order by a.id ";
			List columns = dbHelper.getMapList(sql, connection);
			Map m = null;
			for (int i = 0; i < columns.size(); i++) {
				m = (Map) columns.get(i);
				out.print(m.get("name"));
				if(i!=(columns.size()-1)){
					out.print("&nbsp;,&nbsp;");
				}
			}
		}
		//更新浏览次数并返回浏览次数
		if("upd_view_count".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" update "+tableName+" set view_count = isnull(view_count,0)+1 where uuid = ? ",new Object [] {uuid},connection);
			Integer times = (Integer)dbHelper.getOne(" select view_count from "+tableName+" where uuid = ? ",new Object [] {uuid},connection);
			rs = ""+times;
		}
		//获取图形验证码
		if("rand".equals(flag)){
			Common.getAuthImg(request, response);
			out.clear();
			out = pageContext.pushBody();
			return;
		}
		//获取验证码(字符串格式)
		if("getRandNum".equals(flag)){
			rs = (String)session.getAttribute("rand");
		}
		//全站生成
		if("allHtmlCreate".equals(flag)){
			Integer second = 0;
			long d1 = Calendar.getInstance().getTime().getTime();
			List<Map> channels = dbHelper.getMapList(" select id from "+table_prefix+"common_channel ",connection);
			Map params = null;
			for(Map m : channels){
				params = new HashMap();
				params.put("eventAfter", "channelTemplate");
				params.put("keyId", m.get("id"));
				Common.doPost(Common.getDomain(request)+"/admin/action/after_own.jsp", params);
			}
			long d2 = Calendar.getInstance().getTime().getTime();
			long l = d2-d1;
			long day=l/(24*60*60*1000);  
			long hour=(l/(60*60*1000)-day*24);  
			long min=((l/(60*1000))-day*24*60-hour*60);  
			long s=(l/1000-day*24*60*60-hour*60*60-min*60);  
			rs = "生成成功<br />共计用时"+s+"秒";
		}
		//商家从车源车辆总数
		if("getDealerCount".equals(flag)){
			
		}
		if("inputDisposePs".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("uuid")) ;
			String sel_sql = "select dispose_ps from pro_product_form where uuid=?" ;
			Map oneMap = null ;
			if(!"".equals(uuid)){
				oneMap = (HashMap)dbHelper.getMap(sel_sql,new Object[]{uuid}) ;
			}
			if(null!=oneMap && oneMap.size()>0){
				out.println(CommonString.getFormatPara(oneMap.get("dispose_ps"))) ;
			}else{
				out.println("") ;
			}
			return ;
		}
		if("inputDisposePs_app".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("uuid")) ;
			String msg = CommonString.getFormatPara(request.getParameter("msg")) ;
			String upt_sql = "update pro_product_form set dispose_ps=? where uuid=?" ;
			if(!"".equals(uuid)){
				dbHelper.execute(upt_sql,new Object[]{msg,uuid}) ;
			}
		}
		connection.commit();
	}catch(Exception e){
	connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	out.print(rs);
%>