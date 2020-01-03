package com.jerehnet.util.freemarker;

import java.util.List;
import com.jerehnet.util.dbutil.DBHelper;
import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

/**
 * 模板页面写SQL语句工具类
 * @author Administrator
 *
 */
public class SQLUtils implements TemplateMethodModel {

	@SuppressWarnings("rawtypes")
	public Object exec(List args) throws TemplateModelException {
		try {
			DBHelper dbHelper = DBHelper.getInstance();
			if(null!=args&&args.size()==1){
				String sql = (String)args.get(0);
				return dbHelper.getMapList(sql);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
