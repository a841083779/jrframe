package com.jerehnet.util.common;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import com.jerehnet.util.dbutil.DBHelper;

/**
 * 
 * @describe application管理类
 * 
 */
@SuppressWarnings("serial")
public class CommonApplication extends HttpServlet {

	public void init() throws ServletException {
	    getChannelMap(getServletContext());
	    getEnumMap(getServletContext());
	    getBrandMap(getServletContext());
	    getCatalogMap(getServletContext());
	    getSEOTitleKeyword(getServletContext());
	    getPinyin(getServletContext());
	    getCity(getServletContext());
	    getArea(getServletContext());
	    getBrandsMap(getServletContext());
	    getBrandFromCatalog(getServletContext());
	    getCatalogFromBrand(getServletContext());
	    getCatalogFromBrandTwo(getServletContext());
	    getKeyParamList(getServletContext());
	    getCatalogParamList(getServletContext());
	    getSalePolicyList(getServletContext());
	    //getProMainParamMap(this.getServletContext());
	    getMachineBrandMap(getServletContext());
	    getMachineCatalogMap(getServletContext());
	}

	/* 对表操作时更新application */
	public static void updateApplication(HttpServletRequest request,
			String tableName) {
		// 枚举表
		if (tableName != null && tableName.equals(Env.getInstance().getProperty( "table_prefix") + "common_enum")) {
			CommonApplication.getEnumMap(request.getSession().getServletContext());
		}
		// 品牌表（厂家表）
		if (tableName != null&& tableName.equals(Env.getInstance().getProperty("table_prefix")+ "agent_factory")) {
			CommonApplication.getBrandMap(request.getSession().getServletContext());
		}
		// 产品类别表
		if (tableName != null&& tableName.equals(Env.getInstance().getProperty("table_prefix")+ "catalog")) {
			CommonApplication.getCatalogMap(request.getSession().getServletContext());
			CommonApplication.getSEOTitleKeyword(request.getSession().getServletContext()); // 即时更新 seotitle 关键词
		}
	}

	/**
	 * 
	 * @describe 枚举
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getEnumMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> enumMap = null;
		List enumList = null;
		String sql = " select * from "
				+ Env.getInstance().getProperty("table_prefix")
				+ "common_enum where is_show = 1 order by order_no desc,no asc ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			enumList = dbHelper.getMapList(sql, conn);
			enumMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < enumList.size(); i++) {
				info = (Map) enumList.get(i);
				enumMap.put((String) info.get("no"), (String) info.get("name"));
			}
			application.setAttribute("enumMap", enumMap);
			application.setAttribute("enumList", enumList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 栏目
	 * 
	 */
	@SuppressWarnings("unchecked")
	public static void getChannelMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		List channelList = null;
		HashMap<String, String> channelMap = null;
		String sql = " select * from "
				+ Env.getInstance().getProperty("table_prefix")
				+ "common_channel where is_show = 1 order by order_no desc , id asc ";
		Connection conn = null;
		String key = CommonString.getFormatPara(Env.getInstance().getProperty( "channel_key"));
		if ("".equals(key)) {
			key = "uuid";
		}
		try {
			conn = dbHelper.getConnection();
			channelList = dbHelper.getMapList(sql, conn);
			channelMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < channelList.size(); i++) {
				info = (Map) channelList.get(i);
				channelMap.put((String) info.get(key), (String) info .get("name"));
			}
			application.setAttribute("channelMap", channelMap);
			application.setAttribute("channelList", channelList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 品牌
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getBrandMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> brandMap = null;
		HashMap<String, String> brandMap2 = null;
		HashMap<String, String> brandUsernMap = null;
		List brandList = null;
		String sql = " select id,name,usern from "
				+ Env.getInstance().getProperty("table_prefix")
				+ "agent_factory where flag = 1 order by name asc ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			brandList = dbHelper.getMapList(sql, conn);
			brandMap = new HashMap<String, String>();
			brandMap2 = new HashMap<String, String>();
			brandUsernMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < brandList.size(); i++) {
				info = (Map) brandList.get(i);
				brandMap.put(info.get("id").toString(), info.get("name").toString());
				brandMap2.put(info.get("name").toString(), info.get("id").toString());
				brandUsernMap.put(info.get("id").toString(), info.get("usern").toString());
			}
			application.setAttribute("brandUsernMap", brandUsernMap);
			application.setAttribute("brandMap", brandMap);
			application.setAttribute("brandMap2", brandMap2);
			application.setAttribute("brandList", brandList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 产品类别
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getCatalogMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> catalogMap = null;
		HashMap<String, String> catalogMap2 = null;
		HashMap<String, String> catalogMap3	 = null;
		List catalogList = null;
		List topCatalogList = null;
		String sql = " select num,name,id,parentid from " + Env.getInstance().getProperty("table_prefix") + "catalog where is_show = 1 order by order_no,id ";
		String sqlTop="select num,name from pro_catalog where is_show=1 and  parentid=0  order by order_no asc ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			catalogList = dbHelper.getMapList(sql, conn);
			topCatalogList= dbHelper.getMapList(sqlTop);
			catalogMap = new HashMap<String, String>();
			catalogMap2 = new HashMap<String, String>();
			catalogMap3 = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < catalogList.size(); i++) {
				info = (Map) catalogList.get(i);
				catalogMap.put(info.get("num").toString(), info.get("name").toString());
				catalogMap2.put(info.get("name").toString(), info.get("num").toString());
				catalogMap3.put(info.get("num").toString(), info.get("id").toString());
			}
			application.setAttribute("catalogMap", catalogMap);
			application.setAttribute("catalogMap2", catalogMap2);
			application.setAttribute("catalogMap3", catalogMap3);
			application.setAttribute("catalogList", catalogList);
			application.setAttribute("topCatalogList", topCatalogList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 省市
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getCity(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> cityMap = null;
		HashMap<String, String> cityMap2 = null;
		List cityList = null;
		String sql = " select num,name from pro_agent_province_city   order by num asc ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			cityList = dbHelper.getMapList(sql, conn);
			cityMap = new HashMap<String, String>();
			cityMap2 = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < cityList.size(); i++) {
				info = (Map) cityList.get(i);
				cityMap.put(info.get("num").toString(), info.get("name").toString());
				cityMap2.put(info.get("name").toString(), info.get("num").toString());
			}
			application.setAttribute("cityMap", cityMap);
			application.setAttribute("cityMap2", cityMap2);
			application.setAttribute("cityList", cityList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 产品类别 SEO关键词
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getSEOTitleKeyword(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> seoTitleKeywordMap = null;
		List seoTitleKeywordList = null;
		String sql = " select num,title_keyword from "
				+ Env.getInstance().getProperty("table_prefix")
				+ "catalog where is_show = 1 order by order_no,id ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			seoTitleKeywordList = dbHelper.getMapList(sql, conn);
			seoTitleKeywordMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < seoTitleKeywordList.size(); i++) {
				info = (Map) seoTitleKeywordList.get(i);
				seoTitleKeywordMap.put(info.get("num").toString(), CommonString.getFormatPara(info.get("title_keyword")));
			}
			application.setAttribute("seoTitleKeywordMap", seoTitleKeywordMap);
			application.setAttribute("seoTitleKeywordMapNew", seoTitleKeywordMap);
			application.setAttribute("seoTitleKeywordList", seoTitleKeywordList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 根据父节点获取孩子树形
	 * 
	 * @param parNo
	 * @param list
	 */
	public static List<Map> getTreeByPno(String parNo, List<Map> list) {
		List<Map> rList = new ArrayList<Map>(0);
		String key = "";
		for (Map m : list) {
			key = (String) m.get("no");
			if (key.startsWith(parNo) && !key.equals(parNo)) {
				rList.add(m);
			}
		}
		return rList;
	}

	/**
	 * 根据父编号获取子编号集合
	 * 
	 * @param parNo
	 *            父编号
	 * @param application
	 *            应用程序对象
	 * @return
	 */
	public static Map getEnumChildren(String parNo, ServletContext application) {
		List<Map> enumList = (List) application.getAttribute("enumList");
		Map map = new HashMap();
		String parentNo = "";
		for (Map m : enumList) {
			parentNo = (String) m.get("parent_no");
			if (parentNo.equals(parNo)) {
				map.put((String) m.get("no"), (String) m.get("name"));
			}
		}
		return map;
	}

	/**
	 * 根据父编号获取子编号集合
	 * 
	 * @param parNo
	 *            父编号
	 * @param application
	 *            应用程序对象
	 * @return
	 */
	public static Map getEnumChildren(String parNo, List<Map> enumList) {
		Map map = new HashMap();
		String parentNo = "";
		for (Map m : enumList) {
			parentNo = (String) m.get("parent_no");
			if (parentNo.equals(parNo)) {
				map.put((String) m.get("no"), (String) m.get("name"));
			}
		}
		return map;
	}

	/**
	 * 根据父编号获取子编号集合
	 * 
	 * @param parNo
	 *            父编号
	 * @param application
	 *            应用程序对象
	 * @return
	 */
	public static List<Map> getEnumChildrenList(String parNo, List<Map> enumList) {
		List<Map> rsList = new ArrayList<Map>(0);
		String parentNo = "";
		for (Map m : enumList) {
			parentNo = (String) m.get("parent_no");
			if (parentNo.equals(parNo)) {
				rsList.add(m);
			}
		}
		return rsList;
	}

	/**
	 * 根据父编号获取子编号集合
	 * 
	 * @param parNo
	 *            父编号
	 * @param application
	 *            应用程序对象
	 * @return
	 */
	public static List<Map> getChildrenList(String parNo, List<Map> list) {
		List<Map> rsList = new ArrayList<Map>(0);
		String parentNo = "";
		for (Map m : list) {
			parentNo = (String) m.get("parent_no");
			if (parentNo.equals(parNo)) {
				rsList.add(m);
			}
		}
		return rsList;
	}

	/**
	 * 根据父节点递归获取孩子树形
	 * 
	 * @param parNo：父节点值
	 * @param list：List集合
	 * @param parentField：父节点字段名
	 * @param field：子节点字段名
	 * @return
	 */
	public static List<Map> getTreeByPno(String parNo, List<Map> list,String parentField, String field) {
		List<Map> rList = new ArrayList<Map>(0);
		String parentValue = "";
		String value = "";
		if (list != null && list.size() > 0) {
			for (Map m : list) {
				parentValue = m.get(parentField).toString();
				value = m.get(field).toString();
				if (parentValue.equals(parNo)) {
					rList.add(m);
					List<Map> childList = getTreeByPno(value, list,parentField, field);
					rList.addAll(childList);
				}
			}
		}
		return rList;
	}

	/**
	 * 根据父编号获取子编号集合
	 * 
	 * @param parNo
	 *            父编号
	 * @param application
	 *            应用程序对象
	 * @return
	 */
	public static String getValue(Map appMap, int key) {
		return (String) appMap.get(key);
	}

	/**
	 * 根据父编号获取子编号集合
	 * 
	 * @param parNo
	 *            父编号
	 * @param application
	 *            应用程序对象
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map getEnumChildrenLink(String parNo,ServletContext application) {
		List<Map> enumList = (List) application.getAttribute("enumList");
		LinkedHashMap map = new LinkedHashMap();
		String parentNo = "";
		for (Map m : enumList) {
			parentNo = (String) m.get("parent_no");
			if (parentNo.equals(parNo)) {
				map.put((String) m.get("no"), (String) m.get("name"));
			}
		}
		return map;
	}

	/**
	 * 
	 * @describe 汉字拼音对应
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getPinyin(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		// 通过拼音查找汉字
		HashMap<String, String> hzpyMap = null;
		// 通过汉字查找拼音
		HashMap<String, String> pyhzMap = null;
		List hzpyList = null;
		String sql = " select pinyin,hanzi from " + " hz_py  order by id desc ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			hzpyList = dbHelper.getMapList(sql, conn);
			hzpyMap = new HashMap<String, String>();
			pyhzMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < hzpyList.size(); i++) {
				info = (Map) hzpyList.get(i);
				// 通过拼音查找汉字
				hzpyMap.put(info.get("pinyin").toString(), info.get("hanzi").toString());
				// 通过汉字查找拼音
				pyhzMap.put(info.get("hanzi").toString(), info.get("pinyin").toString());
			}
			application.setAttribute("hzpyMap", hzpyMap);
			application.setAttribute("pyhzMap", pyhzMap);
			application.setAttribute("hzpyList", hzpyList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 区域（维修）
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getArea(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> areaMap = null;
		HashMap<String, String> areaMap2 = null;
		List areaList = null;
		String sql = " select area_id,area_name from comm_area where level_id=2 and area_id<>105500 and area_id<>105690 and area_id<>105300 and area_id<>105880 order by node_full_name";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			areaList = dbHelper.getMapList(sql, conn);
			areaMap = new HashMap<String, String>();
			areaMap2 = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < areaList.size(); i++) {
				info = (Map) areaList.get(i);
				String area_name = info.get("area_name").toString();
				if (area_name.endsWith("州")) {
					area_name = area_name.substring(0, area_name.length() - 1);
				}
				area_name = area_name.replace("市", "").replace("地区", "").replace("林区", "").replace("区", "");
				if (area_name.length() < 5) {
					areaMap.put(info.get("area_id").toString(), area_name);
					areaMap2.put(area_name, info.get("area_id").toString());
				}

			}
			areaMap.put("105500", "北京");
			areaMap.put("105690", "天津");
			areaMap.put("105300", "上海");
			areaMap.put("105880", "重庆");
			application.setAttribute("areaMap", areaMap);
			areaMap2.put("北京", "105500");
			areaMap2.put("天津", "105690");
			areaMap2.put("上海", "105300");
			areaMap2.put("重庆", "105880");
			application.setAttribute("areaMap2", areaMap2);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 旧的类别编号和新的类别编号对应
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getCatalogNew(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		// 旧的类别到新的类别
		HashMap<String, String> catalogNewMap = null;
		// 旧的类别到新的类别
		HashMap<String, String> catalogNewMap2 = null;
		List catalogListNew = null;
		String sql = " select num,catalog_num  from "
				+ " pro_catalog   order by id desc ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			catalogListNew = dbHelper.getMapList(sql, conn);
			catalogNewMap = new HashMap<String, String>();
			catalogNewMap2 = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < catalogListNew.size(); i++) {
				info = (Map) catalogListNew.get(i);
				//旧的类别到新的类别
				catalogNewMap.put(info.get("num").toString(), info.get("catalog_num").toString());
				//旧的类别到新的类别
				catalogNewMap2.put(info.get("catalog_num").toString(), info.get("num").toString());
			}
			application.setAttribute("catalogNewMap", catalogNewMap);
			application.setAttribute("catalogNewMap2", catalogNewMap2);
			application.setAttribute("catalogListNew", catalogListNew);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 国内外品牌
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getBrandsMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> brandInnerMap = null;
		HashMap<String, String> brandOutMap = null;
		List brandInnerList = null;
		List brandOutList = null;
		List catalogList = null;
		String brandInner = "";
		String brandOut = "";
		String sqlCatalog = "select catalog_num,id from pro_catalog ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			catalogList = dbHelper.getMapList(sqlCatalog, conn);
			brandInnerMap = new HashMap<String, String>();
			brandOutMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < catalogList.size(); i++) {
				Map innerMap = null;
				Map outMap = null;
				brandInner = "";
				brandOut = "";
				info = (Map) catalogList.get(i);
				String catalog_num = CommonString.getFormatPara(info.get("catalog_num"));
				if (catalog_num != null && !catalog_num.equals("")) {
					brandInnerList = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where is_show=1  and flag=1 and  id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+ catalog_num+ "%') and is_inner=1 order by view_count desc",conn);
					brandOutList = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where  is_show=1  and flag=1 and  id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+ catalog_num+ "%') and is_inner=0 order by view_count desc",conn);
					if (brandInnerList != null && brandInnerList.size() > 0) {
						for (int a = 0; a < brandInnerList.size(); a++) {
							innerMap = (Map) brandInnerList.get(a);
							if (a == brandInnerList.size() - 1) {
								brandInner += innerMap.get("id").toString();
							} else {
								brandInner += innerMap.get("id").toString()+ ",";
							}
						}
					}
					if (brandOutList != null && brandOutList.size() > 0) {
						for (int b = 0; b < brandOutList.size(); b++) {
							outMap = (Map) brandOutList.get(b);
							if (b == brandOutList.size() - 1) {
								brandOut += outMap.get("id").toString();
							} else {
								brandOut += outMap.get("id").toString() + ",";
							}
						}
					}
					brandOutMap.put(catalog_num, brandOut);
					brandInnerMap.put(catalog_num, brandInner);
				}
			}
			application.setAttribute("brandInnerMap", brandInnerMap);
			application.setAttribute("brandOutMap", brandOutMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 类别对应品牌
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getBrandFromCatalog(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> brandInnerMap = null;
		HashMap<String, String> brandOutMap = null;
		List brandInnerList = null;
		List catalogList = null;
		String brandInner = "";
		String sqlCatalog = "select id,catalog_num from pro_catalog ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			catalogList = dbHelper.getMapList(sqlCatalog, conn);
			brandInnerMap = new HashMap<String, String>();
			brandOutMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < catalogList.size(); i++) {
				Map innerMap = null;
				Map outMap = null;
				brandInner = "";
				info = (Map) catalogList.get(i);
				String catalog_num = CommonString.getFormatPara(info.get("catalog_num"));
				if (catalog_num != null && !catalog_num.equals("")) {
					brandInnerList = dbHelper.getMapList("select name,id  from pro_agent_factory where  is_show=1  and flag=1 and  id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+ catalog_num+ "%')  order by view_count desc",conn);
					if (brandInnerList != null && brandInnerList.size() > 0) {
						for (int a = 0; a < brandInnerList.size(); a++) {
							innerMap = (Map) brandInnerList.get(a);
							if (a == brandInnerList.size() - 1) {
								brandInner += innerMap.get("id").toString();
							} else {
								brandInner += innerMap.get("id").toString()+ ",";
							}
						}
					}

					brandInnerMap.put(catalog_num, brandInner);
				}
			}
			application.setAttribute("BrandCatalogMap", brandInnerMap);

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 品牌对应类别
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getCatalogFromBrand(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> CatalogFromBrandMap = null;
		List brandList = null;
		List catalogList = null;
		String brandInner = "";
		String sqlBrand = "select name,id from pro_agent_factory where is_show=1 and flag=1  ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			brandList = dbHelper.getMapList(sqlBrand, conn);
			CatalogFromBrandMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < brandList.size(); i++) {
				Map innerMap = null;
				Map outMap = null;
				brandInner = "";
				info = (Map) brandList.get(i);
				String factoryid = CommonString.getFormatPara(info.get("id"));
				if (factoryid != null && !factoryid.equals("")) {
					catalogList = dbHelper.getMapList(" select catalognum from  pro_products  where is_show=1 and factoryid= "+ factoryid+ "  group by catalognum", conn);
					if (catalogList != null && catalogList.size() > 0) {
						for (int a = 0; a < catalogList.size(); a++) {
							innerMap = (Map) catalogList.get(a);
							if (a == catalogList.size() - 1) {
								brandInner += innerMap.get("catalognum").toString();
							} else {
								brandInner += innerMap.get("catalognum").toString()+ ",";
							}
						}
					}
					CatalogFromBrandMap.put(factoryid, brandInner);
				}
			}
			application
					.setAttribute("CatalogFromBrandMap", CatalogFromBrandMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 类别对应二级品牌
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getCatalogFromBrandTwo(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> CatalogFromBrandMap = null;
		List brandList = null;
		List catalogList = null;
		String brandInner = "";
		String sqlBrand = "select name,id from pro_agent_factory where is_show=1 and flag=1  ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			brandList = dbHelper.getMapList(sqlBrand, conn);
			CatalogFromBrandMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < brandList.size(); i++) {
				Map innerMap = null;
				Map outMap = null;
				brandInner = "";
				info = (Map) brandList.get(i);
				String factoryid = CommonString.getFormatPara(info.get("id"));
				if (factoryid != null && !factoryid.equals("")) {
					catalogList = dbHelper.getMapList(" select substring(catalognum,0,7) as catalognum from  pro_products  where is_show=1 and factoryid= "+ factoryid+ "  group by substring(catalognum,0,7)",conn);
					if (catalogList != null && catalogList.size() > 0) {
						for (int a = 0; a < catalogList.size(); a++) {
							innerMap = (Map) catalogList.get(a);
							if (a == catalogList.size() - 1) {
								brandInner += innerMap.get("catalognum").toString();
							} else {
								brandInner += innerMap.get("catalognum").toString()+ ",";
							}
						}
					}
					CatalogFromBrandMap.put(factoryid, brandInner);
				}
			}
			application.setAttribute("CatalogFromBrandTwoMap",CatalogFromBrandMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	
	
	/**
	 * 
	 * @describe 获取关键的参数项
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getKeyParamList(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		List keyParamList = null;
		String sql = " select id,name  from pro_catalog_param where is_key=1  ";
		Connection conn = null;
		HashMap<String, List<Map>> keyParamMap = null;
		try {
			keyParamMap = new HashMap<String, List<Map>>();
			conn = dbHelper.getConnection();
			keyParamList = dbHelper.getMapList(sql, conn);
			keyParamMap.put("keyParam",keyParamList);
			application.setAttribute("keyParamMap", keyParamMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	
	/**
	 * 
	 * @describe 获取各类别参数项
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getCatalogParamList(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		List keyParamList = null;
		String sql = " select parent_no  from pro_catalog_param  group by parent_no   ";
		Connection conn = null;
		HashMap<String, List<Map>> paramListMap = null;
		try {
			conn = dbHelper.getConnection();
			keyParamList = dbHelper.getMapList(sql, conn);
			paramListMap = new HashMap<String, List<Map>>();
			Map info = null;
			for (int i = 0; i < keyParamList.size(); i++) {
				info = (Map) keyParamList.get(i);
				//System.out.println("select id,name,parent_no,category_id  from pro_catalog_param  where parent_no="+info.get("parent_no").toString());
				List <Map>   thelist = dbHelper.getMapList("select id,name,parent_no,category_id  from pro_catalog_param  where parent_no="+info.get("parent_no").toString(), conn);
				paramListMap.put(info.get("parent_no").toString(), thelist);
			}
			application.setAttribute("paramListMap", paramListMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	
	/**
	 * 
	 * @describe 获取优惠政策
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getSalePolicyList(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		List salePolicyList = null;
		String sql = " select q1,q2,q3,factoryid,catalognum from pro_sale_policy ";
		Connection conn = null;
		HashMap<String, Map> salePolicyListMap = null;
		try {
			conn = dbHelper.getConnection();
			salePolicyList = dbHelper.getMapList(sql, conn);
			Map info = null;
			salePolicyListMap = new HashMap<String, Map>();
			for (int i = 0; i < salePolicyList.size(); i++) {
				info = (Map) salePolicyList.get(i);
				salePolicyListMap.put(info.get("factoryid").toString()+"-"+info.get("catalognum").toString(), info);
			}
			application.setAttribute("salePolicyListMap", salePolicyListMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	
	
	/**
	 * 
	 * @describe 获取代理商代理品牌
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getAgentBrand(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		List salePolicyList = null;
		String sql = " select q1,q2,q3,factoryid,catalognum from pro_sale_policy ";
		Connection conn = null;
		HashMap<String, Map> salePolicyListMap = null;
		try {
			conn = dbHelper.getConnection();
			salePolicyList = dbHelper.getMapList(sql, conn);
			Map info = null;
			salePolicyListMap = new HashMap<String, Map>();
			for (int i = 0; i < salePolicyList.size(); i++) {
				info = (Map) salePolicyList.get(i);
				salePolicyListMap.put(info.get("factoryid").toString()+"-"+info.get("catalognum").toString(), info);
			}
			application.setAttribute("salePolicyListMap", salePolicyListMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	
	

	/**
	 * 
	 * @describe 产品参数
	 * 
	 */
	@SuppressWarnings({ "unchecked", "static-access" })
	public static void getProMainParamMap(ServletContext application) {

		DBHelper dbHelper = DBHelper.getInstance();
		List proList = null;
		//String sqlCatalog = "select id,pro_id,param_id,param_value,param_name  from pro_main_param ";
		String sql="select id from  pro_products where is_show=1 order by id desc";
		Connection conn = null;
		HashMap<String, List<Map>> proParamMap = null;
		try {
			conn = dbHelper.getConnection();
			proList = dbHelper.getMapList(sql, conn);
			Map info = null;
			proParamMap = new HashMap<String, List<Map>>();
			for (int i = 0; i < proList.size(); i++) {
				info = (Map) proList.get(i);
				List <Map>   paramList = dbHelper.getMapList("select id,pro_id,param_id,param_value,param_name  from pro_main_param   where pro_id="+info.get("id").toString(), conn);
                if(paramList==null){
                	paramList=new ArrayList<Map>();
                }
				proParamMap.put(info.get("id").toString(), paramList);
			}
			application.setAttribute("proParamMap", proParamMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	
	
	/**
	 * 
	 * @describe 品牌
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getMachineBrandMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> brandMap = null;
		List brandList = null;
		String sql = " select id,name from "
				+ Env.getInstance().getProperty("table_prefix")
				+ "machine_brand   ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			brandList = dbHelper.getMapList(sql, conn);
			brandMap = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < brandList.size(); i++) {
				info = (Map) brandList.get(i);
				brandMap.put(info.get("id").toString(), info.get("name").toString());
			}
			application.setAttribute("machineBrandMap", brandMap);
			application.setAttribute("machineBrandList", brandList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}

	/**
	 * 
	 * @describe 产品类别
	 * 
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public static void getMachineCatalogMap(ServletContext application) {
		DBHelper dbHelper = DBHelper.getInstance();
		HashMap<String, String> catalogMap = null;
		HashMap<String, String> catalogMap2 = null;
		List catalogList = null;
		String sql = " select num,name,id,parentid from "
				+ Env.getInstance().getProperty("table_prefix")
				+ "machine_catalog  ";
		Connection conn = null;
		try {
			conn = dbHelper.getConnection();
			catalogList = dbHelper.getMapList(sql, conn);
			catalogMap = new HashMap<String, String>();
			catalogMap2 = new HashMap<String, String>();
			Map info = null;
			for (int i = 0; i < catalogList.size(); i++) {
				info = (Map) catalogList.get(i);
				catalogMap.put(info.get("num").toString(), info.get("name").toString());
				catalogMap2.put(info.get("name").toString(), info.get("num").toString());
			}
			application.setAttribute("machineCatalogMap", catalogMap);
			application.setAttribute("machineCatalogList", catalogList);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			dbHelper.freeConnection(conn);
		}
	}
	

}
