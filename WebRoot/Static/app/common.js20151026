/**
 * name: common
 * version: v1.2.3
 * update: ProductEnvironment独立配置
 * date: 2015-06-02
 */
define(function(require, exports, module) {
	var $ = require('jquery');
	var base = require('base');
	var typeCatch = base.getType();
	var ProductEnvironment = false;	//生产 or 开发
	if(base.isIE6){
		alert('本站不支持IE6访问，请升级IE或使用chrome、Firefox等高级浏览器！');
	}

	//pc模拟多终端检测
	if(window.sessionStorage && sessionStorage.getItem('PcMode')){
		$('body').addClass('PcMode');
		typeCatch = base.getType();
	}
	(function() { 
		if( window.sessionStorage && sessionStorage.getItem('browserRedirectLock') ) return;
	    if(!base.browser.isMobile && typeCatch!=='Pc'){
	    	require.async('box',function(){
	    		$.box.confirm('网站即将进入移动模式，点【取消】保持电脑模式', function(){
	    			window.sessionStorage && sessionStorage.setItem('browserRedirectLock','true'); 
	    			$.box.hide();
	    		},function(){
	    			typeCatch = 'Pc';
	    			window.sessionStorage && sessionStorage.setItem('PcMode','Pc'); 
	    		},{
	    			title: "切换到移动模式"
	    		})
	    	})
	    }
	})();
	
	//跨屏刷新
	var throttleResize = base.throttle(function(){
			if(base.getType()!==typeCatch) document.location.reload();
		});
	$(window).on('resize',function(){
		throttleResize();
	});
	//seajs.config中配置开发模式
	if(ProductEnvironment){	

		setTimeout(function(){
			//统计代码
			require.async('count',function(c){
				c();
			});
		},480)

	}
	/*
	* 常用工具
	*/
	//返回顶部
	$('body').on('click','.gotop',function(){$('html,body').stop(1).animate({scrollTop:'0'},300);return false});
	//关闭当前页
	$('body').on('click','.closewin',function(){window.opener=null;window.open("","_self");window.close()});
	//打印当前页
	$('body').on('click','.print',function(){window.print()});
	//加入收藏
	$('body').on('click','.favorite',function(){var sURL = "http:&#47;&#47;"+document.domain+"&#47;",sTitle = document.title;try{window.external.addFavorite(sURL, sTitle)} catch (e){try{window.sidebar.addPanel(sTitle, sURL, "")}catch (e){alert("加入收藏失败，请使用Ctrl+D进行添加")}}});
	//设为首页
	$('body').on('click','.sethome',function(){var vrl="http:&#47;&#47;"+document.domain+"&#47;";if(window.netscape){try{netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect")}catch(e){alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。")}var prefs=Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);prefs.setCharPref('browser.startup.homepage',vrl)}else{alert("您的浏览器不支持自动设为首页，请您手动进行设置！")}});
	//屏蔽ie78 console未定义错误
	if (typeof console === 'undefined') {
	    console = { log: function() {}, warn: function() {} }
	}
	//textarea限制字数
	$('textarea[max-length]').on('change blur keyup',function(){
		var _val=$(this).val(),_max=$(this).attr('max-length');
		if(_val.length>_max){
			$(this).val(_val.substr(0,_max));
		};
	})
	//延时显示
	$('.opc0').animate({'opacity':'1'},160);
	
	$(function(){
		//字号调节
		var $speech=$('.myart:visible'),
			 defaultsize=parseFloat($speech.css('font-size'));
		if($speech.length){
			window.localStorage &&  localStorage.getItem('fz') && $speech.css('font-size', localStorage.getItem('fz')+'px');
			$('body').on('click','#switcher a',function(){
				var num=parseFloat($speech.css('font-size'))
				switch(this.id){
					case'small':num/=1.4
					break
					case'big':num*=1.4
					break
					default:num=defaultsize
				}
				$speech.css('font-size',num+'px')
				window.localStorage && localStorage.setItem('fz',num);
			})
		}
		// placeholder
		$('input, textarea').placeholder();
		//延迟渲染
		if(typeCatch=='Pc'){
			base.topush('.PcPush',function(){
				$('body').trigger('PcPush');
			})
		}else{
			base.topush('.UnpcPush',function(){
				$('body').trigger('UnpcPush');
			})	
		}
		if(typeCatch=='Mobile'){
			base.topush('.MobilePush',function(){
				$('body').trigger('MobilePush');
			})	
		}else{
			base.topush('.UnmobilePush',function(){
				$('body').trigger('UnmobilePush');
			})	
		}
	});	
	//响应图片
	base.resImg();
	/*
	* 输出
	*/
	module.exports = {
		demo:function(){
			console.log('hello '+base.getType());
		}
	}

	/*
	* 站内公用
	*/
 
	//导航当前状态
	//var jrChannelArr=jrChannel.split('#');
	//$('.nav').children('li').eq(jrChannelArr[0]).addClass('cur').find('li').eq(jrChannelArr[1]).addClass('cur');
	
	//topbar layer
	$('.j_mobile,.j_service,.j_siteNav').mouseenter(function(){
		$(this).addClass('j_hover');
	}).mouseleave(function(){
		$(this).removeClass('j_hover');
	});
	$('.j_proNav').mouseenter(function(){
		$(this).addClass('j_proNav_hover');
		$('.topBigGuide .j_n').after($('.j_prol'));
	}).mouseleave(function(){
		$(this).removeClass('j_proNav_hover');
	});
	
	//全部产品分类
	$('.allCates .acn').after($('.acLayer'));
	$('.allCates').click(function(){
		$(this).find('.acLayer').show();
	}).mouseleave(function(){
		$(this).find('.acLayer').hide();
	});
	$('.acLayer .acb').mouseenter(function(){
		$(this).addClass('acb_hover');
	}).mouseleave(function(){
		$(this).removeClass('acb_hover');
	});
	$('.acLayer').children('.acb:last').addClass('last')
	
	//图片懒加载
	require('scroll-loading');
	$("img").scrollLoading({
		attr:"data-lazy"
	});
	$(document).ready(function(e) {
        require.async('bdshare',function(bdshare){
		   bdshare([{
				tag : 'foot_share',  
				bdSize : 16,      //图标尺寸, 16｜24｜32
				bdStyle : '1'     //图标类型, 0｜1｜2
	
			 },{
				tag : 'pageSharePreview',  
				bdSize : 16,      //图标尺寸, 16｜24｜32
				bdStyle : '1'     //图标类型, 0｜1｜2
	
			 }])
	   });
    });
	
   $('.currentDate').html((new Date()).getFullYear());
   
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
	
	
})