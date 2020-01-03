package com.jerehnet.mobile.action;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.alibaba.fastjson.JSON;
import com.jerehnet.mobile.sync.BaseSyncActon;
import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;
public class AgentAction  extends BaseSyncActon{
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();  
	JSONObject jsonObject = new JSONObject();
	
	
	/**
	 * 
	 * @param format
	 * @param days
	 *            距离今日的天数
	 * @return
	 */
	public static String getYesterday(String format, int days) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -days);
		if (null == format || "".equals(format)) {
			format = "yyyy-MM-dd";
		}
		String yesterday = new SimpleDateFormat(format).format(cal.getTime());
		return yesterday;
	}
	
	
	/**
	 * 代理商登录
	 * @param usern
	 * @param pwd
	 * @return
	 */
	public String login(String usern,String pwd){
		String sql=" select id as uid,usern,full_name,'agent_login' as type,city_num,city "+
				   " from pro_agent_factory a where flag=2  and  usern=? and passw_bak=? and order_end_time >= ? ";
		Map<String,Object> user = null ;
		try{
			user = dbHelper.getMap(sql,new Object[]{usern,pwd,CommonDate.getToday("yyyy-MM-dd")}) ;
			if(user!=null){
				jsonObject.put("success","true");
          	  	jsonObject.put("msg","登录成功");           
                jsonObject.put("result",getUpperMap(user));  
			}else{
				jsonObject.put("success","true");
          	  	jsonObject.put("msg","账号或密码错误");          
                jsonObject.put("result",""); 
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
      	  	jsonObject.put("msg","登录失败");          
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 代理商 绑定微信openID
	 * @param uid
	 * @return
	 */
	public String bindWXID(int uid,String openId){
		int id=0;
		try{
			Map user=dbHelper.getMap(" select open_id from pro_agent_factory where id=?  ",new Object[]{uid});
			if(user!=null){
				if("".equals(CommonString.getFormatPara(user.get("open_id")))){
					if(!"".equals(openId)){
						id=dbHelper.execute(" update pro_agent_factory set open_id=? where id=? ", new Object[]{openId,uid});
						if(id>0){
							jsonObject.put("success","true");
							jsonObject.put("result","true");
				      	  	jsonObject.put("msg","成功绑定微信号！"); 
						}else{
							jsonObject.put("success","true");
							jsonObject.put("result","false");
				      	  	jsonObject.put("msg","绑定失败，请重试！"); 
						}
					}else{
						jsonObject.put("success","true");
						jsonObject.put("result","false");
			      	  	jsonObject.put("msg","没有找到要绑定的微信号！"); 
					}
				}else{//已绑定微信，不能重复绑定
					jsonObject.put("success","true");
					jsonObject.put("result","false");
		      	  	jsonObject.put("msg","已绑定微信，不能重复绑定！"); 
				}
				
			}
			
			
			         
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
      	  	jsonObject.put("msg","微信绑定失败"); 
		}
		return jsonObject.toString();
	}
	
	/**
	 * 代理商  状态统计数
	 * @param agent_id
	 * @return
	 */
	public String getCountNum(int agent_id){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		Map unHandleMap=null;Map inTrackMap=null;Map dealMap=null;Map lossMap=null;Map markMap=null;Map province=null;
		
		try{
			if(agent_id!=0){
				unHandleMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id where f.person_id is not null and f.person_id !='' and   f.agent_id=?  and f.order_state=102001 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  ",new Object[]{agent_id});
				inTrackMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id where f.person_id is not null and f.person_id !='' and   f.agent_id=?  and f.order_state in ('102002','102003','102010','102004','102005','102006','102007')  and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time   ",new Object[]{agent_id});
				dealMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id where f.person_id is not null and f.person_id !='' and   f.agent_id=?  and f.order_state=102008 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  ",new Object[]{agent_id});
				lossMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id where f.person_id is not null and f.person_id !='' and   f.agent_id=?  and f.order_state=102009  and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time ",new Object[]{agent_id});
				markMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id where f.person_id is not null and f.person_id !='' and   f.agent_id=?  and f.isTagged=1 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  ",new Object[]{agent_id});
				province=dbHelper.getMap(" select city from pro_agent_factory where id=? ",new Object[]{agent_id});
				
				jsonObject.put("success","true");
	          	jsonObject.put("unHandleNum",CommonString.getFormatInt(CommonString.getFormatPara(unHandleMap.get("num")))); 
	          	jsonObject.put("inTrackNum",CommonString.getFormatInt(CommonString.getFormatPara(inTrackMap.get("num")))); 
	          	jsonObject.put("dealNum",CommonString.getFormatInt(CommonString.getFormatPara(dealMap.get("num")))); 
	          	jsonObject.put("lossNum",CommonString.getFormatInt(CommonString.getFormatPara(lossMap.get("num")))); 
	          	jsonObject.put("markNum",CommonString.getFormatInt(CommonString.getFormatPara(markMap.get("num")))); 
	          	jsonObject.put("provinceNum", CommonString.getFormatPara(province.get("city")).split(",").length);
			}else{
				jsonObject.put("success","true");
				jsonObject.put("unHandleNum",0); 
	          	jsonObject.put("inTrackNum",0); 
	          	jsonObject.put("dealNum",0); 
	          	jsonObject.put("lossNum",0); 
				jsonObject.put("markNum",0); 
				jsonObject.put("provinceNum",0); 
			}
			

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("unHandleNum",0); 
          	jsonObject.put("inTrackNum",0); 
          	jsonObject.put("dealNum",0); 
          	jsonObject.put("lossNum",0); 
			jsonObject.put("markNum",0); 
			jsonObject.put("provinceNum",0); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	
	
	/**
	 * 代理商 业务员列表
	 * @param agent_id
	 * @param searchStr
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public String personList(int agent_id,String searchStr, int pageNum,int pageSize){

		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";
		if(!"".equals(searchStr)&&searchStr!=null){
			whereStr += " and (name like '%"+searchStr+"%' or phone like '%"+searchStr+"%') ";
		}
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}
		String sql=" select top "+pageSize+" id as uid,usern,name as uname,phone from pro_agent_personnel where id not in (select  top "+pageSize*(pageNum-1)+" id from pro_agent_personnel where agent_id=? "+whereStr+" order by id desc ) and agent_id= ? "+whereStr+" order by id desc ";
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		
		try{
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id,agent_id}) ;
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result",""); 
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 代理商 订单列表
	 * @param agent_id 代理商id   （必传值）
	 * @param orderState 订单状态 0未处理  1跟踪中  2成交  -1流失   （必传值）
	 * @param ywid 业务员id 
	 * @param trackState 跟踪状态 
	 * @param lostReason 流失原因 
	 * @param pageNum 当前页 第一页 1   （必传值）
	 * @param pageSize 分页条数		（必传值）
	 * @return
	 */
	public String orderList(int agent_id,int ywid,String orderState,String trackState,String province,String lostReason, int pageNum,int pageSize){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";
		String orderStr=" order by f.id desc ";
		if("1".equals(orderState)){//跟踪中
			whereStr += " and f.order_state in ('102002','102003','102010','102004','102005','102006','102007') ";
			if(!"".equals(trackState)&&trackState!=null){//跟踪状态
				whereStr += " and f.order_state = '"+trackState+"' ";
			}
			orderStr=" order by f.last_record_date desc ";
		}else if("2".equals(orderState)){//成交
			whereStr += " and f.order_state = '102008' ";
			orderStr=" order by f.id desc ";
		}else if("-1".equals(orderState)){//流失
			whereStr += " and f.order_state = '102009' ";
			if(!"".equals(lostReason)&&lostReason!=null){//流失原因
				whereStr += " and f.run_off_flag='"+lostReason+"' ";
			}
			orderStr=" order by f.id desc ";
		}else{//未处理
			whereStr += " and f.order_state = '102001' ";
			orderStr=" order by f.id desc ";
		}
		if(ywid!=0){//业务员查询
			whereStr += " and f.person_id="+ywid;
		}
		if(!"".equals(province)&&province!=null){//
			whereStr += " and f.province like '%"+province+"%' ";
		}
		
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}

		//String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,ISNULL(p.name,'') as receive_man,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged "+
		//		   " from  pro_agent_products_form f ,pro_agent_personnel p,pro_products pro "+
		//		   " where f.person_id is not null and f.person_id !='' and f.person_id=p.id and f.product_id=pro.id and f.agent_id=?  "+
		//		   whereStr+
		//		   " and f.id not in ( select top "+pageSize*(pageNum-1)+"  f.id from pro_agent_products_form f ,pro_agent_personnel p,pro_products pro where f.person_id is not null and f.person_id !='' and f.person_id=p.id and f.product_id=pro.id and f.agent_id=?  "+whereStr+orderStr+"  ) "+orderStr;// 

		String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,ISNULL(p.name,'') as receive_man,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged "+
		 " from  pro_agent_products_form f "+
		 " left join pro_agent_personnel p on f.person_id=p.id "+
		 " left join pro_products pro on f.product_id=pro.id "+
		 " left join pro_agent_factory b on f.agent_id=b.id"+
		 " where f.person_id is not null and f.person_id !='' and f.person_id=p.id and f.product_id=pro.id and f.agent_id=? "+
		 " and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time "+whereStr+
		 " and f.id not in (select top "+pageSize*(pageNum-1)+" f.id from pro_agent_products_form f left join pro_agent_personnel p on f.person_id=p.id left join pro_products pro on f.product_id=pro.id left join pro_agent_factory b on f.agent_id=b.id where f.person_id is not null and f.person_id!=''and f.person_id=p.id and f.product_id=pro.id and f.agent_id=? and f.add_date>=b.order_start_time and f.add_date<=b.order_end_time "+whereStr+orderStr+" ) "+orderStr;
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id,agent_id}) ;
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result","");
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	/**
	 * 订单详细页
	 * @param form_id
	 * @return
	 */
	
	
	public String orderInfo(int form_id){
		String whereStr="";

		String sql="select f.id as order_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,CONVERT(varchar(100), f.form_date, 20) create_date,(factory_name+cata_name+product_name) as order_title, f.user_name as order_user,f.contact_address,f.contact_tel,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,ISNULL ( f.app_remark , '') as app_remark,p.name as receive_man,ISNULL(f.run_off_flag,'') as run_off_flag,(case f.run_off_flag when '103001' then '成交竞品' when '103002' then '意向识别不准确' when '103003' then '无效电话' when '103004' then '不需要' else '' end) as run_off_flagname,ISNULL(f.brand,'') as brand,a.name as agentName "+
				 " from pro_agent_products_form f,pro_agent_personnel p,pro_agent_factory a "+
				 " where f.person_id=p.id and f.agent_id=a.id and f.id=?";
		Map<String,Object> order = null ;
		List<Map<String,Object>> rList = null ;
		String jsonString = "";
		try{
			if(form_id!=0){
				order = dbHelper.getMap(sql,new Object[]{form_id}) ;
				if(order.size()>0){
					
					rList=dbHelper.getMapList(" select p.name as receive_man,s.flag as order_state,(case s.flag when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,CONVERT(varchar(100), s.record_date, 20) as receive_date from pro_order_state s ,pro_agent_personnel p where s.receive_man_id=p.id and s.parent_id=  ?  order by s.record_date desc,s.id desc",new Object[]{form_id});
					order.put("recordList", getFormatList(rList));
					
					jsonObject.put("success","true");
	                jsonObject.put("result",getUpperMap(order));  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result",""); 
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 业务员统计报表
	 * @param agent_id
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public String personReport(int agent_id, int pageNum,int pageSize){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();

		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}

		String sql="select top "+pageSize+" id as uid,name,phone,"+
				 " (select count(id) from pro_agent_products_form where person_id is not null and person_id !='' and   person_id=p.id and order_state='102002') as unHandleNum, "+
				 " (select count(id) from pro_agent_products_form where person_id is not null and person_id !='' and   person_id=p.id and order_state in ('102002','102003','102010','102004','102005','102006','102007')) as inTrackNum, "+
				 " (select count(id) from pro_agent_products_form where person_id is not null and person_id !='' and   person_id=p.id and order_state='102008') as dealNum, "+
				 " (select count(id) from pro_agent_products_form where person_id is not null and person_id !='' and   person_id=p.id and order_state='102009') as lossNum "+
				 " from pro_agent_personnel p where p.id not in (select top "+pageSize*(pageNum-1)+" id from pro_agent_personnel where agent_id=? order by p.id desc ) and p.agent_id=? order by p.id desc"; 
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id,agent_id}) ;
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result","");
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 区域列表
	 * @param agent_id
	 * @return
	 */
	public String provinceList(int agent_id){

		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String sql=" select city from pro_agent_factory where id=? ";
		Map agentMap=null;String[] cityStr=null;
		String jsonString = "";
		try{
			if(agent_id!=0){
				agentMap=dbHelper.getMap(sql,new Object[]{agent_id});
				if(agentMap!=null){
					if(CommonString.getFormatPara(agentMap.get("city")).equals("全国")){
						cityStr = new String[]{"安徽","北京","重庆","福建","甘肃","广东","广西","贵州","海南","河北","河南","黑龙江","湖北","湖南","江苏","江西","吉林","辽宁","内蒙古","宁夏","青海","上海","山东","山西","陕西","四川","天津","新疆","西藏","云南","浙江"};
					}else{
						cityStr=CommonString.getFormatPara(agentMap.get("city")).split(",");
					}
					
				}
				json = net.sf.json.JSONArray.fromObject(cityStr);
					jsonObject.put("success","true");
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  

			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 类别列表
	 * @param agent_id
	 * @return
	 */
	public String catalogList(int agent_id){

		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";
		
		String sql=" select DISTINCT pp.catalognum,pc.name from pro_agent_products pap,pro_products pp,pro_catalog pc where pap.product_id=pp.id and pp.catalognum=pc.num  and pap.agent_id=? order by pp.catalognum  ";
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		
		try{
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id}) ;
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result",""); 
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 同区域品牌前十饼图
	 * @param agent_id
	 * @param province 省id 必传值
	 * @param catalogNum 类别编号
	 * @param timeType 时间类型 近一周 week 近一月 month 近半年 half 近一年 year
	 * @return
	 */
	public String brandReport(String province,String catalogNum,String timeType){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";int total=0;String ts="";String te="";
		if("year".equals(timeType)){//年
			ts=getYesterday("",366);
			te=getYesterday("",0);
		}else if("month".equals(timeType)){//月
			ts=getYesterday("",31);
			te=getYesterday("",0);
		}else if("half".equals(timeType)){//半年
			ts=getYesterday("",181);
			te=getYesterday("",0);
		}else{//周
			ts=getYesterday("",7);
			te=getYesterday("",0);
		}
		System.out.println("ts:"+ts+";te:"+te);
		if(!"".equals(catalogNum)){
			whereStr +=" and catanum = '" + catalogNum + "' ";
		}
		if(!"".equals(ts)){
			whereStr +="  and add_date>='"+ts+" 00:00:00' ";
		}
		if(!"".equals(te)){
			whereStr +=" and add_date<='"+te+" 23:59:59' ";
		}
		String sql=" SELECT TOP 10 rtrim(ltrim(factoryname)) AS name,count(*) AS counts FROM  pro_product_form WHERE province = ?  "+whereStr+"  GROUP BY rtrim(ltrim(factoryname))  ORDER BY counts DESC "; 
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(!"".equals(province)){
				list = dbHelper.getMapList(sql,new Object[]{province}) ;
				if(list!=null&&list.size()>0){
					for(Map m:list){
						total +=CommonString.getFormatInt(m.get("counts"));
					}
				}
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
	                jsonObject.put("total", total);
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result","");
		            jsonObject.put("total", 0);
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
	            jsonObject.put("total", 0);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
            jsonObject.put("total", 0);
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 代理机型排名前十饼图
	 * @param agent_id 代理商id 必传值
	 * @param province
	 * @param catalogNum
	 * @param timeType 时间类型 近一周 week 近一月 month 近半年 half 近一年 year
	 * @return
	 */
	public String modelReport(int agent_id,String province,String catalogNum,String timeType){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String sql=""; String whereStr="";int total=0;String ts="";String te="";
		if("year".equals(timeType)){//年
			ts=getYesterday("",366);
			te=getYesterday("",0);
		}else if("month".equals(timeType)){//月
			ts=getYesterday("",31);
			te=getYesterday("",0);
		}else if("half".equals(timeType)){//半年
			ts=getYesterday("",181);
			te=getYesterday("",0);
		}else{//周
			ts=getYesterday("",7);
			te=getYesterday("",0);
		}
		System.out.println("ts:"+ts+";te:"+te);
		List<Map<String,Object>> list = null ;Map pMap=null;
		String jsonString = "";
		try{
			
			if(!"".equals(province)){
				whereStr +=" and f.province ='"+province+"' ";
			}
			if(!"".equals(catalogNum)){
				whereStr +=" and f.cata_num = '" + catalogNum + "' ";
			}
			if(!"".equals(ts)){
				whereStr +="  and f.add_date>='"+ts+" 00:00:00' ";
			}
			if(!"".equals(te)){
				whereStr +=" and f.add_date<='"+te+" 23:59:59' ";
			}
			sql=" select top 10 f.product_name as name,count(f.id) as counts from pro_agent_products_form f,pro_agent_factory a where f.agent_id=a.id and f.add_date >=a. order_start_time and f.add_date <=a.order_end_time  "+whereStr+"  and f.agent_id=? group by f.product_name order by count(f.id) desc  ";
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id}) ;
				if(list!=null&&list.size()>0){
					for(Map m:list){
						total +=CommonString.getFormatInt(m.get("counts"));
					}
				}
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
	                jsonObject.put("total", total);
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result","");
		            jsonObject.put("total", 0);
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
	            jsonObject.put("total", 0);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
            jsonObject.put("total", 0);
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 订单走势图
	 * @param agent_id
	 * @param province
	 * @param catalogNum
	 * @param timeType 时间类型 近一周 week 近一月 month 近半年 half 近一年 year
	 * @return
	 */
	public String orderReport(int agent_id,String province,String catalogNum,String timeType){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String sql="";String whereStr="";int total=0;String ts="";String te="";
		if("year".equals(timeType)){//年
			ts=getYesterday("",366);
			te=getYesterday("",0);
		}else if("month".equals(timeType)){//月
			ts=getYesterday("",31);
			te=getYesterday("",0);
		}else if("half".equals(timeType)){//半年
			ts=getYesterday("",181);
			te=getYesterday("",0);
		}else{//周
			ts=getYesterday("",7);
			te=getYesterday("",0);
		}
		System.out.println("ts:"+ts+";te:"+te);
		List<Map<String,Object>> list = null ;Map pMap=null;
		String jsonString = "";
		try{
			
			if(!"".equals(province)){
				whereStr +=" and f.province ='"+province+"' ";
			}
			if(!"".equals(catalogNum)){
				whereStr +=" and f.cata_num = '" + catalogNum + "' ";
			}
			if(!"".equals(ts)){
				whereStr +="  and f.add_date>='"+ts+" 00:00:00' ";
			}
			if(!"".equals(te)){
				whereStr +=" and f.add_date<='"+te+" 23:59:59' ";
			}
			if("week".equals(timeType)||"month".equals(timeType)){//近一周/近一月 统计日报表
				sql=" select datename(month,f.add_date)+'/'+datename(day,f.add_date)as name,count(f.id) as counts from pro_agent_products_form f,pro_agent_factory a where f.agent_id=a.id and f.add_date >=a.order_start_time and f.add_date <=a.order_end_time and f.agent_id=? "+whereStr+" group by datename(month,f.add_date)+'/'+datename(day,f.add_date) order by datename(month,f.add_date)+'/'+datename(day,f.add_date) ";
			}else{//近半年/近一年 统计月报表
				sql=" select datename(year,f.add_date)+'/'+datename(month,f.add_date)as name,count(f.id) as counts from pro_agent_products_form f,pro_agent_factory a where f.agent_id=a.id and f.add_date >=a.order_start_time and f.add_date <=a.order_end_time and f.agent_id=?  "+whereStr+" group by datename(year,f.add_date)+'/'+datename(month,f.add_date) order by datename(year,f.add_date)+'/'+datename(month,f.add_date) ";
			}
			
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id}) ;
				if(list!=null&&list.size()>0){
					for(Map m:list){
						total +=CommonString.getFormatInt(m.get("counts"));
					}
				}
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
	                jsonObject.put("total", total);
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result","");
		            jsonObject.put("total", 0);
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
	            jsonObject.put("total", 0);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
            jsonObject.put("total", 0);
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 星标列表
	 * @param agent_id
	 * @param trackState
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public String taggedList(int agent_id,String trackState, String province, int pageNum,int pageSize){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";
		whereStr += " and f.isTagged=1  ";//and f.order_state in ('102002','102003','102010','102004','102005','102006','102007')
		if(!"".equals(trackState)&&trackState!=null){//跟踪状态
			whereStr += " and f.order_state = '"+trackState+"' ";
		}
		if(!"".equals(province)&&province!=null){//
			whereStr += " and f.province like '%"+province+"%' ";
		}
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}

		String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,ISNULL(p.name,'') as receive_man,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged "+
				   " from  pro_agent_products_form f ,pro_agent_personnel p,pro_products pro "+
				   " where f.person_id is not null and f.person_id !='' and f.person_id=p.id and f.product_id=pro.id and f.agent_id=?  "+whereStr+
				   " and f.id not in ( select top "+pageSize*(pageNum-1)+"  f.id from pro_agent_products_form f ,pro_agent_personnel p,pro_products pro where f.person_id is not null and f.person_id !='' and f.person_id=p.id and f.product_id=pro.id and f.agent_id=?  "+whereStr+" order by f.id desc ) "+
				   " order by f.id desc ";// 
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(agent_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{agent_id,agent_id}) ;
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result","");
				}
			}else{
				jsonObject.put("success","true");         
	            jsonObject.put("result",""); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");         
            jsonObject.put("result",""); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}


}

