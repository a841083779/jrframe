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
	$('.adBox01').slide({
		imgattr:'slide-src'
	});
	
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
	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+$(this).data('val')	, {	
	title: "在线询价",
	width: 769,
	height: 600,
	top: '10%',	
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
	});
	
	$('a.inqubttn').click(function(e){
	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+$(this).data('val')	, {	
	title: "在线询价",
	width: 769,
	height: 600,
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



	
})
