package com.jerehnet.webservice;

import java.net.MalformedURLException;

public class WEBEmail {

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String title, String content) throws MalformedURLException, Exception {
		return sendMail(to, null, title, content);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String cc, String title, String content) throws MalformedURLException, Exception {
		return sendMail(to, cc, null, title, content);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMailByUrl(String to, String cc, String bcc, String title, String url, String encoding) throws MalformedURLException, Exception {
		String method = "sendMailByUrl";
		Object[] param = new Object[] { to, cc, bcc, title, url, encoding };
		Object[] results = WEBServiceUtil.executeDynamic("SendMail", method, param);
		return (Boolean) results[0];
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMailByUrl(String to, String title, String url, String encoding) throws MalformedURLException, Exception {
		return sendMailByUrl(to, null, null, title, url, encoding);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param 抄送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMailByUrl(String to, String cc, String title, String url, String encoding) throws MalformedURLException, Exception {
		return sendMailByUrl(to, cc, null, title, url, encoding);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param bcc
	 *            暗送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String cc, String bcc, String title, String content) throws MalformedURLException, Exception {
		return sendMail(to, cc, bcc, title, content, null);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param bcc
	 *            暗送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @param fromName
	 *            发送邮件显示
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String cc, String bcc, String title, String content, String fromName) throws MalformedURLException, Exception {
		return sendMail(to, cc, bcc, title, content, fromName, null, null);
	}

	/**
	 * 发送邮件带附件
	 * 
	 * @param to
	 * @param cc
	 * @param bcc
	 * @param title
	 * @param content
	 * @param fromName
	 * @param attachment
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String cc, String bcc, String title, String content, String fromName, String attachmentFile, String attachmentFileName)
			throws MalformedURLException, Exception {   
		if (null == cc) {
			cc = "";
		}
		if (null == bcc) {
			bcc = "";
		}
		if (null == content) {
			content = "";
		}
		if (null == to) {
			to = "";
		}
		if (null == fromName) {
			fromName = "";
		}
		if (null == attachmentFile) {
			attachmentFile = "";
		}
		if (null == attachmentFileName) {
			if (null != attachmentFile) {
				attachmentFileName = attachmentFile;
				if (attachmentFileName.lastIndexOf("\\") != -1) {
					attachmentFileName = attachmentFileName.substring(attachmentFileName.lastIndexOf("\\") + 1);
				} else if (attachmentFileName.lastIndexOf("/") != -1) {
					attachmentFileName = attachmentFileName.substring(attachmentFileName.lastIndexOf("/") + 1);
				}
			} else { 
				attachmentFileName = "";
			}
		}
		String method = "sendMail4";
		Object[] param = new Object[] { to, cc, bcc, title, content, fromName, attachmentFile, attachmentFileName };
		Object[] results = WEBServiceUtil.executeDynamic("SendMail", method, param);
		for(int i=0;i<results.length;i++){
			System.out.println(results[i]);
		}
		return (Boolean) results[0];
	} 
}
