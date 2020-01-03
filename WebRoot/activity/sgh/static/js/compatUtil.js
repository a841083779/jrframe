/*
 * Name : compatUtil.js
 * Author : ht
 * @Copyright : http://www.jerei.com/
 * Build Date : 2017-02-24
 * Update : 
 * Version : v1.0.0
*/
;
(function(){
	
	/*
	* 命名空间
	*/
	var compat = {};
	
	
	/*
	* 获取行间样式
	* @param  ele 元素对象
	* @param  styleName  样式名---获取复合样式如 background  border 等,可以这样写backgroundColor
	* @returns
	*/
	
    compat.getStyle = function(ele, styleName){
		if(ele.currentStyle){//兼容IE
			return ele.currentStyle[styleName];
			}
		else{//兼容fireFox、chrome
			return getComputedStyle(ele, false)[styleName];
			}
		};
	
	/*
	* 获取第一个子节点
	* @param  ele 元素对象
	* @returns
	*/
	
	compat.getFirstChild = function(ele){
		if(ele.firstElementChild){
			return ele.firstElementChild;//兼容高版本浏览器
			}
		else{
			return ele.firstChild;//兼容IE6-8
			}
		};
	
	/*
	* 获取最后一个子节点
	* @param  ele 元素对象
	* @returns
	*/
	
	compat.getLastChild = function(ele){	
		if(ele.lastElementChild){
			return ele.lastElementChild;//兼容高版本浏览器
			}
		else{
			return ele.lastChild;//兼容IE6-8
			}
		};
	
	/*
	* 获取下一个兄弟节点
	* @param  ele 元素对象
	* @returns
	*/
	
	compat.getNextSibling = function(ele){
		if(ele.nextElementSibling){
			return ele.nextElementSibling;//兼容高版本浏览器
			}
		else{
			return ele.nextSibling;//兼容IE6-8
			}
		};
	
	/*
	* 获取上一个兄弟节点
	* @param  ele 元素对象
	* @returns
	*/
	
	compat.getPreviousSibling = function(ele){
		if(ele.previousElementSibling){
			return ele.previousElementSibling;//兼容高版本浏览器
			}
		else{
			return ele.previousSibling;//兼容IE6-8
			}
		};
	
	/*
	* 绑定事件 (可绑定若干事件)
	* @param  ele 元素对象
	* @param  eventType 点击事件类型  例如click 、mouseover  不能为onclick
	* @param  fn 回调函数，点击事件触发的方法
	*/
	
	compat.addEvent = function(eventType, ele, fn){
		if(ele.attachEvent){//兼容IE， 这里主要考虑可兼容IE7 8
			ele.attachEvent('on' + eventType, fn);
			}
		else{//兼容谷歌、火狐浏览器，同时可兼容IE9机器以上浏览器
			ele.addEventListener(eventType, fn, false);
			}
		};
	
	/*
	* 数组过滤  兼容IE7 IE8
	* @param  fn 函数
	* @param  val 数组中元素item
	* @param  i 索引index
	* @param  arr 数组本身
	* @returns  result过滤后数组
	*/
	
	if( ! Array.prototype.filter){
		Array.prototype.filter = function (fn){
			if(typeof this === 'undefined' || this === null){
				throw new Error();
				}
			if(typeof fn === 'undefined' || !(fn instanceof Function)){
				throw new Error();
				}
			
			var result = [];
			
			for( var i = 0 , len = this.length ; i < len ; i ++ ){
				if(i in this){
					if(fn.call(this, this[i], i, this)){
						result.push(this[i]);
						}
					}
				}
			return result;
			};
		}
	
	/*
	* 移除指定元素, 添加的新的方法
	* @param  index 移除元素的索引
	* @returns
	*/
	
	if( ! Array.prototype.removeAt){
		Array.prototype.removeAt = function (index){
			if(index < 0){
				return this;
				}
			for( var i = index + 1 , len = this.length ; i < len ; i ++ ){
				this[ i - 1 ] = this[i];
				}
			this.length -- ;
			return this;
			};
		}
	
	/*
	* 判断是否为数组 兼容IE7 IE8
	* @param
	* @returns
	*/
	
	if ( ! Array.isArray) {
		Array.isArray = function() {
		    return Object.prototype.toString.call(arguments[0]) === '[object Array]';
		    };
		}
	
	/*
	* 查找元素位置 兼容IE7 IE8
	* @param  searchValue
	* @param  fromIndex
	* @returns
	*/
	
	if( ! Array.prototype.indexOf){
		Array.prototype.indexOf = function (searchValue, fromIndex){
			if(this === null){
				throw new Error(this + 'is null or not defined');
				}
			
			var len = this.length;
			if(len === 0){
				return -1;
				}
			
			var fromNum = fromIndex || 0;
			
			if(fromNum >= len){
				return -1;
				}
			if(fromNum < 0 && Math.abs(fromNum) > len){
				fromNum = 0;
				}
			
			posNum = fromNum >= 0 ? fromNum : len - Math.abs(fromNum);
			
			while(posNum < len){
				if(this[posNum] === searchValue){
					return posNum;
					}
				posNum ++;
				}
			return -1;
			};
		}
	
	/*
	* 表单placehodler IE7 IE8 IE9不显示的问题
	* @param  eles 为input[type="text"]、textarea或者input[type="password"]元素
	* @param  
	* @returns
	*/
	compat.placeholderForIE = function (ele){
		if( ! document.attachEvent){
			return;
			}
		if(!ele){
			throw new Error('没有可执行的元素');
			}
		
		//获取到placeholder
		var val = ele.getAttribute('placeholder');
		
		if(ele.type === 'text' || ele.tagName.toLowerCase() === 'textarea'){
			ele.value = val;
			ele.style.color = '#a0a0a0';
			compat.addEvent('focus', ele, function (){
				if(ele.value === val){
					ele.value = '';
				    ele.style.color = '';
					}
				});
			compat.addEvent('blur', ele, function (){
				if(ele.value === ''){
					ele.value = val;
					ele.style.color = '#a0a0a0';
					}
				});
			}
		if(ele.type === 'password'){
			var parent = ele.parentNode;
			
			var eleWrap = document.createElement('div');
			eleWrap.className = 'password-wrap';
			eleWrap.style.position = 'relative';
			
			parent.insertBefore(eleWrap, ele);
			eleWrap.appendChild(ele);
			
			var taskPassword = document.createElement('input');
			var prop = {
				className : 'task-password',
				type : 'text',
				value : val,
				style : {
					position : 'absolute',
					left : 0,
					top : 0,
					color : '#a0a0a0'
					}
				};
			for(var i in prop){
				if(typeof prop[i] === 'object'){
					var _prop = prop[i];
					for(var _i in _prop){
						taskPassword[i][_i] = _prop[_i];
						}
					}
				else{
					taskPassword[i] = prop[i];
					}
				}
			
			eleWrap.appendChild(taskPassword);
			
			compat.addEvent('focus', taskPassword, function (){
				if(ele.value === ''){
					taskPassword.style.display = 'none';
				    ele.focus();
					}
				});
			compat.addEvent('blur', ele, function (){
				if(ele.value === ''){
					taskPassword.style.display = 'block';
					ele.blur();
					}
				});
			}
		}
	
	
	
	
	
	
	//对外接口
	window.compat = compat;
	
	})();