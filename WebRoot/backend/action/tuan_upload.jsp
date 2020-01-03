<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.file.*,org.json.*,com.jerehnet.util.images.*,java.text.*,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.*,java.util.*,com.jerehnet.util.dbutil.*,org.apache.commons.fileupload.servlet.ServletFileUpload,com.jerehnet.util.common.*,java.io.*" pageEncoding="UTF-8"%>
<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String group_id = CommonString.getFormatPara(request.getParameter("group_id"));
	String fileExts = CommonString.getFormatPara(request.getParameter("fileExt")) ;
	String iswartermark = CommonString.getFormatPara(application.getAttribute("ismark")) ;  // 中否加水印
	if("".equals(iswartermark)){
		iswartermark = "1" ;  // 默认加水印
	}
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String state = "SUCCESS";
	Long maxSize = 100000000l;
	Map<String, String> extMap = new HashMap<String, String>();
	extMap.put("image", "gif,jpg,jpeg,png,bmp");
	extMap.put("file", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb,doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
	response.setContentType("application/json; charset=UTF-8");
	DBHelper dbHelper = DBHelper.getInstance();
	// 文件保存目录路径
	String savePath = request.getSession().getServletContext().getRealPath("/")+ "uploadfiles/";
	// 文件保存目录URL
	String saveUrl = request.getContextPath() + "/uploadfiles/";
	// 最大文件大小
	response.setContentType("text/html; charset=UTF-8");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		Map adminInfo = (Map)session.getAttribute("adminInfo");
		if(null==adminInfo){
			String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
			adminInfo = dbHelper.getMap(" select * from "+table_prefix+"common_user where uuid = ? ",new Object [] {uuid},connection);
		}
		List params = new ArrayList(0);
		Map postMap = new HashMap();
		postMap.putAll(request.getParameterMap());
		if(null!=adminInfo){
			postMap.put("uuid",adminInfo.get("uuid"));
		}
		if (!ServletFileUpload.isMultipartContent(request)) {
			Common.println("请选择文件");
			state = "ERROR";
		}
		// 检查目录
		File uploadDir = new File(savePath);
		if (!uploadDir.isDirectory()) {
			Common.println("上传目录不存在。");
			return;
		}
		// 检查目录写权限
		if (!uploadDir.canWrite()) {
			Common.println("上传目录没有写权限。");
			state = "ERROR";
		}
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		List items = new ArrayList(0);
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		String sql = "";
		Iterator itr = items.iterator();
		FileItem item = null;
		File uploadedFile = null;
		String newFileName = null;
		String describe = "";
		BufferedInputStream in = null;
		while (itr.hasNext()) {
			params = new ArrayList(0);
			item = (FileItem) itr.next();
			String fileName = item.getName();
			@SuppressWarnings("unused")
			long fileSize = item.getSize();
			
			//如果有照片描述
			if(item.getFieldName().indexOf("pictitle")!=-1){
				in = new BufferedInputStream(item.getInputStream());
                byte c [] = new byte[10];
                int n = 0;
                describe = "";
                while((n=in.read(c))!=-1){
                	describe += new String(c,0,n);
                }
                if(null!=describe&&describe.indexOf(".")!=-1){
                	describe = "";
                }
                in.close();
			}
			if (!item.isFormField()) {
				if(null!=adminInfo){
					params.add(adminInfo.get("usern"));
				}else{
					params.add("");
				}
				params.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
				params.add(Common.getIp(request));
				params.add(CommonString.getUUID());
				params.add(describe);
				params.add(describe);
				params.add(fileName);
				// 检查文件大小
				if (item.getSize() > maxSize) {
					Common.println("上传文件大小超过限制。");
					state = "ERROR";
				}
				//创建文件夹
				Map<String,String> folderMap = new HashMap<String, String>();
				String dirName = "file";
				// 检查扩展名
				String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
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
				if (!Arrays.<String> asList(extMap.get(dirName).split(","))
						.contains(fileExt)) {
					Common.println("上传文件扩展名是不允许的扩展名。\n只允许"
							+ extMap.get(dirName) + "格式。");
					state = "ERROR";
					continue;
				}
				newFileName = CommonDate.getToday("yyyyMMddHHmmss") + "_" + new Random().nextInt(1000) + "." + fileExt;
				uploadedFile = new File(savePath, newFileName);
				item.write(uploadedFile);
				sql = " insert into pro_tuan_image ( add_user , add_date , add_ip , uuid , title , description , old_name , new_name , small_new_name , file_size , file_type ,pro_id) ";
				//向数据库保存时，去掉uploadfiles的路径
				saveUrl = saveUrl.replace("/uploadfiles","");
				params.add(saveUrl+newFileName);
				if(extMap.get("image").indexOf(fileExt)!=-1){
					ImageUtils.resizeImg(uploadedFile,1000,1000);
					
					if(iswartermark.equals("1"))
					{
						ImageUtils.pressImage(Common.getAbsolutePath(request)+"/images/21sun_logo.png",uploadedFile.getAbsolutePath()); // 加水印
					}
					ImageUtils.createThumbnail(uploadedFile.getAbsolutePath());
					params.add(Common.getSmallImg(saveUrl+newFileName));
					params.add(FileUtils.getFileSize(uploadedFile));
					params.add(1);
					params.add(group_id);
				}else{
					params.add("");
					params.add(FileUtils.getFileSize(uploadedFile));
					params.add(2);
					params.add(group_id);
				}
				sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,?) ";
				Integer keyId = null ;
				if(!state.equals("ERROR")){
					 keyId = dbHelper.executeUpdate(sql,params.toArray(),connection);
				}
				if(null!=adminInfo){
					postMap.put("channel_no","101007");
					postMap.put("tableName","pro_tuan_image");
					postMap.put("keyId",keyId);
					postMap.put("logFlag","101001");
					postMap.put("usern",adminInfo.get("usern"));
					Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/log.jsp",postMap);
				}
				//如果为空的话是百度编辑器来上传
				if("".equals(flag)){
					JSONObject obj = new JSONObject();
					obj.put("url", "/uploadfiles/"+saveUrl + newFileName);
					obj.put("title",describe);
					obj.put("state","SUCCESS");
					out.println(obj.toString());
				}else if("camera?m=user".equals(flag)){
					response.setContentType("application/json; charset=UTF-8");
					String outStr = basePath+saveUrl+newFileName; 
					out.println(outStr);
					return;
				}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>
