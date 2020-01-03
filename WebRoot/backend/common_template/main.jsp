<%@ page language="java" import="java.util.*,java.io.*,com.jerehnet.util.common.*,com.jerehnet.util.freemarker.TemplateUtils" pageEncoding="UTF-8"%>
<%
	File t = new File(Common.getAbsolutePath(request)+"/template/");
	List<Map> list = new ArrayList<Map>();
	TemplateUtils.createTemplateTree(t,list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>模板管理</title>
    <link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<style type="text/css">
	#layout1{
		width:100%; 
		margin:40px;  
		height:400px; 
		margin:0; 
		padding:0;
	} 
	</style>
  </head>
  
  <body>
  <div id="layout1">
    <div position="left" title="模板文件">
	    <div style="overflow:scroll; width: 200px; ">
	    	<ul id="ztree" style="margin-top: 3px;" class="ztree"></ul>
	    </div>
    </div>
    <div position="center" id="center" title="模板详细">
    	<textarea style="width: 100%; height: 100%; border: none; " id="content" name="content"></textarea>
    </div>
   </div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/keyboard/kibo/kibo.js"></script>
<script type="text/javascript">
var nowFile = "";
jQuery("#layout1").ligerLayout({
	leftWidth : 200,
	isLeftCollapse : false,
	allowLeftCollapse : false,
	allowLeftResize : false
});
jQuery("#ztree").parent().height(jQuery("textarea").height());
var zTreeNodes = [
	<%
	if(null!=list&&list.size()>0){
		Map m = null;
		int size = list.size();
		String abFile = "";
		String realPah = application.getRealPath("/template");
		for(int i=0;i<size;i++){
			m = (Map)list.get(i);
			abFile = (String)m.get("absolute");
			abFile = abFile.replace(realPah,"");
			abFile = abFile.replace("\\","/");
			out.print("{");
			out.print("id:'"+m.get("id")+"',");
			out.print("pId:'"+m.get("pId")+"',");
			out.print("name:'"+m.get("self")+"'");
			if(!m.get("isDirectory").equals(true)){
				out.print(",click:\"createEdit('"+abFile+"');\"");
			}else{
				out.print(",open:true");
			}
			out.print("}");
			if(i!=(size-1)){
				out.print(",");
			}
		}	
	}
	%>
];
var setting = {
	view: {
		dblClickExpand: false,
		showLine: true,
		selectedMulti: false,
		expandSpeed: (jQuery.browser.msie && parseInt($.browser.version)<=6)?"":"fast"
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: "template"
		}
	}
};
jQuery.fn.zTree.init(jQuery("#ztree"), setting, zTreeNodes);
function createEdit(file){
	nowFile = file;
	var content = "";
	jQuery.ajax({
		url:"/backend/action/ajax_r.jsp",
		data:{'flag':'get_file_html','fileName':file},
		async:false,
		cache:false,
		success:function(data){
			content = jQuery.trim(data);
		}
	});
	jQuery("#content").val(content);
}
var k = new Kibo();
k.down(['ctrl s'],function(){
	saveHtml();
	return false;
});

function saveHtml(){
	if(null==nowFile||''==nowFile){
		return;
	}
	jQuery.ajax({
		url:"/backend/action/ajax_cud.jsp",
		data:{'flag':'writeTemplate','fileName':nowFile,content:jQuery("#content").val()},
		type:'post',
		async:true,
		cache:false,
		success:function(data){
			var rs = jQuery.trim(data);
			if(rs=='ok'){
				alert("保存成功！");
			}
		}
	});
}
</script>