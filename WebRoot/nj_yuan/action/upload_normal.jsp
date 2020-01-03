<%@ page language="java" import="java.io.File,java.util.*,com.jerei.website.utils.db.*,com.jerehnet.util.common.*,com.jerei.website.utils.*,org.apache.commons.fileupload.servlet.*,com.jerehnet.util.images.*" pageEncoding="UTF-8"%><%@page import="org.apache.commons.fileupload.FileItemFactory"%><%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%><%@page import="java.io.BufferedInputStream"%><%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%

	    String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		String saveUrl = request.getContextPath() + "/uploadfiles/";
		Long maxSize = 100000000l;
		Map<String, String> extMap = new HashMap<String, String>();
		extMap.put("image", "gif,jpg,jpeg,png,bmp");
		extMap.put("file", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb,doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
		String savePath = Common.getAbsolutePath(request)+"uploadfiles/";
		if (!ServletFileUpload.isMultipartContent(request)) {
			Common.println("请选择文件");
			return;
		}
		// 检查目录
		File uploadDir = new File(savePath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}
		// 检查目录写权限
		if (!uploadDir.canWrite()) {
			Common.println("上传目录没有写权限。");
			return;
		}
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		List items = upload.parseRequest(request);
		Iterator itr = items.iterator();
		FileItem item = null;
		File uploadedFile = null;
		String newFileName = null;
		String describe = "";
		BufferedInputStream in = null;
		while (itr.hasNext()) {
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
				if (item.getSize() > maxSize) {
					Common.println("上传文件大小超过限制。");
					return;
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
				String ymd = CommonDate.getToday("yyyy");
				savePath += ymd + "/";
				saveUrl += ymd + "/";
				File dirFile = new File(savePath);
				if (!dirFile.exists()) {
					dirFile.mkdirs();
				}
				//创建月文件夹
				ymd = CommonDate.getToday("MM");
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
					return;
				}
				newFileName = CommonDate.getToday("yyyyMMddHHmmss") + "_" + new Random().nextInt(1000) + "." + fileExt;
				uploadedFile = new File(savePath, newFileName);
				item.write(uploadedFile);
				
				ImageUtils.resizeImg(uploadedFile,1000,1000);
				ImageUtils.pressImage(Common.getAbsolutePath(request)+"/images/21sun_logo.png",uploadedFile.getAbsolutePath()); // 加水印
                ImageUtils.createThumbnail(uploadedFile.getAbsolutePath());
                out.print(saveUrl + newFileName);

			}
		}

%>