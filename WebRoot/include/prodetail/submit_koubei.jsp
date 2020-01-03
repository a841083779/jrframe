<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" errorPage="" %>

<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
%>
	<div class="wfull l mb10" id="myTab2_ContentA4">
    <form name="comment_form" id="comment_form" method="post" action="/action/ajax.jsp">
      <div class="sentComment" name="sentComment" id="sentComment">
        <div class="pdTab" id="00a">
          <ul style="width:445px;">
            <li class="select">我要评论</li>
          </ul>
          <div class="rbtip"> 了解更多获奖明细及活动公告请加 <b>QQ群： 215179483</b> </div>
        </div>
        <div class="scc">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="48" colspan="2" align="left" class="td_bot"><b>产品评分：</b>在星星上滑动鼠标点击即可评分<span>( 您对爱机的评价可以帮助更多人选机*为必填项 )</span></td>
          </tr>
        <tr>
          <td width="19%" align="right" valign="top"><b>*</b>价格：</td>
          <td width="81%" valign="top">
          <div class="xing" id="price_1" style="float:left; margin-left:3px;"></div><span class="xing_tip">点击星星为该机型价格打分</span>
           </td>
        </tr>
        <tr>
          <td align="right" valign="top"><b>*</b>质量：</td>
          <td> <div class="xing" id="zhiliang_1" style="float:left;margin-left:3px;"></div><span class="xing_tip">点击星星为该机型质量打分</span></td>
        </tr>
        <tr>
          <td align="right" valign="top"><b>*</b>性能：</td>
          <td><div class="xing" id="xingneng_1" style="float:left;margin-left:3px;"></div><span class="xing_tip">点击星星为该机型性能打分</span></td>
        </tr>
        <tr>
          <td align="right" valign="top"><b>*</b>售后：</td>
          <td> <div class="xing" id="shouhou_1" style="float:left;margin-left:3px;"></div><span class="xing_tip">点击星星为该机型售后打分</span></td>
        </tr>
        <tr>
          <td align="right" valign="top"><b>*</b>评价：</td>
          <td><textarea id="content" name="content" dataType="Require" msg="请输入评价内容！" placeholder="沉默不是金，来一吐为快吧！"></textarea></td>
        </tr>
        <tr>
          <td colspan="2" style="padding-left:65px; padding-top:10px;"><ul class="showpic clearfix" id="addImgs_show">
           </ul></td>         
        </tr>
        <tr>
          <td height="56">&nbsp;</td>
          <td><span class="tip">10~2000个字</span></a></td>
        </tr>
        <tr>
          <td align="right">上传图片：</td>
          <td><%	if(username.equals("")){ %><img src="http://product.21-sun.com/activity/koubei/images/1_22.jpg" onclick="login();" width="77" height="30" /><%}else{%><span id="addImgs"></span><%}%></td>
        </tr>
        <tr>
          <td height="39" class="td_bot">&nbsp;</td>
          <td class="td_bot">单张图片不超过10MB，尺寸不小于300*300px,支持jpg、png和bmp。</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td align="left">
            <p><input id="button" name="button" value="&nbsp;" type="button"<%	if(username.equals("")){ %>  onclick="login();"<%}else{%>onclick="doComments();"<%}%> class="ti_btn" style="border:0" /></p>
         </td>
        </tr>
      </table>
        </div>
      </div>
      <input type="hidden" name="flag" value="new_save_comment" />
      <input type="hidden" name="product_id" value="<%=id %>" />
      <input type="hidden" name="score1" id="score1" />
      <input type="hidden" name="score2" id="score2" />
      <input type="hidden" name="score3" id="score3" />
      <input type="hidden" name="score4" id="score4" />
      </form>
    </div>
	<script>
	
	//获得评论分数
	jQuery("#pricescore").raty({
		path: "/koubei/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
	jQuery("#abilityscore").raty({
		path: "/koubei/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
	jQuery("#qualityscore").raty({
		path: "/koubei/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
	jQuery("#servicescore").raty({
		path: "/koubei/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
function getAllComment(){
		jQuery.getJSON("/action/ajax.jsp?flag=get_all_comment&callback=?&pid=<%=id %>",function(data){
			var s1 = (parseInt(data.score1,10)/20);
			var s2 = (parseInt(data.score2,10)/20);
			var s3 = (parseInt(data.score3,10)/20);
			var s4 = (parseInt(data.score4,10)/20);
			var sall = ((s1*5)+(s2*5)+(s3*5)+(s4*5));
			jQuery("#totalScoreId").html(sall);
			jQuery("#pricescore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#abilityscore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#qualityscore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#servicescore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s4
			});
		});
	}
	getAllComment();
	
	//评论提交	
	jQuery("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({		
		path: "/koubei/img", //图片路径  
		half : true ,
		score : 0
	});

	jQuery(function(){
		jQuery("#addImgs").JrUpload({
			remotUrl : "http://resource.21-sun.com/upload.jsp",
			folder : "product/koubei" ,
			sizeLimit:10*1024*1024, //10M
			multi : true,
			beforeCallback : "beforeCallback",
			callback : "setImgs" ,
			style : "width:98px;height:30px;",
			buttonImg : "<%=Common.getDomain(request) %>/activity/koubei/images/1_22.jpg" ,
			buttonImgWidth : 77 ,
			buttonImgHeight : 30
		});
	});
	function beforeCallback(){
		$.jBox.tip("图片上传中，请稍后。。。", "loading");
	}
	function setImgs(data){
		var imgs = data.split(",");
		var htm = '';
		var f = 'http://resource.21-sun.com';
		for(var i=0;i<imgs.length;i++){
			htm += '<li><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" name="img" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
		}
		jQuery("#addImgs_show").append(htm);
		regEvent();
		$.jBox.closeTip();
	}
	function regEvent(){
		jQuery("#addImgs_show>li").mouseover(function(){
			jQuery(".img_delete").hide();
			jQuery(this).find(".img_delete").show();
		});
		jQuery("#addImgs_show>li").mouseout(function(){
			jQuery(".img_delete").hide();
		});
	}
	function removeThis(o){
		var attrId = jQuery(o).attr("attrId")+"";
		if(attrId=='0'){
			jQuery(o).parent().remove();
		}else{
			if(confirm("确定删除该张图片吗？")){
				jQuery(o).parent().remove();
			}
		}
	}
	</script>