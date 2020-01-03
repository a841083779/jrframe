var newMessageRemind={
	_step: 0,
    _title: document.title,
    _timer: null,
	//显示新消息提示
	show:function(req){
		 	var _cookieOrderId = GetCookie("cookieOrderId") ;	
		 	_cookieOrderId = (_cookieOrderId==null?"":_cookieOrderId) ;
		 	pushOrderInfo.getOrderInfo(_cookieOrderId,req,callback) ;
		 	function callback(_msg){
 			if(''==jQuery.trim(_msg)){
 				newMessageRemind.clearParent() ;
 				return ;
 			}
		 		var temps = newMessageRemind._title.replace("【　　　            】", "").replace("【新订单"+_msg+"】", "");
			 	//这里写Cookie操作
	            newMessageRemind._step++;
	            if (newMessageRemind._step == 3) { newMessageRemind._step = 1 };
	            if (newMessageRemind._step == 1) { document.title = "【　　　            】" + temps };
	            if (newMessageRemind._step == 2) { document.title = "【新订单"+_msg+"】" + temps };
		 	}
        return [newMessageRemind._timer, newMessageRemind._title];
	},
	//取消新消息提示
	clear: function(){
		clearTimeout(newMessageRemind._timer );
		document.title = newMessageRemind._title;
		//这里写Cookie操作
	},
		//取消新消息提示
	clearParent: function(){
		setTimeout(function(){
			parent.document.title =newMessageRemind._title;
		},100) ;
		return ;
		//这里写Cookie操作
	}
			
};