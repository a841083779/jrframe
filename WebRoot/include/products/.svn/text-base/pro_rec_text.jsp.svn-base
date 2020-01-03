<%@ page language="java" import="java.util.*,java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%
	String catalog = CommonString.getFormatPara(request.getParameter("catalognum")) ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	StringBuffer whereStr = new StringBuffer(" ");
			//拆分吨位
		String[] parttonandmeters = null;
		String firsttonandmeter = "";
		String sectonandmeter = "";
		if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
			parttonandmeters = tonandmeter.split("_");
			firsttonandmeter = parttonandmeters[1];
			sectonandmeter = parttonandmeters[2];
			if ("0".equals(parttonandmeters[2])) {
				whereStr.append(" and a.tonandmeter < " + firsttonandmeter);
			} else if ("1".equals(parttonandmeters[2])) {
				whereStr.append(" and a.tonandmeter >" + firsttonandmeter);
			} else if ("01".equals(parttonandmeters[2])) {
				whereStr.append(" and a.tonandmeter =" + firsttonandmeter);
			} else {
				whereStr.append(" and a.tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
			}
		}
	
	if("".equals(factoryid)){
		Map catalogMap = (Map) application.getAttribute("catalogMap");
		if("".equals(offset)||"0".equals(offset)){
			String city = "";
			String ip  = Common.getIp(request);
			Connection connection = null;
			DBHelper dbHelper = DBHelper.getInstance();
			try{
				connection = dbHelper.getConnection();
				String objStr = Tools.getMyProvinceAndCity(ip);
				JSONObject obj = new JSONObject(objStr);
				if(null!=obj&&obj.length()>0){
					city = CommonString.getFormatPara(obj.getString("city"));
				}
				//开通代理商营销宝高级版会员+开通厂家营销宝高级版会员+后台该类别推荐的产品，共3条随机查出
				String sql = "";
				sql += " SELECT TOP 3 a.factoryid,a.factoryname,a.catalognum,a.catalogname,a.name,a.file_name,";
				sql += " a.introduce,a.id,a.img2 ";
				sql += " FROM pro_products a ";
				sql += " WHERE id IN( ";
				sql += " SELECT pp.id ";
				sql += " FROM pro_agent_ad_position paap ";
				sql += " INNER JOIN pro_products pp ON pp.id = paap.product_id AND pp.catalognum LIKE '"+catalog+"%' ";
				sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 2 ";
				sql += " INNER JOIN pro_agent_factory_and_area pafaa ON pafaa.agent_id = paf.id ";
				sql += " INNER JOIN comm_area ca ON pafaa.area_id = ca.area_id AND ca.area_name LIKE '%"+city+"%' ";
				sql += " WHERE paap.position = 1 ";
				sql += " UNION ";
				sql += " SELECT pp.id ";
				sql += " FROM pro_agent_ad_position paap ";
				sql += " INNER JOIN pro_products pp ON pp.id = paap.product_id AND pp.catalognum LIKE '"+catalog+"%' ";
				sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 1 ";
				sql += " WHERE paap.position = 1 ";
				sql += " UNION ";
				sql += " SELECT id FROM ";
				sql += " pro_products ";
				sql += " WHERE is_rec = 1 AND is_show=1 AND catalognum LIKE '"+catalog+"%' ";
				sql += " )  "+whereStr.toString();
				sql += " ORDER BY newid() ";
				List<Map> list = dbHelper.getMapList(sql,connection);
				if(null!=list){
					for(Map oneMap : list){
						%>
	<li>
		<a href="/proDetail/<%=oneMap.get("file_name")%>"
			target="_blank"> <img
				src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"
				onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"
				width="130" height="90" class="plimg"
				alt="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")+ (String) oneMap.get("catalogname"))%>"
				title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
				+ (String) oneMap.get("catalogname"))%>" />
		</a>
		<div class="w618 r">
			<h2>
				<a title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%>" href="/proDetail/<%=oneMap.get("file_name")%>"
					target="_blank"><%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
				+ (String) oneMap.get("catalogname"))%></a>
			</h2>
			<span class="info"> <a
				href="?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum")).length() >= 6 ? CommonString
		.getFormatPara(oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))%>"><%=CommonString.getFormatPara((String) oneMap.get("factoryname")).replace("卡特彼勒","卡特")
		+ CommonString.getFormatPara(catalogMap.get((((String) oneMap.get("catalognum")).length() >= 6) ? CommonString.getFormatPara(oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))))%></a><em>|</em><a
				href="/proDetail/<%=((String)oneMap.get("file_name")).replace(".shtm","")%>_order.shtm"
				target='_blank'>订单</a><em>|</em><a
				href="/proDetail/<%=((String)oneMap.get("file_name")).replace(".shtm","")%>_pic.shtm"
				target="_balnk">图片</a><em>|</em><a href="/proDetail/<%=((String)oneMap.get("file_name")).replace(".shtm","")%>_parameter.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm")%>" target="_blank">评论</a>
				 <a href="javascript:;"	onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')"
				class="plbtn">询最低价</a><i>提交后收到最低价短信</i></span>
			<div class="plInfo"><%=CommonString.substringByte(CommonHtml.filterHTML((String) oneMap.get("introduce")), 180) + "..."%><a style="color:#2e65b7;"
					href="/proDetail/<%=oneMap.get("file_name")%>"
					target="_blank">[查看详情]</a> 
			</div>
		</div>
	</li>
						<%
					}
				}
			}catch(Exception e){
				
			}finally{
				DBHelper.freeConnection(connection);
			}
		}
	}
%>