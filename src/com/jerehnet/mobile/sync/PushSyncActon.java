package com.jerehnet.mobile.sync;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import net.sf.json.JSONArray;

import com.alibaba.fastjson.JSONObject;
import com.jerehnet.mobile.entity.EOrder;
import com.jerehnet.mobile.utils.PushService;

import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.common.Env;
import com.jerehnet.util.dbutil.DBHelper;

public class PushSyncActon extends BaseSyncActon {
	/**
	 * 消息推送订单(自动)
	 * @return
	 */
	public boolean pushMessage(int flag,String orderNo,String machineNo,String machineImg,String createDate,String linkMan,String linkTel,
			String address,String receiveMan,int receiveManId,int agentId,String username)
	{
		try{
			DBHelper dbHelper = DBHelper.getInstance();
			
			int sid = CommonString.getFormatInt(Env.getInstance().getProperty("platform_id"));
			/*主键生成方法*/
			String sql="select count(*) as num from wcm_common_apn_order";
			List<Map<String,Object>> list = null ; 
			list = dbHelper.getMapList(sql) ;
			
			int id=CommonString.getFormatInt(list.get(0).get("num"))+1;
			
			EOrder order = new EOrder();
			
			// 保存数据
			String insert = "INSERT INTO [wcm_common_apn_order]([id],[flag],[order_no],[machine_no],[machine_img],[create_date],[link_man],[link_tel],[address],[receive_man],[receive_man_id],[agent_id])VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			int keyId = dbHelper.executeUpdate(insert,new Object[]{id,flag,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId});
			//order.setId(CommonString.getFormatInt(keyId));//TODO 订单编号
	
			if(keyId==0)
			{
				//组装消息数据
				//order.setId(id);
				order.setId("123");
				order.setFlag(flag);//TODO 订单状态
				order.setOrderNo(orderNo);//TODO 订单编号（手机显示）
				order.setMachineNo(machineNo);//TODO 机型编号
				order.setMachineImg(machineImg);//TODO 图片地址
				order.setCreateDate(createDate);//TODO 订单创建时间
				order.setLinkMan(linkMan);//TODO 联系人
				order.setLinkTel(linkTel);//TODO 联系方式
				order.setAddress(address);//TODO 地址
				order.setReceiveMan(receiveMan);//TODO 订单接收人
				order.setReceiveManId("123");//TODO 订单接受人编号
				order.setAgentId(agentId);//TODO 代理商或厂家编号
				
				//推送收件人信息组装
				StringBuffer receiveUserName = new StringBuffer();
				receiveUserName.append(sid);
				receiveUserName.append("_");
				receiveUserName.append(order.getReceiveMan());

				
				JSONArray json = JSONArray.fromObject(order);  
				System.out.println("json:"+json.getJSONObject(0).toString());
				//PushService.pushMessage(JSONObject.toJSONString(order),receiveUserName.toString(),"",order.getMachineNo());
				PushService.pushMessage(json.getJSONObject(0).toString(),username,"",order.getMachineNo());
			}
			
			//	开始推送，把实体转换成JSON数据
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//关闭链接
		}	
		return true;
	}
}
