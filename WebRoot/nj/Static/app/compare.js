/**
 * 
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	var com=require('./common');
	//
	require('sele');
	$('.comp_sele01').sele({
		act:"click",
		callback:function(val,text){
			
		}    
	});
	$('.comp_sele02').sele({
		act:"click",
		callback:function(val,text){
			
		}    
	});
	$('.comp_sele03').sele({
		act:"click",
		callback:function(val,text){
			
		}    
	});
	$('.comp_sele04').sele({
		act:"click",
		callback:function(val,text){
			var catalognum=$('#catalognum').val();
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"compareProLoad","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#sele06").html(data);
		        }
	        });

		}    
	});
	
	$('.comp_sele05').sele({
		act:"click",
		callback:function(val,text){
			
		}    
	});
	$('.comp_sele06').sele({
		act:"click",
		callback:function(val,text){
			$("#pro2").val(val);
		}    
	});
	$('.comp_sele07').sele({
		act:"click",
		callback:function(val,text){
			var catalognum=$('#catalognum').val();
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"compareProLoad","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#sele09").html(data);
		        }
	        });
		}    
	});
	$('.comp_sele08').sele({
		act:"click",
		callback:function(val,text){
		}    
	});
	$('.comp_sele09').sele({
		act:"click",
		callback:function(val,text){
			$("#pro3").val(val);
		}    
	});
	$('.comp_sele10').sele({
		act:"click",
		callback:function(val,text){
			var catalognum=$('#catalognum').val();
			$.ajax({
		        url:"/action/ajax.jsp",
		        type:"post",
		        data:{"flag":"compareProLoad","catalognum":catalognum,"factoryid":val},
		        success:function(data){
		              $("#sele12").html(data);
		        }
	        });
		}    
	});
	$('.comp_sele11').sele({
		act:"click",
		callback:function(val,text){
			
		}    
	});
	$('.comp_sele12').sele({
		act:"click",
		callback:function(val,text){
			$("#pro4").val(val);
		}    
	});
	//拆分,合并切换
	$('.chaifen .hb').click(function(e){
		e.preventDefault();
		$('.chaifen').hide();
		$('.hebing').show();
	});
	$('.hebing .hb').click(function(e){
		e.preventDefault();
		$('.chaifen').show();
		$('.hebing').hide();
	});
	
	//滚动条
	require('scroll-bar');
	$('._textScroll').scrollBar({
		width:4
	});
	
	//滚动跳转
	require('on-scroll');
	$('.compare_bd').onScroll({
		offset:231,
		target:'.comp_Target',
		targetCell:'.li'
	});
	//头部滚动跟随
	$('.compare_hd').width($('.compare_hd_box').width());
	var _top = $('.compare_hd').offset().top;
	$(window).scroll(function(){
		var scrolls = $(this).scrollTop();
		if(scrolls > _top){
			$('.compare_hd').addClass('compare_hd_fixed');
		}else{
			$('.compare_hd').removeClass('compare_hd_fixed');
		};
	});
	
	var _dtop = $('.compare_hd_box').offset().top-30;
	$(window).scroll(function(){
		var dscrolls = $(this).scrollTop();
		if(dscrolls > _dtop){
			$('.sideLayer').fadeIn();
		}else{
			$('.sideLayer').fadeOut();
		};
	});
	
	$('#compare2').click(function(e){
         var pro1=$("#pro1").val();
		 var pro2=$("#pro2").val();
		 var pro3=$("#pro3").val();
		 var pro4=$("#pro4").val();
		 if(pro1==''){pro1='0';}
		 if(pro2==''){pro2='0';}
		 if(pro3==''){pro3='0';}
		 if(pro4==''){pro4='0';}
		 window.location.href='/compares/index.jsp?pro1='+pro1+'&pro2='+pro2+'&pro3='+pro3+'&pro4='+pro4;
		
	});
	
	
	$('#compare3').click(function(e){
         var pro1=$("#pro1").val();
		 var pro2=$("#pro2").val();
		 var pro3=$("#pro3").val();
		 var pro4=$("#pro4").val();
		 if(pro1==''){pro1='0';}
		 if(pro2==''){pro2='0';}
		 if(pro3==''){pro3='0';}
		 if(pro4==''){pro4='0';}
		 window.location.href='/compares/index.jsp?pro1='+pro1+'&pro2='+pro2+'&pro3='+pro3+'&pro4='+pro4;
	});
	
	
	$('#compare4').click(function(e){
         var pro1=$("#pro1").val();
		 var pro2=$("#pro2").val();
		 var pro3=$("#pro3").val();
		 var pro4=$("#pro4").val();
		 if(pro1==''){pro1='0';}
		 if(pro2==''){pro2='0';}
		 if(pro3==''){pro3='0';}
		 if(pro4==''){pro4='0';}
		 window.location.href='/compares/index.jsp?pro1='+pro1+'&pro2='+pro2+'&pro3='+pro3+'&pro4='+pro4;
	});
		
})

