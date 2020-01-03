/*
 * Name : commonUtil.jquery.js
 * Author : ht
 * @Copyright : http://www.jerei.com/
 * Build Date : 2017-02-27
 * Update : 创建中... 依赖jquery.js
 * Version : v1.0.0
*/
;
(function ($){
	
	/*
	* 可兼容IE7、IE8、IE9的oninput事件
	* @param  callback 事件处理的回调函数
	* @returns 
	*/
	if('onpropertychange' in document){
		var reg = /^INPUT|TEXTAREA$/;
		var isInput = function (ele){
			return reg.test(ele.nodeName);
			}
		$.event.special.input = {
			setup : function (){
				var ele = this;
				if(!isInput(ele)){
					return false;
					}
				$.data(ele, '@oldvalue', ele.value);
				$.event.add(ele, 'propertychange', function (event){
					if($.data(ele, '@oldvalue') !== this.value){
						$.event.trigger('input', null, this);
						}
					$.data(ele, '@oldvalue', this.value);
					});
				},
			teardown : function (){
				var ele = this;
				if(!isInput(ele)){
					return false;
					}
				$.event.remove(ele, 'propertychange');
				$.removeData(ele, '@oldvalue');
				}
			};
		}
	$.fn.input = function (callback){
		return this.bind('input', callback);
		};
	
	
	
	
	
	
	
	})(jQuery);