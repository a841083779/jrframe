var newMessageRemind={
	_step: 0,
    _title: document.title,
    _timer: null,
	//显示新消息提示
	show:function(req){
 
        return "";
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