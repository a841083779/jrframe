/**
 * index
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	require('./common');
	
	//console.log('hello '+base.getType())

	$('.allCates').addClass('indexCates');

	require('slide');
	/*$('.adBox01').slide({
		imgattr:'slide-src'
	});*/
	
	//优买团
	$('.tuanList .tuanBox:first').stop().animate({width:600},'fast');
	$('.tuanList .tuanBox').mouseenter(function(){
		$(this).stop().animate({width:600},'fast').siblings().stop().animate({width:200},'fast');
	});
	
	//挖掘机左侧筛选
	require('sele');
	$('.wjj_sele01').sele({
		act:"click",
		callback:function(val,text){
			$("#wjj_catalog").val(val);
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadBrand","catalognum":val},
		        success:function(data){
		              $("#wjj_brand_list").html(data);
		        }
	        });
		}    
	});
	
	$('.wjj_sele02').sele({
		act:"click",
		callback:function(val,text){
			    $("#wjj_brand").val(val);
				var catalognum=$('#wjj_catalog').val();
				$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadPro","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#wjj_pro_list").html(data);
		        }
	            });
		}    
	});
	
	$('.wjj_sele03').sele({
		act:"click",
		callback:function(val,text){
			$("#wjj_pro").val(val);
		}    
	});
	
	//装载机左侧筛选
	$('.zzj_sele01').sele({
		act:"click",
		callback:function(val,text){
			$("#zzj_catalog").val(val);
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadBrand","catalognum":val},
		        success:function(data){
		              $("#zzj_brand_list").html(data);
		        }
	        });
		}    
	});
	$('.zzj_sele02').sele({
		act:"click",
		callback:function(val,text){
				$("#zzj_brand").val(val);
				var catalognum=$('#zzj_catalog').val();
				$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadPro","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#zzj_pro_list").html(data);
		        }
	            });
		}    
	});
	$('.zzj_sele03').sele({
		act:"click",
		callback:function(val,text){
			$("#zzj_pro").val(val);
		}    
	});
	
	//起重机左侧筛选
	$('.qzj_sele01').sele({
		act:"click",
		callback:function(val,text){
			$("#qzj_catalog").val(val);
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadBrand","catalognum":val},
		        success:function(data){
		              $("#qzj_brand_list").html(data);
		        }
	        });
		}    
	});
	$('.qzj_sele02').sele({
		act:"click",
		callback:function(val,text){
				$("#qzj_brand").val(val);
				var catalognum=$('#qzj_catalog').val();
				$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadPro","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#qzj_pro_list").html(data);
		        }
	            });
		}    
	});
	$('.qzj_sele03').sele({
		act:"click",
		callback:function(val,text){
			$("#qzj_pro").val(val);
		}    
	});
	
	//混凝土左侧筛选
	$('.hnt_sele01').sele({
		act:"click",
		callback:function(val,text){
			$("#hnt_catalog").val(val);
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadBrand","catalognum":val},
		        success:function(data){
		              $("#hnt_brand_list").html(data);
		        }
	        });
		}    
	});
	$('.hnt_sele02').sele({
		act:"click",
		callback:function(val,text){
				$("#hnt_brand").val(val);
				var catalognum=$('#hnt_catalog').val();
				$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"indexLoadPro","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#hnt_pro_list").html(data);
		        }
	            });
		}    
	});
	$('.hnt_sele03').sele({
		act:"click",
		callback:function(val,text){
			$("#hnt_pro").val(val);
		}    
	});
	
	$('.txd_mpro_list li').mouseenter(function(e) {
		$(this).find('.mp_price').show();
		$(this).find('#detail').show();
		$(this).find('#summary').hide();
	}).mouseleave(function(){
		$(this).find('.mp_price').hide();	
		$(this).find('#detail').hide();
		$(this).find('#summary').show();
	});
	
	require('tab');
	$('.rankTab').tab({
		posi_auto:false,
		act:'mouseenter'
	});
	$('.otherBox').tab({
		posi_auto:false,
		act:'mouseenter'
	});
	
	require('album');
	require('scroll-bar');
	//获取口碑数据
	function koubeiList(catalog){
		
		var getUrl='/create_index/index_'+catalog+'_koubei.htm';
		$.ajax({
			type:'get',
			url:getUrl,
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#kbListAjax').html(html);
				$('.zoomList').album({
					type:2
				})
				$('.kbList').scrollBar();
			}
		});
	};
	//获取数据
	koubeiList('wjj');
	
	
	//头部右侧
	function indexTop(){
		
		$.ajax({
			type:'get',
			url:'/create_index/index_top_inquiry.htm',
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#top_inquiry').html(html);
			}
		});
		
		$.ajax({
			type:'get',
			url:'/create_index/index_top_comment.htm',
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#top_koubei').html(html);
			}
		});
		
	};
	//头部右侧获取数据
	indexTop();
	
	
	$('.kb_hd a').click(function(e){
		e.preventDefault();
		var _this=$(this);
	    var catalog=$(this).data('val');
		koubeiList(catalog);
		$(this).parent().addClass('cur').siblings().removeClass('cur')
	})
	
	//二手机下拉
	$('.used_sele01').sele({
		act:"click",
		callback:function(val,text){
				$("#used_catalog").val(val);
		}    
	});
	$('.used_sele02').sele({
		act:"click",
		callback:function(val,text){
				$("#used_brand").val(val);
		}    
	});
	
	//刷新二手
	$('#reloadUsed').click(function(e){
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"reloadUsed"},
		        success:function(data){
		              $("#used_list").html(data);
		        }
	        });
	});
	//搜索挖掘机
	$('#searchWjj').click(function(e){
		var catalognum=$('#wjj_catalog').val();
        var brand=$('#wjj_brand').val();
        var pro=$('#wjj_pro').val();	
		var url='http://product.21-sun.com/products/prolist.jsp?catalog='+catalognum;
        if(brand!=''){
			url='http://product.21-sun.com/products/prolist.jsp?factory='+brand+'&catalog='+catalognum;
		}	
        if(pro!=''){
			url='http://product.21-sun.com/proDetail/'+pro;
		}	
        window.open(url);		
	});
	//搜索装载机
	$('#searchZzj').click(function(e){
		var catalognum=$('#zzj_catalog').val();
        var brand=$('#zzj_brand').val();
        var pro=$('#zzj_pro').val();	
		var url='http://product.21-sun.com/products/prolist.jsp?catalog='+catalognum;
        if(brand!=''){
			url='http://product.21-sun.com/products/prolist.jsp?factory='+brand+'&catalog='+catalognum;
		}	
        if(pro!=''){
			url='http://product.21-sun.com/proDetail/'+pro;
		}	
        window.open(url);	
	});
	//搜索起重机
	$('#searchQzj').click(function(e){
        var catalognum=$('#qzj_catalog').val();
        var brand=$('#qzj_brand').val();
        var pro=$('#qzj_pro').val();
		var url='http://product.21-sun.com/products/prolist.jsp?catalog='+catalognum;
        if(brand!=''){
			url='http://product.21-sun.com/products/prolist.jsp?factory='+brand+'&catalog='+catalognum;
		}	
        if(pro!=''){
			url='http://product.21-sun.com/proDetail/'+pro;
		}	
        window.open(url);			
	});
	//搜索混凝土
	$('#searchHnt').click(function(e){
        var catalognum=$('#hnt_catalog').val();
        var brand=$('#hnt_brand').val();
        var pro=$('#hnt_pro').val();
		var url='http://product.21-sun.com/products/prolist.jsp?catalog='+catalognum;
        if(brand!=''){
			url='http://product.21-sun.com/products/prolist.jsp?factory='+brand+'&catalog='+catalognum;
		}	
        if(pro!=''){
			url='http://product.21-sun.com/proDetail/'+pro;
		}	
        window.open(url);			
	});
	
	//搜索二手
	$('#searchUsed').click(function(e){
        var used_catalog=$('#used_catalog').val();
        var used_brand=$('#used_brand').val();
        if(used_catalog!='0'||used_brand!='0'){
	var keyord="";
	if(used_catalog=='2'){
      keyord="wajueji";
	}else if(used_catalog=='10'){
	 keyord="zhuangzaiji";
	}else if(used_catalog=='14'){
	 keyord="tuituji";
	}else if(used_catalog=='28'){
	 keyord="pingdiji";
	}else if(used_catalog=='32'){
	 keyord="qizhongji";
	}else if(used_catalog=='60'){
	  keyord="hunningtu";
	}else if(used_catalog=='105'){
	 keyord="tanpuji";
	}else if(used_catalog=='151'){
	 keyord="yaluji";
	}else if(used_catalog=='9999'){
	 keyord="other";
    }
	
	
	if(keyord!=''&&used_brand!=''){
	   if(used_catalog=="60"||used_catalog=="105"||used_catalog=="151"){
		    window.open("http://used.21-sun.com/"+keyord+"/0-0-0-"+used_brand+"-0-0-0-0-0-0.htm");
		}else{
		    window.open("http://used.21-sun.com/"+keyord+"/0-0-0-"+used_brand+"-0-0-0-0-0.htm");
		}
	 }
	 if(keyord!=''&&used_brand==''){
		window.open("http://used.21-sun.com/"+keyord+"/0-0-0-0-0-0-0-0-0-0.htm");
	 } 
	 if(keyord==''&&used_brand!=''){
	  window.open("http://used.21-sun.com/equipment/0-0-0-"+used_brand+"-0-0-0-0.htm");
	 }
		}else{
			alert("请先选择系列或者品牌！");
		}
      		
	});
	        //广告01
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"gg01"},
		        success:function(data){
		              $("#gg01").html($.trim(data));
		        }
	        });
			
	        //广告02
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"gg02"},
		        success:function(data){
		              $("#gg02").html($.trim(data));
		        }
	        });

	        //广告03
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"gg03"},
		        success:function(data){
		              $("#gg03").html($.trim(data));
		        }
	        });
			
	        //广告04
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"gg04"},
		        success:function(data){
		              $("#gg04").html($.trim(data));
		        }
	        });
	
	
	//关注1
	$('#gz01').click(function(e){
	    try{
            window.external.addFavorite('http://product.21-sun.com/proDetail/336D2XE-D2LXE.shtm', 'Cat大挖336D2 XE 震撼出击');
        }catch (e){
            try{
                window.sidebar.addPanel('Cat大挖336D2 XE 震撼出击','http://product.21-sun.com/proDetail/336D2XE-D2LXE.shtm',"");
            }catch (e){
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }
	});	
	
	//关注2
	$('#gz02').click(function(e){
	    try{
            window.external.addFavorite('http://product.21-sun.com/activity/leiqm/', '雷乔曼购机促销');
        }catch (e){
            try{
                window.sidebar.addPanel('雷乔曼购机促销','http://product.21-sun.com/activity/leiqm/',"");
            }catch (e){
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }		
	});	
	
	//关注3
	$('#gz03').click(function(e){
	    try{
            window.external.addFavorite('http://product.21-sun.com/tuan/detail.jsp?id=100', '卡特306E迷你小挖');
        }catch (e){
            try{
                window.sidebar.addPanel('卡特306E迷你小挖','http://product.21-sun.com/tuan/detail.jsp?id=100',"");
            }catch (e){
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }		
	});	
	
	//关注4
	$('#gz04').click(function(e){
	    try{
            window.external.addFavorite('http://product.21-sun.com/activity/ihisce/', '购石川岛挖掘机享三重豪礼');
        }catch (e){
            try{
                window.sidebar.addPanel('购石川岛挖掘机享三重豪礼','http://product.21-sun.com/activity/ihisce/',"");
            }catch (e){
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }		
	});	
	
	//挖掘机ajax
	$('#wjj_move a').mouseenter(function(){
		$(this).parent().addClass('tab_t_cur').siblings().removeClass('tab_t_cur');	
		$.ajax({
			type:'get',
			url:$(this).data('val'),
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#wjj_list').html(html);
				$('.txd_mpro_list li').mouseenter(function(e) {
					$(this).find('.mp_price').show();
					$(this).find('#detail').show();
					$(this).find('#summary').hide();
				}).mouseleave(function(){
					$(this).find('.mp_price').hide();	
					$(this).find('#detail').hide();
					$(this).find('#summary').show();
				});
			}
		});
    });
	//装载机ajax
	$('#zzj_move a').mouseenter(function(){
		$(this).parent().addClass('tab_t_cur').siblings().removeClass('tab_t_cur');	
		$.ajax({
			type:'get',
			url:$(this).data('val'),
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#zzj_list').html(html);
				$('.txd_mpro_list li').mouseenter(function(e) {
					$(this).find('.mp_price').show();
					$(this).find('#detail').show();
					$(this).find('#summary').hide();
				}).mouseleave(function(){
					$(this).find('.mp_price').hide();	
					$(this).find('#detail').hide();
					$(this).find('#summary').show();
				});	
			}
		});
    });
	//起重机ajax
	$('#qzj_move a').mouseenter(function(){
		$(this).parent().addClass('tab_t_cur').siblings().removeClass('tab_t_cur');
		$.ajax({
			type:'get',
			url:$(this).data('val'),
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#qzj_list').html(html);
				$('.txd_mpro_list li').mouseenter(function(e) {
					$(this).find('.mp_price').show();
					$(this).find('#detail').show();
					$(this).find('#summary').hide();
				}).mouseleave(function(){
					$(this).find('.mp_price').hide();	
					$(this).find('#detail').hide();
					$(this).find('#summary').show();
				});	
			}
		});
    });	
    //混凝土ajax
	$('#hnt_move a').mouseenter(function(){
	    $(this).parent().addClass('tab_t_cur').siblings().removeClass('tab_t_cur');
		$.ajax({
			type:'get',
			url:$(this).data('val'),
			dataType:'html',
			data:{
				item:'001'
			},
			success:function(html){
				$('#hnt_list').html(html);
				$('.txd_mpro_list li').mouseenter(function(e) {
					$(this).find('.mp_price').show();
					$(this).find('#detail').show();
					$(this).find('#summary').hide();
				}).mouseleave(function(){
					$(this).find('.mp_price').hide();	
					$(this).find('#detail').hide();
					$(this).find('#summary').show();
				});	
			}
		});
    });	
	
	
	//询价
	$('body').on('click','a.xj',function(){
	jQuery.jBox("iframe:/nj/include/products/product_order_s.jsp?productid="+$(this).data('val')	, {	
	title: "在线询价",
	width: 769,
	height: 480,
	top: '10%',	
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
	});
	
	$('a.inqubttn').click(function(e){
	jQuery.jBox("iframe:/nj/include/products/product_order_s.jsp?productid="+$(this).data('val')	, {	
	title: "在线询价",
	width: 769,
	height: 480,
	top: '10%',	
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});

	});
	

jQuery(function(){
    jQuery.post("/action/ajax.jsp", {
        flag: "isLogin_Tiebi"
    }, function(data){
        var tData = jQuery.trim(data);
        if (tData != 'no') {
            jQuery("#topLabel").html("<a href='http://www.21-sun.com/' target='_blank'>欢迎您访问中国工程机械商贸网！</a><a href='javascript:void(0);' onclick='logout();' style='text-decoration: underline;'>退出</a> | 欢迎您，<a target='_blank' href='/member/'>" + tData + "</a>");
           
        }
    });
});

    //首页banner图滚动效果修改
	$(function () {
		var sWidth = $(".adBox01").width(); //获取焦点图的宽度（显示面积）
		var len = $(".adBox01 ul li").length; //获取焦点图个数
		var index = 0;
		var picTimer;
	
		//以下代码添加数字按钮和按钮后的半透明长条
		var _btn = "<div class='_btnBg'></div><div class='_btn'>";
		for (var i = 0; i < len; i++) {
			_btn += "<span>" + (i + 1) + "</span>";
		}
		_btn += "</div>"
		$(".adBox01").append(_btn);
		$(".adBox01 ._btnBg").css("opacity", 0.2);
	
		//为数字按钮添加鼠标滑入事件，以显示相应的内容
		$(".adBox01 ._btn span").mouseenter(function () {
			index = $(".adBox01 ._btn span").index(this);
			showPics(index);
		}).eq(0).trigger("mouseenter");
	
		//本例为左右滚动，即所有li元素都是在同一排向左浮动，所以这里需要计算出外围ul元素的宽度
		$(".adBox01 ul").css("width", sWidth * (len + 1));
	    
	
	//鼠标滑入某li中的某div里，调整其同辈div元素的透明度，由于li的背景为黑色，所以会有变暗的效果
		/*$(".adBox01 ul li div").hover(function () {
			$(this).siblings().css("opacity", 0.7);
		}, function () {
			$("#focus ul li div").css("opacity", 1);
		});*/
	
		//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
		$(".adBox01").hover(function () {
			clearInterval(picTimer);
		}, function () {
			picTimer = setInterval(function () {
				if (index == len) { //如果索引值等于li元素个数，说明最后一张图播放完毕，接下来要显示第一张图，即调用showFirPic()，然后将索引值清零
					showFirPic();
					index = 0;
				} else { //如果索引值不等于li元素个数，按普通状态切换，调用showPics()
					showPics(index);
				}
				index++;
			}, 3000); //此3000代表自动播放的间隔，单位：毫秒
		}).trigger("mouseleave");
	
		//显示图片函数，根据接收的index值显示相应的内容
		function showPics(index) { //普通切换
			var nowLeft = -index * sWidth; //根据index值计算ul元素的left值
			$(".adBox01 ul").stop(true, false).animate({"left": nowLeft}, 500); //通过animate()调整ul元素滚动到计算出的position
			$(".adBox01 ._btn span").removeClass("on").eq(index).addClass("on"); //为当前的按钮切换到选中的效果
		}
	
		function showFirPic() { //最后一张图自动切换到第一张图时专用
			$(".adBox01 ul").append($(".adBox01 ul li:first").clone());
			var nowLeft = -len * sWidth; //通过li元素个数计算ul元素的left值，也就是最后一个li元素的右边
			$(".adBox01 ul").stop(true, false).animate({"left": nowLeft}, 500, function () {
				//通过callback，在动画结束后把ul元素重新定位到起点，然后删除最后一个复制过去的元素
				$(".adBox01 ul").css("left", "0");
				$(".adBox01 ul li:last").remove();
			});
			$(".adBox01 ._btn span").removeClass("on").eq(0).addClass("on"); //为第一个按钮添加选中的效果
		}
	});
	
	
	//双十一  ad_11_11
	var timer=null;
	function adShow(){
		/*$('.ad_11_11').show(1000);*/
		timer=setTimeout(function(){
		$('.ad_11_11').slideUp(600).siblings().delay(600).slideDown(600);
		},5000);
		}
	adShow();
	$('.ad_11_11_little').click(function(){
		clearTimeout(timer);
		$('.ad_11_11').slideDown(600).siblings().slideUp(0);
		adShow();
		});
	$('.closeAd').click(function(){
		$('.ad_11_11').slideUp(600).siblings().delay(600).slideDown(600);
		});
	
})

