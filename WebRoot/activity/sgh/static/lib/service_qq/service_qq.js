/*
* name : Service_qq(QQ客服)
* version : v1.0.0
* update : set
* date : 2017-01-12
* API : 对外接口为top和qq号
*/
;
(function(){
	
	//样式方法
	function css(ele,json){
		for(var attr in json){
			ele.style[attr]=json[attr];
			}
		}
	/*function extend(newObj,pri,opt){
		newObj=pri;//对象传递，防止原对象被污染
		for(var attr in opt){
			newObj[attr]=opt[attr];
			}
		return newObj;
		}*/
	function extend(){//与上面同样的功能，无论添加多少对象
		for(var i=1;i<arguments.length;i++){
			for(var attr in arguments[i]){
			  arguments[0][attr]=arguments[i][attr];
			  }
			}
		return arguments[0];
		}
	
	
	//创建对象
	var Service_qq=function(ele,options){
		
		this.obj = typeof ele == 'string' ? document.getElementById(ele) : ele;
		
		this.defaults={
			top:0,
			qq:1234567
			};
		this.opts=extend({},this.defaults,options);//这样防止defaults被污染
		
		//定位盒子
		css(this.obj,{
			top:this.opts.top+'px'
			});
		
		//设置盒子内层背景
		this.inner=this.obj.getElementsByTagName('div')[0];
		css(this.inner,{
			background:'url(../static/lib/service_qq/q_1.png) no-repeat'
			});
		
		this.init();
		
		};
	
	//对象原型
	Service_qq.prototype={
		
		init:function(){
			
			var that=this;
			
			this.obj.onmouseover=function(){
				that.mouseoverEvent(that.inner);
				};
				
			this.obj.onmouseout=function(){
				that.mouseoutEvent(that.inner);
				};
			
			this.inner.onclick=function(){
				that.clickEvent(that.opts.qq);
				};
			
			this.drag(this.obj);
			
			},
		
		mouseoverEvent:function(ele){
			
			css(ele,{
				background:'url(../static/lib/service_qq/q_2.png) no-repeat'
				});
			
			},
		
		mouseoutEvent:function(ele){
			
			css(ele,{
				background:'url(../static/lib/service_qq/q_1.png) no-repeat'
				});
			
			},
		
		clickEvent:function(qq){
			
			window.open('http://wpa.qq.com/msgrd?v=3&uin='+qq+'&site=qq&menu=yes','_blank');
			
			},
		
		drag:function(ele){
			
			var vw=document.documentElement.clientWidth||document.body.clientWidth;
			var vh=document.documentElement.clientHeight||document.body.clientHeight;
			
			var sw=ele.offsetWidth;//sw====selfWidth
			var sh=ele.offsetHeight;
			
			ele.onmousedown=function(e){
				
				var oEvent=e||event;
				
				var disX=oEvent.clientX-ele.offsetLeft;
				var disY=oEvent.clientY-ele.offsetTop;
				
				document.onmousemove=function(e){
					
					var oEvent=e||event;
					var l=oEvent.clientX-disX;
					var t=oEvent.clientY-disY;
					
					if(l<=10){
						l=0;
						}
					else if(l>=vw-sw-10){
						l=vw-sw;
						}
					
					
					if(t<=10){
						t=0;
						}
					else if(t>=vh-sh-10){
						t=vh-sh;
						}
					
					ele.style.left=l+'px';
					ele.style.top=t+'px';
					
					};
				
				document.onmouseup=function(){
					
					document.onmousemove=null;
					
					document.onmouseup=null;
					
					};
				
				return false;
				
				};
			
			}
		
		};
	
	window.Service_qq=Service_qq;
	
	})();