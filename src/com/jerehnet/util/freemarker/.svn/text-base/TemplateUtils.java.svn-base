package com.jerehnet.util.freemarker;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 模板工具类
 * 
 * @author Administrator
 * 
 */
public class TemplateUtils {
	/**
	 * 建立模板树
	 * 
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void createTemplateTree(File file, List trees) {
		if (null == file || null == trees) {
			return;
		}
		Map model = null;
		File[] fs = file.listFiles();
		if(null!=fs&&fs.length>0){
			for (File f : fs) {
				if (f.getName().equals("tags")) {
					continue;
				}
				if (f.getName().startsWith(".")) {
					continue;
				}
				model = new HashMap();
				model.put("id", f.hashCode());
				model.put("pId", file.hashCode());
				model.put("parent", file.getName());
				model.put("self", f.getName());
				model.put("absolute", f.getAbsolutePath());
				if (f.isDirectory()) {
					model.put("isDirectory", true);
					createTemplateTree(f, trees);
				} else {
					model.put("isDirectory", false);
				}
				trees.add(model);
			}
		}
	}
}
