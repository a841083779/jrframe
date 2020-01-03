/**
 * common
 * v0.12
 * 非委托事件放到docReady中，不受dom修改类插件影响
 * 2014-08-27
 */
define(function(require, exports, module) {
	var $ = require('$');
	var base = require('base');
	/*
	* 常用工具集合
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
	
	$(function(){
		//字号调节
		var $speech=$('.myart:visible'),
			 defaultsize=parseFloat($speech.css('font-size'))
				
		if($speech.length){
			$.storage('fz') && $speech.css('font-size',$.storage('fz')+'px')
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
				$.storage('fz',num)
			})
		}
		// 模拟placeholder
		var $placeholder=$('input.placeholder');
		if($placeholder.length && !('placeholder' in document.createElement('input'))){
			$placeholder.each(function(i, e) {
				var placeval=$(e).attr('placeholder');
				if($(e).attr('type')!=='password'){
					$(e).val(placeval).on({
						'blur':function(){
							$.trim($(this).val())==='' && $(this).val(placeval).removeClass('on')
						},
						'focus':function(){
							$(this).val()===placeval && $(this).val('').addClass('on')
						}
					})
				}
			})
		}
		//textarea限制字数
		$('textarea[data-max]').on('change blur keyup',function(){
			var _val=$(this).val(),_max=$(this).data('max');
			if(_val.length>_max){
				$(this).val(_val.substr(0,_max));
			};
		})
		//延时显示
		$('.opc0').animate({'opacity':'1'},256)
		/*
		* 延迟渲染策略
		*/
		if(base.getType()=='Pc'){
			base.topush('.PcPush')	
		}else{
			base.topush('.UnpcPush')	
		}
		if(base.getType()=='Mobile'){
			base.topush('.MobilePush')	
		}else{
			base.topush('.UnmobilePush')	
		}
		//统计代码	
		require.async('count',function(c){
			c()
		})	

	});

	
	/*
	* 站内公用
	*/
 
	//导航当前状态
	//var jrChannelArr=jrChannel.split('#');
	//$('.nav').children('li').eq(jrChannelArr[0]).addClass('cur').find('li').eq(jrChannelArr[1]).addClass('cur');
	
	require.async('bdshare',function(bdshare){
    bdshare({
      bdSize : 16
      });
    });
	
	
})

