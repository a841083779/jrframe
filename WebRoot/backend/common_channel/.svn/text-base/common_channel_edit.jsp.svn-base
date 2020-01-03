<%@ page language="java" import="java.io.File,com.jerehnet.util.freemarker.TemplateUtils,java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"common_channel";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	Map channels = new TreeMap();
	try{
		connection = dbHelper.getConnection();
		String uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=uuid&&!"".equals(uuid)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid  = ? ",new Object [] {uuid} , connection);
		}
		channels.put("0","无父栏目");
		List<Map> channelList = (List)application.getAttribute("channelList");
		Map channelMap = (Map)application.getAttribute("channelMap");
		/*模板部分*/
		File t = new File(Common.getAbsolutePath(request)+"/template/");
		List<Map> list = new ArrayList<Map>(0);
		TemplateUtils.createTemplateTree(t,list);
		/*模板部分*/
		
		
		/*父栏目*/
		String sql = " select uuid,parent_uuid,name,action_link from "+tablePrefix+"common_channel "; 
		List<Map> parentChannels = DBHelper.getInstance().getMapList(sql,connection);
		StringBuffer tree = new StringBuffer();
		String parentUUID = "";
		String UUID = "";
		String actionLink = "";
		String name = "";
		for(Map m : parentChannels){
			UUID = (String)m.get("uuid");
			parentUUID = m.get("parent_uuid")==null?"0":(String)m.get("parent_uuid");
			actionLink = (String)m.get("action_link");
			name = (String)m.get("name");
			tree.append("{ id:'"+UUID+"', pId:'"+parentUUID+"', name:'"+name+"'");
			tree.append(",click:\"setPar('"+UUID+"','"+name+"')\"");
			if(parentUUID.toString().equals("0")){
				tree.append(",open:true");
			}
			tree.append("},");
		}
		if(tree.length()>1&&tree.indexOf(",")!=-1){
			tree.setLength(tree.length()-1);
		}
		
		/*子块部分*/
		List<Map> subblocks = new ArrayList<Map>(0);
		if(!"".equals(uuid)){
			sql = " select uuid,name,style ";
			sql += " from "+tablePrefix+"common_channel_subblock pccs , "+tablePrefix+"common_acl_channel_subblock pcas ";
			sql += " where pccs.uuid = pcas.subblock_uuid and pcas.channel_uuid = '"+uuid+"' and is_data = 0 ";
			subblocks = dbHelper.getMapList(sql,connection);
		}
		/*子块部分*/
		
		//后台链接
		Map tempLinkMap = CommonApplication.getEnumChildren("101", application);
		Map linkMap = new HashMap();
		for(Object obj : tempLinkMap.values()){
			linkMap.put(obj, obj);
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
     <link rel="stylesheet" href="/plugin/ui/jqueryUI/themes/base/jquery.ui.all.css" />
    <link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
     <link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="/plugin/ui/jqueryUI/jquery-ui-1.8.20.custom.min.js"></script>
    <style type="text/css">
    	#template {
			display: none;
			width: 350px;
			height: 340px;
			border: 1px solid #ccc;
			position: relative;
			top: -364px;
			left: 0px;
			background: #fff;
			overflow-y: scroll;
			overflow-x: hidden;
			z-index: 99999;
		}
		
		#template_channel {
			display: none;
			width: 350px;
			height: 340px;
			border: 1px solid #ccc;
			position: relative;
			top: -64px;
			left: 0px;
			background: #fff;
			overflow-y: scroll;
			overflow-x: hidden;
			z-index: 99999;
		}
		
		#template_close {
			display: none;
			width: 30px;
			height: 16px;
			border: 1px solid #ccc;
			position: relative;
			top: -706px;
			z-index:9999;
			left: 352px;
			cursor: pointer;
			font-weight: bold;
			background-color: #eee;
		}
	
    </style>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	  <div id="layout1">
	    <div position="left" title="<div class='l-toolbar-item l-panel-btn l-toolbar-item-hasicon' style='font-size:12px;font-weight:normal;position: relative;top:-4px;'><span>保存</span><div class='l-panel-btn-l'></div><div class='l-panel-btn-r'></div><div class='l-icon l-icon-save'></div></div>">
	    	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv" style="overflow-y:scroll; ">
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span>
					<span class="groupTitle">基础信息</span>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">父<span class="span3"></span>栏<span class="span3"></span>目</div>
				<div class="formRight">
					<%
						String fulanmu = CommonString.getFormatPara(channelMap.get(CommonString.getFormatPara(model.get("parent_uuid"))));
						if("".equals(fulanmu)){
							fulanmu = "无父栏目";
						}
						parentUUID = CommonString.getFormatPara(model.get("parent_uuid"));
						if("".equals(parentUUID)){
							parentUUID = "4CCDF227-7F10-4E09-A47C-085CCB4A45FF";
						}
					%>
					<input type="text" class="jr_text" id="fulanmu" readonly="readonly" value="<%=fulanmu %>" />
					<input type="hidden" name="zd_parent_uuid" id="zd_parent_uuid" value="<%=parentUUID %>" />
					<div id="template_channel">
						<ul id="lanmu" style="margin-top: 3px;" class="ztree"></ul>
					</div>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">栏目名称</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">栏目介绍</div>
				<div class="formRight" style="text-align: left; height: 300px;">
					<script type="text/plain" id="editor_intro" style="width:750px; height:200px;"><%=CommonString.getFormatPara(model.get("intro")) %></script>
					<input type="hidden" name="zd_intro" id="zd_intro" value='<%=CommonString.getFormatPara(model.get("intro")) %>' />
				</div>
				<div style="clear: left;"></div>
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span>
					<span class="groupTitle">扩展信息</span>
				</div>
                <div style="clear: left;"></div>
				<div class="formLeft">栏目链接</div>
				<div class="formRight">
					<select name="zd_action_link" id="zd_action_link" class="jr_select" style="width: 552px;" dataType="Require" msg="请您输入栏目链接！">
						<%=CommonForm.createSelect(linkMap, CommonString.getFormatPara(model.get("action_link"))) %>
					</select>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">模板名称</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_template_file_name" id="zd_template_file_name" value="<%=CommonString.getFormatPara(model.get("template_file_name")) %>" />
					<div id="template">
						<ul id="ztree" style="margin-top: 3px;" class="ztree"></ul>
					</div>
					<div id="template_close">关闭</div>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">生成文件</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_create_file_name" id="zd_create_file_name" value="<%=CommonString.getFormatPara(model.get("create_file_name")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">是否显示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %>
				</div>
				<div style="clear: left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
		<input type="hidden" name="eventAfter" value="channelTemplate" />
	</form>
	    </div>
	    <div position="center" id="center" title="元素管理">
	    <div class="extensioninfo">
	    	<ul>
				<li " class="ui-state-default" onclick='jrWindow("/backend/common_template/common_template_list.jsp?channel_uuid=<%=uuid %>","扩展模板",800,500);'><span class="ui-icon ui-icon-arrowthick-2-n-s" style="float: left;"></span>&nbsp;<span style="float:left; margin-top: 1px;">扩展模板</span></li>
	    	</ul>
	    </div>
	    			<%
		if(null!=subblocks&&subblocks.size()>0){
			%>
		<div class="extensioninfo">
			 <ul id="sortable">
			<%
				Map m = null;
				Integer dataStyle = 0;
				String subblock_uuid = "";
				Map subdata = null;
				for(int i=0;i<subblocks.size();i++){
					m = (Map)subblocks.get(i);
					subblock_uuid = (String)m.get("uuid");
					dataStyle = (Integer)m.get("style");					
					if(dataStyle.equals(0)){
						%>
					<li myid="<%=m.get("uuid") %>" class="ui-state-default" onclick="viewExtensionListInfo('<%=subblock_uuid %>','<%=m.get("name") %>');"><span class="ui-icon ui-icon-arrowthick-2-n-s" style="float: left;"></span>&nbsp;<span style="float:left; margin-top: 1px;"><%=m.get("name") %></span></li>
						<%
					}
					if(dataStyle.equals(1)){
						subdata = dbHelper.getMap(" select top 1 uuid,title from "+tablePrefix+"common_channel_subblock_data where subblock_uuid = ? ",new Object [] {subblock_uuid},connection);
						if(null!=subdata){
						%>
					<li myid="<%=m.get("uuid") %>" class="ui-state-default" onclick='jrWindow("/backend/common_channel_subblock_data/common_channel_subblock_data_edit.jsp?id=<%=subdata.get("uuid") %>","<%=subdata.get("title") %>",680,500);'><span class="ui-icon ui-icon-arrowthick-2-n-s" style="float: left;"></span>&nbsp;<span style="float:left; margin-top: 1px;"><%=m.get("name") %></span></li>
						<%
						}else{
						%>
					<li myid="<%=m.get("uuid") %>" class="ui-state-default" onclick="viewExtensionSingleInfo('<%=subblock_uuid %>','<%=m.get("name") %>');"><span class="ui-icon ui-icon-arrowthick-2-n-s" style="float: left;"></span>&nbsp;<span style="float:left; margin-top: 1px;"><%=m.get("name") %></span></li>
						<%
						}
					}
				}
			%>
			</ul>
		</div>
			<%
		}
		%>
	    </div>
	   </div>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<script type="text/javascript">
	jQuery("#sortable").sortable({
		stop : function(event, ui) {
			doSort();
		}
	});
	jQuery("#sortable").disableSelection();
	jQuery("#layout1").ligerLayout({
		leftWidth : "83%",
		centerWidth : "17%",
		isLeftCollapse : false,
		allowLeftCollapse : false,
		allowLeftResize : false
	});
	jQuery(".formDiv").height(jQuery(document).height()-50);
	function doSub(){
		jQuery("#theform").ajaxSubmit({
			type : "POST",
            async : false ,
			success : function(data) {
				var rs = parseInt(jQuery.trim(data), 10);
				if (rs > 0) {
					jrSuccess("保存成功！");
					<%
					if("".equals(CommonString.getFormatPara(model.get("id")))){
						%>
					window.location.reload();
						<%
					}
					%>
				} 
			}
		});
	}
	jQuery(function(){
		jQuery("#zd_parent_no").change(function(){
			jQuery.post("/backend/action/ajax_r.jsp",{'tableName':'<%=tableName%>','flag':'get_no','pno':this.value},function(data){
				jQuery("#zd_no").val(jQuery.trim(data));
			});
		});
	});
	var zTreeNodes = [
		<%
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
				out.print(",click:\"chooseTemplate('"+abFile+"');\"");
			}else{
				out.print(",open:true");
			}
			out.print("}");
			if(i!=(size-1)){
				out.print(",");
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
	
	
	var channelNodes = [
		{ id:'0', pId:'-1', name:'无父栏目',click:"setPar('4CCDF227-7F10-4E09-A47C-085CCB4A45FF','无父栏目')",open:true},
		<%=tree.toString() %>
	];
	
	jQuery.fn.zTree.init(jQuery("#lanmu"), setting, channelNodes);
	
	
	jQuery("#fulanmu").click(function(){
		jQuery("#template_channel").show();
	});
	
	function chooseTemplate(file){
		jQuery("#zd_template_file_name").val(file);
		jQuery("#zd_create_file_name").val(file);
	}
	
	function showDiv(){
		hideDiv();
		jQuery("#template,#template_close").show();
	}
	
	function hideDiv(){
		jQuery("#template,#template_close").hide();
	}
	
	jQuery("#template_close").click(function(){
		hideDiv();
	});
	
	jQuery("#zd_template_file_name").click(function(){
		var dis = jQuery("#template").css("display");
		if(dis=='none'){
			showDiv();
		}
	});
	jQuery(function(){
		var ue_intro = new baidu.editor.ui.Editor({
	    	textarea : 'zd_intro',
	    	autoHeightEnabled:false,
	    	minFrameHeight:250
	    });
	    ue_intro.render('editor_intro');
	    ue_intro.addListener("selectionchange",function(){
		    var state_intro = ue_intro.queryCommandState("source");
		    document.getElementById("zd_intro").value=ue_intro.getContent();
		});
		parent.jQuery(".l-tab-loading").hide();
		
		jQuery("#ztree li").dblclick(function(){
			hideDiv();
		});
		
		jQuery(".formDiv").height(jQuery(".l-layout-left").height()-30);
		if(jQuery.browser.msie){
			jQuery(".formDiv").css("width","98%");
			jQuery(".l-layout-center").width(jQuery(".l-layout-center").width()+10);
		}
	})
	//编辑扩展列表信息
	function viewExtensionListInfo(subblock_uuid,title){
		jrWindow("/backend/common_channel_subblock_data/common_channel_subblock_data_list.jsp?subblock_uuid="+subblock_uuid,title,700,400);
	}
	//编辑扩展单条信息
	function viewExtensionSingleInfo(subblock_no,title){
		jrWindow("/backend/common_channel_subblock_data/common_channel_subblock_data_edit.jsp?subblock_no="+subblock_no,title,680,500);
	}
	
	function doSort(){
		var sortHtml = "";
		jQuery.each(jQuery("#sortable li"),function(index,data){
			sortHtml += jQuery(this).attr("myid")+",";
		});
		sortHtml = sortHtml.substring(0,sortHtml.length-1);
		jQuery.ajax({
			url:"/backend/action/ajax_cud.jsp",
			type:"post",
			data:{'flag':'saveSort',"tableName":"<%=tablePrefix %>common_channel_subblock","sortId":sortHtml},
			async:false,
			cache:false
		});
	}
	jQuery(".l-toolbar-item").click(function(){
		doSub();
	});
	jQuery(".l-toolbar-item").hover(function(){
		jQuery(this).addClass("l-panel-btn-over");
	},function(){
		jQuery(this).removeClass("l-panel-btn-over");
	});
	function setPar(uuid,name){
		jQuery("#fulanmu").val(name);
		jQuery("#zd_parent_uuid").val(uuid);
		jQuery("#template_channel").hide();
	}
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>