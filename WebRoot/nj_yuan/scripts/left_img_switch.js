////////左侧组图轮显//////////////////
(function(jQuery){
    dk_slideplayer = function(object,config){
        this.obj = object;
        this.n =0;
        this.j =0;
        var _this = this;
        var t;
        var defaults = {width:"300px",height:"200px",fontsize:"12px",right:"0px",bottom:"3px",time:"5000"};
        this.config = jQuery.extend(defaults,config);
        this.count = jQuery(this.obj + " li").size();

        if(this.config.fontsize == "14px"){
            this.size = "14px";this.height = "23px";this.right = "6px";this.bottom = "15px";
        }else{
            this.size = "12px";this.height = "21px";this.right = "6px";this.bottom = "10px";
        }
		// Download by http://www.codefans.net
        this.factory = function(){
            //元素定位
            jQuery(this.obj).css({position:"relative",zIndex:"0",margin:"0",padding:"0",width:this.config.width,height:this.config.height,overflow:"hidden"})
            jQuery(this.obj).prepend("<div style='position:absolute;z-index:3;right:"+this.config.right+";bottom:"+this.config.bottom+"'></div>");
            jQuery(this.obj + " li").css({position:"absolute",top:"0",left:"0",width:"100%",height:"100%",overflow:"hidden"}).each(function(i){
                jQuery(_this.obj + " div").append("<a>"+(i+1)+"</a>");
            });
            jQuery(this.obj + " img").css({border:"none",width:"100%",height:"100%"})
            this.resetclass(this.obj + " div a",0);
            //标题背景
            jQuery(this.obj).prepend("<div class='dkTitleBg'></div>");
            jQuery(this.obj + " .dkTitleBg").css({position:"absolute",margin:"0",padding:"0",zIndex:"1",bottom:"0",left:"0",width:"100%",height:_this.height,background:"none",opacity:"0.4",overflow:"hidden"})
            //插入标题
            jQuery(this.obj).prepend("<div class='dkTitle'></div>");
            jQuery(this.obj + " p").each(function(i){			
                jQuery(this).appendTo(jQuery(_this.obj + " .dkTitle")).css({position:"absolute",margin:"0",padding:"0",zIndex:"2",bottom:"0",left:"0",width:"100%",height:_this.height,lineHeight:_this.height,textIndent:"5px",textDecoration:"none",fontSize:_this.size,color:"#FFFFFF",background:"none",opacity:"1",overflow:"hidden"});
                if(i!= 0){jQuery(this).hide()}
            });
            this.slide();
            this.addhover();
            t = setInterval(this.autoplay,this.config.time);
        }
        //图片渐影
        this.slide = function(){
            jQuery(this.obj + " div a").mouseover(function(){
                _this.j = jQuery(this).text() - 1;
                _this.n = _this.j;
                if (_this.j >= _this.count){return;}
                jQuery(_this.obj + " li:eq(" + _this.j + ")").fadeIn("200").siblings("li").fadeOut("200");
                jQuery(_this.obj + " .dkTitle p:eq(" + _this.j + ")").show().siblings().hide();
                _this.resetclass(_this.obj + " div a",_this.j);
            });
        }
        //滑过停止
        this.addhover = function(){
            jQuery(this.obj).hover(function(){clearInterval(t);}, function(){t = setInterval(_this.autoplay,_this.config.time)});
        }
        //自动播放 
        this.autoplay = function(){
            _this.n = _this.n >= (_this.count - 1) ? 0 : ++_this.n;
            jQuery(_this.obj + " div a").eq(_this.n).triggerHandler('mouseover');
        }
        //翻页函数
        this.resetclass =function(obj,i){
            jQuery(obj).css({float:"left",marginRight:"3px",width:"18px",height:"18px",lineHeight:"18px",textAlign:"center",fontSize:"14px",color:"#000",background:"#FFFFFF",cursor:"pointer"});
            jQuery(obj).eq(i).css({color:"#FFFFFF",background:"#005de8",textDecoration:"none"});
        }
        this.factory();
    }
})(jQuery)