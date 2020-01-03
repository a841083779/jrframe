/*
 * Name : commonUtil.js
 * Author : ht
 * @Copyright : http://www.jerei.com/
 * Build Date : 2017-02-27
 * Update : 创建中...
 * Version : v1.0.0
*/
;
(function (){
	
	
	//命名空间,有趣的函数库,本命名为fnLib
	var funLib = {};
	
	/*
	* 实例化接口
	* @param  name 接口名字
	* @param  methods  接口方法数组
	* @returns  
	*/
	
	funLib.Interface = function (name, methods){
		if(arguments.length !== 2){
			throw new Error('The instance interface constructor arguments should be two!');
			}
		
		this.name = name; 
		this.methods = [];//接收方法名字
		
		for(var i = 0, len = methods.length; i < len; i ++){
			if(typeof methods[i] !== 'string'){
				throw new Error('The name of method is wrong!');
				}
			this.methods.push(methods[i]);
			}
		};
	
	/*
	* 检验接口
	* @param   object 
	* @returns  
	*/
	
    funLib.Interface.ensureImplements = function (object){
		if(arguments.length < 2){
			throw new Error('The Interface has no implement class!');
			}
		
		for(var i = 1, len = arguments.length; i < len; i ++){
			var instanceInterface = arguments[i]; //定义一个变量接收参数
			
			if(instanceInterface.constructor !== funLib.Interface){
				throw new Error('The arguments constructor is not Interface Class!');
				}
			
			for(var j = 0, len = instanceInterface.methods.length; j < len; j ++){
				var methodName = instanceInterface.methods[j];
				if(!object[methodName] || typeof object[methodName] !== 'function'){
					throw new Error('The method ' + methodName + ' is not found');
					}
				}
			}
		};	
	
	/*
	* 类的方法继承
	* @param  SuperClass 父类
	* @param  SubClass 子类
	* @returns  
	*/
	
	funLib.extend = function (SubClass, SuperClass){
		var Fn = new Function();
		Fn.prototype = SuperClass.prototype;
		SubClass.prototype = new Fn();
		SubClass.prototype.constructor = SubClass;//构造器还原
		
		SubClass.superClass = SuperClass.prototype;
		if(SuperClass.prototype.constructor === Object.prototype.constructor){
			SuperClass.prototype.constructor = SuperClass;
			}
		};
	
	/*
	* 将字符串转化为Unicode
	* @param  str 字符串
	* @returns  _str 转化后的字符串
	*/
	
	funLib.chrToUnicode = function (str){
		if(str === ''){
			return null;
			}
		//return escape(str).replace(/%/g, '\\').toLowerCase();
		var _str = '';
		if (str !== '') {
			for(var i = 0, len = str.length; i < len; i ++){
				_str += '\\u' + parseInt(str[i].charCodeAt(0), 10).toString(16);
			}
		}
		return _str;
		};
	
	/*
	* 将Unicode转化字符串为
	* @param  data Unicode
	* @returns  eval("'"+data+"'"); 完全可以实现转码
	*/
	
	funLib.unicodeToChr = function (data){
		if(data === ''){
			return null;
		    }
		//return eval("'"+data+"'");
		return unescape(data.replace(/\\u/g, '%u'));
		};
	
	/*
	* 设定延迟时间(分钟)
	* @param  minutes 以分钟计时
	* @param  minutes*60*1000这里将分钟换算为毫秒
	* @param  oDate.toUTCString()(推荐使用)   oDate.toGMTString()(不推荐使用)
	* @returns 格林威治时间
	*/
	
	funLib.delayMinutes = function (minutes){//延时时间
		var oDate = new Date();
		oDate.setTime(oDate.getTime() + minutes * 60 * 1000);
		return oDate.toUTCString();
		};
	
	/*
	* 设定延迟时间(天)
	* @param  days 以天计时
	* @returns   至 oDate 这个时间
	*/
	
	funLib.delayDays = function (days){
		var oDate = new Date();
		oDate.setDate(oDate.getDate() + days);
		return oDate;
		};
	
	/*
	* 在数字之前添加0
	* @param  str 传入数字 为 字符串类型 或者 数字类型
	* @param  digit 补位后的长度
	* @returns 部位后digit长度的字符串  
	*/
	
	funLib.fillZero = function (str, digit){
		if(str === '' || typeof str === 'undefined'){
			return null;
		    }
		
		var _str = '' + str;
		while(_str.length < digit){
			_str = '0' + _str;
			}
		return _str;
		};
	
	/*
	* 设置cookie   document.cookie='name=value;expires=time';
	* @param  key cookie名称
	* @param  value  cookie名称对应的值
	* @param  delay 为字符串，如'2m' '30d'  延迟时间失效（m 结束 以分钟计 ； d 结束 以天计）
	* @returns
	*/
	
	funLib.setCookie = function (key, value, delay){
		var time;
		if(delay.indexOf('m') !== -1){
			var num = parseInt(funLib.getNum(delay));
			time = funLib.delayMinutes(num);
			}
		else if(delay.indexOf('d') !== -1){
			var num = parseInt(funLib.getNum(delay));
			time = funLib.delayDays(num);
			}
		document.cookie = key + '=' + value + ';expires=' + time;//创建cookie
		};
		
	/*
	* 本地存储  包括window.localStorage、 window.sessionStorage
	* @param  storageType  字符串 可选'localStorage'或者'sessionStorage'
	* @returns  
	*/
	
	funLib.Storage = function (storageType){
		if(storageType === 'localStorage'){
			this.storageObj = window.localStorage;
			}
		else if(storageType === 'sessionStorage'){
			this.storageObj = window.sessionStorage;
		    }
		};
	
	funLib.Storage.prototype = {
		constructor : funLib.Storage,
		setItem : function(key, value){
			this.storageObj.setItem(key, value);
			},
		getItem : function(key){
			return this.storageObj.getItem(key);
			},
		clearItems : function(){
			this.storageObj.clear();
			},
		mapItems : function(fn){
			for(var prop in this.storageObj){
				fn(prop, this.storageObj.getItem(prop));
				}
			}
		};
	
	/*
	* 获取字符串中的数字   
	* @param  str
	* @returns 纯数字字符串  
	*/
	
	funLib.getNum = function (str){
		if(str === ''){
			return null;
			}
		return str.replace(/[^0-9]/ig, '');
		}
	
	/*
	* 获取字符串中的字母 
	* @param  str
	* @returns 纯字母的字符串  
	*/
	
	funLib.getLetter = function (str){
		if(str === ''){
			return null;
			}
		return str.replace(/[^a-z]/ig, '');
		}
	
	/*
	* 删除字符串中的空格   
	* @param  str
	* @returns  
	*/
	
	funLib.deleteBlank = function (str){
		if(str === ''){
			return null;
		    }
		return str.replace(/\s/ig, '');
		}
	
	
	/*
	* map模拟
	* @param  put(key, value)  //向对象中输入数据
	* @param  get(key)         //从对象中获取数据
	* @param  remove(key)      //从对象中删除数据
	* @param  size()           //获取对象的长度
	* @param  eachMap(fn)      //fn方法
	*/
	
	//单体模式
	funLib.Map={
		obj : new Object(),
		put : function(key, value){
			this.obj[key] = value;
			},
		get : function(key){
			if(this.obj[key] || this.obj[key] === 0 || this.obj[key] === false){
				return this.obj[key];
				}
			else{
				return null;
				}
			},
		remove : function(key){
			if(this.obj[key] || this.obj[key] === 0 || this.obj[key] === false){
				delete this.obj[key];
				}
			},
		size:function(){
			var len = 0;
			for(var prop in this.obj){
				len ++;
				}
			return len;
			},
		eachMap:function(fn){
			if(this.size() > 0){
				for(var prop in this.obj){
					fn(prop, this.obj[prop]);
					}
				return this.size();
				}
			else{
				return -1;
				}
			}
		};
	
	/*
	* 获取可视区的大小
	* @param 
	* @returns  可视区大小对象
	*/
	
	funLib.windowSize = function (){
		var winWidth = 0;
		var winHeight = 0;
		
		if(window.innerWidth && window.innerHeight){
			winWidth = window.innerWidth;
			winHeight = window.innerHeight;
			}
		else if(document.body && document.body.clientWidth && document.body.clientHeight){
			winWidth = document.body.clientWidth;
			winHeight = document.body.clientHeight;
			}
		
		//通过深入Document内部对body进行检测，获取窗口大小
		if(document.documentElement && document.documentElement.clientWidth && document.documentElement.clientHeight){
			winWidth = document.documentElement.clientWidth;
			winHeight = document.documentElement.clientHeight;
			}
		return {
			width : winWidth,
			height : winHeight
			};
		};
	
	/*
	* 日期格式
	* @param oDate 时间对象
	* @param fmt
	* @returns 'YYYY-MM-DD-hh-mm-ss-qq' 格式的数据，可选
	*/
	
	funLib.format = function (oDate, fmt){
		var obj = {
			'M+' : oDate.getMonth() + 1, //月份
			'D+' : oDate.getDate(), //日
			'h+' : oDate.getHours(), //小时
			'm+' : oDate.getMinutes(), //分
			's+' : oDate.getSeconds(), //秒
			'q+' : Math.floor((oDate.getMonth() + 3) / 3) //季度
			};
		//年
		if(/(Y+)/.test(fmt)){
			fmt = fmt.replace(RegExp.$1, (oDate.getFullYear() + '').substr(4 - RegExp.$1.length));
			}
		 for (var prop in obj){
			 if(new RegExp('(' + prop + ')').test(fmt)){
				 fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? obj[prop] : (('00' + obj[prop]).substr(('' + obj[prop]).length)));
			     }
			 }
		
		return fmt;
		}
	
	/*
	* 更新时间
	* @param stamp   | var oDate = new Date();
	* @param         | var newDate = funLib.delayDays(-2); //从现在起往前推两天
	* @param         | stamp = Date.parse(newDate) / 1000;  //以秒为单位
	* returns 为 { timeStr : 'xx秒前 等格式' , t : 以'YYYY-MM-DD'格式的具体时间 }
	*
	* 更新时间
	* 1.时间戳
	* 规则:
	* 1分钟内 -> xx秒前
	* 1小时内 -> xx分钟前
	* 1小时至24小时以内 -> xx小时前
	* 24小时至72小时以内 -> x天前
	* 72小时以后 -> 年-月-日
	*/
	
	funLib.updateTime = function (stamp){
		var t = new Date(stamp * 1000);
		var now  = new Date();
	
		var r = Math.abs((now.getTime() - t.getTime()) / 1000);
	
		var timeStr = r < 10 ? r + '\u79d2\u524d' : r < 60 ? Math.floor(r) + '\u79d2\u524d' : r < 3600 ? Math.floor(r / 60) + '\u5206\u949f\u524d' : r < 86400 ? Math.floor(r / 3600) + '\u5c0f\u65f6\u524d' : r < 259200 ? Math.floor(r / 86400) + '\u5929\u524d' : t.getFullYear() + '-' + funLib.fillZero((t.getMonth() + 1), 2) + '-' + funLib.fillZero(t.getDate(), 2);
	
		 return {
			 timeStr : timeStr,
			 t : funLib.format(t, 'YYYY-MM-DD')
			 };
		}
	
	/*
	* 分享到微博，针对pc端
	* @param title
	* @param url
	* @param desc
	* returns
	*/
	
	funLib.posToWeibo = function (title, url, desc){
		
		var pos_url = 'http://service.weibo.com/share/share.php?title=' + title + '，摘要：' + desc + ' @21SUN&url=' + url;

		var iWidth = 650,
			iHeight = 450,
			iTop = (window.screen.height - 30 - iHeight) / 2,
			iLeft = (window.screen.width - 10 - iWidth) / 2;
		
		window.open(pos_url, title, 'height=' + iHeight + ', innerHeight=' + iHeight + ', width=' + iWidth + ', innerWidth=' + iWidth + ', top=' + iTop + ', left=' + iLeft + ', toolbar=no, menubar=no, scrollbars=auto, resizeable=no, location=no, status=no');
		}
	
	/*
	* 分享到QQ空间，针对pc端
	* @param title
	* @param url
	* @param desc
	* returns
	*/
	
	funLib.posToQzone = function (title, url, desc){
		
		var pos_url = 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=' + url + '&title=' + title + '&&summary=' + desc;
		
		var iWidth = 650,
			iHeight = 450,
			iTop = (window.screen.height-30-iHeight)/2,
			iLeft = (window.screen.width-10-iWidth)/2;
		
		window.open(pos_url, title, 'height=' + iHeight + ', innerHeight=' + iHeight + ', width=' + iWidth + ', innerWidth=' + iWidth + ', top=' + iTop + ', left=' + iLeft+', toolbar=no, menubar=no, scrollbars=auto, resizeable=no, location=no, status=no');
		}
	
	/*
	* 截取url的数据  获取'http://www.21-sun.com?'+key+'=string'中 string 的数据
	* @param key 要获取的关键字
	* returns
	*/
	
	funLib.getQueryString = function (key){	
		var reg = new RegExp('(^|&)' + key + '=([^&]*)(&|$)', 'i');
		var r = window.location.search.substr(1).match(reg);
		
		if (r !== null){
			return decodeURIComponent(r[2]);
		    }
		return null;
		}
	
	/*
	* 判断img的链接是否有效
	* @param url 图片的链接地址
	* returns boolean值
	*/
	
	funLib.isValidImgUrl = function (url){
		var oImg = new Image();
		oImg.src = url;
		
		if(oImg.fileSize > 0 || ( oImg.width > 0 && oImg.height > 0 )){
			return true;
			}
		else{
			return false;
			}
		};
	
	/*
	* 数组去重
	* @param arr  传入数组
	* returns result  去重后结果
	*/
	
	funLib.unique = function (arr){
		var result = [];
		var obj = {};
		for(var i = 0, len = arr.length; i < len; i ++){
			if(!obj[arr[i]]){
				result.push(arr[i]);
				obj[arr[i]] = true;
				}
			}
		return result;
		}
	
	/*
	* 判断终端设备类型
	* @param 
	* returns 
	*/
	funLib.device = function (){
		var b = navigator.userAgent.toLowerCase();
		if(b.indexOf('mobile') >= 0){
			return 'mobile';
			}
		if(b.indexOf('mobile') < 0){
			return 'pc';
			}
		if(b.indexOf('micromessenger') >= 0){
			return 'wx';
			}
		return '';
		};
	
	
	
	
	
	
	window.funLib = funLib;
	
	})();