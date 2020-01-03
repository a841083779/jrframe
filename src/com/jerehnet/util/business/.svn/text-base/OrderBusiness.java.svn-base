package com.jerehnet.util.business;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;

/**
 * 订单业务类
 * 1.处理 付费会员的产品订单推送问题
 * @author Administrator
 *
 */
public class OrderBusiness {
	/**
	 * 
	 * @param agentArea 代理地区  
	 * @param catalognum 类别
	 * @return
	 */
	private static DBHelper dbHelper = DBHelper.getInstance() ;
	public static List<Map> getRecommendProducts(String agentArea,String catalognum){
		List<Map> recommendProductsList = null ;
		String agentFactoryid = "" ;  // 选出的一个代理商 id
		Map agentFactoryMap = null ;
		// 随机选出一个符合条件的代理商
		String agent_factory_sql = " select top 1 id from pro_agent_factory where flag=2 and is_recommend_order=1 and city like '%"+agentArea+"%' order by newid()" ;
		// 选出的产品
		String recommend_products_sql = "  select top 2 pp.id productid,pp.name,pp.factoryname,pp.catalogname,pp.file_name,pp.factoryid,pp.img2 from pro_agent_products pap inner join pro_products pp on pap.product_id=pp.id where agent_id=? and catalognum like '"+catalognum+"%' order by newid()" ;
		if(!"".equals(agentArea)){ 
			try {
				agentFactoryMap = dbHelper.getMap(agent_factory_sql) ;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(null!=agentFactoryMap && agentFactoryMap.size()>0){
			agentFactoryid = CommonString.getFormatPara(agentFactoryMap.get("id")) ;
		}
		if(!"".equals(agentFactoryid) && !"".equals(catalognum)){
			try {
				recommendProductsList = dbHelper.getMapList(recommend_products_sql,new Object[]{agentFactoryid}) ;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return recommendProductsList ;
	}

}
