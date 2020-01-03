function onfocusTochangeTxt(obj) { 
	if (obj.id == "showLoginName") {
		$("#showLoginName").hide();
		jQuery("#login_username").val("") ;
		$("#login_username").show(); 
		$("#login_username").focus();
		
		jQuery("#zd_username").val("") ;
		$("#zd_username").show();
		$("#zd_username").focus();
		
		jQuery("#login_username_top").val("") ;
		$("#login_username_top").show();
		$("#login_username_top").focus();
	} 
	if (obj.id == "showLoginPasswd") {
		$("#showLoginPasswd").hide();
		jQuery("#login_password").val("") ;
		$("#login_password").show();
		$("#login_password").focus();
		
		jQuery("#zd_password").val("") ;
		$("#zd_password").show();
		$("#zd_password").focus();
		
		jQuery("#login_password_top").val("") ;
		$("#login_password_top").show();
		$("#login_password_top").focus();
	}
	if (obj.id == "showPassword") {
		$("#showPassword").hide();
		$("#zd_password").show();
		$("#zd_password").focus();
	}
	if (obj.id == "showNickName") {
		$("#showNickName").hide();
		jQuery("#zd_nickname").val("") ;
		$("#zd_nickname").show();
		$("#zd_nickname").focus();
	}
	if (obj.id == "showYanZheng") {
		$("#showYanZheng").hide();
		jQuery("#yanzheng").val("") ;
		$("#yanzheng").show();
		$("#yanzheng").focus();
	}
}

function onblurTochangeTxt(obj) {
	var arr = ["邮箱/手机号", "创建密码", "昵称", "所在区域", "密码"];
	if (obj.id == "area" && jQuery("#" + obj.id).val() == "") {
		jQuery("#" + obj.id).val("所在区域");
	} else if (obj.id == "zd_username" && jQuery("#" + obj.id).val() == "") {
		$("#zd_username").hide();
		$("#showLoginName").show();
	} else if (obj.id == "zd_password" && jQuery("#" + obj.id).val() == "") {
		$("#zd_password").hide();
		$("#showLoginPasswd").show();
	} else if (obj.id == "zd_nickname" && jQuery("#" + obj.id).val() == "") {
		$("#zd_nickname").hide();
		$("#showNickName").show();
	} else if (obj.id == "login_password" && jQuery("#" + obj.id).val() == "") {
		$("#login_password").hide();
		$("#showLoginPasswd").show();
	}else if (obj.id == "login_username" && jQuery("#" + obj.id).val() == "") {
		$("#login_username").hide();
		$("#showLoginName").show();
	}else if (obj.id == "yanzheng" && jQuery("#" + obj.id).val() == "") {
		$("#yanzheng").hide();
		$("#showYanZheng").show();
	}else if (obj.id == "login_username_top" && jQuery("#" + obj.id).val() == "") {
		$("#login_username_top").hide();
		$("#showLoginName").show();
	} else if (obj.id == "login_password_top" && jQuery("#" + obj.id).val() == "") {
		$("#login_password_top").hide();
		$("#showLoginPasswd").show();
	}
}

// 登录js
function doLogin2() {
	jQuery("#loginform").ajaxSubmit({
		type: "POST",
		success: function(data) {
			var rs = parseInt(jQuery.trim(data), 10);
			if (rs == 1) {
				jQuery.jBox.tip("登录成功！");
				if(typeof backUrl != 'undefined' && backUrl != ''){
					parent.window.location.href = backUrl;
				}else{
					setTimeout("parent.window.location.reload()",1000);
				}
			} else if(rs == 2) {
				jQuery.jBox.tip("账号已被禁用");
			} else if(rs == 3) {
				jQuery.jBox.tip("密码错误");
			} else if(rs == 4) {
				jQuery.jBox.tip("账号不存在!");
			}
		}
	});
}

function show_tip(content,info_icon){
	var str = '<font class="jBox_tips">'+content+'</font>';
	jQuery.jBox.tip(str,'',{timeout:999999});
}

// 登录js
function doLogin() {
	jQuery("#loginform").ajaxSubmit({
		type: "POST",
		success: function(data) {
			var rs = parseInt(jQuery.trim(data), 10);
			if (rs == 1) {
				jQuery.jBox.tip("登录成功！");
				if(window.location.href.indexOf("/activity/") != -1){
					if(typeof backUrl != 'undefined' && backUrl != ''){
						var timestamp=new Date().getTime();
						var href=backUrl;
						var url=href.replace("http://www.wajueji.com/","/");
							if (url.indexOf("timestamp")>0){
								url=url.substring(0,url.lastIndexOf("timestamp"));
								if(url.indexOf("?")>0){
									if (url.indexOf("=")>0){
										if(url.indexOf("&")>0){
											url=url+"timestamp="+timestamp;
										}else{
											url=url+"&timestamp="+timestamp;
										}
									}else{
										url=url+"timestamp="+timestamp;
									}
								}else{
									url=url+"?timestamp="+timestamp;
								}
							}else{
								if (url.indexOf("?")>0){
									url=url+"&timestamp="+timestamp;
								}else{
									url=url+"?timestamp="+timestamp;
								}
							}
							setTimeout(function(){parent.window.location.href = url;},1000);
						}else{
							var timestamp=new Date().getTime();
							var href=window.location.href;
							var url=href.replace("http://www.wajueji.com/","/");
							if (url.indexOf("timestamp")>0){
								url=url.substring(0,url.lastIndexOf("timestamp"));
								if(url.indexOf("?")>0){
									if (url.indexOf("=")>0){
										if(url.indexOf("&")>0){
											url=url+"timestamp="+timestamp;
										}else{
											url=url+"&timestamp="+timestamp;
										}
									}else{
										url=url+"timestamp="+timestamp;
									}
								}else{
									url=url+"?timestamp="+timestamp;
								}
							}else{
								if (url.indexOf("?")>0){
									url=url+"&timestamp="+timestamp;
								}else{
									url=url+"?timestamp="+timestamp;
								}
							}
							setTimeout(function(){parent.window.location.href = url;},1000);
						}
				}else{
					if(typeof backUrl != 'undefined' && backUrl != ''){
						//setTimeout(function(){
						window.location.href=backUrl;
						//},1000);
					}else{
						//setTimeout(function(){
						parent.window.location.reload();
						//},1000);
					}
				}
			} else if(rs == 2) {
				jQuery.jBox.tip("账号已被禁用");
			} else if(rs == 3) {
				jQuery.jBox.tip("密码错误");
			} else if(rs == 4) {
				jQuery.jBox.tip("账号不存在!");
			}
		}
	});
}
try{
$.ajaxSetup({
	cache:false
});
//添加表情1
function addFace(){
	jQuery("#opLogFaces").jqfaceedit({
		txtAreaObj : $("#oplogContent"),
		containerObj : $('#container')
	});
}
//添加表情2
function addFacea(id){
	jQuery("#opLogFaces_"+id).jqfaceedit2({
		txtAreaObj : $("#oplogContent_"+id),
		containerObj : $("#container_"+id)
	});
}
//添加表情3
function addFace3(){
	jQuery("#TopicFaces").jqfaceedit3({
		txtAreaObj : $("#oplogContent"),
		containerObj : $('#container')
	});
}
}catch(e){}
//	弹出登陆对话框
//	静态页版本
function loginHtml() {
	jQuery.jBox.setDefaults({
		defaults : {
			border : 5
		}
	}); // 只修改全局 border
	jQuery.jBox("iframe:/loginHtml.jsp?back=" + encodeURIComponent(document.URL), {
		border:5,
		title : null,
		opacity : 0.3,
		width : 620,
		top : '30%',
		height : 280,
		showIcon : false,
		iframeScrolling : 'no',
		id:'loginFrame',
		buttons : {}
	});
}


// 弹出登陆对话框
function login() {
	jQuery.jBox.setDefaults({
		defaults : {
			border : 5
		}
	}); // 只修改全局 border
	jQuery.jBox("iframe:/login.jsp?back=" + encodeURIComponent(document.URL), {
		border:5,
		title : null,
		opacity : 0.3,
		width : 620,
		top : '30%',
		height : 280,
		showClose:false,
		showIcon : false,
		iframeScrolling : 'no',
		id:'loginFrame',
		buttons : {}
	});
}
function LoginToRegister(){//注册成功会自动登录并返回注册前页面
		window.parent.location.href = '/regist.jsp';
	}
function goToSNS(flag,visitId){
	var equalsIgnoreCase = function (a,b){
		if(a.toLowerCase() == b.toLowerCase()){
			return true;
		}else{
			return false;
		}
	}
	var visitStr = '';
	if(typeof visitId != 'undefined'){
		visitStr = '&state='+visitId;
	}
	jQuery(parent.jQuery("div[id^='jBox_']")[0]).css("display","none");
	var url = "";
	if(equalsIgnoreCase(flag,"qq")){
		url = 'https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100364233&scope=all&redirect_uri=http://www.wajueji.com/other_login/qq.jsp'+visitStr;
	}else if(equalsIgnoreCase(flag,"sina")){
		url = 'https://api.weibo.com/oauth2/authorize?client_id=3539553052&response_type=code&redirect_uri=http://www.wajueji.com/other_login/sina.jsp'+visitStr;
	}else if(equalsIgnoreCase(flag,"renren")){
		url = 'https://graph.renren.com/oauth/authorize?client_id=225092&response_type=code&display=page&redirect_uri=http://www.wajueji.com/other_login/renren.jsp'+visitStr;
	}
	window.open(url);
}


//弹出登陆还是注册对话框,登陆成功返回主页面上一级
function loginOrRegister_for_return(href) {
	jQuery.jBox("iframe:/login.jsp?backUrl="+href, {
			border:5,
			title : null,
			opacity : 0.3,
			width : 620,
			top : '30%',
			height : 280,
			showIcon : false,
			iframeScrolling : 'no',
			buttons : {}
		});
	jQuery(".jbox-content").css("overflow-y","hidden");
}


//单击回复框判断是否是登录用户，不是登录用户就弹出登录页面，否则就直接回复。
function isLogin(isTemp){
	if(isTemp==1){
		login();
		return;
	}
}

//单击回复框判断是否是登录用户，不是登录用户就弹出登录页面，否则就直接回复。
//静态页版本
function isLoginHtml(isTemp){
	if(isTemp==1){
		loginHtml();
		return;
	}
}

jQuery(".delete").click(function() {
	jQuery.jBox.tip("图片已经删除！", 2);
	jQuery("#zd_mood_img").val("");
	jQuery("#imgLayer").hide();
	jQuery("#cate a").removeClass("csel") ;
});

//关闭表情框
function closeFace(){
	container.find("#face").remove();
}


//删除评论

//function delTopicComment(act_id){
//	jQuery.ajax({
//		url:'/data_ajax/activity_oplog_delete.jsp?oplogId=',
//	});
function chageShowNum(obj){
	obj.text(parseInt(obj.text())+1) ;
}

//改变评论数量
function changeLogsCount(logs_id,count){
	var htmlObj = jQuery("a[id='a_oplog_"+logs_id+"']");
	var t = null;
	var _tem = htmlObj.html();
	t=_tem.replace(/[^\d]*/ig,"");
	t = parseInt(count);
	htmlObj.html("评论("+t+")");
}

/**
*回复提交
*/
function doSub(obj){
	var isTemp=jQuery("#isTemp").val();
	if(isTemp==1){
		login();
		return;
	}else{
		jQuery("#pubTopicFormReplay").ajaxSubmit({
			type : "POST",
			dataType:"json",
			success : function(data) {
				if(data == '-2'){
					jQuery.jBox.tip("请输入内容!",1);
					return;
				}
				var result_code = data[0].result_code;
				var result_message = data[0].result_message;
				var score = data[0].score;
				if (result_code =='0001') {
					$("#bt-ico").addClass("disable");
					$('#bt-ico').attr('href', 'javascript:void(0);');
					jQuery("#oplogContent").val("");
					//if(null==score||score==0){
						jQuery.jBox.tip(result_message);
					//}else{
					//	jQuery.jBox.tip(result_message+'，恭喜您又加了'+score+'分');
					//}
					setTimeout(function(){
						if(typeof obj != 'undefined'){
							getComment(1,obj);
						}else{
							getComment(1);
						}
					},100) ;
					//更改显示数字
					chageShowNum(jQuery(".hf a span em"));
					chageShowNum(jQuery("#huifu span"));
				} else if (result_code =='0002')  {
					jQuery.jBox.tip('出错了，请联系管理员！');
				}
				jQuery("#imgLayer").hide();
			}
		});
	}
}

/**
*	div节点为pageLine
*	评论分页
*	输入页码方法统一为：goToDetailPage(nowPage);
*	换页方法为各自的getComment(pageIndex);
*/
function createPage(pageCount, nowPage) {
	var perv = 1;
	var next = pageCount;
	if (nowPage > 1) {
		perv = nowPage - 1;
	}
	if (nowPage < pageCount) {
		next = nowPage + 1;
	}
	var htm='';
	htm+=' <div class="paging baobao">' ;
	htm+='<a href="javascript:;" class="prev" onclick="getComment(' + perv+');">上一页</a>';
	for (var i = 1; i < pageCount; i++) {
	if (i == nowPage) {
		htm += ' <span class="cur">' + i + '</span> ';
	} else {
		htm += ' <a href="javascript:void(0);" onclick="getComment(' + i + ');">' + i + '</a> ';
		}
	}
	if(nowPage==pageCount){
		htm+='<span class="cur">'+pageCount+'</span> ' ;
	}else{
		htm+='<a href="javascript:;" onclick="getComment(' + pageCount+ ');">...'+pageCount+'</a>' ;
	}
		htm+=' <span><input name="textfield2" type="text" class="page_select" id="textfield2" value="'+nowPage+'"  onkeydown="if(event.keyCode==13) goToDetailPage(this,'+pageCount+');"/>' ;
		htm+='/'+pageCount+'页</span> <a href="javascript:;" class="next" onclick="getComment(' + next+ ');" ><em></em>下一页</a><span class="page_tip"></span>' ;
	if (pageCount < 2) {
		jQuery("#pageLine").remove() ;
	}else{
		jQuery("#pageLine").html(htm) ;
	}
}

function insertOp(isTemp,id,infoCatalogNo,opCatalogNo){
	if(isTemp==0){
		var url = "/action/crudcc.jsp?parentId="+id+"&infoCatalogNo="+infoCatalogNo+"&opCatalogNo="+opCatalogNo+"&flag=saveOp";
		jQuery.ajax({
			url:url,
			type : "post",
			dataType:'json',
			async : false,
			success : function(data) {
				var result_code = data[0].result_code;
				var result_message = data[0].result_message;
				var score = data[0].score;
				if (result_code =='0001') {
					score_tips(result_message,data);
				} else if (result_code =='0002')  {
					jQuery.jBox.tip(result_message);
				}
			}
		});
	}else{
		login();
	}
}
//通用评论评论的评论
function insertOpLogOp(opLogsId,obj){
	jQuery("#pubReplay").ajaxSubmit({
		type : "POST",
		dataType:"json",
		success : function(data) {
			var result_code = data[0].result_code;
			var result_message = data[0].result_message;
			if (result_code == '0001') {
				score_tips(result_message,data);
				var discStr = jQuery.trim((jQuery("#disc_" + opLogsId).html()));
				if(discStr!=''){
					jQuery("#disc_" + opLogsId).html("") ;
				}
		  		var count = parseInt(jQuery("#disc_"+opLogsId).parent("div").find("font").html()) ;
		  		jQuery("#disc_"+opLogsId).parent("div").find("font").html(count+1);
			} else if (result_code =='0002')  {
				jQuery.jBox.tip(result_message);
			}
		}
	});
}

function registerEvent() {
	var lis = jQuery("#pl_content_list_all li");
	lis.hover(function() {
		jQuery(".del").hide();
		lis.removeClass("backgray");
		jQuery(this).addClass("backgray");
		jQuery(this).find(".del").show();
	}, function() {
		jQuery(".del").hide();
		jQuery(this).removeClass("backgray");
	});
}

/**
*	详细页的评论分页输入页码是出发的事件
*/
function goToDetailPage(obj,pageTotal){
	if(isNaN(jQuery(obj).val()) || parseInt(jQuery(obj).val())>parseInt(pageTotal) || jQuery.trim(jQuery(obj).val())==''||jQuery.trim(jQuery(obj).val())<=0||jQuery.trim(jQuery(obj).val()).indexOf('.',0)>0){
      jQuery.jBox.tip("请您输入正确的页码！") ;
    }else{ // 正常跳转
		getComment(jQuery(obj).val());
    }
}


//用户操作
function voteTopic(parentId,infoCatalogNo){
	jQuery.ajax({
		type:"post" ,
		dataType:"json",
		url:"/action/crudcc.jsp" ,
		data:{
			parentId:parentId,
			flag:'saveOp',
			infoCatalogNo:infoCatalogNo,
			opCatalogNo:'LIKE'
	  	} ,
	  	success:function(data){
			var result_code = data[0].result_code;
			var result_message = data[0].result_message;
			var score = data[0].score;
		  	if('0001'==result_code){
				jQuery.jBox.tip(result_message);
		  		var count = parseInt(jQuery("#vote_"+parentId+" font").html()) ;
		  		jQuery("#vote_"+parentId+" font").html(count+1) ;
		  		jQuery("#vote_"+parentId+" a").attr("href", "javascript:void(0);") ;
		  		jQuery("#vote_"+parentId+" a").attr("onclick", "");
		  		jQuery("#vote_"+parentId+" a").html("已投票");
		  	}else if('0002'==result_code){
		  		jQuery.jBox.tip(result_message) ;
		  	}else if(jQuery.trim(data)==-1){
		  		login();
		  	}
	  	}
  }) ;
}

//用户操作
function voteTopic(parentId,infoCatalogNo){
	jQuery.ajax({
		type:"post" ,
		dataType:"json",
		url:"/action/crudcc.jsp" ,
		data:{
			parentId:parentId,
			flag:'saveOp',
			infoCatalogNo:infoCatalogNo,
			opCatalogNo:'LIKE'
	  	} ,
	  	success:function(data){
			var result_code = data[0].result_code;
			var result_message = data[0].result_message;
			var score = data[0].score;
		  	if('0001'==result_code){
				jQuery.jBox.tip(result_message);
		  		var count = parseInt(jQuery("#vote_"+parentId+" font").html()) ;
		  		jQuery("#vote_"+parentId+" font").html(count+1) ;
		  		jQuery("#vote_"+parentId+" img").attr("src", "/images_new/voted.png") ;
		  	}else if('0002'==result_code){
		  		jQuery.jBox.tip(result_message) ;
		  	}else if(jQuery.trim(data)==-1){
		  		login();
		  	}
	  	}
  }) ;
}
//喜欢操作
function getLikeCount(parentId,obj,userId,infoCatalogNo){
	getOplogCount(parentId,obj,userId,infoCatalogNo,'LIKE');
}

//喜欢操作_iframe
function getLikeCount_2(parentId,obj,userId,infoCatalogNo){
	getOplogCount(parentId,obj,userId,infoCatalogNo,'LIKE',1);
}

//分享操作
function getShareCount(parentId,obj,userId,infoCatalogNo){
	getOplogCount(parentId,obj,userId,infoCatalogNo,'SHARE');
}
//分享操作_iframe
function getShareCount_2(parentId,obj,userId,infoCatalogNo){
	getOplogCount(parentId,obj,userId,infoCatalogNo,'SHARE',1);
}
//收藏操作
function getFavoriteCount(parentId,obj,userId,infoCatalogNo){
	getOplogCount(parentId,obj,userId,infoCatalogNo,'FAVORITE');
}
//收藏操作_iframe
function getFavoriteCount_2(parentId,obj,userId,infoCatalogNo){
	getOplogCount(parentId,obj,userId,infoCatalogNo,'FAVORITE',1);
}


//用户操作
function getOplogCount(parentId,obj,userId,infoCatalogNo,oplogInfo,isIframe,notip){
	if(isIframe == 1){
		parent.login();
		return;
	}
	if(jQuery.trim(userId)=='' || userId == 0 ){
		login() ;
		return ;
	}
	jQuery.ajax({
		type:"post" ,
		dataType:"json",
		url:"/action/crudcc.jsp" ,
		data:{parentId:parentId,flag:'saveOp',infoCatalogNo:infoCatalogNo,opCatalogNo:oplogInfo} ,
	  	success:function(data){
			var result_code = data[0].result_code;
			var result_message = data[0].result_message;
		  	if('0001'==result_code){
				if(!notip){
					score_tips(result_message,data);
				}
		  		var count = parseInt(jQuery(obj).find("font").html()) ;
		  		if(!jQuery.isNumeric(count)){
		  			count = 0;
		  		}
		  		jQuery(obj).find("font").html(count+1) ;
		  	}else if('0002'==result_code){
		  		if(!notip){
		  			jQuery.jBox.tip(result_message) ;
		  		}
		  	}else if(jQuery.trim(data)==-1){
		  		login();
		  	}
	  	}
  }) ;
}
//显示好友请求框
function showRequest(tarUserId,id,callBack){
	if(id == 0){
		login();
	}else if(tarUserId == id){
		jQuery.jBox.tip("不能添加自己");
	}else{
		try{
			var e = e?e:window.event;//阻止事件冒泡传递
			if(window.event){//IE
				e.cancelBubble = true;
			}else{
				e.stopPropagation();
			}
		}catch(e){}
		jQuery.ajax({
			url:'/data_ajax/friend/before_friend_request.jsp?tarUserId='+tarUserId,
			dataType:'json',
			success:function(data){
				var json = data;
				data = data[1];
				if(data.is_allow == true){
					score_tips('添加成功',json);
			  		var arr = jQuery("a[href*='showRequest'][href*='"+tarUserId+"'],a[onclick*='showRequest'][onclick*='"+tarUserId+"']");
			  		arr.attr("href","javascript:void(0)");
			  		arr.attr("onclick","messageTo('"+data.myId+"','"+tarUserId+"','"+data.name+"','"+data.face+"','"+data.online+"')");
			  		arr.html("聊天");
			  		if(typeof callBack != 'undefined' && callBack != ''){
			  			setTimeout(function(){
				    		eval(callBack+"("+tarUserId+")");
				    	},2000)
			  		}
				}else{
					jQuery.jBox("iframe:/include/sendFriendRequest.jsp?id="+tarUserId+'&face='+data.face+'&sex='+data.sex+'&name='+data.name,{ border:5,buttons: {},id:'TBSend',draggable:false,title:null,width:375,height:210,iframeScrolling : 'no'});
				}
			}
		});
	}
}

function loadDiscuss(parentId,infoCatalogNo,pageIndex,id){
	var discStr = jQuery.trim((jQuery("#disc_" + id).html()));
	if(discStr!=''){
		jQuery("#disc_" + id).html("") ;
	}else{
		jQuery.ajax({
			url : "/tools/getDis.jsp",
			type : "post",
			async : false,
			data : {
				parentId : parentId,
				infoCatalogNo : infoCatalogNo,
				pageIndex : pageIndex,
				pageSize : 15,
				opCatalogNo : "REPLY"
			},
			success : function(data) {
				jQuery("#disc_" + id).html(data);
			}
		})
	}
}

//顶部好友请求
function getFriendRequest(){
	jQuery.ajax({
		url:'/data_ajax/friend/getRequest.jsp',
		dataType:'json',
		success:function(data){
			if(jQuery.trim(data)==-1){
		  		return false;
		  	}
		  	if(jQuery.trim(data) != ''){
			  	var html ='';
			  	for(var i in data){
			  		html += friendListHTML(data[i]);
			  	}
			  	jQuery("#requestKey .Nav_messLayer dl").append(html);
			  	var totalCount = data[0].total_count;
			  	if(totalCount != 0){
			  		jQuery("#requestKey").addClass("active");
			  		jQuery("#request_Num").html(totalCount);
			  	}
			  	jQuery("div.Allqingqiu").html("全部请求（"+totalCount+"条未处理）");
		  	}else{
		  		jQuery("div.Allqingqiu").html("全部请求（0条未处理）");
		  	}
		}	
	});
}
//好友请求列表的HTML
function friendListHTML(obj){	
	var face = obj.member_face == ''?'/images_new/no_photo/sex_'+obj.sex+'.png':obj.member_face;
	var html ='<dd id="request_'+obj.id+'">';
    html +='  <div class="face"><a href="/infocenter/index.jsp?userId='+obj.member_id+'"><img src="'+face+'" onerror="this.src=\'/images_new/no_photo/sex_'+obj.sex+'.png\'" width="48" height="48"></a></div>';
    html +='  <strong class="name"><a href="/infocenter/index.jsp?userId='+obj.member_id+'" target="_blank">'+obj.member_name+'</a></strong>';
    html +='  <span class="link"><a href="javascript:void(0);" onclick="handleRequest({requestId:'+obj.id+',flag:1})">接受</a><em>|</em><a href="javascript:void(0);" onclick="handleRequest({requestId:'+obj.id+',flag:2})">拒绝</a></span>';
    html +='</dd>';
    return html;
}
//未读消息列表的HTML
function messageListHTML(obj){
	var face = obj.send_user_face == ''?'/images_new/no_photo/sex_'+obj.send_user_sex+'.png':obj.send_user_face;
	if(obj.is_catalog == 1){
		var html ='<dd total="'+obj.new_msg_count+'">';
	    html +='  <div class="face"><a href="/infocenter/index.jsp?userId='+obj.send_user_id+'"><img src="'+face+'" onerror="this.src=\'/images_new/no_photo/sex_'+obj.send_user_sex+'.png\'" width="48" height="48"></a></div>';
	    html +='  <strong class="name" style="width:176px;"><a href="'+obj.url+'" target="_blank">'+obj.info_user_name+':'+obj.message_title+obj.new_count+'</a></strong>';
	    html +='</dd>';
	    return html;
	}else{
		var html ='<dd total="'+obj.new_msg_count+'">';
	    html +='  <div class="face"><a href="/infocenter/index.jsp?userId='+obj.send_user_id+'"><img src="'+face+'" onerror="this.src=\'/images_new/no_photo/sex_'+obj.send_user_sex+'.png\'" width="48" height="48"></a></div>';
	    html +='  <strong class="name" style="width:176px;"><a href="javascript:void(0);" onclick="getMessage(\''+obj.chat_id+'\')" >'+obj.send_user_name+':'+obj.message_content+obj.fileTypeName+obj.new_count+'</a></strong>';
	    html +='</dd>';
	    return html;
    }
}					

//处理好友请求
function handleRequest(obj){
	jQuery.ajax({
		url:'/data_ajax/friend/handleRequest.jsp',
		data:obj,
		dataType:'json',
		success:function(data){
			if(jQuery.trim(data) == '-1'){
				login();
				return false;
			}
			var code = data[0].result_code;
			if('0001' == code){
				jQuery("#request_"+obj.requestId).remove();
				jQuery("#request_main_"+obj.requestId).remove();
				var i = 0;//更改顶部数量变化
				jQuery(".Nav_mess dl dd").each(function(){
					i++;
				});
				jQuery.jBox.tip(data[0].result_message,1);
				jQuery("div.Allqingqiu").html("全部请求（"+i+"条未处理）");
				if(i == 0){
					jQuery(".Nav_mess").removeClass("active");
					jQuery("#request_Num").html("");
				}
			}else{
				jQuery.jBox.tip('系统错误,请联系管理员!');
			}
		}
	});
}

//创建分组
function createGroup(memId){
	if(memId == 0){
		login();
	}
	jQuery.jBox.open("iframe:/member/member_newgroup.jsp",'新建分组',520,600,{border:5,top:0,id:'group',iframeScrolling:'no' })
}
//点击聊天按钮弹出对话框
function messageTo(loginUserId,userID,userName,face,online){
	jQuery.jBox.tip("敬请期待!");
	return;
	if(loginUserId == 0){
		login();
		return;
	}else if(loginUserId == userID){
		jQuery.jBox.tip("不能和自己聊天~");
		return;
	}
	try{
		var e = e?e:window.event;//阻止事件冒泡传递
		if(window.event){//IE
			e.cancelBubble = true;
		}else{
			e.stopPropagation();
		}
	}catch(e){
		
	}
	//var chat = parseInt(loginUserId)<=parseInt(userID)?(loginUserId+'_'+userID):(userID+'_'+loginUserId);
	if(typeof createChat == 'undefined'){
		if(typeof parent.createChat == 'undefined'){
			jQuery.jBox.tip("敬请期待");
		}else{
			parent.createChat({
					uid:userID,
					name:userName,
					src:face,
					online:online,
					sex:1
				});
		}
	}else{
		createChat({
			uid:userID,
			name:userName,
			src:face,
			online:online,
			sex:1
		});
	}
	
}

//用户关注插入 flag = 0 取消关注
function AttentionInsert(id,flag){
	if(typeof flag == 'undefined'){
		flag = 1;
	}
	jQuery.ajax({
		url:'/data_ajax/friend/saveAttention.jsp?flag='+flag+'&idList='+id,
		dataType:'text',
		success:function(data){
			var data = parseInt(data);
			if(data == -1){
				login();
				return;
			}else{
				if(flag == 0){
					jQuery.jBox.tip("操作成功!");
				}else{
					jQuery.jBox.tip("关注成功!");
				}
				setTimeout(function(){window.location.reload()},1000);
			}
		}
	})
}
//好友圈关注
function addPublicAttention(myId,id,name,obj){
		if(myId == 0){
			login();
			return;
		}
		jQuery.ajax({
			url:'/data_ajax/friend/saveAttention.jsp?idList='+id,
			dataType:'text',
			success:function(data){
				var data = $.trim(data);
				if(data == '-1'){
					login();
					return;
				}else{
					//jQuery.jBox.tip('关注成功!');
					//jQuery(obj).attr("onclick","messageTo('"+myId+"','"+id+"','"+name+"')");
					//jQuery(obj).html("聊天");
					window.location.reload();
				}
			}
		})
	}

//跳转
function gotoPage(obj,pageTotal){
	var num = jQuery(obj).val();
    if(isNaN(num) || parseInt(num)>parseInt(pageTotal) || jQuery.trim(num)==''||jQuery.trim(num)<=0||jQuery.trim(num).indexOf('.',0)>0){
      jQuery.jBox.tip("请您输入正确的页码！") ;
    }else{ // 正常跳转
    	var hrefUrl = window.location.href;
    	if(hrefUrl.indexOf('service/detail_for_') != -1){
    		hrefUrl = hrefUrl.substring(hrefUrl.lastIndexOf('_')+1,hrefUrl.lastIndexOf('.'));
    		window.location.href='/service/detail.jsp?id='+hrefUrl+'&pageIndex='+num;
    		return;
    	}
    	var url = orderURL(window.location.search,"pageIndex",jQuery(obj).val());
    	window.location.href= url;
    }
}

//跳转
function gotoPageForTopic(id,obj,pageTotal){
	var num = jQuery(obj).val();
    if(isNaN(num) || parseInt(num)>parseInt(pageTotal) || jQuery.trim(num)==''||jQuery.trim(num)<=0||jQuery.trim(num).indexOf('.',0)>0){
      jQuery.jBox.tip("请您输入正确的页码！") ;
    }else{ // 正常跳转
    	//var url = orderURL(,"pageIndex",jQuery(obj).val());
    	//window.location.href= url;
    	window.location.href='/service/detail.jsp?id='+id+'&pageIndex='+num;
    }
}

//search 要更新的变量(一般为window.location.search)
//name 要更新的参数名字
//要更新的参数值
function orderURL(search,name,keyID){
	//判断是否已选中板块
	if(search.indexOf(name+'=')>0){
		var which = '';
		var beginIndex = search.indexOf(name);//定位到Condition
		var Index = search.indexOf("=",beginIndex,1);//定位到condition的第一个等号
		var num = search.indexOf("&",Index,1);//定位到参数结束
		if(num==-1){
			which = search.substring(Index+1);
		}else{
			which = search.substring(Index+1,num);
		}//查找参数结束!
		search = search.replace(name+"="+which,name+"="+keyID);//替换参数
		return search;
	}else{
		if(search!=''){
			return  search+"&"+name+"="+keyID;
		}else{
			return  "?"+name+"="+keyID;
		}
	}
}
/**
*	str = 前置文字 json 后台返回的json数据
**/
function score_tips(str,json,time){
	try{
		var score = json[0].score;
		var prestige = json[0].prestige;
		var is_level_up = json[0].is_level_up;
		var tips_str = '';
		if(typeof time == 'undefined' || time <=0){
			time = 2000;
		}
		
		if(is_level_up == 0 && (score > 0 || prestige > 0)){
			var scrollTop = jQuery(document).scrollTop();
			var top = (jQuery(window).height()/2)+scrollTop-50;
			var left = jQuery(window).width()/2-175;
			var html = '<div id="score_tips" style="left:'+left+'px;top:'+top+'px;z-index: 9999;position: absolute ;background: url(/images_new/growth/score_add.png) no-repeat;width: 350px;height: 111px;">';
			html += '	<div style="width: 223px;height: 44px;margin-top: 43px;margin-left: 104px;">';
			html += '		<ul style="text-align: center;font-size: 16px;font-weight: bold;">';
			if(prestige > 0){
				html += '			<li style="float: left;height: 44px;line-height: 44px;width: '+ ( score>0?"110":"220") +'px;">经验<font style="font-size: 20px;color: #ff6a00;">+'+prestige+'</font></li>';
			}
			if(score > 0){
				html += '			<li style="float: left;height: 44px;line-height: 44px;width: '+ (prestige>0?"110":"220") +'px;">积分<font style="font-size: 20px;color: #ff6a00;">+'+score+'</font></li>';
			}
			html += '		</ul>';
			html += '	</div>';
			html += '</div>';
			jQuery('body').prepend(html);
			setTimeout(function(){
				jQuery("#score_tips").remove();
			},time);
			return;
		}else if(is_level_up == 1){
			var scrollTop = jQuery(document).scrollTop();
			var top = (jQuery(window).height()/2)+scrollTop-175;
			var left = jQuery(window).width()/2-290;
			var rank_name = json[0].rank_name;
			var html = '<div id="score_tips" style="left:'+left+'px;top:'+top+'px;z-index: 9999;position: absolute ;background: url(/images_new/growth/level_up.png) no-repeat;width: 580px;height: 353px;">';
			html += '	<div style="width: 464px;height: 139px;margin-top: 164px;margin-left: 62px;">';
			html += '		<ul style="text-align: center;font-size: 16px;font-weight: bold;">';
			html += '			<li style="float: left;height: 40px;line-height: 40px;width: 100%;font-size: 18px;">恭喜您上升为<font style="color: #ff6a00;">'+rank_name+'</font>，谢谢您对铁臂兄弟连的支持！</li>';
			if(prestige > 0){
				html += '		<li style="float: left;height: 100px;line-height: 100px;width: '+ ( score>0?"50%":"100%") +';"><img src="/images_new/growth/prestige.jpg" style="vertical-align: middle;margin-bottom: 23px;" />经验<font style="font-size: 36px;color: #ff6a00;">+'+prestige+'</font></li>';
			}
			if(score > 0){
				html += '		<li style="float: left;height: 100px;line-height: 100px;width: '+ ( prestige>0?"50%":"100%") +';"><img src="/images_new/growth/score.jpg" style="vertical-align: middle;margin-bottom: 23px;" />积分<font style="font-size: 36px;color: #ff6a00;">+'+score+'</font></li>';
			}
			html += '		</ul>';
			html += '	</div>';
			html += '</div>';
			jQuery('body').prepend(html);
			setTimeout(function(){
				jQuery("#score_tips").remove();
			},time);
		}else if(str != ''){
			jQuery.jBox.tip(str);
		}
	}catch(e){
		jQuery.jBox.tip(str);
		//show_tip(str);
	}
}

//异步请求获取积分增加
/*
function getHongbao(){
	$.ajax({
		url:'/data_ajax/ajax_data.jsp',
		data:{flag:'hongbao'},
		dataType:'TEXT',
		success:function(data){
			data = parseInt(data);
			if(data > 0){
				jQuery("#score_tips").remove();
				var scrollTop = jQuery(document).scrollTop();
				var top = (jQuery(window).height()/2)+scrollTop-175;
				var left = jQuery(window).width()/2-290;
				var score = data;
				var html = '<div id="hongbao_tips" style="left:'+left+'px;top:'+top+'px;z-index: 9999;position: absolute ;background: url(/images_new/growth/hongbao_tip.png) no-repeat;width: 580px;height: 353px;">';
				html += '	<div style="width: 464px;height: 139px;margin-top: 164px;margin-left: 62px;">';
				html += '		<ul style="text-align: center;font-size: 16px;font-weight: bold;">';
				html += '			<li style="float: left;height: 40px;line-height: 40px;width: 100%;font-size: 18px;">恭喜您获得红包，谢谢您对铁臂兄弟连的支持！</li>';
				html += '			<li style="float: left;height: 100px;line-height: 100px;width: 100%;"><img src="/images_new/growth/score.jpg" style="vertical-align: middle;margin-bottom: 23px;" />积分<font style="font-size: 36px;color: #ff6a00;">+'+score+'</font></li>';
				html += '		</ul>';
				html += '	</div>';
				html += '</div>';
				jQuery('body').prepend(html);
				setTimeout(function(){
					jQuery("#hongbao_tips").remove();
				},3000);
			}
		}
	})
}
*/
function show_reg(){
	jQuery.jBox("iframe:/include/infocenter/registration.jsp", {
		border:5,
		title : null,
		opacity : 0.3,
		width : 603,
		top : '20%',
		height : 339,
		showIcon : false,
		iframeScrolling : 'no',
		buttons : {}
	});
}

jQuery(function(){
	//分享按钮的点击事件
	jQuery(".bds_tsina,.bds_qzone,.bds_tqq,.bds_renren,.bds_taobao,.bds_tqf,.activity_share").click(function(){
		if(typeof info_catalog_no == 'undefined' || info_catalog_no == ''){
			info_catalog_no = 'TOPIC';
		}
		if(user_id == 0){
			return;
		}
		if(jQuery(this).attr("parent_id") != null){
			parent_id = jQuery(this).attr("parent_id");
		}
		getShareCount(parent_id,this,user_id,info_catalog_no)
	});
})
//分享按钮的点击事件
jQuery("#bdshare_l_c a").live("click",function(){
	if(typeof info_catalog_no == 'undefined' || info_catalog_no == ''){
		info_catalog_no = 'TOPIC';
	}
	if(user_id == 0){
		return;
	}
	getShareCount(parent_id,this,user_id,info_catalog_no)
});


//删除好友
function deleteInfoFriend(tarUserName,tarUserId){
	var submit = function (v, h, f) {
    if (v == 'ok'){
    	jQuery.ajax({
		url:'/data_ajax/friend/friend_delete.jsp?friendUserId='+tarUserId,
		dataType:'JSON',
		success:function(data){
			var result_code = data[0].result_code;
			var result_message = data[0].result_message;
			var score = data[0].score;
			if (result_code =='0001') {
				jQuery.jBox.tip(result_message)
			}
		}
	});
    }
    return true;
	};
	jQuery.jBox.confirm("确定解除与<span  style='font-weight: bold;'> "+tarUserName+" </span>的好友关系吗？", "提示", submit);
}

//特殊字符出现次数!
function countInstances(mainStr, subStr)
{
    var count = 0;
    var offset = 0;
    do
    {
        offset = mainStr.indexOf(subStr, offset);
        if(offset != -1)
        {
            count++;
            offset += subStr.length;
        }
    }while(offset != -1)
    return count;
}