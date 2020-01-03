package com.jerehnet.util.freemarker;

import java.util.List;
import com.jerehnet.util.dbutil.DBHelper;
import com.jerehnet.webservice.WEBDBHelper;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

/**
 * 模板页面写SQL语句工具类
 * @author Administrator
 *
 */
public class SQLUtilsWebService implements TemplateMethodModel {

	@SuppressWarnings("rawtypes")
	public Object exec(List args) throws TemplateModelException {
		try {
			if(null!=args&&args.size()==1){
				String sql = (String)args.get(0);
				return WEBDBHelper.getMapList(sql,"Web21sunDBHelper");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
