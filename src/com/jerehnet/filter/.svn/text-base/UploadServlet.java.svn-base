package com.jerehnet.filter;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.jerehnet.util.common.Common;
import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.images.ImageUtils;

@SuppressWarnings("serial")
public class UploadServlet extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String servletPath = request.getServletPath();
		String folder = servletPath.substring(0, servletPath.lastIndexOf("."));
		folder = "";
		PrintWriter out = response.getWriter();
		String path = request.getContextPath();
		@SuppressWarnings("unused")
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
		@SuppressWarnings("unused")
		String state = "SUCCESS";
		Map<String, String> extMap = new HashMap<String, String>();
		extMap.put("image", "gif,jpg,jpeg,png,bmp");
		extMap.put("file", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb,doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
		response.setContentType("application/json; charset=UTF-8");
		// 文件保存目录路径
		String savePath = request.getSession().getServletContext().getRealPath("/") + "uploadfiles" + folder + "/";
		// 文件保存目录URL
		String saveUrl = request.getContextPath() + "/uploadfiles" + folder + "/";
		// 最大文件大小
		response.setContentType("text/html; charset=UTF-8");
		try {
			@SuppressWarnings("unused")
			List params = new ArrayList(0);
			if (!ServletFileUpload.isMultipartContent(request)) {
				state = "ERROR";
			}
			// 检查目录
			File uploadDir = new File(savePath);
			if (!uploadDir.isDirectory()) {
				uploadDir.mkdirs();
			}
			// 检查目录写权限
			if (!uploadDir.canWrite()) {
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
			Iterator itr = items.iterator();
			FileItem item = null;
			File uploadedFile = null;
			String newFileName = null;
			@SuppressWarnings("unused")
			BufferedInputStream in = null;
			while (itr.hasNext()) {
				params = new ArrayList(0);
				item = (FileItem) itr.next();
				String fileName = item.getName();
				@SuppressWarnings("unused")
				long fileSize = item.getSize();
				if (!item.isFormField()) {
					// 检查文件大小
					// if (item.getSize() > maxSize) {
					// state = "ERROR";
					// }
					// 创建文件夹
					Map<String, String> folderMap = new HashMap<String, String>();
					String dirName = "file";
					// 检查扩展名
					String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
					String imgExt = extMap.get("image");
					String[] imgExts = imgExt.split(",");
					for (int i = 0; i < imgExts.length; i++) {
						if (fileExt.equals(imgExts[i])) {
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
					// 创建年文件夹
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
					String ymd = sdf.format(new Date());
					savePath += ymd + "/";
					saveUrl += ymd + "/";
					File dirFile = new File(savePath);
					if (!dirFile.exists()) {
						dirFile.mkdirs();
					}
					// 创建月文件夹
					sdf = new SimpleDateFormat("MM");
					ymd = sdf.format(new Date());
					savePath += ymd + "/";
					saveUrl += ymd + "/";
					dirFile = new File(savePath);
					if (!dirFile.exists()) {
						dirFile.mkdirs();
					}
					// 创建天文件夹
					sdf = new SimpleDateFormat("dd");
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
					// 创建文件夹
					dirName = folderMap.get("dirName");
					savePath = folderMap.get("savePath");
					saveUrl = folderMap.get("saveUrl");
					// 检查扩展名
					fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
					if (!Arrays.<String> asList(extMap.get(dirName).split(",")).contains(fileExt)) {
						state = "ERROR";
					}
					newFileName = CommonDate.getToday("yyyyMMddHHmmss") + "_" + new Random().nextInt(1000) + "." + fileExt;
					uploadedFile = new File(savePath, newFileName);
					Map fileMap = new HashMap();
					fileMap.put("add_user", folder.replaceAll("/", ""));
					fileMap.put("add_date", CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
					fileMap.put("add_ip", Common.getIp(request));
					fileMap.put("description", "");
					fileMap.put("old_name", fileName);
					fileMap.put("new_name", saveUrl + newFileName);
					fileMap.put("website", folder.replaceAll("/", ""));
					fileMap.put("file_size", fileSize);
					fileMap.put("file_type", fileExt);
					item.write(uploadedFile);
					if (extMap.get("image").indexOf(fileExt) != -1) {// 如果是图片
						// 修改图片大小
						ImageUtils.resizeImg(uploadedFile);
						// 添加水印
						String watermark = CommonString.getFormatPara(request.getParameter("watermark"));
						if (null != watermark) {
							if (watermark.indexOf("fileext=") != -1) {
								watermark = watermark.substring(0, watermark.indexOf("fileext="));
							}
						}
						if (null == watermark || "".equals(watermark)) {
							watermark = "true";
						}
						if (null != watermark && "true".equals(watermark)) {
							File water = new File(request.getSession().getServletContext().getRealPath("/images/") + "/21sun_water.png");
							if (water.exists()) {// 如果水印存在
								ImageUtils.pressImage(water.getAbsolutePath(), uploadedFile.getAbsolutePath());
							}
						}
						// 创建缩略图
						ImageUtils.createThumbnail(uploadedFile.getAbsolutePath());
					}
					out.print(saveUrl + newFileName);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
