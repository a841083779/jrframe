package com.jerehnet.util.getproducts;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import org.apache.commons.io.FileUtils;

public class FileDownLoader {
	public static void downFile(String fileUrl, String savePath) throws Exception {
		// 构造URL
		if (!fileUrl.toLowerCase().startsWith("http://")) {
			fileUrl = "http://" + fileUrl;
		}
//		URL url = new URL(fileUrl);
//		// 打开连接
//		URLConnection con = url.openConnection();
//		con.setConnectTimeout(5000);
//		con.setReadTimeout(10000);
//		System.out.println("打开url连接");
//		// 输入流
//		InputStream is = con.getInputStream();
//		System.out.println("获取输入流");
//		// 1K的数据缓冲
//		byte[] bs = new byte[1024];
//		// 读取到的数据长度
//		int len;
//		// 输出的文件流
//		OutputStream os = new FileOutputStream(savePath);
//		System.out.println("获取输出流");
//		// 开始读取
//		while ((len = is.read(bs)) != -1) {
//			os.write(bs, 0, len);
//		}
//		System.out.println("循环输出完毕");
//		// 完毕，关闭所有链接
//		os.close();
//		is.close();
//		System.out.println("关闭资源");
		URL httpurl = new URL(fileUrl);  
		File f = new File(savePath);    
		f.createNewFile();
		FileUtils.copyURLToFile(httpurl, f); 
	}
}
