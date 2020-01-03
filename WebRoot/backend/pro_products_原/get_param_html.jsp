<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	String category = CommonString.getFormatPara(request.getParameter("category"));
	String no = CommonString.getFormatPara(request.getParameter("no"));
	try{
		List<Map> list = null;
		if(!category.equals("")){
			list = Tools.getCategoryParam(category,"106013");//获得设置为礼品网的枚举
		}
%>
<%
	if(!category.equals("") && list != null && list.size() > 0){
		Map enumMap = null;
%>
<div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">产品参数</span> </div>
<%
		int i = 0;
		for(Map m:list){
			i++;
%>
<%
	if(CommonString.getFormatPara(m.get("type")).equals("2")){//枚举类型
		enumMap = CommonApplication.getEnumChildren(CommonString.getFormatPara(m.get("enum_no")),application);
%>
<div class="formLeft"><%=m.get("name")%></div>
<div class="formRight" style="width:190px">
  <select class="jr_select" name="param" id="<%=CommonString.getFormatPara(m.get("no"))%>" lang="'product_no':'<%=no%>' ,'no':'<%=CommonString.getFormatPara(m.get("no"))%>' , 'name':'<%=CommonString.getFormatPara(m.get("name"))%>' , 'type':'2' , 'order_no':'<%=CommonString.getFormatPara(m.get("order_no"))%>' , 'enum_no':'<%=CommonString.getFormatPara(m.get("enum_no"))%>'" >
    <option value="">--请选择--</option>
    <%=CommonForm.createSelect(enumMap, "") %>
  </select>
</div>
<%
	}else{//文本类型
%>
<div class="formLeft"><%=m.get("name")%></div>
<div class="formRight" style="width:190px">
  <input type="text" class="jr_text" name="param" id="<%=CommonString.getFormatPara(m.get("no"))%>" lang="'product_no':'<%=no%>' ,'no':'<%=CommonString.getFormatPara(m.get("no"))%>' , 'name':'<%=CommonString.getFormatPara(m.get("name"))%>' , 'type':'1', 'order_no':'<%=CommonString.getFormatPara(m.get("order_no"))%>' , 'enum_no':''" value="" maxlength="50"/>
</div>
<%}%>
<%if(i%2==0){%>
<div style="clear:left;"></div>
<%}%>
<%
		}
	}
%>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
