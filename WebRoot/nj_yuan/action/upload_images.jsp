<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="com.jereh.commons.dbutils.DBHelper"%>
<%@page import="com.jereh.commons.utils.Common"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="com.jereh.commons.utils.ImageUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.jereh.commons.utils.CommonDate"%>
<%@page import="com.jereh.commons.utils.CommonString"%>
<%@page import="com.jereh.bbs.file.FileUtils"%>
<%@page import="com.jereh.commons.utils.Constants"%>
<%

int userId=000001;
Map pubTopicMap=(Map)session.getAttribute(userId+"_pub_topic");
if(pubTopicMap==null){
	pubTopicMap=new HashMap();
}
String pressImgPath = request.getSession().getServletContext().getRealPath("");
pressImgPath=pressImgPath.replace("\\","/");

String stateInfo = "";
String newFileUrl = "";
String newFileName ="";
String fileName = "";
String saveUrl="";
File uploadedFile = null;
int width=0;
int height=0;
String title=CommonString.getFormatPara(request.getParameter("title"));
if(!"".equals(title)){
	pubTopicMap.put("title",title);
}


session.setAttribute(userId+"_pub_topic",pubTopicMap);
String UUID=CommonString.getUUID();
String sql="";
if(ServletFileUpload.isMultipartContent(request)){
	//设置返回值类型	
	response.setContentType("text/html;charset=utf-8");
	//设置返回状态
	String state = "SUCCESS";
	//允许上传的文件扩展名集合
	Map<String, String> extMap = new HashMap<String, String>();
	extMap.put("image", "gif,jpg,jpeg,png,bmp");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		// 文件保存目录路径
		String savePath = request.getSession().getServletContext().getRealPath("/")+ "upload/";
		// 文件保存目录URL
		saveUrl = request.getContextPath() + "/upload/";
		// 验证用户是否登录
		Map userInfo = null;
		userInfo = (Map)session.getAttribute("userInfo");

		// 判断请求中是否包含文件
		if (!ServletFileUpload.isMultipartContent(request)) {
			Common.println("请选择文件");
			state = "ERROR";
			throw new Exception("请选择文件");
		}
		// 检查目录是否正确
		File uploadDir = new File(savePath);
		if (!uploadDir.isDirectory()) {
			state = "ERROR";
			stateInfo = "上传目录不存在，上传失败！<a href='javascript:window.history.go(-1)' onclick='window.history.go(-1)'>请重新填写</a>";
			throw new Exception("上传目录不存在。");
		}
		// 检查目录写权限
		if (!uploadDir.canWrite()) {
			state = "ERROR";
			stateInfo = "上传目录没有写权限，上传失败！<a href='javascript:window.history.go(-1)' onclick='window.history.go(-1)'>请重新填写</a>";
			throw new Exception("上传目录没有写权限。");
		}
		
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		List<FileItem> items = (List<FileItem>)upload.parseRequest(request);
		//设置最大上传尺寸
		Long maxSize = 20000000l;
		for (FileItem item : items) {
			List params = new ArrayList(0);
			//如果是普通表单，不检查
			if (item.isFormField()) {
				continue;
			}
			fileName = item.getName();
			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			//检查扩展名,不允许则停止上传

			//检查文件大小
			long fileSize = item.getSize();
			if (item.getSize() > maxSize) {
				state = "ERROR";
				stateInfo = "上传失败，上传文件过大！<a href='javascript:window.history.go(-1)' onclick='window.history.go(-1)'>请重新填写</a>";
				throw new Exception("文件大小超出限制。");
			}
			//创建文件夹
			Map<String,String> folderMap = new HashMap<String, String>();
			String dirName = "file";
			// 检查扩展名
			fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			String imgExt = extMap.get("image");
			String [] imgExts = imgExt.split(",");
			for (int i = 0; i < imgExts.length; i++) {
				if(fileExt.equals(imgExts[i])){
					dirName = "image";
				}
			}
			// 创建文件夹
			savePath += dirName + "/";
			saveUrl += dirName + "/";
			File saveDirFile = new File(savePath);
			if (!saveDirFile.exists()) {
				saveDirFile.mkdirs();
			}
			//创建年文件夹
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			String ymd = sdf.format(new Date());
			savePath += ymd + "/";
			saveUrl += ymd + "/";
			File dirFile = new File(savePath);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}
			//创建月文件夹
			sdf = new SimpleDateFormat("MM");
			ymd = sdf.format(new Date());
			savePath += ymd + "/";
			saveUrl += ymd + "/";
			dirFile = new File(savePath);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}
			folderMap.put("dirName", dirName);
			folderMap.put("savePath", savePath);
			folderMap.put("saveUrl", saveUrl);
			//创建文件夹
			
			dirName = folderMap.get("dirName");
			savePath = folderMap.get("savePath");
			saveUrl = folderMap.get("saveUrl");
			// 检查扩展名
			fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			
			newFileName = CommonDate.getToday("yyyyMMddHHmmss") + "_" + new Random().nextInt(1000) + "." + fileExt;
			uploadedFile = new File(savePath, newFileName);
			
			item.write(uploadedFile);
			//上传图片重新剪裁
			ImageUtils.resizeWeiboImg(uploadedFile,575);
			//生成缩略图1
			String wh=ImageUtils.createThumbnailReturn(uploadedFile.getAbsolutePath());
			//大图加水印
			ImageUtils.pressImage(pressImgPath+Constants.PRESSIMG_TIEBI,pressImgPath+Constants.PRESSIMG_21SUN,savePath+newFileName);
			
			String widths=wh.substring(0,wh.indexOf(","));
			String heights=wh.substring(wh.indexOf(",")+1,wh.length());
			if(!"".equals(widths)){
			  width=CommonString.getFormatInt(widths);
			}
			if(!"".equals(heights)){
			  height=CommonString.getFormatInt(heights);
			}
			newFileUrl = saveUrl+newFileName;
			sql="insert into pro_comments_image (create_date,last_modify_date,create_user_id,last_modify_user_id,add_ip,uuid,info_catalog_no,resource_name,remark,resource_address,img_small,width,height,file_size,resource_type_id,parent_uuid)";
			params.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
			params.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
			params.add(userId);
			params.add(userId);
			params.add(Common.getIp(request,1));
			params.add(UUID);
			params.add(pubTopicMap.get("infoCatalogNo"));
			params.add(fileName);
			params.add("");
			params.add(newFileUrl);
			params.add(Common.getSmallImg(newFileUrl));
			params.add(width);
			params.add(height);
			params.add(FileUtils.getFileSize(uploadedFile));
			params.add(1);
			params.add(2);
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ?) ";
			Integer keyId = dbHelper.executeUpdate(sql,params.toArray(),connection);
			
			if(keyId>0){
				state="ok";
				//System.out.println(111);
				stateInfo = "上传成功,<a href='/m/posting.jsp?uuid="+pubTopicMap.get("uuid")+"'>返回页面继续编辑</a>";
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}}
%>
<!DOCTYPE>
<html>
  <head>
    
    <title>图片上传</title>
    
	<meta name="viewport" content="width=device-width" />
	<%
	if(ServletFileUpload.isMultipartContent(request)){%>
		<meta HTTP-EQUIV="Refresh" Content=" 1;URL=/m/posting.jsp?uuid=<%=pubTopicMap.get("uuid") %>">
	<%} %>
	
  </head>
  <body>
    <div class="appbar redbtn"><a href="/pic/m/index.jsp" class="home"></a>上传图片</div>
<div class="wrap">
   <form name="form1" method="post" action="?&uuid=<%=pubTopicMap.get("uuid") %>&flag=true" enctype="multipart/form-data" style="">
   
   <p class="tabs-1" style="">选择照片:</p>
   <p class="tabs-1" style=""><input name="picFile" type="file" size="15" style=""></p>
   <p class="tabs-1" style=""><input type="submit" name="submit" value="上传" class="btn-s" style=""></p>
   </form>
   <label><%=stateInfo %></label>
   </div>
  </body>
</html>
