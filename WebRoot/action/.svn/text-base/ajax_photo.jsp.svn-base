<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFormatPara(request.getParameter("callback"));
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	
	
	try{
		connection = dbHelper.getConnection(); 	
		
		//前台图集上传
		if("new_save_photo".equals(flag)){
			
			String sql = " insert into pro_photo_group(title,index_title,sort_num,image,is_recommend,is_show,add_date,add_ip,usern,pub_date,uuid,keywords,brand_keywords,zhanhui_num,catalognum,factoryid)";
			sql += " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			String zd_title = CommonString.getFormatPara(request.getParameter("zd_title")) ; // 输入的内容
			String zd_type = CommonString.getFormatPara(request.getParameter("zd_type")) ; // 输入的内容
			String zd_pro_cataname = CommonString.getFormatPara(request.getParameter("zd_pro_cataname")) ; // 输入的类别
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id")) ; // 类别
			String fa_id = CommonString.getFormatPara(request.getParameter("fa_id")) ; // 品牌
			String sort_num = CommonString.getFormatPara(request.getParameter("zd_sort_num")) ; // sort_num
			String zd_zhanhui_num = CommonString.getFormatPara(request.getParameter("zd_zhanhui_num")) ;
			String [] imgs = request.getParameterValues("img");//列表图片
			String img="";
			if(null!=imgs&&imgs.length>0){img=Common.getSmallImg(imgs[0]);}
		    int keyId = dbHelper.executeUpdate(sql,new Object []{zd_title,zd_type,sort_num,img,1,0,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),"youke",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),UUID.randomUUID().toString(),zd_pro_cataname,CommonString.getFormatPara(request.getParameter("zd_factoryname")),zd_zhanhui_num,pro_id,fa_id},connection);
			 connection.setAutoCommit(false);
			 	
			if(null!=imgs&&imgs.length>0){
				for(int i=0;i<imgs.length;i++){
			String sqlStr = " insert into pro_photo ( title,group_id,image,author,pub_date,is_show,add_ip,add_date,add_user,uuid,catalognum,factoryid) ";
			sqlStr += " values ( ? , ? , ? , ? , ? , ? , ? ,?,?,?,?,?)";
			int rb = dbHelper.execute(sqlStr,new Object [] {CommonString.getFormatPara(request.getParameter("zd_title")),keyId,Common.getSmallImg(imgs[i]),"youke",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),1,Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),"author",UUID.randomUUID().toString(),pro_id,fa_id},connection);
		    }}
			
				
			connection.commit();
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>