﻿//产品分类
jQuery.fn.extend({
	allenMenu: function() {
		jQuery(this).children('ul').children('li').hover(
			function() {
				if(!jQuery(this).children('ul').hasClass('focus')) {
					jQuery(this).addClass('focus');
					jQuery(this).children('div.nb01:first').stop(true, true).animate({ height:'show' }, 0);
				}
			},
			function() {
				jQuery(this).removeClass('focus');
				jQuery(this).children('div.nb01:first').stop(true, true).animate({ height:'hide', opacity:'hide' }, 0);
			}
		);
		jQuery(this).children('ul').children('li').children('div.nb01').hover(
			function() {
				jQuery(this).addClass('focus');
			},
			function() {
				jQuery(this).removeClass('focus');
			}
		);
	}
});
jQuery(document).ready(function() {
	jQuery('#sort').allenMenu();
});
//产品分类结束
    function showinquery(pid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order_s.jsp?productid="+pid+"&factoryid="+factoryid, {
	title: "在线询价",
	width: 769,
	height: 480,
	top: '10%',
	opacity:0.75,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
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
//产品分类结束
    function showinquery_tuan(pid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order_tuan.jsp?productid="+pid+"&factoryid="+factoryid, {
	title: "在线询价",
	width: 769,
	height: 620,
	top: '10%',
	opacity:0.75,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
    }
//置顶
$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
 