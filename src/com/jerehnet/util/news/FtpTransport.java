package com.jerehnet.util.news;

import java.io.IOException;
import java.io.InputStream;
import java.security.Key;
import java.security.Security;

import javax.crypto.Cipher;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

public class FtpTransport {
    
	
	 //传输文件
	public static boolean uploadFile(String url,int port,String username, String password, String path, String filename, InputStream input) {
		boolean success = false;
		FTPClient ftp = new FTPClient();
		try {
			int reply;
			ftp.connect(url, port);//连接FTP服务器
			//如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
			ftp.login(username, password);//登录
			reply = ftp.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				ftp.disconnect();
				return success;
			}
	        //设置以二 制方式传输   
			ftp.enterLocalPassiveMode();
			ftp.setFileType(FTPClient.BINARY_FILE_TYPE); 
			ftp.setControlEncoding("UTF-8");

			ftp.changeWorkingDirectory(path);
			Boolean test = ftp.storeFile(filename, input);			
			input.close();
			ftp.logout();
	
			if(test!=true){success = false;}
			else{ success = true;}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch (IOException ioe) {
				}
			}
		}
		return success;
	}
	
	 public static boolean removeFile(String url,int port,String username, String password, String path, String filename){  
		   boolean success = false;
			FTPClient ftp = new FTPClient();
			String srcFname=path+filename;
			try {
				int reply;
				ftp.connect(url, port);//连接FTP服务器
				//如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
				ftp.login(username, password);//登录
				reply = ftp.getReplyCode();
				System.out.println("reply="+reply);
				if (!FTPReply.isPositiveCompletion(reply)) {
					ftp.disconnect();
					return success;
				}
				System.out.println("srcFname="+srcFname);
				success = ftp.deleteFile(srcFname); //文件删除 
				System.out.println("success="+success);
				 if(ftp !=null){  //ftp销毁
			            if(ftp.isConnected()){  
			                try {  
			                	ftp.logout();  
			                	ftp.disconnect();  
			                } catch (IOException e) {  
			                    e.printStackTrace();  
			                }   
			            }  
			        }  
	            } catch (IOException e) {  
	                e.printStackTrace();
	            }  
	        return success;  
	    }  
	 
	 
	 //验证上传文件
	 public static int checkFiles(String url) {
		  int formatStr = 0;
		    String prefixs=url.substring(url.lastIndexOf(".")+1);
		    if(prefixs.equals("shtml")){
		    	formatStr = 1;
			}else if(prefixs.equals("html")){
				formatStr = 1;
			}else if(prefixs.equals("htm")){
				formatStr = 1;
			}
		  return formatStr;
	 }
	 
	 
        //创建文件夹
	 public static boolean makeDirectory(String url,int port,String username, String password,String path, String dir) {  
		   boolean success = false;
			FTPClient ftp = new FTPClient();
			try {
				int reply;
				ftp.connect(url, port);//连接FTP服务器
				//如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
				ftp.login(username, password);//登录
				reply = ftp.getReplyCode();
				if (!FTPReply.isPositiveCompletion(reply)) {
					ftp.disconnect();
					return success;
				}
			} catch (IOException e) {  
                e.printStackTrace();
            }  
			//创建文件夹
	        boolean flag = true;  
	        try {  
	            flag = ftp.makeDirectory(path+dir);  
	            if (flag) {  
	                System.out.println("make Directory " +dir +" succeed");  
	  
	            } else {  
	  
	                System.out.println("make Directory " +dir+ " false");  
	            }  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        return flag;  
	    }  
}
