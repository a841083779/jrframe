package com.jerehnet.mobile.utils;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.alibaba.fastjson.JSONArray;
import com.jerehnet.mobile.entity.ECity;
import com.jerehnet.mobile.entity.EProvice;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;

public class getDistcodeJson {
	
	public static String getJson(String areaids){
		Connection connection = null;
		DBHelper dbHelper = DBHelper.getInstance();
		List<EProvice> privaces = new ArrayList<EProvice>();
		try {/*
			connection = dbHelper.getConnection();

			String[] str = areaids.split(",");
	
			
			String level_id_regex="";   //用此字符串做判断是省还是市			
			for(int i=0;i<str.length;i++){
      		  String distcode_sql="select area_id,area_name,parent_area_id,node_full_name,level_id from comm_area where area_id="+str[i];	  
      		  List<Map<String,Object>> distcode_list = null ;
				  distcode_list = dbHelper.getMapList(distcode_sql);
				  level_id_regex+=distcode_list.get(0).get("level_id")+",";
      	    }
			
			if(level_id_regex.indexOf("2")!=-1){
				
				
				Set<Map> privacess = new HashSet<Map>();
				List<Map> citys = new ArrayList<Map>();
				for (int i = 0; i < str.length; i++) {
		
					
					String parentArea_sql = "select * from comm_area where  area_id="+ str[i];
					List<Map> parentArealist = null;
					parentArealist = dbHelper.getMapList(parentArea_sql);
					//市、省

					Map	parentArea = (Map)parentArealist.get(0);	
				  
					System.out.println("a"+parentArea.get("parent_area_id"));
					String privaceArea_sql = "select * from comm_area where level_id in (1,2) and  area_id="+ parentArea.get("parent_area_id");
					List<Map> privaceArealist = null;
					privaceArealist = dbHelper.getMapList(privaceArea_sql);
					//省、国家
				
			        if(privaceArealist.size()>0){
			        	Map privaceArea = (Map)privaceArealist.get(0);
			        	//省、国家 list
						
						privacess.add(privaceArea);	
			        }		
			
					
	                //市、省  list
					citys.add(parentArea);
	                	
				}
				
				
				System.out.println("b:"+privacess);
				for (Iterator<Map> iter = privacess.iterator(); iter
						.hasNext();) {
					Map reg = iter.next();
					System.out.println("d:"+reg);
					EProvice privace = new EProvice();
					privace.setId(Integer.parseInt(CommonString.getFormatPara(reg.get("area_id"))));
					privace.setProviceName(CommonString.getFormatPara(reg.get("area_name")));
					List<ECity> cityss = new ArrayList<ECity>();
					for (Map region : citys) {

						if (CommonString.getFormatPara(reg.get("area_id")).equals(CommonString.getFormatPara(region.get("parent_area_id"))) ) {

							ECity city = new ECity();
							city.setId(Integer.parseInt(CommonString.getFormatPara(region.get("area_id"))));
							city.setCityName(CommonString.getFormatPara(region.get("area_name")));
							cityss.add(city);
						}
					}
					privace.setCitys(cityss);
					privaces.add(privace);
				}
				
				
				
			}else{				
				//只有省                      	  
          	  for(int i=0;i<str.length;i++){
          		  String distcode_sql="select area_id,area_name,parent_area_id,node_full_name,level_id from comm_area where area_id="+str[i];	  
          		  List<Map<String,Object>> distcode_list = null ;
					  distcode_list = dbHelper.getMapList(distcode_sql);
					  Map<String,Object> map=null;
					  EProvice privace = new EProvice();
					  List<EProvice> distcodelist=new ArrayList<EProvice>();
					  for(int j=0;j<distcode_list.size();j++){
						  privace = new EProvice();
						  privace.setId(Integer.parseInt(CommonString.getFormatPara(distcode_list.get(j).get("area_id"))));
						  privace.setProviceName(CommonString.getFormatPara(distcode_list.get(j).get("area_name")));
						  privaces.add(privace);
					  }   							  
          	   }                      	  
			}
			
			


			

		*/
			
			
			/*connection = dbHelper.getConnection();

			String[] str = areaids.split(",");
			
			for(int i=0;i<str.length;i++){
        		  String distcode_sql="select area_id,area_name,parent_area_id,node_full_name,level_id from comm_area where area_id="+str[i];	  
        		  List<Map<String,Object>> distcode_list = null ;
					  distcode_list = dbHelper.getMapList(distcode_sql);
					  Map<String,Object> map=null;
					  EProvice privace = new EProvice();
					  List<EProvice> distcodelist=new ArrayList<EProvice>();
					  for(int j=0;j<distcode_list.size();j++){
						  privace = new EProvice();
						  privace.setId(Integer.parseInt(CommonString.getFormatPara(distcode_list.get(j).get("area_id"))));
						  privace.setProviceName(CommonString.getFormatPara(distcode_list.get(j).get("area_name")));
						  privaces.add(privace);
					  }   							  
        	   }   */
			connection = dbHelper.getConnection();

			String[] str = areaids.split(",");
	
			
			String level_id_regex="";   //用此字符串做判断是省还是市			
			for(int i=0;i<str.length;i++){
      		  String distcode_sql="select area_id,area_name,parent_area_id,node_full_name,level_id from comm_area where area_id="+str[i];	  
      		  List<Map<String,Object>> distcode_list = null ;
				  distcode_list = dbHelper.getMapList(distcode_sql);
				  level_id_regex+=distcode_list.get(0).get("level_id")+",";
      	    }
			
			if(level_id_regex.indexOf("2")!=-1){
				
				
				Set<Map> privacess = new HashSet<Map>();
				List<Map> citys = new ArrayList<Map>();
				for (int i = 0; i < str.length; i++) {
		
					
					String parentArea_sql = "select * from comm_area where  area_id="+ str[i];
					List<Map> parentArealist = null;
					parentArealist = dbHelper.getMapList(parentArea_sql);
					//市、省

					Map	parentArea = (Map)parentArealist.get(0);	
				  
					System.out.println("a"+parentArea.get("parent_area_id"));
					String privaceArea_sql = "select * from comm_area where level_id in (1,2) and  area_id="+ parentArea.get("parent_area_id");
					List<Map> privaceArealist = null;
					privaceArealist = dbHelper.getMapList(privaceArea_sql);
					//省、国家
				
			        if(privaceArealist.size()>0){
			        	Map privaceArea = (Map)privaceArealist.get(0);
			        	//省、国家 list
						
						privacess.add(privaceArea);	
			        }		
			
					
	                //市、省  list
					citys.add(parentArea);
	                	
				}
				
				
				System.out.println("b:"+privacess);
				for (Iterator<Map> iter = privacess.iterator(); iter
						.hasNext();) {
					Map reg = iter.next();
					System.out.println("d:"+reg);
					EProvice privace = new EProvice();
					privace.setId(Integer.parseInt(CommonString.getFormatPara(reg.get("area_id"))));
					privace.setProviceName(CommonString.getFormatPara(reg.get("area_name")));
					List<ECity> cityss = new ArrayList<ECity>();
					
					for (Map region : citys) {

						if (CommonString.getFormatPara(reg.get("area_id")).equals(CommonString.getFormatPara(region.get("parent_area_id"))) ) {

							ECity city = new ECity();
							city.setId(Integer.parseInt(CommonString.getFormatPara(region.get("area_id"))));
							city.setCityName(CommonString.getFormatPara(region.get("area_name")));
							cityss.add(city);
						}
					}
					
					privace.setCitys(cityss);
					privaces.add(privace);
				}
				
				
				
			}else{				
				//只有省                      	  
          	  for(int i=0;i<str.length;i++){
          		  String distcode_sql="select area_id,area_name,parent_area_id,node_full_name,level_id from comm_area where area_id="+str[i];	  
          		  List<Map<String,Object>> distcode_list = null ;
					  distcode_list = dbHelper.getMapList(distcode_sql);
					  Map<String,Object> map=null;
					  EProvice privace = new EProvice();
					  List<EProvice> distcodelist=new ArrayList<EProvice>();
					  for(int j=0;j<distcode_list.size();j++){
						  privace = new EProvice();
						  privace.setId(Integer.parseInt(CommonString.getFormatPara(distcode_list.get(j).get("area_id"))));
						  privace.setProviceName(CommonString.getFormatPara(distcode_list.get(j).get("area_name")));
						  privaces.add(privace);
					  }   							  
          	   }                      	  
			}
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBHelper.freeConnection(connection);
		}
	
		
		return (JSONArray.toJSONString(privaces));
		
	}
	public static void main(String args[]) {
		getDistcodeJson g =new getDistcodeJson();
		//System.out.println(g.getJson());
	}
}
