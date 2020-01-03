<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="com.jerehnet.mobile.action.*" %>
<%@page import="com.jerehnet.util.dbutil.*" %>
<%@page import="java.sql.*" %>
<%@page import="net.sf.json.*" %>
<%
	AgentAction agentAction=new AgentAction();
	FactoryAction factoryAction=new FactoryAction();
	PersonnelAction personnelAction=new PersonnelAction();
	//UmengAction umengAction=new UmengAction();
	AppVersionAction  appVersionAction=new AppVersionAction();
	CommonAction comAc=new CommonAction();
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String resultStr="";
	String flag = CommonString.getFormatPara(request.getParameter("flag"));	
	//------------------------------代理商（开始）------------------------------
	//代理商 登录
    if("agent_login".equals(flag)){
		String usern = CommonString.getFormatPara(request.getParameter("usern")); 
		String pwd = CommonString.getFormatPara(request.getParameter("pwd")); 
		resultStr=agentAction.login(usern,pwd);
		out.println(resultStr);
	}
	//代理商 微信登录绑定openID
    if("agent_bind_wxid".equals(flag)){
		int uid=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid")));
		String openId=CommonString.getFormatPara(session.getAttribute("wx_id"));
		resultStr=agentAction.bindWXID(uid,openId);
		out.println(resultStr);
	}
	//代理商 状态统计数
    if("agent_stateNum".equals(flag)){
    	int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		resultStr=agentAction.getCountNum(agent_id);
		out.println(resultStr);
	}
    //代理商 业务员列表
    if("agent_person_list".equals(flag)){
		int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		String searchStr=CommonString.getFormatPara(request.getParameter("searchStr"));
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		resultStr=agentAction.personList(agent_id,searchStr,pageNum,pageSize);
		out.println(resultStr);
	}
    //代理商 订单列表
    if("agent_order_list".equals(flag)){
		int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int ywid =  CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("ywid")));
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		String orderState = CommonString.getFormatPara(request.getParameter("orderState"));
		String trackState = CommonString.getFormatPara(request.getParameter("trackState"));
		String province = CommonString.getFormatPara(request.getParameter("province"));
		String lostReason = CommonString.getFormatPara(request.getParameter("lostReason"));
		resultStr=agentAction.orderList(agent_id,ywid,orderState,trackState,province,lostReason,pageNum,pageSize);
		out.println(resultStr);
	}
    
    //代理商 订单详细页
    if("order_detail".equals(flag)){
		int form_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("form_id"))); 
		resultStr=agentAction.orderInfo(form_id);
		out.println(resultStr);
	}
    
    
    //统计报表---开始---
    //代理商 业务员统计
    if("agent_person_report".equals(flag)){
		int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		resultStr=agentAction.personReport(agent_id,pageNum,pageSize);
		out.println(resultStr);
	}
    //代理商 代理区域列表
    if("agent_province_list".equals(flag)){
		int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		resultStr=agentAction.provinceList(agent_id);
		out.println(resultStr);
	}
    
    //代理商 代理机型列表
    if("agent_catalog_list".equals(flag)){
		int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		resultStr=agentAction.catalogList(agent_id);
		out.println(resultStr);
	}
    
    //同区域品牌前十饼图
    if("agent_brand_report".equals(flag)){
    	String province=CommonString.getFormatPara(request.getParameter("province"));
		String catalogNum=CommonString.getFormatPara(request.getParameter("catalogNum"));
		String timeType=CommonString.getFormatPara(request.getParameter("timeType"));
		resultStr=agentAction.brandReport(province,catalogNum,timeType);
		out.println(resultStr);
	}
  	//代理机型前十饼图
    if("agent_catalog_report".equals(flag)){
    	int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
    	String province=CommonString.getFormatPara(request.getParameter("province"));
		String catalogNum=CommonString.getFormatPara(request.getParameter("catalogNum"));
		String timeType=CommonString.getFormatPara(request.getParameter("timeType"));
		resultStr=agentAction.modelReport(agent_id,province,catalogNum,timeType);
		out.println(resultStr);
	}
  	
    //订单走势图
    if("agent_order_report".equals(flag)){
    	int agent_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
    	String province=CommonString.getFormatPara(request.getParameter("province"));
		String catalogNum=CommonString.getFormatPara(request.getParameter("catalogNum"));
		String timeType=CommonString.getFormatPara(request.getParameter("timeType"));
		resultStr=agentAction.orderReport(agent_id,province,catalogNum,timeType);
		out.println(resultStr);
	}
    
  //星标列表
    if("agent_tagged_list".equals(flag)){
		int factory_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		String trackState = CommonString.getFormatPara(request.getParameter("trackState"));
		String province = CommonString.getFormatPara(request.getParameter("province"));
		resultStr=agentAction.taggedList(factory_id,trackState,province,pageNum,pageSize);
		out.println(resultStr);
	}
    
    //统计报表---结束---
    
    //------------------------------代理商（结束）------------------------------
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~厂商（开始）~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  	//厂商 登录
    if("factory_login".equals(flag)){
		String usern = CommonString.getFormatPara(request.getParameter("usern")); 
		String pwd = CommonString.getFormatPara(request.getParameter("pwd")); 
		resultStr=factoryAction.login(usern,pwd);
		out.println(resultStr);
	}
  	//厂商 微信登录绑定openID
    if("factory_bind_wxid".equals(flag)){
    	int uid=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid")));
		String openId=CommonString.getFormatPara(session.getAttribute("wx_id"));
		resultStr=factoryAction.bindWXID(uid,openId);
		out.println(resultStr);
	}
    
    //厂商 状态统计数
    if("factory_stateNum".equals(flag)){
    	int factory_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		resultStr=factoryAction.getCountNum(factory_id);
		out.println(resultStr);
	}
    
    //厂商 代理列表
    if("factory_agent_list".equals(flag)){
    	int factory_id=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid")));
    	String searchStr=CommonString.getFormatPara(request.getParameter("searchStr"));
    	int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
    	resultStr=factoryAction.agentList(factory_id,searchStr,pageNum,pageSize);
		out.println(resultStr);
    }
    
    //厂商 订单列表
    if("factory_order_list".equals(flag)){
		int factory_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int ywid =  CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("ywid")));
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		String orderState = CommonString.getFormatPara(request.getParameter("orderState"));
		String trackState = CommonString.getFormatPara(request.getParameter("trackState"));
		String lostReason = CommonString.getFormatPara(request.getParameter("lostReason"));
		resultStr=factoryAction.orderList(factory_id,ywid,orderState,trackState,lostReason,pageNum,pageSize);
		out.println(resultStr);
	}
    
    //星标列表
    if("factory_tagged_list".equals(flag)){
		int factory_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		String trackState = CommonString.getFormatPara(request.getParameter("trackState"));
		resultStr=factoryAction.taggedList(factory_id,trackState,pageNum,pageSize);
		out.println(resultStr);
	}
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~厂商（结束）~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    
    
    //*******************************************业务员（开始）*******************************************
  	//业务员 登录
    if("personnel_login".equals(flag)){
		String usern = CommonString.getFormatPara(request.getParameter("usern")); 
		String pwd = CommonString.getFormatPara(request.getParameter("pwd")); 
		resultStr=personnelAction.login(usern,pwd);
		out.println(resultStr);
	}
    
  	//业务员 微信登录绑定openID
    if("personnel_bind_wxid".equals(flag)){
    	int uid=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid")));
		String openId=CommonString.getFormatPara(session.getAttribute("wx_id"));
		resultStr=personnelAction.bindWXID(uid,openId);
		out.println(resultStr);
	}
    
    //业务员 状态统计数
    if("personnel_stateNum".equals(flag)){
    	int person_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		resultStr=personnelAction.getCountNum(person_id);
		out.println(resultStr);
	}
    
  //业务员 负责区域列表
    if("personnel_province_list".equals(flag)){
		int person_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		resultStr=personnelAction.provinceList(person_id);
		out.println(resultStr);
	}
    
    //业务员 订单列表
    if("personnel_order_list".equals(flag)){
		int factory_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		String orderState = CommonString.getFormatPara(request.getParameter("orderState"));
		String trackState = CommonString.getFormatPara(request.getParameter("trackState"));
		String province = CommonString.getFormatPara(request.getParameter("province"));
		String lostReason = CommonString.getFormatPara(request.getParameter("lostReason"));
		resultStr=personnelAction.orderList(factory_id,orderState,trackState,province,lostReason,pageNum,pageSize);
		out.println(resultStr);
	}
    
    //业务员 订单修改
    if("personnel_order_detail".equals(flag)){
		int form_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("form_id"))); 
		String orderState=CommonString.getFormatPara(request.getParameter("orderState"));
		String lostReason = CommonString.getFormatPara(request.getParameter("lostReason"));
		String brand = CommonString.getFormatPara(request.getParameter("brand"));
		String appRemark=CommonString.getFormatPara(request.getParameter("appRemark"));
		resultStr=personnelAction.orderEdit(form_id,orderState,lostReason,brand,appRemark);
		out.println(resultStr);
	}
    
  	//业务员 确认接收订单操作
    if("personnel_order_receive".equals(flag)){
		int form_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("form_id"))); 
		resultStr=personnelAction.receiveOrder(form_id);
		out.println(resultStr);
	}
  	//标记星标
    if("personnel_doTag".equals(flag)){
		int form_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("form_id"))); 
		resultStr=personnelAction.doTag(form_id);
		out.println(resultStr);
	}
  	//取消星标
    if("personnel_cancelTag".equals(flag)){
		int form_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("form_id"))); 
		resultStr=personnelAction.cancelTag(form_id);
		out.println(resultStr);
	}
  	//星标列表
    if("personnel_tagged_list".equals(flag)){
		int factory_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("uid"))); 
		int pageNum = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageNum"))); 
		int pageSize = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("pageSize"))); 
		String trackState = CommonString.getFormatPara(request.getParameter("trackState"));
		String province = CommonString.getFormatPara(request.getParameter("province"));
		resultStr=personnelAction.taggedList(factory_id,trackState,province,pageNum,pageSize);
		out.println(resultStr);
	}
  	
    //*******************************************业务员（结束）*******************************************
    
    
    //ios消息推送 单播模式
    //if("ios_unicast".equals(flag)){ 
	//	String deviceToken = CommonString.getFormatPara(request.getParameter("deviceToken"));
	//	umengAction.sendIOSUnicast(deviceToken);	
	//}
	
    //ios消息推送 alias
    //if("ios_customizedcast".equals(flag)){
    //	String alias = CommonString.getFormatPara(request.getParameter("alias"));
    //	String aliasType = CommonString.getFormatPara(request.getParameter("aliasType"));
    //	umengAction.sendIOSCustomizedcast(alias,aliasType);
    //}
	
	//ios版本号
    if("ios_versionUpdate".equals(flag)){
    	resultStr=appVersionAction.getIosVersionNum();
    	out.println(resultStr);
    }
	
	
  	//android版本号
    if("android_versionUpdate".equals(flag)){
    	resultStr=appVersionAction.getAndroidVersionNum();
    	out.println(resultStr);
    }
  
	//微信消息推送
    if("sendWxMsg".equals(flag)){
    	int form_id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("form_id")));
    	//resultStr=comAc.sendWxMsg(form_id,"X2EdpnzIotI8FrCMSn7joYv2tHAcpVTXyDYYWbbcCeQ");
		resultStr=comAc.sendWxMsg(form_id,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
    	out.println(resultStr);
    }
	
	if("accessToken".equals(flag)){
    	resultStr=comAc.getAccessToken();
    	out.println(resultStr);
    }
	
	if("getParams".equals(flag)){
		String a="[{'product_no':'101001004' ,'no':'106' , 'name':'总长度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'6667mm'},{'product_no':'101001004' ,'no':'107' , 'name':'总宽度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'2115mm'},{'product_no':'101001004' ,'no':'108' , 'name':'总高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'2897mm'},{'product_no':'101001004' ,'no':'109' , 'name':'尾部回转半径' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'2130mm'},{'product_no':'101001004' ,'no':'110' , 'name':'轮距' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'225mm'},{'product_no':'101001004' ,'no':'111' , 'name':'轴距' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'2635mm'},{'product_no':'101001004' ,'no':'112' , 'name':'配重离地间隙' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'1010mm'},{'product_no':'101001004' ,'no':'113' , 'name':'最小离地间隙' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'370mm'},{'product_no':'101001004' ,'no':'114' , 'name':'驾驶室宽度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'115' , 'name':'驾驶室高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'116' , 'name':'机罩高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'117' , 'name':'最大挖掘高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'6524mm'},{'product_no':'101001004' ,'no':'118' , 'name':'最大卸载高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'4716mm'},{'product_no':'101001004' ,'no':'119' , 'name':'最大挖掘深度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'3900mm'},{'product_no':'101001004' ,'no':'120' , 'name':'最大垂直挖掘深度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'121' , 'name':'最大挖掘半径' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'122' , 'name':'最小回转半径' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'2476mm'},{'product_no':'101001004' ,'no':'123' , 'name':'最大地面挖掘半径' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'124' , 'name':'工作重量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'8300kg'},{'product_no':'101001004' ,'no':'125' , 'name':'铲斗容量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'0.33'},{'product_no':'101001004' ,'no':'126' , 'name':'铲斗最大挖掘力' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'42.03kn'},{'product_no':'101001004' ,'no':'127' , 'name':'斗杆最大挖掘力' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'128' , 'name':'回转速度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'12r/min'},{'product_no':'101001004' ,'no':'129' , 'name':'最大牵引力' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'130' , 'name':'爬坡能力' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'30'},{'product_no':'101001004' ,'no':'131' , 'name':'行走速度（高/中/低）' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'30Km/h'},{'product_no':'101001004' ,'no':'132' , 'name':'品牌型号' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'YC4FA65-T300'},{'product_no':'101001004' ,'no':'133' , 'name':'类型' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'134' , 'name':'额定功率' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'48Kw /2200RPM'},{'product_no':'101001004' ,'no':'135' , 'name':'额定转速' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'136' , 'name':'吸气类型' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'137' , 'name':'汽缸数量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'138' , 'name':'缸径' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'139' , 'name':'活塞行程' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'140' , 'name':'活塞排量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'141' , 'name':'变速器' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'142' , 'name':'排放标准' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'143' , 'name':'主泵类型' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'144' , 'name':'主泵最大流量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'145' , 'name':'行走液压马达' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'146' , 'name':'回转液压马达' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'147' , 'name':'工作装置液压回路安全阀值' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'148' , 'name':'行走液压回路安全阀值' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'149' , 'name':'回转液压回路安全阀值' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'150' , 'name':'先导液压回路安全阀值' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'151' , 'name':'轮胎规格' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'152' , 'name':'驱动方式' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'153' , 'name':'减速机构' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'154' , 'name':'回转操作制动' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'155' , 'name':'转向控制' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'156' , 'name':'驱动方式' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'157' , 'name':'行走马达' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'158' , 'name':'操作制动器' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'159' , 'name':'停车制动器' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'160' , 'name':'燃油箱容量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'120L'},{'product_no':'101001004' ,'no':'161' , 'name':'液压油箱容量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'125L'},{'product_no':'101001004' ,'no':'162' , 'name':'冷却液' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'163' , 'name':'发动机油' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'164' , 'name':'回转减速' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'165' , 'name':'行走减速（终传动）' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'166' , 'name':'前桥' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'101001004' ,'no':'167' , 'name':'后桥' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''}]";
    	comAc.outParam(a,119411);
    	
    }
	//微信token
    if("updateAccessToken".equals(flag)){
    	connection = dbHelper.getConnection();
    	String accessToken=comAc.getAccessToken();
    	int r=0;
		try{
			r=dbHelper.execute("update weixin_access_token set access_token =?,update_time=GETDATE()  where id=2 ",new Object[]{accessToken});
		}catch(Exception ee){
			ee.printStackTrace();
		}finally{
			dbHelper.freeConnection(connection);
		}
    	out.println(r);
    }
 
    
%>





 
