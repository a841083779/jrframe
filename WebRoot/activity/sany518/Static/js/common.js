/**
* name: common
* version: v3.0.0
* update: 去掉pc端跨屏支持
* date: 2016-04-30
*/
define(function(require, exports, module) {
  var $ = require('jquery');
  var base = require('base');
  var typeCatch = base.getType();

  if(base.browser.ie<7){
    alert('您的浏览器版本过低，请升级或使用chrome、Firefox等高级浏览器！');
  }

  //移动端跨屏刷新
  $('body').attr('data-w',$('body').outerWidth());
  var throttleResize = base.throttle(function(){
    if(base.getType()!=='Pc'){
      var new_width = $('body').outerWidth();
      if(new_width !== $('body').data('w')){
        document.location.reload()
      }
    }
  });
  $(window).on('resize',function(){
    throttleResize();
  });

  //字号调节
  var $speech=$('.myart:visible'),
     defaultsize=parseFloat($speech.css('font-size'));
  if($speech.length){
    //window.localStorage &&  localStorage.getItem('fz') && $speech.css('font-size', localStorage.getItem('fz')+'px');
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
      //window.localStorage && localStorage.setItem('fz',num);
    })
  }

  //页面平滑滚动
  if(base.getType() == 'Pc'){
    if (base.browser.ie > 8 || base.browser.ie == 0) {
      require('smoothscroll');
    }
  }

  //图片懒加载
  require('scroll-loading');
  $("img").scrollLoading({
    attr:"data-url"
  });

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
  if (typeof console === void(0)) {
      console = { log: function() {}, warn: function() {} }
  };
  //textarea扩展max-length
  $('textarea[max-length]').on('change blur keyup',function(){
    var _val=$(this).val(),_max=$(this).attr('max-length');
    if(_val.length>_max){
      $(this).val(_val.substr(0,_max));
    };
  });
  //延时显示
  $('.opc0').animate({'opacity':'1'},160);
  // placeholder
  $('input, textarea').placeholder();
  //按需渲染
  base.scanpush();
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
  var jrChannelArr=jrChannel.split('#');
  $('.nav').children('li').eq(jrChannelArr[0]).addClass('cur').find('li').eq(jrChannelArr[1]).addClass('cur');
  
  
  
  
})