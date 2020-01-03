$.fn.inputholder=function(){
	var dval=$(this).val();
	$(this).focus(function(){
		$(this).val('').addClass('focus');
		}).blur(function(){
		if($(this).val()==''){
			$(this).val(dval).removeClass('focus');
			}
		});
	};
var inputholder=$('.inputholder');
if(inputholder.length){
	inputholder.each(function() {
      $(this).inputholder()
   })
};
$('.imgEff').find('img').hover(function(){
	$(this).stop(1,1).animate({opacity:0.7},160);
},function(){
	$(this).stop(1,1).animate({opacity:1},160);
});

//全部分类
$("a.CloseAllBtn").click(function(){
	$(".nav_proCate").removeClass("bigBtnCur");
	return false;
});

$(".nav_proCate").children('.n').click(function(){
	   var par = $(this).parent();
	   var cls = par.attr("class");
	   if(cls.indexOf("bigBtnCur")!=-1){
		   par.removeClass("bigBtnCur");
	   }else{
		   par.addClass("bigBtnCur");
	   }
 });


//topbar layer
$('.j_mobile,.j_service,.j_siteNav').mouseenter(function(){
	$(this).addClass('j_hover');
}).mouseleave(function(){
	$(this).removeClass('j_hover');
});
$('.j_proNav').mouseenter(function(){
	$(this).addClass('j_proNav_hover');
}).mouseleave(function(){
	$(this).removeClass('j_proNav_hover');
});

//选项卡
$.fn.tab=function(){
	var $key=$(this).find('.j_tab_key'),
		 $val=$(this).find('.j_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.j_tab').each(function() { $(this).tab()});
$.fn.tab=function(){
	var $key=$(this).find('.t_tab_key'),
		 $val=$(this).find('.t_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.t_tab').each(function() { $(this).tab()});


//产品列表分类
$('.txd_filter_plist_cat li:first').addClass('cur');
$('.txd_filter_plist_brand li:first').addClass('cur');
$('.txd_filter_plist li').hover(function(e) {
	$(this).addClass('cur').siblings().removeClass('cur');
});



//产品列表
$('.txd_ppro_list li').hover(function(e) {
	$(this).find('.tpp_prie').show();
},function(e) {
	$(this).find('.tpp_prie').hide();
});


//产品类别筛选
$('.txd_shaixuan dl:last').css('border-bottom','none');


$('.txd_shaixuan dl').each(function(index, element) {
	var tsx_h = $(this).find('.tsx_ddheight').height();
	if(tsx_h<=38){
		$(this).find('.tsx_more').hide();
	}
});

$('.txd_shaixuan dl .tsx_more').click(function(){
    var na = $(this).parent().find('dd'); 
    na.toggleClass('txd_sx_auto'); 
    if( na.hasClass('txd_sx_auto') ){ 
	
        $(this).html('收起');
		$(this).addClass('tsx_more_close');
    }else{ 
        $(this).html('更多'); 
		$(this).removeClass('tsx_more_close');
	} 
});

//产品类别列表
//$('.txd_sx_plist li:last').css('border-bottom','none');

//代理商产品右侧
$('.txd_dlr_plist li:first').addClass('hover');
$('.txd_dlr_plist li').hover(function(e) {
	$(this).addClass('hover').siblings().removeClass('hover');
});


//询价表单
$('.txd_order_list li').hover(function(e) {
	$(this).addClass('hover');	
},function(e) {
	$(this).removeClass('hover');
});



//产品分类结束
function showinquery(pid,factoryid){
jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid+"&factoryid="+factoryid, {
	
title: "在线询价",
width: 769,
height: 580,
top: '10%',
opacity:0.75,
iframeScrolling : 'no',
buttons: { '关闭': false }
});
jQuery(".jbox-button-panel").attr("style","display:none;") ;
jQuery(".jbox-title-panel").attr("style","display:none;") ;
jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
}
//询价猫在线询价
function showinquery_cat(pid,factoryid){
jQuery.jBox("iframe:/include/products/product_order_cat_miao.jsp?productid="+pid+"&factoryid="+factoryid, {		
title: "在线询价",
width: 769,
height: 600,
top: '5%',
opacity:0.75,
iframeScrolling : 'no',
buttons: { '关闭': false }
});
jQuery(".jbox-button-panel").attr("style","display:none;") ;
jQuery(".jbox-title-panel").attr("style","display:none;") ;
jQuery(".jbox-close").css({width:"48px", height:"48px",top:"0px",right:"-20px"});
}   
//上海成基专题询价
function showinquerySHCJ(pid,factoryid,proName){
	jQuery.jBox("iframe:/include/products/product_order_shcj.jsp?productid="+pid+"&factoryid="+factoryid+"&proName="+proName, {
	title: "在线询价",
	width: 720,
	height: 435,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
//代理商电话查看
function lianXiDianHua(id){
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return subSr;
				}
			}
		});
	}

	/**  
 * 图片出错处理，可以重加载指定的图片。超过重试次数仍不能正常显示的，显示缺省图片。  
 * 示例<img onerror="showImgDelay(this,'1.jpg',2)" src="1.jpg">  
 *  
 * imgObj:img节点对象  
 * imgSrc:出错时加载的图片地址  
 * maxErrorNum:最大出错次数，防止出现死循环  
 */  
function showImgDelay(imgObj,imgSrc,maxErrorNum){  
    //showSpan.innerHTML += "--" + maxErrorNum;  
    if(maxErrorNum>0){  
        imgObj.onerror=function(){  
            showImgDelay(imgObj,imgSrc,maxErrorNum-1);  
        };  
        setTimeout(function(){  
            imgObj.src=imgSrc;  
        },100);  
    }else{  
        imgObj.onerror=null;  
        imgObj.src="http://product.21-sun.com/uploadfiles/no_small.gif";  
    }  
} 

//置顶
  $('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});

