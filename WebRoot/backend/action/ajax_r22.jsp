<%@ page language="java" import="org.json.*,java.io.File,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,org.apache.commons.io.FileUtils" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map adminInfo = (Map)session.getAttribute("adminInfo");
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
			htmlName = Common.getSingleSpell(htmlName).replaceAll("\\+","");
			
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
		// 厂家类别
		if("factory_catalog".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}
			
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeData(channels,"parentid","num");
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
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ; // 厂家 id
			if(!"".equals(factoryid)){
				rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName,"parentid","num",factoryid);
			}else{
				rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName,"parentid","num");
			}
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
				Common.doPost(Common.getDomain(request)+"/backend/action/after_own.jsp", params);
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
		//任务一列表请求地址
		if("task1_list_report".equals(flag)){
			JSONObject obj = new JSONObject();
			String sql = " select pce.name,count(p4t.call_rs) as counts from ";
			sql += " pro_common_enum pce left join pro_400_task1 p4t on p4t.call_rs = pce.no ";
			sql += " where pce.parent_no = '103' group by p4t.call_rs,pce.name ";
			List<Map> enumCounts = dbHelper.getMapList(sql,connection);
			obj.put("Rows",new JSONArray(enumCounts));
			obj.put("Total",enumCounts.size());
			rs = obj.toString();
		}
		//任务二列表请求地址
		if("task2_list_report".equals(flag)){
			JSONObject obj = new JSONObject();
			String sql = " select pce.name,count(p4t.call_rs) as counts from ";
			sql += " pro_common_enum pce left join pro_400_task2 p4t on p4t.call_rs = pce.no ";
			sql += " where pce.parent_no = '103' group by p4t.call_rs,pce.name ";
			List<Map> enumCounts = dbHelper.getMapList(sql,connection);
			obj.put("Rows",new JSONArray(enumCounts));
			obj.put("Total",enumCounts.size());
			rs = obj.toString();
		}
		//将订单状态改为已删除
		if(flag.equals("updateProductOrderDelete")){
			//前置事件
			String eventBefore = CommonString.getFormatPara(request.getParameter("eventBefore"));
			//如果有前置事件
			if(!"".equals(eventBefore)){
				Common.doPost(Common.getDomain(request)+"/backend/action/before.jsp",request.getParameterMap());
			}
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			rs = String.valueOf(dbHelper.execute("update pro_product_form set is_deleted=1 where uuid in (" + ids + ")", connection));
		}
		//获取代理商及厂家代理的品牌
		if(flag.equals("getBrand")){
		    String factoryId = CommonString.getFormatPara(request.getParameter("factoryId"));
			if(!"".equals(factoryId)){
			String ids="";
			String sql="";
			String daili="select agent_fac from pro_agent_factory where id="+factoryId;
			List<Map> dailiList =(ArrayList) dbHelper.getMapList(daili , connection);
			if(dailiList!=null&&dailiList.size()>0){
			    for(Map m : dailiList){
				    ids=(String)(m.get("agent_fac"));
				}
			}
			if(ids.equals("")){	 sql = " select id,name from pro_agent_factory where 1 = 1 and flag=1 and id="+factoryId;}else{
			 sql = " select id,name from pro_agent_factory where 1 = 1 and flag=1 and (id="+factoryId+" or id in("+ids+"))";}
			List<Map> brandList =(ArrayList) dbHelper.getMapList(sql , connection);
		    String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(brandList != null){
			    for(Map m : brandList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		  }
		}
		//获取改品牌下产品
		if(flag.equals("getPro")){
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
		if(!"".equals(brandId)){	
		    String  sql="select id,name from pro_products where is_show=1 and factoryid="+brandId+" order by view_count desc";
			if(!catalognum.equals("")){sql=sql+"and catalognum='"+catalognum+"'";}
         	List<Map> proList =(ArrayList) dbHelper.getMapList(sql , connection);
			String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(proList != null){
			    for(Map m : proList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		 }	
		}
		
		
		
		//获取改品牌下产品
		if(flag.equals("getAgentList")){
			String factoryId = CommonString.getFormatPara(request.getParameter("factoryId"));
		if(!"".equals(factoryId)){	
		    String  sql="select id,name from pro_agent_factory where is_show=1 and flag=2 and  agent_fac like '%"+factoryId+"%'";
         	List<Map> proList =(ArrayList) dbHelper.getMapList(sql , connection);
			String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(proList != null){
			    for(Map m : proList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		  }	
		}
		
		// 留言批量放入回收站
		if("orderDeleteCheck".equals(flag)){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			if (null != ids && ids.length() > 0) {
				String sql = "update pro_comments set is_show=0  where uuid in (" + ids+ ") ";
				rs = dbHelper.execute(sql,connection)+"";
			}
		}
		// 留言批量从回收站移回评论栏目
		if("orderRebackCheck".equals(flag)){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			if (null != ids && ids.length() > 0) {
				String sql = "update pro_comments set is_show=1  where uuid in (" + ids+ ") ";
				rs = dbHelper.execute(sql,connection)+"";
			}
		}
		//该订单为恶意垃圾订单，删除至垃圾订单仓库
		if(flag.equals("updateProductOrderDeleteNew")){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			rs = String.valueOf(dbHelper.execute("update pro_product_form set is_garbage=1,is_deleted=1 where uuid in (" + ids + ")", connection));
		}
		
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>