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
  //页面平滑滚动
  if(base.getType() == 'Pc'){
    if (base.browser.ie > 8 || base.browser.ie == 0) {
      require('smoothscroll');
    }
  }

  /*
  * 常用工具
  */
  //返回顶部
  $('body').on('click','.gotop',function(){$('html,body').stop(1).animate({scrollTop:'0'},300);return false});

  //延时显示
  $('.opc0').animate({'opacity':'1'},160);

  //响应图片
  base.resImg();
  /*
  * 输出
  */
  module.exports = {
    demo:function(){
    //  console.log('hello '+base.getType());
    }
  }


})