package com.jerehnet.util.getproducts;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.action.DataManager;
import com.jerehnet.action.PoolManager;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.file.FileUtils;
import com.sun.org.apache.xpath.internal.operations.And;


public class ProductsDataImportAction {

	private ArrayList<String> _downLoadedImgList = new ArrayList<String>(); // 用于存放已下载过的图片，避免重复下载
	private int _total_counter = 0; // 总更新数量的计数器，包括增加和修改
	private int _total_new_counter = 0; // 新增的数量
	private int _total_update_counter = 0; // 更新的数量

	// 计数器，用于记录某个厂家更新的数量
	private int _factory_counter = 0;
	private int _factory_new_counter = 0;
	private int _factory_update_counter = 0;

	public void getFactoryProductData(HttpServletRequest request, String current_scan_date, String is_develop, String factoryid) {
		String cmdTxt = "select * from vi_ipt_product_factory where flag=1";
		if (!factoryid.equals("0")) {
			cmdTxt += " and id=" + factoryid;
		}
		if (!is_develop.isEmpty()) {
			cmdTxt += " and is_develop='" + is_develop + "'";
		}
		cmdTxt += " and (last_scan_date <'" + current_scan_date + "' or last_scan_date is null)";

		System.out.println("sql=" + cmdTxt);
		System.out.println("抓取开始" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

		PoolManager pool = new PoolManager();
		Connection conn = pool.getConnection();
		ResultSet rs = null;
		try {
			rs = DataManager.executeQuery(conn, cmdTxt);
			while (rs != null && rs.next()) {
				// 计数器，用于记录某个厂家更新的数量
				_factory_counter = 0;
				_factory_new_counter = 0;
				_factory_update_counter = 0;
				_downLoadedImgList.clear();

				if (rs.getString("is_develop").toLowerCase().equals("yes")) {
					isDevelop(pool, conn, rs, current_scan_date, request);
				} else if (rs.getString("is_develop").toLowerCase().equals("no")) {
					notDevelop(pool, conn, rs, current_scan_date, request);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			System.out.println("共更新了" + _total_counter + "个产品，其中新增了个" + _total_new_counter + "产品，更新了" + _total_update_counter + "个产品");
		}
		System.out.println("抓取结束" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
	}

	/**
	 * 获取网站是杰瑞网络开发的厂家的产品数据
	 * 
	 * @param pool 产品中心库的pool
	 * @param conn 产品中心库的conn
	 * @param factoryCfgRs 厂家配置的rs，需要取数据库连接字串的部分
	 * @param current_scan_date
	 * @param request
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public void isDevelop(PoolManager pool, Connection conn, ResultSet factoryCfgRs, String current_scan_date, HttpServletRequest request) throws SQLException, ClassNotFoundException {
		Connection factoryConnection = null;
		String dbtype = CommonString.getFormatPara(factoryCfgRs.getString("databasetype"));
		String dbip = CommonString.getFormatPara(factoryCfgRs.getString("db_ip"));
		String dbport = factoryCfgRs.getString("db_port") == null ? "1433" : factoryCfgRs.getString("db_port");
		String dbname = factoryCfgRs.getString("db_name");
		String username = factoryCfgRs.getString("username");
		String password = factoryCfgRs.getString("password");

		try {
			if (dbtype.equalsIgnoreCase("sql")) {
				Class.forName("net.sourceforge.jtds.jdbc.Driver");
				factoryConnection = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbip + ":" + dbport + ";DatabaseName=" + dbname + ";useLOBs=false", username, password);
			} else if (dbtype.equalsIgnoreCase("mysql")) {
				Class.forName("com.mysql.jdbc.Driver");
				factoryConnection = DriverManager.getConnection("jdbc:mysql://" + dbip + ":" + dbport + "/" + dbname + "?characterEncoding=utf-8", username, password);
			}

			String select_sql = factoryCfgRs.getString("select_sql");
			String last_scan_date = factoryCfgRs.getString("last_scan_date") == null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(factoryCfgRs.getDate("last_scan_date"));
			if (current_scan_date.equals("")) {
				current_scan_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			}
			
			/*
			 * 原有的按最后更新字段取
			 */
			select_sql += " and last_update_date<'" + current_scan_date + "'"; 
			if (!last_scan_date.equals("")) { 
				select_sql += " and last_update_date>'" + last_scan_date + "'"; 
			}

			/* 客户数据库未添加last_update_date字段前在查询语句
			 * select_sql += " and add_date<'" + current_scan_date + "'";
			if (!last_scan_date.equals("")) {
				select_sql += " and add_date>'" + last_scan_date + "'";
			}*/
			ResultSet frs = DataManager.executeQuery(factoryConnection, select_sql);
			while (frs != null && frs.next()) {
				TempProductInfo info = new TempProductInfo();
				info.setFactoryid(factoryCfgRs.getInt("id"));
				info.setFactoryname(factoryCfgRs.getString("factoryname"));
				info.setCrawl_date(new Date());

				info.setFrom_productid(frs.getInt("from_productid"));
				info.setCatalogname(frs.getString("catalog_name"));
				if (info.getCatalogname() == null) {
					info.setCatalogname("");
				}
				info.setName(frs.getString("name"));
				info.setModel_number(frs.getString("model_number"));
				info.setParas(frs.getString("paras"));
				String imgs = frs.getString("img");
				info.setIntroduce(frs.getString("introduce"));

				// 判断是否是中文，如果是再抓取
				if (isUseful(info)) {
					// 处理图片
					String factoryDomainName = factoryCfgRs.getString("domain_name");
					String imgSavePath = factoryCfgRs.getString("img_save_path");
					String[] imgAry = handlerImg(factoryDomainName, "", imgSavePath, imgs, request);
					info.setImg(imgAry[0]);
					info.setImg2(imgAry[1]);

					// saveToDb(pool, conn, info, factoryRs.getDate("addtime"),factoryRs.getString("lastupdatetime"));
					saveToDb(pool, conn, info, frs.getDate("addtime"), "");
				}
			}

			// 解析完成后加入最后更新时间
			DataManager.dataOperation(conn, "update ipt_product_factory set last_scan_date='" + current_scan_date + "' where id=" + factoryCfgRs.getInt("id"));
			System.out.println(factoryCfgRs.getString("factoryname") + "更新" + _factory_counter + "个产品，其中新增" + _factory_new_counter + "个，更新" + _factory_update_counter + "个");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (factoryConnection != null) {
				factoryConnection.close();
			}
		}
	}

	/**
	 * 获取网站不是杰瑞网络开发的厂家的产品数据
	 * 
	 * @param pool 产品中心库的pool
	 * @param conn 产品中心库的conn
	 * @param factoryCfgRs 厂家配置的rs，需要取正则表达式的部分
	 * @param current_scan_date
	 * @param request
	 * @throws SQLException
	 */
	public void notDevelop(PoolManager pool, Connection conn, ResultSet factoryCfgRs, String current_scan_date, HttpServletRequest request) throws SQLException {
		String website_encode = factoryCfgRs.getString("website_encode");
		String website_domain = factoryCfgRs.getString("domain_name");
		String product_path = CommonString.getFormatPara(factoryCfgRs.getString("product_path"));
		String image_path = CommonString.getFormatPara(factoryCfgRs.getString("image_path"));
		int product_catalog_depth = factoryCfgRs.getInt("product_catalog_depth");
		String product_catalog_url = factoryCfgRs.getString("product_catalog_url");
		String product_catalog_regex = factoryCfgRs.getString("product_catalog_regex");
		String product_catalog_small_regex = factoryCfgRs.getString("product_catalog_small_regex");
		String product_list_url = factoryCfgRs.getString("product_list_url");
		String product_list_regex = factoryCfgRs.getString("product_list_regex");
		String pager_url_regex = CommonString.getFormatPara(factoryCfgRs.getString("pager_url_regex"));
		String pager_url = CommonString.getFormatPara(factoryCfgRs.getString("pager_url"));
		String pager_count_regex = CommonString.getFormatPara(factoryCfgRs.getString("pager_count_regex"));
		String name_regex = factoryCfgRs.getString("name_regex");
		String model_regex = factoryCfgRs.getString("model_regex");
		String paras_regex = factoryCfgRs.getString("paras_regex");
		String img_regex = factoryCfgRs.getString("img_regex");
		String introduce_regex = factoryCfgRs.getString("introduce_regex");

		String factoryName = factoryCfgRs.getString("factoryname");
		String imgSavePath = factoryCfgRs.getString("img_save_path");

		System.out.println(factoryName + "解析开始……");
		ArrayList<TempProductInfo> list = new ArrayList<TempProductInfo>();
		switch (CatalogDepthEnum.values()[product_catalog_depth]) {
		case none: // 没有分类级别，直接读取列表页面
			ArrayList<String> productUrlList = getProductUrlList(website_domain, product_path, product_list_url, website_encode, product_list_regex, pager_url_regex, pager_url, pager_count_regex);
			if (productUrlList.size() > 0) {
				for (String productUrl : productUrlList) {
					TempProductInfo tempInfo = getProductInfo(website_domain, image_path, imgSavePath, productUrl, website_encode, name_regex, model_regex, paras_regex, img_regex, introduce_regex,
							product_catalog_regex, null, request);
					if (tempInfo != null) {
						list.add(tempInfo);
					}
				}
			}
			break;
		case one: // 只有一级分类
			Hashtable<String, String> catalogTable = getCatalogUrlList(website_domain, product_path, product_catalog_url, website_encode, product_catalog_regex);
			if (catalogTable.size() > 0) {
				Iterator iter = catalogTable.entrySet().iterator();
				while (iter.hasNext()) {
					Map.Entry<String, String> entry = (Map.Entry<String, String>) iter.next();
					String productListUrl = entry.getKey().replaceAll("&amp;", "&");
					String catalogName = entry.getValue();

					ArrayList<String> proUrlList = getProductUrlList(website_domain, product_path, productListUrl, website_encode, product_list_regex, pager_url_regex, pager_url, pager_count_regex);
					if (proUrlList.size() > 0) {
						for (String productUrl : proUrlList) {
							TempProductInfo tempInfo = getProductInfo(website_domain, image_path, imgSavePath, productUrl, website_encode, name_regex, model_regex, paras_regex, img_regex,
									introduce_regex, "", catalogName, request);
							if (tempInfo != null) {
								list.add(tempInfo);
							}
						}
					}
				}
			}
			break;
		case two:
			Hashtable<String, String> topCatalogTable = getCatalogUrlList(website_domain, product_path, product_catalog_url, website_encode, product_catalog_regex);
			if (topCatalogTable.size() > 0) {
				Iterator topIter = topCatalogTable.entrySet().iterator();
				while (topIter.hasNext()) {
					Map.Entry<String, String> topEntry = (Map.Entry<String, String>) topIter.next();
					String subCatalogUrl = topEntry.getKey();
					String topCatalogName = topEntry.getValue();

					Hashtable<String, String> subCatalogTable = getCatalogUrlList(website_domain, product_path, subCatalogUrl, website_encode, product_catalog_small_regex);
					if (subCatalogTable.size() > 0) {
						Iterator subIter = subCatalogTable.entrySet().iterator();
						while (subIter.hasNext()) {
							Map.Entry<String, String> subEntry = (Map.Entry<String, String>) subIter.next();
							String productListUrl = subEntry.getKey();
							String subCatalogName = subEntry.getValue();

							ArrayList<String> proUrlList = getProductUrlList(website_domain, product_path, productListUrl, website_encode, product_list_regex, pager_url_regex, pager_url,
									pager_count_regex);
							if (proUrlList.size() > 0) {
								for (String productUrl : proUrlList) {
									TempProductInfo tempInfo = getProductInfo(website_domain, image_path, imgSavePath, productUrl, website_encode, name_regex, model_regex, paras_regex, img_regex,
											introduce_regex, "", subCatalogName.trim().isEmpty() ? topCatalogName.trim() : subCatalogName.trim(), request);
									if (tempInfo != null) {
										list.add(tempInfo);
									}
								}
							}
						}
					}
				}
			}
			break;
		}

		if (list.size() > 0) {
			for (TempProductInfo info : list) {
				info.setFactoryid(factoryCfgRs.getInt("id"));
				info.setFactoryname(factoryName);
				info.setCrawl_date(new Date());
				saveToDb(pool, conn, info);
			}

			if (current_scan_date == null || current_scan_date.equals("")) {
				current_scan_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			}
			try {
				// 解析完成后加入最后更新时间
				DataManager.dataOperation(conn, "update ipt_product_factory set last_scan_date='" + current_scan_date + "' where id=" + factoryCfgRs.getInt("id"));
				System.out.println(factoryCfgRs.getString("factoryname") + "更新" + _factory_counter + "个产品，其中新增" + _factory_new_counter + "个，更新" + _factory_update_counter + "个");
			} catch (Exception e) {
				System.out.println(factoryCfgRs.getString("factoryname") + "更新最后扫描时间失败");
			}
		}
		System.out.println(factoryName + "解析结束……");
	}

	/**
	 * 获得分类列表
	 * 
	 * @param catalogUrl
	 * @param encode
	 * @param catalogReg
	 * @return
	 */
	private Hashtable<String, String> getCatalogUrlList(String website_domain, String product_path, String catalogUrl, String encode, String catalogReg) {
		if (!catalogUrl.startsWith("/")) {
			catalogUrl = "/" + catalogUrl;
		}
		Hashtable<String, String> hashtable = new Hashtable<String, String>();
		String catalogHtml = HtmlParser.getHtmlContent(website_domain + product_path + catalogUrl, encode);
		if (!catalogHtml.trim().isEmpty()) {
			Pattern catalog_reg = Pattern.compile(catalogReg, Pattern.CASE_INSENSITIVE);
			Matcher catalog_mtr = catalog_reg.matcher(catalogHtml);
			while (catalog_mtr.find()) {
				hashtable.put(catalog_mtr.group(1).trim(), catalog_mtr.group(2).trim());
			}
		}
		return hashtable;
	}

	/**
	 * 获取产品url列表
	 * 
	 * @param listPageUrl
	 * @param encode
	 * @param productListReg
	 * @param pagerReg
	 * @return
	 */
	private ArrayList<String> getProductUrlList(String website_domain, String product_path, String listPageUrl, String encode, String productListReg, String pagerReg, String pagerUrl,
			String pagerCountReg) {
		ArrayList<String> productUrlList = new ArrayList<String>();
		listPageUrl = listPageUrl.startsWith("/") ? listPageUrl : "/" + listPageUrl;

		String productListHtml = HtmlParser.getHtmlContent(website_domain + product_path + listPageUrl, encode);
		if (!productListHtml.trim().isEmpty()) {
			System.out.println(website_domain + product_path + listPageUrl);
			Pattern proListReg = Pattern.compile(productListReg, Pattern.CASE_INSENSITIVE);
			Matcher proListMat = proListReg.matcher(productListHtml);
			while (proListMat.find()) {
				String productUrl = proListMat.group(1).trim();
				if (productUrl.startsWith("?")) {
					productUrl = listPageUrl + productUrl;
				}
				productUrl = productUrl.replaceAll("&amp;", "&");
				if (!productUrl.startsWith("/")) {
					productUrl = "/" + productUrl;
				}
				productUrlList.add(website_domain + product_path + productUrl);
			}

			// 取分页的产品列表
			String listUrl = ""; // 分页链接的url
			String pagerCount = ""; // 总页数
			if (!pagerReg.isEmpty()) {
				Pattern pagerUrl_reg = Pattern.compile(pagerReg, Pattern.CASE_INSENSITIVE);
				Matcher pagerUrl_mat = pagerUrl_reg.matcher(productListHtml);
				if (pagerUrl_mat.find()) {
					String paraBeforeStr = pagerUrl_mat.group(1).trim();
					pagerCount = pagerUrl_mat.group(2).trim();
					String paraAfterStr = "";
					listUrl += paraBeforeStr + "{pagernumber}"; // 将分页的url中分页参数替换
					if (pagerUrl_mat.groupCount() == 3) {
						paraAfterStr = pagerUrl_mat.group(3).trim();
						listUrl += paraAfterStr;
					}
					if (listUrl.startsWith("?")) {
						if (listPageUrl.contains("?")) {
							listUrl = listPageUrl.substring(0, listPageUrl.indexOf("?")) + listUrl;
						} else {
							listUrl = listPageUrl + listUrl;
						}
					}
					if (!listUrl.startsWith("/")) {
						listUrl = "/" + listUrl;
					}
					listUrl = listUrl.replace("&amp;", "&");
					listUrl = website_domain + product_path + listUrl;
				}
			} else if (!pagerUrl.isEmpty() && !pagerCountReg.isEmpty()) {
				listUrl = website_domain + product_path + pagerUrl;
				Pattern pagerCount_reg = Pattern.compile(pagerCountReg, Pattern.CASE_INSENSITIVE);
				Matcher pagerCount_mat = pagerCount_reg.matcher(productListHtml);
				if (pagerCount_mat.find()) {
					pagerCount = pagerCount_mat.group(1).trim();
				}
			}

			if (!listUrl.isEmpty() && !pagerCount.isEmpty()) {
				int count = Integer.parseInt(pagerCount);
				for (int i = 2; i <= count; i++) { // 从第二页开始循环
					String replacedUrl = listUrl.replace("{pagernumber}", String.valueOf(i));
					String listHtml = HtmlParser.getHtmlContent(replacedUrl, encode);
					if (!listHtml.trim().isEmpty()) {
						Pattern pagerListReg = Pattern.compile(productListReg, Pattern.CASE_INSENSITIVE);
						Matcher pagerListMat = pagerListReg.matcher(listHtml);
						while (pagerListMat.find()) {
							String productUrl = pagerListMat.group(1).trim();
							if (productUrl.startsWith("?")) {
								productUrl = listPageUrl + productUrl;
							}
							if (!productUrl.startsWith("/")) {
								productUrl = "/" + productUrl;
							}
							productUrl = productUrl.replace("&amp;", "&");
							productUrlList.add(website_domain + product_path + productUrl);
						}
					}
				}
			}
		}
		return productUrlList;
	}

	/**
	 * 获取产品信息
	 * 
	 * @param productPageUrl
	 * @param encode
	 * @param nameReg
	 * @param modelReg
	 * @param paraReg
	 * @param imgReg
	 * @param introReg
	 * @param catalogReg
	 * @return
	 */
	private TempProductInfo getProductInfo(String website_domain, String image_path, String imgSavePath, String productPageUrl, String encode, String nameReg, String modelReg, String paraReg,
			String imgReg, String introReg, String catalogReg, String catalogName, HttpServletRequest request) {
		String productHtml = HtmlParser.getHtmlContent(productPageUrl, encode);
		if (productHtml!=null&&!productHtml.trim().isEmpty()) {
			TempProductInfo info = new TempProductInfo();
             
			if (nameReg != null && !nameReg.isEmpty()) {
				Pattern name_reg = Pattern.compile(nameReg, Pattern.CASE_INSENSITIVE);
				Matcher name_mtr = name_reg.matcher(productHtml);
				if (name_mtr.find()) {
					info.setName(name_mtr.group(1).trim());
				}
			}

			if (modelReg != null && !modelReg.isEmpty()) {
				Pattern model_reg = Pattern.compile(modelReg, Pattern.CASE_INSENSITIVE);
				Matcher model_mtr = model_reg.matcher(productHtml);
				if (model_mtr.find()) {
					info.setModel_number(model_mtr.group(1).trim());
				}
			}

			if (paraReg != null && !paraReg.isEmpty()) {
				Pattern paras_reg = Pattern.compile(paraReg, Pattern.CASE_INSENSITIVE);
				Matcher paras_mtr = paras_reg.matcher(productHtml);
				if (paras_mtr.find()) {
					info.setParas(paras_mtr.group(1).trim());
				}
			}

			if (imgReg != null && !imgReg.isEmpty()) {
				Pattern imgs_reg = Pattern.compile(imgReg, Pattern.CASE_INSENSITIVE);
				Matcher imgs_mtr = imgs_reg.matcher(productHtml);
				String imgsStr = "";
				while (imgs_mtr.find()) {
					imgsStr += imgs_mtr.group(1).trim() + ",";
				}
				info.setImg(imgsStr); // 暂时保存到img字段
			}

			if (introReg != null && !introReg.isEmpty()) {
				Pattern intro_reg = Pattern.compile(introReg, Pattern.CASE_INSENSITIVE);
				Matcher intro_mtr = intro_reg.matcher(productHtml);
				if (intro_mtr.find()) {
					info.setIntroduce(intro_mtr.group(1).trim());
				}
			}

			if (catalogName != null) {
				info.setCatalogname(catalogName.trim().trim());
			} else if (!CommonString.getFormatPara(catalogReg).isEmpty()) {
				Pattern catalog_reg = Pattern.compile(catalogReg, Pattern.CASE_INSENSITIVE);
				Matcher catalog_mtr = catalog_reg.matcher(productHtml);
				if (catalog_mtr.find()) {
					info.setCatalogname(catalog_mtr.group(1).trim());
				}
			}

			productHtml = null;// 释放占用的内存

			info.setSource_url(productPageUrl);

			if (isUseful(info)) {
				String[] imgAry = handlerImg(website_domain, image_path, imgSavePath, info.getImg(), request);
				info.setImg(imgAry[0]);
				info.setImg2(imgAry[1]);

				info.setIntroduce(handlerIntroImg(info.getIntroduce(), imgSavePath, website_domain, image_path, request));
				return info;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	/**
	 * 判断产品信息是否可用
	 * 
	 * @param info
	 * @return
	 */
	private boolean isUseful(TempProductInfo info) {
		Pattern chineseCharPtn = Pattern.compile("[\\u4e00-\\u9fbb]+", Pattern.CASE_INSENSITIVE);
		Matcher cataMat = chineseCharPtn.matcher(info.getCatalogname());
		Matcher nameMat = chineseCharPtn.matcher(info.getName());
		Matcher introMat = chineseCharPtn.matcher(info.getIntroduce());
		Matcher parasMat = chineseCharPtn.matcher(info.getParas());
		return (cataMat.find() || nameMat.find() || introMat.find() || parasMat.find() || (info.getCatalogname().length() == 0 && info.getIntroduce().length() == 0 && info.getParas().length() == 0));
	}

	/**
	 * 将图片保存到本地，并将图片存放路径改为指定的本地路径，并根据大图创建缩略图
	 * 
	 * @param domainName
	 * @param savePath
	 * @param imgsStr 大图
	 * @param request
	 * @return 返回大图与小图的字符串数组
	 */
	private String[] handlerImg(String domainName, String image_path, String savePath, String imgsStr, HttpServletRequest request) {
		ArrayList imgList = new ArrayList();
		StringTokenizer st = new StringTokenizer(imgsStr, ",");
		while (st.hasMoreElements()) {
			String img = st.nextElement().toString().trim();
			String imgName = img.substring(img.lastIndexOf("/") + 1);
			String url = "";

			if ((img.toLowerCase().startsWith("http://")) || (img.toLowerCase().startsWith("www.")))
				url = img;
			else {
				img = img.replace("../", "");
				img = img.replace("./", "");
				if (!img.startsWith("/")) {
					img = "/" + img;
				}
				if (!image_path.trim().isEmpty()) {
					img = image_path.trim() + img;
				}
				url = domainName.trim() + img;
			}

			String saveDirPath = request.getRealPath("/uploadfiles/" + savePath);
			FileUtils.isExists(saveDirPath, true);
			String imgSavePath = saveDirPath + "/" + imgName;
			imgSavePath = imgSavePath.toLowerCase();

			System.out.println("图片下载开始");
			try {
				if (!this._downLoadedImgList.contains(url)) {
					FileDownLoader.downFile(url, imgSavePath);
				}
				imgList.add(savePath + "/" + imgName);
				this._downLoadedImgList.add(url);
			} catch (Exception e) {
				System.out.println("文件下载失败：" + url);
			}
			System.out.println("图片下载结束");
		}

		String[] rtn = { "", "" };
		String bigImgs = "";
		if (!imgList.isEmpty()) {
			String[] imgs = (String[]) imgList.toArray(new String[imgList.size()]);
			String fgf = "," ;
			StringBuffer result = new StringBuffer();
			try {
				if (imgs != null)
					for (int k = 0; k < imgs.length; k++)
						if (k == 0) {
							result.append(imgs[k]);

						} else {
							result.append(fgf + imgs[k]);

						}
			} catch (Exception e) {
				e.printStackTrace();

			} finally {
			}
			bigImgs = result.toString();
			rtn[0] = bigImgs;
			String bigImgName = imgs[0].substring(imgs[0].lastIndexOf("/") + 1);
			String[] name = bigImgName.split("\\.");
			String smallImgName = name[0] + "_small." + name[1];
			String bigImgPath = request.getRealPath(new StringBuilder("/uploadfiles/").append(savePath).toString()) + "/" + bigImgName;

			// 暂时取消生成缩略图功能
			// String smallImgSavePath = request.getRealPath(new StringBuilder("/uploadfiles/").append(savePath).toString()) + "/" + smallImgName;
			// try {
			// ImageUtils.createThumbnail(bigImgPath, smallImgSavePath, 50);
			// rtn[1] = (savePath + "/" + smallImgName);
			// } catch (IOException e) {
			// e.printStackTrace();
			// }
		}
		return rtn;
	}

	/**
	 * 处理介绍或参数中的图片
	 * 
	 * @param content 介绍或参数的html代码
	 * @param imgSavePath 厂家图片的保存目录
	 * @param website_name
	 * @param request
	 * @return
	 */
	private String handlerIntroImg(String content, String imgSavePath, String website_name, String image_path, HttpServletRequest request) {
		if (content == null || content.trim().isEmpty()) {
			return "";
		}

		StringBuffer sb = new StringBuffer();
		String allImgReg = "<img[^>]*?src\\s*=\\s*[\'\"\"]?([^\'\"\"\\s>]*)[^>]*>";
		Pattern allImgPattern = Pattern.compile(allImgReg, Pattern.CASE_INSENSITIVE);
		Matcher allImgMat = allImgPattern.matcher(content);
		while (allImgMat.find()) {
			String src = allImgMat.group(1).trim();
			if (!src.toLowerCase().startsWith("http://")) {
				if (src.toLowerCase().startsWith("www.")) {
					src = "http://" + src;
				} else {
					src = src.replace("../", "");
					src = src.replace("./", "");
					if (!src.startsWith("/")) {
						src = "/" + src;
					}
					src = website_name + image_path + src;
				}
			}

			String saveDirPath = request.getRealPath("/uploadfiles/" + imgSavePath + "/intro_img");
			FileUtils.isExists(saveDirPath, true);
			String imgName = src.substring(src.lastIndexOf("/") + 1);
			String localSavePath = saveDirPath + "/" + imgName;

			try {
				FileDownLoader.downFile(src, localSavePath);
				allImgMat.appendReplacement(sb, "<img src=\"/uploadfiles/" + imgSavePath + "/intro_img/" + imgName + "\" />");
			} catch (Exception e) {
				System.out.println("介绍图片文件下载失败：" + src);
				allImgMat.appendReplacement(sb, "<img src=\"" + src + "\" />");
			}
		}
		allImgMat.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 将从厂家数据库抓取的产品存到数据库
	 * 
	 * @param conn
	 * @param info
	 * @param product_add_date 产品中心库中产品的添加时间
	 * @param product_last_update_date 产品中心库中产品的最后更新时间，如果为""则表示新增的产品
	 * @throws ParseException
	 */
	private void saveToDb(PoolManager pool, Connection conn, TempProductInfo info, Date product_add_date, String product_last_update_dateString) throws ParseException {
		// 判断更新的产品数据是增加的还是修改的
		String importSql = "";
		Object[] paras;

		if (!product_last_update_dateString.isEmpty()) {
			Date productLastUpdateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(product_last_update_dateString);
			if (productLastUpdateTime.after(product_add_date)) { // 表示是更新的数据
				// 获取已存在的产品在临时表中的id及状态
				String[][] theproduct = DataManager.fetchFieldValue(pool, "ipt_product_temp_products", "id,flag", "from_productid=" + info.getFrom_productid());
				if (theproduct != null && theproduct.length > 0) { // 如果查到，则作为更新处理
					int id = Integer.parseInt(theproduct[0][0]);
					int flag = Integer.parseInt(theproduct[0][1]);
					TempProductFlag flagEnum = TempProductFlag.valueOf(flag);
					switch (flagEnum) {
					case imported:
						info.setFlag(TempProductFlag.imported_update.getValue());
						break;
					case unhandle:
						info.setFlag(TempProductFlag.unhandle.getValue());
						break;
					case nothandle:
					case imported_update:
					case nothandle_update:
						info.setFlag(flagEnum.getValue());
						break;
					}
					importSql = "update ipt_product_temp_products set factoryid=?,crawl_date=?,factoryname=?,catalogname=?,name=?,model_number=?,paras=?,img2=?,img=?,introduce=?,flag=? where id=?";
					Object[] updateParas = { info.getFactoryid(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(info.getCrawl_date()), info.getFactoryname(), info.getCatalogname(),
							info.getName(), info.getModel_number(), info.getParas(), info.getImg(), info.getImg2(), info.getIntroduce(), info.getFlag(), id };
					paras = updateParas;

					_factory_update_counter++;
					_total_update_counter++;
				} else { // 如果没查到，则作为新增处理
					info.setFlag(TempProductFlag.unhandle.getValue());
					importSql = "insert into ipt_product_temp_products (factoryid,crawl_date,factoryname,catalogname,name,model_number,paras,img2,img,introduce,flag,from_productid) values (?,?,?,?,?,?,?,?,?,?,?,?)";
					Object[] insertParas = { info.getFactoryid(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(info.getCrawl_date()), info.getFactoryname(), info.getCatalogname(),
							info.getName(), info.getModel_number(), info.getParas(), info.getImg(), info.getImg2(), info.getIntroduce(), info.getFlag(), info.getFrom_productid() };
					paras = insertParas;

					_factory_new_counter++;
					_total_new_counter++;
				}
			} else { // 表示是新加的数据
				info.setFlag(TempProductFlag.unhandle.getValue());
				importSql = "insert into ipt_product_temp_products (factoryid,crawl_date,factoryname,catalogname,name,model_number,paras,img2,img,introduce,flag,from_productid) values (?,?,?,?,?,?,?,?,?,?,?,?)";
				Object[] insertParas = { info.getFactoryid(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(info.getCrawl_date()), info.getFactoryname(), info.getCatalogname(), info.getName(),
						info.getModel_number(), info.getParas(), info.getImg(), info.getImg2(), info.getIntroduce(), info.getFlag(), info.getFrom_productid() };
				paras = insertParas;

				_factory_new_counter++;
				_total_new_counter++;
			}
		} else {
			info.setFlag(TempProductFlag.unhandle.getValue());
			importSql = "insert into ipt_product_temp_products (factoryid,crawl_date,factoryname,catalogname,name,model_number,paras,img2,img,introduce,flag,from_productid) values (?,?,?,?,?,?,?,?,?,?,?,?)";
			Object[] insertParas = { info.getFactoryid(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(info.getCrawl_date()), info.getFactoryname(), info.getCatalogname(), info.getName(),
					info.getModel_number(), info.getParas(), info.getImg(), info.getImg2(), info.getIntroduce(), info.getFlag(), info.getFrom_productid() };
			paras = insertParas;

			_factory_new_counter++;
			_total_new_counter++;
		}

		System.out.println("处理完抓取到的数据，准备插入数据库");

		try {
			DataManager.dataOperation(conn, importSql, paras);
			_factory_counter++;
			_total_counter++;

		} catch (Exception e) {
			e.printStackTrace();

			if (!product_last_update_dateString.isEmpty()) {
				Date productLastUpdateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(product_last_update_dateString);
				if (productLastUpdateTime.after(product_add_date)) {
					_factory_update_counter--;
					_total_update_counter--;
				} else {
					_factory_new_counter--;
					_total_new_counter--;
				}
			} else {
				_factory_new_counter--;
				_total_new_counter--;
			}

		} finally {
			System.out.println("插入数据库完成");
		}
	}

	/**
	 * 将从厂家网站抓取的产品存到数据库
	 * 
	 * @param pool
	 * @param conn
	 * @param info
	 */
	private void saveToDb(PoolManager pool, Connection conn, TempProductInfo info) {
		String importSql = "";
		Object[] paras;

		String[][] theproduct = null;
		try {
			theproduct = DataManager.fetchFieldValue(pool, "ipt_product_temp_products", "id,flag", "factoryid=" + info.getFactoryid() + " and source_url='" + info.getSource_url() + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (theproduct != null) {
			int id = Integer.parseInt(theproduct[0][0]);
			int flag = Integer.parseInt(theproduct[0][1]);
			TempProductFlag flagEnum = TempProductFlag.valueOf(flag);
			switch (flagEnum) {
			case imported:
				info.setFlag(TempProductFlag.imported_update.getValue());
				break;
			case unhandle:
				info.setFlag(TempProductFlag.unhandle.getValue());
				break;
			case nothandle:
			case imported_update:
			case nothandle_update:
				info.setFlag(flagEnum.getValue());
				break;
			}
			importSql = "update ipt_product_temp_products set factoryid=?,crawl_date=?,factoryname=?,catalogname=?,name=?,model_number=?,paras=?,img2=?,img=?,introduce=?,flag=? where id=?";
			Object[] updateParas = { info.getFactoryid(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(info.getCrawl_date()), info.getFactoryname(), info.getCatalogname(), info.getName(),
					info.getModel_number(), info.getParas(), info.getImg(), info.getImg2(), info.getIntroduce(), info.getFlag(), id };
			paras = updateParas;

			_factory_update_counter++;
			_total_update_counter++;
		} else {
			info.setFlag(TempProductFlag.unhandle.getValue());
			importSql = "insert into ipt_product_temp_products (factoryid,crawl_date,factoryname,catalogname,name,model_number,paras,img2,img,introduce,flag,source_url) values (?,?,?,?,?,?,?,?,?,?,?,?)";
			Object[] insertParas = { info.getFactoryid(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(info.getCrawl_date()), info.getFactoryname(), info.getCatalogname(), info.getName(),
					info.getModel_number(), info.getParas(), info.getImg(), info.getImg2(), info.getIntroduce(), info.getFlag(), info.getSource_url() };
			paras = insertParas;

			_factory_new_counter++;
			_total_new_counter++;
		}

		System.out.println("处理完抓取到的数据，准备插入数据库");
		try {
			DataManager.dataOperation(conn, importSql, paras);
			_factory_counter++;
			_total_counter++;

		} catch (Exception e) {
			e.printStackTrace();

			if (theproduct != null) {
				_factory_update_counter--;
				_total_update_counter--;
			} else {
				_factory_new_counter--;
				_total_new_counter--;
			}

		} finally {
			System.out.println("插入数据库完成");
		}
	}
}
