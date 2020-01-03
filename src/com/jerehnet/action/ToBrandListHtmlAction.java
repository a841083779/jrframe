package com.jerehnet.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.util.common.Common;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class ToBrandListHtmlAction {
	private static String websitePath = "";
	private Configuration cfg;
	ToBrandListHtmlAction obj = null;

	public Configuration getCfg() {
		return this.cfg;
	}

	public void init(HttpServletRequest request) {
		websitePath = request.getRealPath("/");
		this.cfg = new Configuration();
		try {
			this.cfg.setDirectoryForTemplateLoading(new File(websitePath));
			this.cfg.setDefaultEncoding("utf-8");
		} catch (Exception e) {
			Common.println(e);
		}
	}

	@SuppressWarnings( { "unchecked", "rawtypes" }) public void toHtmlAllCatalogNames(PoolManager pool, HttpServletRequest request) {
		String catalogNames[][] = DataManager.fetchFieldValue(pool, "pro_catalog", "id,name,num", "parentid=0"); // 获得所有的一级栏目

		List finalAllCatalogList = new ArrayList();
		List finalAllCatalogList02 = new ArrayList();
		obj = new ToBrandListHtmlAction();
		obj.init(request);
		Map catalogsMap = null; // 一级栏目
		Map catalogsMap02 = null; // 一级栏目
		Map catalogMapNameNum = null;
		// List catalogListNameNum = null ;
		Map subCatalogsMap = null;// 二级栏目
		Writer out = null;
		Map root = new HashMap(); // freemarker 数据源
		Template t = null; // 模板
		String createFilename = null; // 要创建的文件的
		String templateName = null; // 模板名字
		for (int i = 0; null != catalogNames && i < catalogNames.length; i++) {
			subCatalogsMap = new HashMap();
			catalogsMap = new HashMap();
			catalogsMap02 = new HashMap();
			catalogMapNameNum = new HashMap();

			catalogMapNameNum.put(catalogNames[i][2], catalogNames[i][1]); // num
			// name

			String subCatalogNames[][] = DataManager.fetchFieldValue(pool, "pro_catalog", "id,name,num", "parentid=" + catalogNames[i][0]);
			for (int j = 0; null != subCatalogNames && j < subCatalogNames.length; j++) // 获得每一个一级栏目下的所有二级栏目
			{
				subCatalogsMap.put(subCatalogNames[j][2], subCatalogNames[j][1]);
			}
			catalogsMap.put(catalogMapNameNum, subCatalogsMap);
			catalogsMap02.put(catalogNames[i][1], subCatalogsMap);
			finalAllCatalogList.add(catalogsMap);
			finalAllCatalogList02.add(catalogsMap02);
		}

		root.put("allCatalogNames", finalAllCatalogList); // 
		root.put("catalogsMap02", finalAllCatalogList02); // 
		// root.put("catalogMapNameNum", catalogMapNameNum) ;
		createFilename = websitePath + "/include/photo/catalog.jsp";
		templateName = "/template/products/catalog.jsp";

		try {
			obj = new ToBrandListHtmlAction();
			obj.init(request);
			t = obj.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			out = new OutputStreamWriter(new FileOutputStream(createFilename), "utf-8");
			t.process(root, out);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		} finally {
			closeOutAndT(out, t);
		}
		for (int k = 0; finalAllCatalogList != null && k < finalAllCatalogList.size(); k++) {
		}

	}

	public void addUpperIndexToCollection(String[][] upperIndex) {

	}

	public void closeOutAndT(Writer out, Template t) {
		if (null != out) {
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (null != t) {
			t = null;
		}
	}

}
