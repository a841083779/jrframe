<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=Env.getInstance().getProperty("project_name") %></title>
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
		<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
		<style type="text/css">
		.l-topmenu {
			margin: 0;
			padding: 0; 
			height: 31px;
			line-height: 31px;
			background: url('/plugin/ui/ligerUI/images/top.jpg') repeat-x bottom;
			position: relative;
			border-top: 1px solid #1D438B;
		}
		.l-topmenu-logo {
			color: #E7E7E7;
			padding-left: 35px;
			line-height: 26px;
			background: url('/plugin/ui/ligerUI/images/topicon.gif') no-repeat 10px
				5px;
		}
		.l-topmenu-welcome {
			position: absolute;
			height: 24px;
			line-height: 24px;
			right: 30px;
			top: 2px;
			color: #070A0C;
		}
		
		.l-topmenu-welcome a {
			color: #E7E7E7;
			text-decoration: underline
		}
		</style>
	<body>
		<div class="l-loading" style="display: block" id="pageloading"></div> 
		<div id="topmenu" class="l-topmenu" style="background: none;">
			<div class="l-topmenu-logo" style="background: url('/backend/images/zoomlion/logo-bj.jpg');margin: 0;padding: 0;position: relative;top:-1px;">
				<img src="/backend/images/zoomlion/logo.jpg" />
			</div>
			<div class="l-topmenu-welcome" style="color: #E7E7E7;">
				<a href="/backend/action/exit.jsp">退出</a>
			</div>
		</div>
		<div id="layout1" style="width: 99.2%; margin: 0 auto; margin-top: 4px;">
			<div position="left" title="主要菜单" id="accordion1">
				<iframe frameborder="0" style="height: 100%;" name="menu" id="menu" src="/backend/menu.jsp"></iframe>
			</div>
			<div position="center" id="framecenter">
				<div tabid="home" title="我的主页" style="height: 300px">
					<iframe frameborder="0" scrolling="no" name="home" id="home" src="/backend/welcome.jsp"></iframe>
				</div>
			</div>
		</div>
		<div style="display: none"></div>
	</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function createAll(){
		jQuery.ligerDialog.confirm("确定要全站生成吗？", function(yes) {
			if(yes){
				jQuery("#pageloading").show();
				jQuery.post("/backend/action/ajax_r.jsp",{
					'flag':'allHtmlCreate'
				},function(data){
					jQuery("#pageloading").hide();
					jQuery.ligerDialog.success(data);
				});
			}
		});
	}
	var tab = null;
	var nowDialog = null;
	var imgChooseIframeUrl = null;
	var accordion = null;
	var imgChooseIframeId = null;
	jQuery(function (){
		//布局
		jQuery("#layout1").ligerLayout({ leftWidth: 190, height: '100%',heightDiff:-2,space:4, onHeightChanged: f_heightChanged });
		var height = jQuery(".l-layout-center").height();
		//Tab
		jQuery("#framecenter").ligerTab({ height: height });
		//面板
		jQuery("#accordion1").ligerAccordion({ height: height - 24, speed: null });
		jQuery(".l-link").hover(function(){
			jQuery(this).addClass("l-link-over");
		},function (){
			jQuery(this).removeClass("l-link-over");
		});
		tab = jQuery("#framecenter").ligerGetTabManager();
		accordion = jQuery("#accordion1").ligerGetAccordionManager();
		jQuery("#pageloading").hide();
	});
	function f_heightChanged(options){
		if (tab){
			tab.addHeight(options.diff);
		}
		if (accordion && options.middleHeight - 24 > 0){
			accordion.setHeight(options.middleHeight - 24);
		}
	}
	function f_addTab(tabid,text, url){ 
		tab.addTabItem({ tabid : tabid,text: text, url: url });
	}
		// 消息提醒 
	//    newMessageRemind.show();
</script>
  <script type="text/javascript" src="/dwr/engine.js"></script>
    <script src="/dwr/interface/pushOrderInfo.js"></script> 
  <script type="text/javascript" src="/dwr/util.js"></script>
  <script type="text/javascript" src="/scripts/show_msg.js"></script>
  <script type="text/javascript" src="/scripts/rememberAccount.js"></script>
  <script type="text/javascript">
    function getOrderIdInterval(){
    		 newMessageRemind.show('<%=request%>') ;
  	} ;
  jQuery(function(){
  SetCookie("cookieOrderId","111") ;
   _intervalTimer = setInterval(function(){
    	 	 getOrderIdInterval() ;
   },1500) ;
 }) ;
 
setInterval(function(){
// 	this.focus();
},1000);
  </script>