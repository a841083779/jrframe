/*!
 * name : htLib.js
 * author : ht
 * update : set
 * date : 2017-01-16
 */
!
(function(a) {
	
	var htLib={
		
		//对对象进行叠加获取
		extend:function(){
			try{
				if(arguments.length>2){
					for(var i=1, max=arguments.length; i<max; i++){
						for(var attr in arguments[i]){
							arguments[0][attr]=arguments[i][attr];
							}
						}
					return arguments[0];
					}
				}
			catch(ex){
				alert('extend参数长度不够');
				}
			
			return this;//把原对象返回
			}
		
		
		
		
		};
    })();