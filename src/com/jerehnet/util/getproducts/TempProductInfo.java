package com.jerehnet.util.getproducts;

import java.util.Date;

public class TempProductInfo {
	private int id;
	private int factoryid;
	private int from_productid;
	private Date crawl_date;
	private Date import_pro_date;
	private String factoryname;
	private String catalogname;
	private String name;
	private String model_number;
	private String paras;
	private String img;
	private String img2;
	private String source_url;
	private String introduce;
	private int flag;

	public TempProductInfo() {
		this.catalogname = "";
		this.name = "";
		this.model_number = "";
		this.paras = "";
		this.img = "";
		this.img2 = "";
		this.source_url = "";
		this.introduce = "";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFactoryid() {
		return factoryid;
	}

	public void setFactoryid(int factoryid) {
		this.factoryid = factoryid;
	}

	public int getFrom_productid() {
		return from_productid;
	}

	public void setFrom_productid(int from_productid) {
		this.from_productid = from_productid;
	}

	public Date getCrawl_date() {
		return crawl_date;
	}

	public void setCrawl_date(Date crawl_date) {
		this.crawl_date = crawl_date;
	}

	public Date getImport_pro_date() {
		return import_pro_date;
	}

	public void setImport_pro_date(Date import_pro_date) {
		this.import_pro_date = import_pro_date;
	}

	public String getFactoryname() {
		return factoryname;
	}

	public void setFactoryname(String factoryname) {
		this.factoryname = factoryname;
	}

	public String getCatalogname() {
		return catalogname;
	}

	public void setCatalogname(String catalogname) {
		this.catalogname = catalogname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getModel_number() {
		return model_number;
	}

	public void setModel_number(String model_number) {
		this.model_number = model_number;
	}

	public String getParas() {
		return paras;
	}

	public void setParas(String paras) {
		this.paras = paras;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public void setImg2(String img2) {
		this.img2 = img2;
	}

	public String getImg2() {
		return img2;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public void setSource_url(String source_url) {
		this.source_url = source_url;
	}

	public String getSource_url() {
		return source_url;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}
}
