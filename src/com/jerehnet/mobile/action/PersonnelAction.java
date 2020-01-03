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
public class PersonnelAction  extends BaseSyncActon{
	Connection connection = null; 
	DBHelper dbHelper = DBHelper.getInstance();  
	JSONObject jsonObject = new JSONObject();
	/**
	 * 业务员登录
	 * @param usern
	 * @param pwd
	 * @return
	 */
	public String login(String usern,String pwd){
		String sql=" select id as uid,usern,name as full_name,'personnel_login' as type ,city_num,city"+
		" from pro_agent_personnel p where usern=? and password=? ";
		Map<String,Object> user = null ;
		try{
			user = dbHelper.getMap(sql,new Object[]{usern,pwd}) ;
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
	 * 业务员 绑定微信openID
	 * @param uid
	 * @return
	 */
	public String bindWXID(int uid,String openId){
		int id=0;
		try{
			Map user=dbHelper.getMap(" select open_id from pro_agent_personnel where id=?  ",new Object[]{uid});
			if(user!=null){
				if("".equals(CommonString.getFormatPara(user.get("open_id")))){
					if(!"".equals(openId)){
						id=dbHelper.execute(" update pro_agent_personnel set open_id=? where id=? ", new Object[]{openId,uid});
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
	 * 业务员  状态统计数
	 * @param agent_id
	 * @return
	 */
	public String getCountNum(int person_id){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		Map unHandleMap=null;Map inTrackMap=null;Map dealMap=null;Map lossMap=null;Map markMap=null;Map province=null;
		try{
			if(person_id!=0){
				unHandleMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id  where f.person_id=? and f.order_state=102001 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time ",new Object[]{person_id});
				inTrackMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id  where f.person_id=? and f.order_state in ('102002','102003','102010','102004','102005','102006','102007') and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  ",new Object[]{person_id});
				dealMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id  where f.person_id=? and f.order_state=102008 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  ",new Object[]{person_id});
				lossMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id  where f.person_id=? and f.order_state=102009 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  ",new Object[]{person_id});
				markMap = dbHelper.getMap(" select count(f.id) as num from pro_agent_products_form f left join pro_agent_factory b on f.agent_id=b.id  where f.person_id=? and f.isTagged=1 and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time   ",new Object[]{person_id});
				province=dbHelper.getMap(" select province from pro_agent_personnel where id=? ",new Object[]{person_id});
				
				jsonObject.put("success","true");
	          	jsonObject.put("unHandleNum",CommonString.getFormatInt(CommonString.getFormatPara(unHandleMap.get("num")))); 
	          	jsonObject.put("inTrackNum",CommonString.getFormatInt(CommonString.getFormatPara(inTrackMap.get("num")))); 
	          	jsonObject.put("dealNum",CommonString.getFormatInt(CommonString.getFormatPara(dealMap.get("num")))); 
	          	jsonObject.put("lossNum",CommonString.getFormatInt(CommonString.getFormatPara(lossMap.get("num"))));
				jsonObject.put("markNum",CommonString.getFormatInt(CommonString.getFormatPara(markMap.get("num"))));
				jsonObject.put("provinceNum", CommonString.getFormatPara(province.get("province")).split(",").length);
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
	 * 业务员 订单列表
	 * @param person_id 业务员id
	 * @param orderState  订单状态
	 * @param trackState  跟踪状态
	 * @param lostReason  流失原因
	 * @param pageNum	当前页
	 * @param pageSize	分页条数
	 * @return
	 */
	public String orderList(int person_id,String orderState,String trackState,String province,String lostReason, int pageNum,int pageSize){
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
		
		if(!"".equals(province)&&province!=null){//
			whereStr += " and f.province like '%"+province+"%' ";
		}
		
		if(pageNum==0){
			pageNum=1;
		}
		if(pageSize==0){
			pageSize=10;
		}

		//String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged"+
		//		   " from  pro_agent_products_form f ,pro_agent_personnel p,pro_products pro "+
		//		   " where f.person_id=p.id and f.product_id=pro.id and f.person_id=?  "+whereStr+
		//		   " and f.id not in ( select top "+pageSize*(pageNum-1)+"  f.id from pro_agent_products_form f ,pro_agent_personnel p,pro_products pro where f.person_id=p.id and f.product_id=pro.id and f.person_id=?  "+whereStr+orderStr+"  ) "+orderStr;// 
		
		String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged "+
		" from  pro_agent_products_form f  "+
		" left join pro_agent_personnel p on f.person_id=p.id  "+
		" left join pro_products pro on f.product_id=pro.id  "+
		" left join pro_agent_factory b on f.agent_id=b.id "+
		"  where f.person_id=p.id and f.product_id=pro.id and f.person_id=?  "+
		" and f.add_date >=b.order_start_time and f.add_date<=b.order_end_time  "+whereStr+
		" and f.id not in (select top "+pageSize*(pageNum-1)+" f.id from pro_agent_products_form f left join pro_agent_personnel p on f.person_id=p.id left join pro_products pro on f.product_id=pro.id left join pro_agent_factory b on f.agent_id=b.id where f.person_id=p.id and f.product_id=pro.id and f.person_id=? and f.add_date>=b.order_start_time and f.add_date<=b.order_end_time "+whereStr+orderStr+" ) "+orderStr;
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(person_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{person_id,person_id}) ;
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
	 * 业务员 订单修改                                                                                            
	 * @param form_id
	 * @param orderState 订单状态（编号）
	 * @param lostReason 流失原因(订单状态选择流失)
	 * @param brand 成交品牌（流失原因选择成交竞品）
	 * @param appRemark  备注
	 * @return
	 */
	public String orderEdit(int form_id,String orderState,String lostReason,String brand,String appRemark){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		Boolean isUpdateState=false;
		String paramStr="";
		if(orderState==null||"".equals(orderState)){
			orderState="102001";
		}
		String sql="select f.id as order_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,CONVERT(varchar(100), f.form_date, 20) create_date,(factory_name+cata_name+product_name) as order_title, f.user_name as order_user,f.contact_address,f.contact_tel,f.order_state,ISNULL ( f.app_remark , '') as app_remark,f.person_id,ISNULL(p.name,'') as receive_man ,CONVERT(varchar(100), f.last_record_date, 20) as last_record_date"+
				   " from pro_agent_products_form f,pro_agent_personnel p "+
		 	       " where f.person_id=p.id and f.id=?";
		List<Map<String,Object>> list = null ;Map stateMap = null;Map formMap=null;
		String jsonString = "";
		int updateRs=0;int insertRs=0;
		try{
			if(form_id!=0){
				formMap=dbHelper.getMap(sql,new Object[]{form_id});
				stateMap=dbHelper.getMap(" select order_state from pro_agent_products_form where id=? ",new Object[]{form_id});
				if(!orderState.equals(CommonString.getFormatPara(stateMap.get("order_state")))){//判断是否修改订单状态，修改订单状态需要记录pro_order_state
					isUpdateState=true;
				}
				if(isUpdateState){
					paramStr +=" ,last_record_date=getDate() ";
				}
				if("102009".equals(orderState)&&!"".equals(lostReason)&lostReason!=null){//订单状态选择流失的，更新流失原因
					paramStr +=" ,run_off_flag='"+lostReason+"' ";
				}
				if("103001".equals(lostReason)&&!"".equals(brand)&lostReason!=null){//流失原因选择成交竞品的，更新成交品牌
					paramStr +=" ,brand='"+brand+"' ";
				}
				String updateSql=" update pro_agent_products_form set order_state=? ,app_remark=? "+paramStr+" where id=? ";
				updateRs=dbHelper.execute(updateSql,new Object[]{orderState,appRemark,form_id});
				String insertSql=" insert into pro_order_state (flag,record_date,parent_id,receive_man_id) values (?,getDate(),?,?)  ";
				if(isUpdateState){//确认状态更新后执行插入
					insertRs=dbHelper.execute(insertSql,new Object[]{orderState,form_id,CommonString.getFormatInt(CommonString.getFormatPara(formMap.get("person_id")))});
				}

				if(updateRs>0){
					jsonObject.put("success","true");
	          	  	jsonObject.put("msg","订单更新成功"); 
					 
				}else{
					jsonObject.put("success","true");
	          	  	jsonObject.put("msg","订单更新失败");          
				}
			}else{
				jsonObject.put("success","true");
	      	  	jsonObject.put("msg","订单更新失败");          
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
      	  	jsonObject.put("msg","订单更新失败");          
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 确认接收订单操作
	 * @param form_id 订单id
	 * @return
	 */
	public String receiveOrder(int form_id){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String sql="select f.id as order_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,CONVERT(varchar(100), f.form_date, 20) create_date,(factory_name+cata_name+product_name) as order_title, f.user_name as order_user,f.contact_address,f.contact_tel,f.order_state,ISNULL ( f.app_remark , '') as app_remark,f.person_id,p.name as receive_man ,CONVERT(varchar(100), f.last_record_date, 20) as last_record_date"+
		   " from pro_agent_products_form f,pro_agent_personnel p "+
	       " where f.person_id=p.id and f.id=?";
		String updateSql=" update pro_agent_products_form set order_state='102002',last_record_date=getDate()  where order_state='102001' and id=? ";
		String insertSql=" insert into pro_order_state (flag,record_date,parent_id,receive_man_id) values (?,getDate(),?,?) ";
		List<Map<String,Object>> list = null ;Map formMap=null;
		String jsonString = "";
		int updateRs=0;int insertRs=0;
		try{
			if(form_id!=0){
				formMap=dbHelper.getMap(sql,new Object[]{form_id});
				updateRs=dbHelper.execute(updateSql,new Object[]{form_id});
				if(updateRs>0){//更新成功后执行插入
					insertRs=dbHelper.execute(insertSql,new Object[]{"102002",form_id,CommonString.getFormatPara(formMap.get("person_id"))});
				}
				if(updateRs>0&&insertRs>0){
					jsonObject.put("success","true");
					jsonObject.put("data","true");
	          	  	jsonObject.put("msg","您的订单接收成功!"); 
				}else{
					jsonObject.put("success","true");
					jsonObject.put("data","false");
	          	  	jsonObject.put("msg","您的订单接收失败!");           
				}
			}else{
				jsonObject.put("success","true");
				jsonObject.put("data","false");
          	  	jsonObject.put("msg","您的订单接收失败!");           
			}
			

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("data","false");
      	  	jsonObject.put("msg","您的订单接收失败!");           
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 标记星标
	 * @param form_id
	 * @return
	 */
	public String doTag(int form_id){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String updateSql=" update pro_agent_products_form set isTagged=1 where isTagged=0 and id=? ";
		String jsonString = "";
		int updateRs=0;
		try{
			if(form_id!=0){
				updateRs=dbHelper.execute(updateSql,new Object[]{form_id});

				if(updateRs>0){
					jsonObject.put("success","true");
					jsonObject.put("data","true");
	          	  	jsonObject.put("msg","订单已标记星标！"); 
				}else{
					jsonObject.put("success","true");
					jsonObject.put("data","false");
	          	  	jsonObject.put("msg","订单标记星标失败！");           
				}
			}else{
				jsonObject.put("success","true");
				jsonObject.put("data","false");
          	  	jsonObject.put("msg","订单标记星标失败！");           
			}
			

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("data","false");
      	  	jsonObject.put("msg","订单标记星标失败！");           
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 取消星标
	 * @param form_id
	 * @return
	 */
	public String cancelTag(int form_id){
		net.sf.json.JSONArray json = new net.sf.json.JSONArray();
		String updateSql=" update pro_agent_products_form set isTagged=0 where isTagged=1 and id=? ";
		String jsonString = "";
		int updateRs=0;
		try{
			if(form_id!=0){
				updateRs=dbHelper.execute(updateSql,new Object[]{form_id});

				if(updateRs>0){
					jsonObject.put("success","true");
					jsonObject.put("data","true");
	          	  	jsonObject.put("msg","订单已取消标记星标！"); 
				}else{
					jsonObject.put("success","true");
					jsonObject.put("data","false");
	          	  	jsonObject.put("msg","订单取消标记星标失败！");           
				}
			}else{
				jsonObject.put("success","true");
				jsonObject.put("data","false");
          	  	jsonObject.put("msg","订单取消标记星标失败！");           
			}
			

		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("success","false");
			jsonObject.put("data","false");
      	  	jsonObject.put("msg","订单取消标记星标失败！");           
		}finally{ 
			DBHelper.freeConnection(connection); 
		} 
		
		return jsonObject.toString();
	}
	
	/**
	 * 星标列表
	 * @param person_id
	 * @param trackState
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public String taggedList(int person_id,String trackState, String province, int pageNum,int pageSize){
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

		String sql=" select top "+pageSize+" f.id as order_id,f.agent_id,(convert(varchar(100),f.id)+CONVERT(varchar(100),f.add_date, 112)) as order_no,f.order_state,(case f.order_state when 102001 then '确认接收'  when 102002 then '已接收'  when 102003 then '初次见面'  when 102004 then '确认意向'  when 102005 then '明确购机需求'  when 102006 then '形成共识，交付押金'  when 102007 then '签订购机合同'  when 102008 then '成交'  when 102009 then '流失'  when 102010 then '沟通中'    end) as order_statename,(f.factory_name+f.cata_name+f.product_name) as order_title,pro.img2 proImg,f.user_name as order_user,CONVERT(varchar(100), form_date, 20) as create_date,f.contact_address,f.contact_tel,CONVERT(varchar(100), f.last_record_date, 20) as record_date,f.isTagged"+
				   " from  pro_agent_products_form f ,pro_agent_personnel p,pro_products pro "+
				   " where f.person_id=p.id and f.product_id=pro.id and f.person_id=?  "+whereStr+
				   " and f.id not in ( select top "+pageSize*(pageNum-1)+"  f.id from pro_agent_products_form f ,pro_agent_personnel p,pro_products pro where f.person_id=p.id and f.product_id=pro.id and f.person_id=? "+whereStr+" order by f.id desc ) "+
				   " order by f.id desc ";// 
		List<Map<String,Object>> list = null ;
		String jsonString = "";
		try{
			if(person_id!=0){
				list = dbHelper.getMapList(sql,new Object[]{person_id,person_id}) ;
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
		String sql=" select province from pro_agent_personnel where id=? ";
		Map personnelMap=null;String[] ProvinceStr=null;
		String jsonString = "";
		try{
			if(agent_id!=0){
				personnelMap=dbHelper.getMap(sql,new Object[]{agent_id});
				if(personnelMap!=null){
					if(CommonString.getFormatPara(personnelMap.get("province")).equals("全国")){
						ProvinceStr = new String[]{"安徽","北京","重庆","福建","甘肃","广东","广西","贵州","海南","河北","河南","黑龙江","湖北","湖南","江苏","江西","吉林","辽宁","内蒙古","宁夏","青海","上海","山东","山西","陕西","四川","天津","新疆","西藏","云南","浙江"};
					}else{
						ProvinceStr=CommonString.getFormatPara(personnelMap.get("province")).split(",");
					}
					
				}
				json = net.sf.json.JSONArray.fromObject(ProvinceStr);
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
	

}
