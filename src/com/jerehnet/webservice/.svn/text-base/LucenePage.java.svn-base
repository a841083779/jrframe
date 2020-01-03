package com.jerehnet.webservice;

import org.json.JSONArray;
import org.json.JSONObject;
import com.jerehnet.lucene.ISearch;
import com.jerehnet.lucene.LuceneUtil;
import com.jerehnet.util.common.CommonString;

public class LucenePage {

	public LucenePage(Integer pageSize, Integer nowPage, String wsdl) {
		super();
		this.pageSize = pageSize;
		this.nowPage = nowPage;
		this.wsdl = wsdl;
	}

	private Integer pageSize;
	private Integer nowPage;
	private Integer total;
	private String wsdl;
	private Double time;
	private Integer all;

	@SuppressWarnings("unchecked")
	public JSONArray doSearch(String keywords) throws Exception {
		if ("".equals(CommonString.getFormatPara(keywords))) {
			return null;
		}
		ISearch iSearch = LuceneUtil.newSearcher(this.getWsdl());
		String str = iSearch.doSearch(keywords, this.getNowPage(), this
				.getPageSize());
		JSONObject jsonObject = new JSONObject(str);
		this.setTotal((Integer) jsonObject.get("total"));
		this.setTime((Double) jsonObject.get("time"));
		this.setAll((Integer) jsonObject.get("all"));
		return jsonObject.getJSONArray("list");
	}

	public JSONArray doAccurateSearch(String keywords, String accurate)
			throws Exception {
		if ("".equals(CommonString.getFormatPara(keywords))) {
			return null;
		}
		ISearch iSearch = LuceneUtil.newSearcher(this.getWsdl());
		String str = iSearch.doAccurateSearch(keywords, this.getNowPage(), this
				.getPageSize(), accurate);
		JSONObject jsonObject = new JSONObject(str);
		this.setTotal((Integer) jsonObject.get("total"));
		this.setTime((Double) jsonObject.get("time"));
		this.setAll((Integer) jsonObject.get("all"));
		return jsonObject.getJSONArray("list");
	}

	public JSONArray doSortSearch(String keywords, String sort)
			throws Exception {
		if ("".equals(CommonString.getFormatPara(keywords))) {
			return null;
		}
		ISearch iSearch = LuceneUtil.newSearcher(this.getWsdl());
		String str = iSearch.doSortSearch(keywords, this.getNowPage(), this
				.getPageSize(), sort);
		JSONObject jsonObject = new JSONObject(str);
		this.setTotal((Integer) jsonObject.get("total"));
		this.setTime((Double) jsonObject.get("time"));
		this.setAll((Integer) jsonObject.get("all"));
		return jsonObject.getJSONArray("list");
	}

	public JSONArray doAccurateSortSearch(String keywords, String accurate,
			String sort) throws Exception {
		if ("".equals(CommonString.getFormatPara(keywords))) {
			return null;
		}
		ISearch iSearch = LuceneUtil.newSearcher(this.getWsdl());
		String str = iSearch.doAccurateSortSearch(keywords, this.getNowPage(),
				this.getPageSize(), accurate, sort);
		JSONObject jsonObject = new JSONObject(str);
		this.setTotal((Integer) jsonObject.get("total"));
		this.setTime((Double) jsonObject.get("time"));
		this.setAll((Integer) jsonObject.get("all"));
		return jsonObject.getJSONArray("list");
	}

	public Integer getPageCount() {
		return ((Double) Math.ceil(this.getTotal() * 1d / this.getPageSize()
				* 1d)).intValue();
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getAll() {
		return all;
	}

	public void setAll(Integer all) {
		this.all = all;
	}

	public Integer getNowPage() {
		return nowPage;
	}

	public void setNowPage(Integer nowPage) {
		this.nowPage = nowPage;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public String getWsdl() {
		return wsdl;
	}

	public void setWsdl(String wsdl) {
		this.wsdl = wsdl;
	}

	public Double getTime() {
		return time;
	}

	public void setTime(Double time) {
		this.time = time;
	}

}
