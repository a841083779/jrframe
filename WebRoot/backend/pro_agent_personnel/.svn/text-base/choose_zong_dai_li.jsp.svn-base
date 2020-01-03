<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	List<Map> zong_dai_li_list = dbHelper.getMapList(" select id,name from pro_agent_factory where flag = 2 and levelflag = 0 ");
	LinkedHashMap zong_dai_li_map = new LinkedHashMap();
	String name = "";
	String pinyin = "";
	for(Map m : zong_dai_li_list){
			name = CommonString.getFormatPara(m.get("name"));
			pinyin = CnToFullSpell.getFirstSpell(name).substring(0,1);
			m.put("pinyin",pinyin);
	}
	Collections.sort(zong_dai_li_list,new java.util.Comparator(){
		public int compare(Object o1, Object o2) {
			Map m1 = (Map)o1;
			Map m2 = (Map)o2;
			return m1.get("pinyin").toString().compareTo(m2.get("pinyin").toString());
		}
	});
	for(Map m : zong_dai_li_list){
		zong_dai_li_map.put(CommonString.getFormatPara(m.get("id")),CommonString.getFormatPara(m.get("pinyin")) + " " + CommonString.getFormatPara(m.get("name")));
	}
	String uuids = CommonString.getFormatPara(request.getParameter("ids")).replaceAll("'","");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>JSP</title>
	<script type="text/javascript" src="/plugin/jquery/jquery.min.js"></script>
  </head>
  
  <body style="margin: 0;padding: 0;overflow: hidden;">
	<select style="width: 100%;" id="parent_id">
		<%=CommonForm.createSelect(zong_dai_li_map,"") %>
	</select>
  </body>
</html>
<script type="text/javascript">
function doSub(){
	jQuery.ajax({
		url : "/backend/action/ajax_cud.jsp",
		data : {
			ids : "<%=uuids %>",
			parent_id : jQuery("#parent_id").val(),
			flag : "saveBatchParentId"
		} ,
		type : "post",
		async : false
	});
	alert("保存成功！");
	return true;
}
</script>