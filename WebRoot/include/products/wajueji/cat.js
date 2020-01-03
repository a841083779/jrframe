jQuery(function(){
	//分享按钮的点击事件
	jQuery("#bdshare").click(function(){
		if( typeof user_id == 'undefined' || user_id == 0 ){
			return;
		}
		var parent_id = jQuery(this).attr("parent_id");
		getOplogCount(parent_id,this,user_id,"CAT_ACTIVITY","SHARE")
	});
})

//用户操作
function getOplogCount(parentId,obj,userId,infoCatalogNo,oplogInfo,isIframe){
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
		url:"http://www.wajueji.com/action/crudcc.jsp" ,
		data:{parentId:parentId,flag:'saveOp',infoCatalogNo:infoCatalogNo,opCatalogNo:oplogInfo} ,
	  	success:function(data){}
  }) ;
}
function showinquery(productid){
    	jQuery.jBox("iframe:http://product.21-sun.com/include/products/product_order.jsp?productid="+productid, {
	    title: "在线询价",
	    width: 720,
	    height: 435,
	    iframeScrolling : 'no',
	    buttons: { '关闭': false }
	    });
	    jQuery(".jbox-button-panel").attr("style","display:none;") ;
 }