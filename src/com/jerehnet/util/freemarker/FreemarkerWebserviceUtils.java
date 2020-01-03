package com.jerehnet.util.freemarker;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import com.jerehnet.util.common.Common;
import com.jerehnet.util.dbutil.DBHelper;
import com.jerehnet.webservice.WEBDBHelper;

import freemarker.cache.MruCacheStorage;
import freemarker.ext.beans.BeansWrapper;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;

public class FreemarkerWebserviceUtils {
	private static Configuration configuration = null;

	private static SQLUtilsWebService sqlUtils = null;

	private Writer out = null;

	public FreemarkerWebserviceUtils(String basePath) {
		configuration = new Configuration();
		try {
			configuration.setDirectoryForTemplateLoading(new File(basePath));
			configuration.setDefaultEncoding("utf-8");
			configuration.setObjectWrapper(new DefaultObjectWrapper());
			configuration
					.setTemplateExceptionHandler(new FreemarkerExceptionHandler());
			configuration.setCacheStorage(new MruCacheStorage(20, 250));
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (null == sqlUtils) {
			sqlUtils = new SQLUtilsWebService();
		}
	}

	/**
	 * 后台根据模板生成文件
	 * 
	 * @param name
	 *            模板名称
	 * @param outPath
	 *            输出路径
	 * @throws IOException
	 * @throws TemplateException
	 */
	public void generate(String name, String outPath) throws TemplateException,
			IOException {
		this.generate(name, null, outPath, null);
	}

	/**
	 * 后台根据模板生成文件
	 * 
	 * @param name
	 *            模板名称
	 * @param root
	 *            数据
	 * @param outPath
	 *            输出路径
	 * @throws IOException
	 * @throws TemplateException
	 */
	public void generate(String name, Map root, String outPath)
			throws TemplateException, IOException {
		this.generate(name, root, outPath, null);
	}

	/**
	 * 生成模板预览
	 * 
	 * @param name
	 * @param root
	 * @param out
	 * @throws IOException
	 * @throws TemplateException
	 */
	public void preview(String name, Map root, Writer out)
			throws TemplateException, IOException {
		this.preview(name, root, out, null);
		if (null != out) {
			out.close();
		}
		root = null;
	}

	/**
	 * 生成模板预览
	 * 
	 * @param name
	 * @param root
	 * @param out
	 * @throws IOException
	 * @throws TemplateException
	 */
	@SuppressWarnings("unchecked")
	public void preview(String name, Map root, Writer out,
			HttpServletRequest request) throws TemplateException, IOException {
		if (null == root) {
			root = new HashMap();
		}
		Template template = configuration.getTemplate(name);
		// 执行sql语句的方法
		root.put("query", sqlUtils);
		// 静态方法
		BeansWrapper wrapper = BeansWrapper.getDefaultInstance();
		TemplateHashModel staticModels = wrapper.getStaticModels();
		TemplateHashModel commonString = (TemplateHashModel) staticModels
				.get("com.jerehnet.util.common.CommonString");
		TemplateHashModel common = (TemplateHashModel) staticModels
				.get("com.jerehnet.util.common.Common");
		TemplateHashModel commonApplication = (TemplateHashModel) staticModels
				.get("com.jerehnet.util.common.CommonApplication");
		TemplateHashModel commonForm = (TemplateHashModel) staticModels
				.get("com.jerehnet.util.common.CommonForm");
		TemplateHashModel commonHtml = (TemplateHashModel) staticModels
				.get("com.jerehnet.util.common.CommonHtml");
		TemplateHashModel commonDate = (TemplateHashModel) staticModels
				.get("com.jerehnet.util.common.CommonDate");
		root.put("CommonString", commonString);
		root.put("Common", common);
		root.put("CommonApplication", commonApplication);
		root.put("CommonForm", commonForm);
		root.put("CommonHtml", commonHtml);
		root.put("CommonDate", commonDate);
		// 枚举值
		if (null != request) {
			root.put("domain", Common.getDomain(request));
			Map enumMap = (Map) request.getSession().getServletContext()
					.getAttribute("enumMap");
			Map brandUsernMap = (Map) request.getSession().getServletContext()
					.getAttribute("brandUsernMap");
			List<Map> enumList = (List<Map>) request.getSession()
					.getServletContext().getAttribute("enumList");
			root.put("enumMap", enumMap);  
			root.put("enumList", enumList);
			Map channelMap = (Map) request.getSession().getServletContext()
					.getAttribute("channelMap");
			List<Map> channelList = (List<Map>) request.getSession()
					.getServletContext().getAttribute("channelList");
			root.put("channelMap", channelMap);
			root.put("channelList", channelList);
			root.put("brandUsernMap", brandUsernMap);
		}
		template.process(root, out);
	}

	/**
	 * 后台根据模板生成文件
	 * 
	 * @param name
	 *            模板名称
	 * @param root
	 *            数据
	 * @param outPath
	 *            输出路径
	 * @param request
	 *            Request对象
	 * @throws IOException
	 * @throws TemplateException
	 */
	@SuppressWarnings( { "unchecked" })
	public void generate(String name, Map root, String outPath,
			HttpServletRequest request) throws TemplateException, IOException {
		String dir = "";
		File f = null;
		if (outPath != null && !outPath.equals("")) {
			dir = outPath.substring(0, outPath.lastIndexOf("/"));
			f = new File(dir);
			if (!f.exists()) {
				f.mkdirs();
			}
		}
		out = new OutputStreamWriter(new FileOutputStream(new File(outPath)),
				"utf-8");
		this.preview(name, root, out, request);
		if (null != out) {
			out.close();
		}
		root = null;
	}

	/**
	 * 统一生成页面方法
	 * 
	 * @param sql
	 * @param tName
	 *            模板名称
	 * @param cName
	 *            生成页面名称
	 * @throws SQLException
	 */
	@SuppressWarnings( { "unchecked" })
	public void toHtml(String sql, String listName, String tName, String cName)
			throws SQLException {
		Template template = null;
		Map root = new HashMap<String, List<?>>();
		if (listName == null || listName.equals("")) {
			listName = "infoList";
		}
		try {

			root.put(listName, WEBDBHelper.getMapList(sql,"Web21sunDBHelper"));

			template = configuration.getTemplate(tName);

			String dir = "";
			if (cName != null && !cName.equals("")) {
				dir = cName.substring(0, cName.lastIndexOf("/"));
				File f = new File(dir);
				if (!f.exists()) {
					f.mkdirs();
				}
			}

			out = new OutputStreamWriter(new FileOutputStream(cName), "utf-8");
			template.process(root, out);
		} catch (Exception e) {
			Common.println(e);
		} finally {
			try {
				out.close();
			} catch (Exception e) {
			}
			out = null;
			template = null;
			tName = null;
			cName = null;
			root = null;
		}
	}

}
