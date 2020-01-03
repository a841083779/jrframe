<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	response.setContentType("text/xml;charset=utf-8");
	StringBuilder builder = new StringBuilder("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
	try{
		connection = dbHelper.getConnection();
		
		if(flag.equals("category")){
			builder.append("<categorys>");
			builder.append("<category num=\"101001\" name=\"挖掘机\" />");
			builder.append("<category num=\"101002\" name=\"装载机\" />");
			builder.append("<category num=\"102\" name=\"起重机\" />");
			builder.append("<category num=\"101003\" name=\"推土机\" />");
			builder.append("<category num=\"103\" name=\"混凝土\" />");
			builder.append("<category num=\"106001\" name=\"压路机\" />");
			builder.append("<category num=\"101005\" name=\"平地机\" />");
			builder.append("<category num=\"105003\" name=\"旋挖钻\" />");
			builder.append("<category num=\"113001\" name=\"破碎锤\" />");
			builder.append("<category num=\"104001\" name=\"摊铺机\" />");
			builder.append("</categorys>");
		}
		
		if(flag.equals("product_list")){
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String factory = CommonString.getFormatPara(request.getParameter("factory"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			String offset = CommonString.getFormatPara(request.getParameter("offset"));
			StringBuffer whereStr = new StringBuffer(" and is_show=1");
			if (!"".equals(catalog)) {
				whereStr.append(" and catalognum like '" + catalog + "%'");
			}
			if (!"".equals(factory)) {  
				whereStr.append(" and factoryid=" + factory);
			}
			if (!"".equals(tonandmeter)) {
				//拆分吨位
				String[] parttonandmeters = null;
				String firsttonandmeter = "";
				parttonandmeters = tonandmeter.split("_");
				firsttonandmeter = parttonandmeters[1];
				if ("0".equals(parttonandmeters[2])) {
					whereStr.append(" and tonandmeter < " + firsttonandmeter);
				} else if ("1".equals(parttonandmeters[2])) {
					whereStr.append(" and tonandmeter >" + firsttonandmeter);
				} else if ("01".equals(parttonandmeters[2])) {
					whereStr.append(" and tonandmeter =" + firsttonandmeter);
				} else {
					whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
				}
			}
			PageBean pageBean = new PageBean(); // 分页程序
			pageBean.setPageSize(10); // 每页显示条数
			pageBean.setCondition(whereStr.toString());
			Integer nowPage = 1;
			if("".equals(offset) || Integer.parseInt(offset)<=0){
				offset = "0" ;
			}
			if (!"".equals(offset) && !"0".equals(offset)) {
				nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
			}
			pageBean.setNowPage(nowPage);
			pageBean.setOrderBy("order_no_all desc, view_count desc");
			pageBean.setFields("id,factoryname,name,introduce,catalogname,img2");
			pageBean.setTableName("pro_products");
			
			List<Map> proList = pageBean.getDatas(connection);
			if(proList!=null && proList.size()>0){
				builder.append("<products>");
				for(Map pro : proList){
					String id = CommonString.getFormatPara(pro.get("id"));
					String factoryname = CommonString.getFormatPara(pro.get("factoryname"));
					String name = CommonString.getFormatPara(pro.get("name"));
					String introduce = CommonString.getFormatPara(pro.get("introduce"));
					introduce = introduce.replace("&nbsp;", " ");
					introduce = CommonString.substringByte(CommonHtml.filterHTML(introduce), 180) + (CommonHtml.filterHTML(introduce).equals("")?"":"...");
					String catalogname = CommonString.getFormatPara(pro.get("catalogname"));
					String img2 = CommonString.getFormatPara(pro.get("img2"));
					img2 = "http://product.21-sun.com/uploadfiles" + img2;
					builder.append("<product>");
					builder.append("<id>" + id + "</id>");
					builder.append("<name>" + factoryname + name + catalogname + "</name>");
					builder.append("<img>" + img2 + "</img>");
					builder.append("<intro>" + introduce + "</intro>");
					builder.append("<size>" + pageBean.getPageCount() + "</size>");
					builder.append("</product>");
				}
				builder.append("</products>");
			}
		}
		
		if(flag.equals("product_detail")){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			Map pro = dbHelper.getMap("select * from pro_products where id=" + id, connection);
			if(pro!=null){
				builder.append("<root>");
				builder.append("<product>");
				builder.append("<id>" + id + "</id>");
				builder.append("<name>" + CommonString.getFormatPara(pro.get("name")) + "</name>");
				builder.append("<factoryid>" + CommonString.getFormatPara(pro.get("factoryid")) + "</factoryid>");
				builder.append("<factoryname>" + CommonString.getFormatPara(pro.get("factoryname")) + "</factoryname>");
				builder.append("<catalognum>" + CommonString.getFormatPara(pro.get("catalognum")) + "</catalognum>");
				builder.append("<catalogname>" + CommonString.getFormatPara(pro.get("catalogname")) + "</catalogname>");
				builder.append("<price_start>" + CommonString.getFormatPara(pro.get("price_start")) + "</price_start>");
				builder.append("<price_end>" + CommonString.getFormatPara(pro.get("price_end")) + "</price_end>");
				builder.append("<img2>" + "http://product.21-sun.com/uploadfiles" + CommonString.getFormatPara(pro.get("img2")) + "</img2>");
				builder.append("<paras>" + CommonString.getFormatPara(pro.get("paras")).replace("&nbsp;", " ").replace("<","^^^^^").replace(">","*****") + "</paras>");
				builder.append("<introduce>" + CommonString.getFormatPara(pro.get("introduce")).replace("&nbsp;", " ").replace("<","^^^^^").replace(">","*****") + "</introduce>");
				builder.append("</product>");
				builder.append("</root>");
			}
		}
		
		if(flag.equals("product_imgs")){
			String product_id = CommonString.getFormatPara(request.getParameter("product_id"));
			List<Map> list = dbHelper.getMapList("select img_name from pro_product_pic where product_id=" + product_id, connection);
			if(list!=null && list.size()>0){
				builder.append("<root>");
				for(Map m : list){
					String img = CommonString.getFormatPara(m.get("img_name")).indexOf("uploadfiles")>0?CommonString.getFormatPara(m.get("img_name")):"/uploadfiles/"+CommonString.getFormatPara(m.get("img_name"));
					img = img.replace("//", "/");
					img = "http://product.21-sun.com" + img;
					builder.append("<imgs><img>" + img + "</img></imgs>");
				}
				builder.append("</root>");
			}
		}
		
		if(flag.equals("product_comments")){
			String product_id = CommonString.getFormatPara(request.getParameter("product_id"));
			List<Map> list = dbHelper.getMapList("select id,add_date,name,content from pro_comments where product_id =" + product_id + " order by add_date desc,id desc", connection);
			if(list!=null &&list.size()>0){
				builder.append("<comments>");
				for(Map m : list){
					builder.append("<comment>");
					builder.append("<id>" + CommonString.getFormatPara(m.get("id")) + "</id>");
					builder.append("<add_date>" + CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss", m.get("add_date")) + "</add_date>");
					builder.append("<name>" + CommonString.getFormatPara(m.get("name")) + "</name>");
					builder.append("<content>" + CommonString.getFormatPara(m.get("content")) + "</content>");
					builder.append("</comment>");
				}
				builder.append("</comments>");
			}
		}
		
		if(flag.equals("product_orders")){
			String product_id = CommonString.getFormatPara(request.getParameter("product_id"));
			List<Map> list = dbHelper.getMapList("select top 20 id,add_date,factoryname,cataname,product_name,name,contact_address from pro_product_form where is_deleted=0 and product_name is not null and product_name!='' and product_id=" + product_id + " order by add_date desc,id desc", connection);
			if(list!=null && list.size()>0){
				builder.append("<orders>");
				for(Map m : list){
					builder.append("<order>");
					builder.append("<id>" + CommonString.getFormatPara(m.get("id")) + "</id>");
					builder.append("<add_date>" + CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss", m.get("add_date")) + "</add_date>");
					builder.append("<factoryname>" + CommonString.getFormatPara(m.get("factoryname")) + "</factoryname>");
					builder.append("<categoryname>" + CommonString.getFormatPara(m.get("categoryname")) + "</categoryname>");
					builder.append("<product_name>" + CommonString.getFormatPara(m.get("product_name")) + "</product_name>");
					builder.append("<name>" + CommonString.getFormatPara(m.get("name")) + "</name>");
					builder.append("<contact_address>" + CommonString.getFormatPara(m.get("contact_address")) + "</contact_address>");
					builder.append("</order>");
				}
				builder.append("</orders>");
			}
		}
		
		rs = builder.toString();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>