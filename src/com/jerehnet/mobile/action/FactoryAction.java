package com.jerehnet.mobile.action;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.jerehnet.mobile.sync.BaseSyncActon;
import com.jerehnet.util.common.CommonDate;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;
public class FactoryAction  extends BaseSyncActon{
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();  
	JSONObject jsonObject = new JSONObject();
	/**
	 * 厂商登录
	 * @param usern
	 * @param pwd
	 * @return
	 */
	public String login(String usern,String pwd){
		String sql=" select id as uid,usern,full_name,'factory_login' as type,city_num,city "+
		" from pro_agent_factory f where flag=1  and  usern=? and passw_bak=? and order_end_time >= ?  ";
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
	 * 厂商 绑定微信openID
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
	 * 厂商  状态统计数
	 * @param agent_id
	 * @return
	 */
	public String getCountNum(int factory_id){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		Map unHandleMap=null;Map inTrackMap=null;Map dealMap=null;Map lossMap=null;Map markMap=null;
		try{
			if(factory_id!=0){
				unHandleMap = dbHelper.getMap(" select count(id) as num from pro_agent_products_form where person_id is not null and person_id !='' and   factory_id=? and order_state=102001 ",new Object[]{factory_id});
				inTrackMap = dbHelper.getMap(" select count(id) as num from pro_agent_products_form where person_id is not null and person_id !='' and   factory_id=? and order_state in ('102002','102003','102010','102004','102005','102006','102007')  ",new Object[]{factory_id});
				dealMap = dbHelper.getMap(" select count(id) as num from pro_agent_products_form where person_id is not null and person_id !='' and   factory_id=? and order_state=102008 ",new Object[]{factory_id});
				lossMap = dbHelper.getMap(" select count(id) as num from pro_agent_products_form where person_id is not null and person_id !='' and   factory_id=? and order_state=102009 ",new Object[]{factory_id});
				markMap = dbHelper.getMap(" select count(id) as num from pro_agent_products_form where person_id is not null and person_id !='' and   factory_id=? and isTagged=1  ",new Object[]{factory_id});
				
				jsonObject.put("success","true");
	          	jsonObject.put("unHandleNum",CommonString.getFormatInt(CommonString.getFormatPara(unHandleMap.get("num")))); 
	          	jsonObject.put("inTrackNum",CommonString.getFormatInt(CommonString.getFormatPara(inTrackMap.get("num")))); 
	          	jsonObject.put("dealNum",CommonString.getFormatInt(CommonString.getFormatPara(dealMap.get("num")))); 
	          	jsonObject.put("lossNum",CommonString.getFormatInt(CommonString.getFormatPara(lossMap.get("num"))));
				jsonObject.put("markNum",CommonString.getFormatInt(CommonString.getFormatPara(markMap.get("num"))));
			}else{
				jsonObject.put("success","true");
				jsonObject.put("unHandleNum",0); 
	          	jsonObject.put("inTrackNum",0); 
	          	jsonObject.put("dealNum",0); 
	          	jsonObject.put("lossNum",0); 
				jsonObject.put("markNum",0); 
			}
			

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("unHandleNum",0); 
          	jsonObject.put("inTrackNum",0); 
          	jsonObject.put("dealNum",0); 
          	jsonObject.put("lossNum",0); 
			jsonObject.put("markNum",0); 
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 厂商 代理列表
	 * @param factory_id 厂商id
	 * @param searchStr	查询条件
	 * @return
	 */
	public String agentList(int factory_id,String searchStr, int pageNum,int pageSize){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";
		if(!"".equals(searchStr)&&searchStr!=null){
			whereStr += " and (name like '%"+searchStr+"%' or telphone like '%"+searchStr+"%') ";
		}
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}
		String sql=" select top "+pageSize+"  id as uid,usern,name as uname,telphone as phone,city from pro_agent_factory where flag=2 and (agent_fac like '%,"+factory_id+",%' or agent_fac like '%"+factory_id+",%' or agent_fac like '%,"+factory_id+"%' or agent_fac='"+factory_id+"') "+whereStr+" and id not in ( select top "+pageSize*(pageNum-1)+" id from pro_agent_factory where flag=2 and (agent_fac like '%,"+factory_id+",%' or agent_fac like '%"+factory_id+",%' or agent_fac like '%,"+factory_id+"%' or agent_fac='"+factory_id+"') "+whereStr+" order by id desc ) order by id desc ";
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(factory_id!=0){
				list = dbHelper.getMapList(sql) ;
				if(list.size()>0){
					jsonObject.put("success","true");
	          	    json.addAll(getFormatList(list));
	                jsonString = json.toString();           
	                jsonObject.put("result",jsonString);  
				}else{
					jsonObject.put("success","true");         
		            jsonObject.put("result",""); 
				}
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
	 * 厂商 订单列表
	 * @param factory_id
	 * @param ywid  代理商id
	 * @param orderState 订单状态
	 * @param trackState  跟踪状态
	 * @param lostReason  流失原因
	 * @param pageNum  当前页
	 * @param pageSize  分页数
	 * @return
	 */
	public String orderList(int factory_id,int ywid,String orderState,String trackState,String lostReason, int pageNum,int pageSize){
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
		if(ywid!=0){//代理商查询
			whereStr += " and f.agent_id="+ywid;
		}
		
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}

		String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,ISNULL(a.name,'') as receive_man,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged "+
				   " from  pro_agent_products_form f ,pro_agent_factory a,pro_products pro "+
				   " where f.agent_id=a.id and f.product_id=pro.id and f.factory_id=?  "+whereStr+
				   " and f.id not in ( select top "+pageSize*(pageNum-1)+"  f.id from pro_agent_products_form f ,pro_agent_factory a,pro_products pro where f.agent_id=a.id and f.product_id=pro.id and f.factory_id=?  "+whereStr+orderStr+"  ) "+orderStr;// 
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(factory_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{factory_id,factory_id}) ;
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
	 * 星标列表
	 * @param factory_id
	 * @param trackState
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public String taggedList(int factory_id,String trackState, int pageNum,int pageSize){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String whereStr="";
		whereStr += " and f.isTagged=1  ";//and f.order_state in ('102002','102003','102010','102004','102005','102006','102007')
		if(!"".equals(trackState)&&trackState!=null){//跟踪状态
			whereStr += " and f.order_state = '"+trackState+"' ";
		}
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}

		String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,ISNULL(a.name,'') as receive_man,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged "+
				   " from  pro_agent_products_form f ,pro_agent_factory a,pro_products pro "+
				   " where f.agent_id=a.id and f.product_id=pro.id and f.factory_id=?  "+whereStr+
				   " and f.id not in ( select top "+pageSize*(pageNum-1)+"  f.id from pro_agent_products_form f ,pro_agent_factory a,pro_products pro where f.agent_id=a.id and f.product_id=pro.id and f.factory_id=?  "+whereStr+" order by f.id desc ) "+
				   " order by f.id desc ";// 
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(factory_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{factory_id,factory_id}) ;
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
