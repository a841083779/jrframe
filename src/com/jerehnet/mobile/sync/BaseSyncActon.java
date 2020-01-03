package com.jerehnet.mobile.sync;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.zxing.WriterException;

public class BaseSyncActon {
	/**
	 * 将list中key名中有下划线的改为大写
	 * 
	 * @param list
	 * @return
	 * @throws WriterException
	 * @throws IOException
	 */
	public List<Map<String,Object>> getFormatList(List<Map<String,Object>> list) throws WriterException,
			IOException {
		List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>();
		if (list != null && list.size() > 0) {
			int num = list.size();
			for(int i=0;i<num;i++){
				Map<String,Object> rowData = list.get(i);
				if(rowData!=null){
					newlist.add(getUpperMap(rowData));
				}
			}
		}
		return newlist;
	}
	/**
	 * 将Map中key名中有下划线的改为大写
	 * 
	 * @param rowData
	 * @return
	 * @throws WriterException
	 * @throws IOException
	 */
	public Map<String,Object> getUpperMap(Map<String,Object> rowData){
		Map<String,Object> newRowData = new HashMap<String,Object>();
		for(Map.Entry<String, Object> entry: rowData.entrySet()) {
			 newRowData.put(replaceUpperCase(entry.getKey()), entry.getValue());
		}
		return newRowData;
	}
	/***
     * 转换回去
     * @param str
     * @return
     */
    public String replaceUpperCase(String str) {
        StringBuffer sb = new StringBuffer();
        String[] c = str.split("_");
        for (int i = 0; c != null && i < c.length; i++) {
            if (i > 0) {
                sb.append(c[i].substring(0, 1).toUpperCase() + c[i].substring(1));
            } else {
                sb.append(c[i]);
            }
        }
        return sb.toString();
    }
}