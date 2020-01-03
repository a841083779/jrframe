jQuery(function(){
	jQuery(".guide").hover(function(){
		jQuery(this).toggleClass("ghover");
	},function(){
		jQuery(this).removeClass("ghover");
	});
})

jQuery(function(){
	jQuery("div.slc div").hover(function(){
		jQuery(this).toggleClass("slcHover");
	},function(){
		jQuery(this).removeClass("slcHover");
	});
})

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

function sosuo(catalog,factoryid,tonandmeter,id,order,keyword){
		jQuery("#catalognum").val(catalog) ;
     	jQuery("#factory_id").val(factoryid) ;
     	jQuery("#tonandmeter").val(tonandmeter) ;
     	jQuery("#key_word").val(keyword);
      	jQuery("#order").val(order) ;
		if(''==jQuery.trim(catalog)){
			jQuery("#catalognum").remove() ;
		}
     if(''==jQuery.trim(factoryid)){
        jQuery("#factory_id").remove() ;
     }
     if(''==jQuery.trim(tonandmeter)) {
       jQuery("#tonandmeter").remove() ;
     }
      if(''==jQuery.trim(order)){
       jQuery("#order").remove() ;
     }
     if(''==keyword||undefined ==keyword){
     	jQuery("#key_word").remove();
     }
     jQuery("#theform").attr("action","") ;
     jQuery("#theform").attr("method","get") ;
     jQuery("#theform").submit() ;
  }
  
var t3 = n3 = 0;
function showAuto3(){
	n3 = n3 >=(count3 - 1) ? 0 : ++n3;
	jQuery(".thn li").eq(n3).trigger('click');
	jQuery("#showNumId").html(n3+1);
}
function showPre3(){
	n3 = n3 <=0 ? (count3 - 1) : --n3;
	jQuery(".thn li").eq(n3).trigger('click');
	jQuery("#showNumId").html(n3+1);
}

//栏目提示
function ts(){
 $.jBox.tip("栏目资料完善中，敬请期待！");
}
//口碑列表页
jQuery(function(){
	$(".diy_pic ul li a").on("click",function(){
		var src=$(this).find('img').attr("src")		
		if($(this).parent().siblings().length!=0){
			$(this).addClass('selected').parent().siblings().find('a').removeClass('selected').
		parentsUntil('.diy_pic').siblings('.pic_yuan').show().find('img').attr({"src":src,"width":"100%","height":"100%"})
			}else{
				$(this).addClass('selected').parentsUntil('.diy_pic').siblings('.pic_yuan').show().find('img').attr({"src":src,"width":"100%","height":"100%"})
				}
		
		})
	$('.pic_yuan').find('a').on("click",function(){
		$(this).parent().siblings('ul').find('li a').removeClass('selected');
		$(this).parent().hide();
		})
})

/*新网站头部需要*/
$(document).ready(function(e) {
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
	//选择区域
	$('.j_area_box').mouseenter(function(){
		$(this).addClass('j_area_box_hover');
	}).mouseleave(function(){
		$(this).removeClass('j_area_box_hover');
	});
	//产品分类按钮弹层
    $(".scl ul li").hover(function(){
		$(this).toggleClass("cur");
	},function(){
		$(this).removeClass("cur");
	});
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
});

