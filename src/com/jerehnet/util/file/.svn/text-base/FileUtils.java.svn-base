package com.jerehnet.util.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;

import magick.MagickException;

import com.jerehnet.util.images.ImageHandle;
import org.apache.commons.httpclient.methods.multipart.Part;

/**
 * 文件操作类
 * 
 * @author Administrator
 * 
 */
public class FileUtils {
	/**
	 * 获取文件大小
	 * 
	 * @param file
	 *            文件
	 * @return
	 */
	public static long getFileSize(File file) {
		long size = 0;
		if (file.exists()) {
			FileInputStream fsi;
			try {
				fsi = new FileInputStream(file);
				size = fsi.available();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		return size;
	}

	/**
	 * 通过HTTP方式下载文件
	 * 
	 * @param httpUrl
	 *            远程URL
	 * @param savePath
	 *            本地保存路径+文件名
	 * @throws IOException
	 */
	public static void downFileByHttp(String httpUrl, String savePath)
			throws IOException {
		if (savePath != null && !savePath.equals("")) {
			String dir = savePath.substring(0, savePath.lastIndexOf("/"));
			File f = new File(dir);
			if (!f.exists()) {
				f.mkdirs();
			}
		}
		// 构造URL
		URL url = new URL(httpUrl);
		// 打开连接
		URLConnection con = url.openConnection();
		con.setConnectTimeout(10000);
		con.setReadTimeout(10000);
		// 输入流
		InputStream is = con.getInputStream();
		// 1K的数据缓冲
		byte[] bs = new byte[1024];
		// 读取到的数据长度
		int len;
		// 输出的文件流
		OutputStream os = new FileOutputStream(savePath);
		// 开始读取
		while ((len = is.read(bs)) != -1) {
			os.write(bs, 0, len);
		}
		// 完毕，关闭所有链接
		os.close();
		is.close();
	}
	/**
	 * 通过http下载文件2
	 * @param url
	 * @param dir
	 * @return
	 */
	public static String downloadFromUrl(String url,String dir) {     
	    
        try {     
            URL httpurl = new URL(url);     
            String fileName = getFileNameFromUrl(url);    
            dir = dir + url.substring(url.indexOf("/uploadfiles"),url.lastIndexOf("/"))+"/";
            File fdir= new File(dir);
			if (!fdir.exists()) {
				fdir.mkdirs();
			}
            File f = new File(dir+ fileName);     
            f.createNewFile();
            org.apache.commons.io.FileUtils.copyURLToFile(httpurl, f);     
        } catch (Exception e) {     
            e.printStackTrace();     
            return "Fault!";     
        }      
        return "Successful!";     
    }     
         
    public static String getFileNameFromUrl(String url){     
        String name = new Long(System.currentTimeMillis()).toString() + ".jpg";     
        int index = url.lastIndexOf("/");     
        if(index > 0){     
            name = url.substring(index + 1);     
            if(name.trim().length()>0){     
                return name;     
            }     
        }     
        return name;     
    }     

	/**
	 * 获取网页源码内容
	 * 
	 * @param strUrl
	 *            ：远程URL地址
	 * @return
	 */
	public static String GetURLstr(String strUrl) {
		InputStream in = null;
		OutputStream out = null;
		String strdata = "";
		try {
			URL url = new URL(strUrl); // 创建 URL
			in = url.openStream(); // 打开到这个URL的流
			out = System.out;

			// 复制字节到输出流
			byte[] buffer = new byte[4096];
			int bytes_read;
			while ((bytes_read = in.read(buffer)) != -1) {
				String reads = new String(buffer, 0, bytes_read, "UTF-8");
				strdata = strdata + reads;
				out.write(buffer, 0, bytes_read);
			}
			in.close();
			out.close();
			return strdata;
		}

		catch (Exception e) {
			System.err.println(e);
			System.err.println("Usage: java GetURL <URL> [<filename>]");
			return strdata;
		}
	}
/**
 * 递归获取指定目录下所有的文件和文件夹，包含子文件夹中文件。
 * 把psd图片批量处理成.jpg
 * @param dir
 * @param level
 * @throws MagickException 
 */
	public static void getAll(File dir, int level) throws MagickException {
		level++;
		File[] files = dir.listFiles();
		for (int x = 0; x < files.length; x++) {
			if (files[x].isDirectory()){
				getAll(files[x], level);
			}else{
				String oldFile =files[x].getAbsolutePath();
				String newFile = oldFile.substring(0,oldFile.lastIndexOf("."))+".jpg";
				if(oldFile.indexOf("psd") >= 0){
					ImageHandle.createThumbnail(oldFile, newFile, 580,440);
				}
			}
		}
	}

	public static String getLevel(int level) {
		StringBuilder sb = new StringBuilder();
		sb.append("|--");

		for (int x = 0; x < level; x++) {
			sb.insert(0, "|  ");
		}
		return sb.toString();
	}
	
	 public static void main(String[] args) throws MagickException  
	    {
	        File dir = new File("W:\\hongdeli-12");
	        getAll(dir,0);
	        System.out.print("执行成功");
	    }
	 /**
		 * 判断文件或文件夹是否存在，如果不存在，则创建
		 * 
		 * @param path
		 * @param needCreate
		 */
		public static boolean isExists(String path, boolean needCreate) {
			boolean exists = false;
			File file = new File(path);
			if (!file.exists()) {
				exists = false;
				if (needCreate) {
					file.mkdirs();
				}
			} else {
				exists = true;
			}
			return exists;
		}
		/**
		 * 远程上传
		 * 
		 * @param url
		 * @param file
		 * @return
		 * @throws HttpException
		 * @throws IOException
		 */
		public static String doHttpClientUpload(String url, File file) throws HttpException, IOException {
			String rs = "";
			PostMethod postMethod = new PostMethod(url);
			Part[] parts = { new FilePart(file.getName(), file) };
			postMethod.setRequestEntity(new MultipartRequestEntity(parts, postMethod.getParams()));
			HttpClient client = new HttpClient();
			client.getHttpConnectionManager().getParams().setConnectionTimeout(30000);
			int status = client.executeMethod(postMethod);
			if (status == HttpStatus.SC_OK) {
				rs = new String(postMethod.getResponseBody());
			} else {
				rs = "fail";
			}
			return rs;
		}

}
