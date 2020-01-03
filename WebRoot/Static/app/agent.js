/**
 *  
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	var com=require('./common');
	
	$('.txd_filter_plist_cat li:first').addClass('cur');
	$('.txd_filter_plist_brand li:first').addClass('cur');
	$('.txd_filter_plist li').hover(function(e) {
		$(this).addClass('cur').siblings().removeClass('cur');
	});
	
$(document).ready(function() {
    $('#main1').height($('#main1').outerHeight());
});
	
	//更多触发事件
	function moreSel(){
		if($(this).find('i').hasClass('ui-more-drop-l-arrow')){
			$(this).parents('.j_Prop').addClass('forMultiple');
			$(this).html('收起 <i class="ui-more-expand-l-arrow"></i>');
			$('#main1').height('347');
			//数据加载
			//var flag = $(this).parent().attr("data");
			//var to = $(this).parent().siblings("ul");
			//var param = $(this).parent().attr("param");
			//loadData(flag,to,param,false);
		}else{
			$(this).parents('.j_Prop').removeClass('forMultiple');
			$(this).html('更多 <i class="ui-more-drop-l-arrow"></i>');
			$(this).parent('.av-options').prev('.av-collapse').animate({scrollTop:'0'},0);
			$('#main1').height('262');
		}
	}
	
	//多选触发事件
	function multiple(){
		$(this).parents('.j_Prop').addClass('forMultiple');
		$(this).parent().next('.av-btns').show();
		$(this).parent('.av-options').hide();
		$(this).parent().prev('.av-collapse').addClass('ms_available');
		$('#main1').height('380');
		//alert($(this).data('val'));
		//数据加载
		//var flag = $(this).parent().attr("data");
		//var to = $(this).parent().siblings("ul");
		//var param = $(this).parent().attr("param");
		//loadData(flag,to,param,true);
	}
	
	//取消多选事件
	function cancel_multiple(){
		$(this).parents('.av-btns').hide();
		$(this).parents('.j_Prop').removeClass('forMultiple');
		$(this).parent().prev('.av-options').find('.j_Multiple').show();
		$(this).parent('.av-btns').prev('.av-options').show();
		$(this).parent('.av-btns').prev('.av-options').prev('.av-collapse').removeClass('ms_available').find('li').removeClass('av-selected');
		$(this).parent('.av-btns').prev('.av-options').find('.j_More').html('更多 <i class="ui-more-drop-l-arrow"></i>');
		$(this).prev('.j_SubmitBtn').addClass('ui-btn-disable');
		$(this).parent('.av-btns').prev('.av-options').prev('.av-collapse').animate({scrollTop:'0'},0);
		$('#main1').height('262');
	}
	
	//多选状态下内容选择
	function multipleSelect(){
		//多选状态下，选中状态添加、移除
		if($(this).parent().hasClass('av-selected')){
			$(this).parent().removeClass('av-selected');
			$(this).find('i').remove();
		}else{
			$(this).parent().addClass('av-selected');
			$(this).parents('.j_Prop').find('.j_SubmitBtn').removeClass('ui-btn-disable');
			$(this).append('<i></i>');
		}
		
		//如果多选状态下，无选中状态，多选确认按钮失效
		if($(this).parents('.av-collapse').find('li.av-selected').length == 0){
			$(this).parents('.j_Prop').find('.j_SubmitBtn').addClass('ui-btn-disable');
		}
		
		//如果多选触发，点击a链接不跳转
		if($(this).parents('.av-collapse').hasClass('ms_available')){
			return false;
		}
		//alert($(this).data('val'));	
	}

	//多选搜索绑定
	function multipleSubmit(){
			/*
		var brands="";
		var selectedList = $('.av-selected a');
		if(selectedList.length==0){
			return;
		}
		var p=selectedList.closest(".attrValues").prev();
		var field=p.attr("data-field");
		var name=p.attr("data-name");
		var values="",show="";
		$.each(selectedList, function(index, val) {
			if(!!values){
				values=g.Joiner.on(",").join(values,$(this).attr("data-values"));
				show=g.Joiner.on(",").join(show,$(this).attr("data-show"));
				alert($(this).data('val'));
			}else{
				values=g.Joiner.on(",").join($(this).attr("data-values"));
				show=g.Joiner.on(",").join($(this).attr("data-show"));
			}
		});
		//alert(g.getLink(g.addFq(field+"="+values+"|"+name+"_"+show),2));
		//window.location.href=g.getLink(g.addFq(field+"="+values+"|"+name+"_"+show),2);
		//go(2,brands);
		 */
	}
	
	function moreShow(){
		var outWidth = $('.j_Propli').find('.av-collapse').outerWidth();
		$('.j_Propli').each(function(){
			var sum_width=0;
			$(this).find('.av-collapse').children('li').each(function(){
				 var liw=$(this).width()+5;
				 sum_width+=liw;
			});
			if(sum_width > outWidth){
				$(this).addClass('hasMore');
			};
		});
	}
	
	//更多触发
	$('body').on('click','.j_More',moreSel)
	
	//多选触发
	$('body').on('click','.j_Multiple',multiple)
	
	//多选取消按钮点击
	$('body').on('click','.j_CancelBtn',cancel_multiple)

	//多选内容选择绑定
	$('body').on('click','.av-collapse li a',multipleSelect);
	
	//多选搜索绑定
	$('body').on('click','.j_SubmitBtn',multipleSubmit);
	
	moreShow();

	
	//搜索条搜索
	$('#searchBS').on('click', function(event) {
		event.preventDefault();
		var keywords = $('#searchBI').val();
		if(!keywords){
			keywords = 0;
		}else if(keywords.indexOf("-")!=-1){
			keywords = keywords.replace("-","[_]");
		}
		var url = window.location.href;
		var a = url.substring(0,url.lastIndexOf('/')+1);
		var b = url.substring(url.lastIndexOf('/')+1,url.lastIndexOf('.'));
		var c = url.substring(url.lastIndexOf('.'));
		if(b.indexOf("-")!=-1){
			var p = b.split("-");
			if(p.length==8){
				p[5] = keywords;
			}
		}
		window.location.href=a+p[0]+"-"+p[1]+"-"+p[2]+"-"+p[3]+"-"+p[4]+"-"+p[5]+"-"+p[6]+"-"+p[7]+c;
	});
	
	//已选
	$('.selectValues .select_val li').hover(function(){
		$(this).addClass('bclose_on');
	},function(){
		$(this).removeClass('bclose_on');
	});
	
	//品牌鼠标状态
	$('body').on('mouseenter','.attr_brand ul li',function(){
		$(this).addClass('attrbrand_hover');
	}).on('mouseleave','.attr_brand ul li',function(){
		$(this).removeClass('attrbrand_hover');
	});
	
	
	
	//如果筛选类别数目小于5个就不显示“更多选项”按钮
	if($('.filter .j_Propli').length < 5){
		$('.filter_more').find('span').css('visibility','hidden');
	}
	//更多的选项显示隐藏
	$('.filter .j_Propli:gt(3)').hide();
	$('.filter .filter_more .fm_btn1').click(function(){
		$('.filter .j_Propli').show();
		$(this).hide();
		$(this).parent().find('.fm_btn2').show();
		moreShow();
	});
	$('.filter .filter_more .fm_btn2').click(function(){
		$('.filter .j_Propli:gt(3)').hide();
		$(this).hide();
		$(this).parent().find('.fm_btn1').show();
	});
	
	
	//搜索品牌
	$('#brand').bind('keypress',function(event){
			var area=$('#the_area').val();
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            if(event.keyCode == "13")    
            {
                $.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"searchBrandAgent","keyword":brand,"area":area},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	            });	
            }
    });
	
	
	//搜索国内品牌
	$('#inner').click(function(){
			var area=$('#the_area').val();
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            $.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"searchInnerBrandAgent","keyword":brand,"area":area},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        });  
    });
	//搜索国外品牌
	$('#out').click(function(){
		    var area=$('#the_area').val();
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            $.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"searchOutBrandAgent","keyword":brand,"area":area},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        });  
    });
	//搜索国外品牌
	$('.all').click(function(){
		    var area=$('#the_area').val();
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            $.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"searchAllBrandAgent","keyword":brand,"area":area},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        });  
    });
	//提交多个品牌选择
	$('#multipleBrand01').click(function(e){
		var brands="";
		var catalog=$('#catalog').val();
		var area=$('#the_area').val();
		var tonandmeter=$('#tonandmeter').val();	
		var selectedList = $('.av-selected a');
		if(selectedList.length==0){
			return;
		}
		$.each(selectedList, function(index, val) {
			   brands+=$(this).data('val')+',';
		});
		$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"goToAgentMul","brands":brands},
		        success:function(data){
		              //$("#brand_list").html($.trim(data));
					  window.location.href="/agent/"+area+"_0_0_0.shtm";
		        }
	    }); 
		//window.location.href="/products/prolist.jsp?factoryids="+brands+"&catalog="+catalog+"&tonandmeter="+tonandmeter;
	});
	
    $('#multipleBrand02').click(function(e){
		var brands="";
		var catalog=$('#catalog').val();
		var tonandmeter=$('#tonandmeter').val();
		var selectedList = $('.av-selected a');
		if(selectedList.length==0){
			return;
		}
		$.each(selectedList, function(index, val) {
			   brands+=$(this).data('val')+',';
		});
	    window.location.href="/products/prolist.jsp?factoryids="+brands+"&catalog="+catalog+"&tonandmeter="+tonandmeter;

	});
	
	$('.letters a').click(function(){
		var area=$('#the_area').val();
		var a=$(this).data('val');
		var catalog=$('#catalog').val();
		     $.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"searchByLetterAgent","letter":a,"area":area},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        }); 
  			$('.letters a').removeClass('cur');
			$(this).addClass('cur');
	});
	//add20150804
	//列表筛选条跟随
	var _top1 = $('#main').offset().top;
	var _top2=$('#right_box').offset().top;
	var _box_leftWidth=$('#right_box').offset().left;
	$(window).scroll(function(){

		var scrolls = $(this).scrollTop();
		/*
		if(scrolls > _top1){
			$('#main').addClass('filterBar_fixed_main').addClass('main_overflow_hidden');
			$('#main1').height('42').addClass('filterBar_fixed_main1');
			$('#select_category').css('display','none');
			//$('#select_catalog').hide();
			$('#select_brand').css('display','none');
			$('#select_tonandmeter').css('display','none');
			//$('#select_condition').hide();
			$('#show_tj').show();
            
			//$('.filterBar').addClass('filterBar_fixed');

		}else{
			$('#main').removeClass('filterBar_fixed_main').removeClass('main_overflow_hidden');
			$('#main1').height('262').removeClass('filterBar_fixed_main1');
			//$('.filterBar').removeClass('filterBar_fixed');
			$('#select_category').css('display','block');
			//$('#select_catalog').show();
			$('#select_brand').css('display','block');
			$('#select_tonandmeter').css('display','block');
			//$('#select_condition').show();
			$('#show_tj').hide();
		};
		*/
/*		if(scrolls>_top2){
		  
			$('#right_box').find('.themap').addClass('right_box_fixed').css('left',function(){
				return _box_leftWidth+1+'px';
				});
			$('.recommend').addClass('recommend_margin');
		
			$('.rcmd_right').addClass('rcmd_right_absolute').css('left',function(){
				return _box_leftWidth+'px';
				});
		
		
			}else{
				$('#right_box').find('.themap').removeClass('right_box_fixed');
				$('.recommend').removeClass('recommend_margin');
		
			    $('.rcmd_right').removeClass('rcmd_right_absolute');

			}
	});*/
     /*
	 		if(scrolls>_top2){
		  
			$('#right_box').addClass('right_box_fixed').css('left',function(){
				return _box_leftWidth+1+'px';
				});
			$('.recommend').addClass('recommend_margin');
		
		
		
			}else{
				$('#right_box').removeClass('right_box_fixed');
				$('.recommend').removeClass('recommend_margin');
			}
			*/
	});
	 
	/*
	var _top = $('.filterBar').offset().top;
	$(window).scroll(function(){
		var scrolls = $(this).scrollTop();
		if(scrolls > _top){
			$('.filterBar').addClass('filterBar_fixed');
		}else{
			$('.filterBar').removeClass('filterBar_fixed');
		};
	});
	*/
	//大图列表模式互换
	$('.modeSwitch').click(function(){
		var prolist = $('.mainList');
		if(prolist.hasClass('listMode')){
			prolist.addClass('picMode').removeClass('listMode');
			$(this).removeClass('switch_on').attr('title','点击切换到列表模式');
		}else{
			prolist.removeClass('picMode').addClass('listMode');
			$(this).addClass('switch_on').attr('title','点击切换到大图模式');
			$('.mainList').find('.pmh').removeAttr('style');
		}
		$('html,body').stop(1,0).animate({scrollTop:$('.filterBox').offset().top},1);
	});
	
	$('.txd_nright').on('mouseenter','.picMode li',function(){
		$(this).addClass('hover').find('.pmh').stop().animate({height:50},'fast');
	}).on('mouseleave','.picMode li',function(){
		$(this).removeClass('hover').find('.pmh').stop().animate({height:0},'fast');
	})
	//显示筛选条件
	$('#show_select').click(function(){
		if($(this).hasClass('on')){
			$(this).removeClass('on').text('隐藏筛选条件');
			$('#select_category').show();
			$('#select_catalog').show();
			$('#select_brand').show();
			$('#select_tonandmeter').show();
			$('#select_condition').show();
		}else{
		    $(this).addClass('on').text('显示筛选条件');
			$('#select_category').hide();
			$('#select_catalog').hide();
			$('#select_brand').hide();
			$('#select_tonandmeter').hide();
			$('#select_condition').hide();
		}
	});
	
	//点击查看联系电话
	$('.search_tel').click(function(){
		    var id=$(this).data('val');
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"showOffice","id":id},
		        success:function(data){
					$("#office_list").html(data);
					$('.wrap_contact_detail').css('display','block').find('.close').click(function(){
			            $(this).parents().find('.wrap_contact_detail').css('display','none');
			        });
		        }
	        });
    });
	
	
	$('#changeArea').on('click', function(event) {
        $('.citybox').show();
	});
	$('#closeArea').on('click', function(event) {
        $('.citybox').hide();
	});
})


