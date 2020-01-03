(function(S,win,doc){
    var D = S.DOM,E = S.Event;
    var ifIE6 = S.UA.ie<=6?true:false;
    var ifIE8 = S.UA.ie<=8?true:false;
    var wheelDelta = 0;
    var blockOffset = [
        {left:1920,top:0,height:1000},//首页
        {left:1920,top:1100,height:1230},//威格尔
        {left:2520,top:2330,height:1027},//普堃
        {left:4440,top:1100,height:1060},//军恒
        {left:4840,top:2330,height:1072},//山工
        {left:1920,top:4250,height:1080},//卡特
		{left:4440,top:3930,height:1230}//国杰
    ];
    var nowPage = 0;
    var CenterLeft = 1920;
    var boxTop;
    var boxLeft;
    var allHeight;
    var scrollTop = 0;
    var doAnim = false;
    var viewHeight = D.viewportHeight();
    var viewWidth = D.viewportWidth();
    var mapNowTime = null;
    var mapClose = true;
    var userClose = true;
    //使当前窗口居中显示
    function boxViewInit(){
        viewHeight = D.viewportHeight();
        viewWidth = D.viewportWidth();
        boxLeft = makeCenterLeft();
        boxTop = parseInt(makeCenterTop());
//        if(!ifIE6){
//            if(viewHeight >= blockOffset[0].height+133&&nowPage == 0){
//                S.one(".L_bottom").css({'position':'absolute','top':blockOffset[0].height-20})
//            }
//            else{
//                S.one(".L_bottom").css({'position':'fixed','top':viewHeight - S.one(".L_bottom").height()})
//            }
//        }
        D.css(D.get(".L_conBox"),{"position":"absolute","left":boxLeft});
        allHeight = blockOffset[nowPage].height;//>viewHeight?blockOffset[nowPage].height+0.5*viewHeight:1.5*viewHeight;
        D.css(D.get(".L_main"),"height",parseInt(allHeight));
    }
    //获取要居中时的left值
    function makeCenterLeft(){
        var width = D.width(D.get(".L_conBox"));
        var boxLeft = (viewWidth-width)/2-(blockOffset[nowPage].left - CenterLeft);
        return parseInt(boxLeft);
    }
    //获取要居中时的top值
    function makeCenterTop(){
        if(blockOffset[nowPage].height>= viewHeight){
            return 0;
        }
        else{
            return (viewHeight - blockOffset[nowPage].height)/2;
        }
    }
    //滚动条滚到底时切换页面
    function bindScroll(e){
        var scrollTop = D.scrollTop();
        S.one(win).stop();
        var isMouse = e.type == "mousewheel"?true:false;
        var direction;
        if(isMouse){
            direction = e.deltaY<0 ? "down" : "up";
        }
        else{
            if(e.which == 40){
                direction = "down";
            }
            if(e.which == 38){
                direction = "up";
            }
        }
        if(nowPage == 7&&doAnim == false){
            if(D.scrollTop()>=1200){
                S.one(".bottom_nav").all("a").item(6).addClass("atBlockNav6");
                S.one(".bottom_nav").all("a").item(5).removeClass("atBlockNav5");
            }
            else{
                S.one(".bottom_nav").all("a").item(5).addClass("atBlockNav5");
                S.one(".bottom_nav").all("a").item(6).removeClass("atBlockNav6");
            }
        }
        if(direction == "down"|| e.type == "touchmove"){
            if(scrollTop + viewHeight>=parseInt(allHeight)){
                if(nowPage < blockOffset.length-1){
                    if(!doAnim){
                        pageAnim(nowPage+1);
                    }
                    else{
                        return;
                    }
                }
                else{
                    return;
                }
            }
        }
        else if(direction == "up"|| e.type == "touchmove"){
            if(scrollTop == 0){
                if(nowPage > 0){
                    if(!doAnim){
                        pageAnim(nowPage-1);
                    }
                    else{
                        return;
                    }
                }
                else{
                    return;
                }
            }
        }
    }
    //切换动画方法
    function pageAnim(page){
        var doMove1 = nowPage == 6 ? true : false;
        if(nowPage> -1){
            S.one(".bottom_nav").all("a").item(6).removeClass("atBlockNav6");
            S.one(".bottom_nav").all("a").item(nowPage).removeClass("atBlockNav"+(nowPage));
        }
        S.all(".map_nav_btn").removeClass("map_now");
        S.all(".map_nav_btn").item(nowPage).addClass("map_nav_hover");
        clearTimeout(mapNowTime);
        mapNowTime = null;
        nowPage = page>=6?6:page;
        var makeScrollTop = page==7?1300:0;
        allHeight = blockOffset[nowPage].height;//>viewHeight?blockOffset[nowPage].height+0.5*viewHeight:1.5*viewHeight;
        if(!(doMove1&&page==7||doMove1&&page==6)){
            if(ifIE8){S.later(function(){
                S.one(".L_main").css("height",viewHeight+1);
            },100)}
            else{S.one(".L_main").css("height",viewHeight+1);}
        }
//        else{
//            if(ifIE8){S.later(function(){
//                S.one(".L_main").css("height",viewHeight+1);
//            },100)}
//            else{S.one(".L_main").css("height",viewHeight+1);}
//        };
        S.one(".L_part"+(nowPage+1)).all("img").each(function(node,index){
            node.css("visibility","visible");
            if(!node.attr("data-ks"+"-lazyload")||node.attr("data-ks"+"-lazyload")=="true"){
                return
            }
            else{
                node.attr("src",node.attr("data-ks"+"-lazyload"));
                node.removeAttr("data-ks"+"-lazyload");
            }
        })
        if(nowPage != -1){
            S.one(".bottom_nav").all("a").item(page).addClass("atBlockNav"+(page));
        }
        S.all(".map_nav_btn").item(nowPage).addClass("map_now");

        S.all(".map_nav_btn").item(nowPage).removeClass("map_nav_hover");
        if(!userClose&&nowPage!=0){
            mapNow();
        }
        doAnim = true;
//        if(!ifIE6){
//            if(viewHeight >= blockOffset[0].height-50&&nowPage == 0){
//                S.one(".L_bottom").css({'position':'absolute','top':blockOffset[0].height-20})
//            }
//            else{
//                S.one(".L_bottom").css({'position':'fixed','top':viewHeight - S.one(".L_bottom").height()})
//            }
//        }
        if(nowPage == 0){
            S.one(".map_box").fadeOut(0.5);
            S.one(".map_small").fadeIn(0.5);
            userClose = false;
            mapNow();
        }
        else{
            if(mapClose == true){
                S.one(".btn_Close").fire("click");
            }
        }
        var makeLeft = makeCenterLeft();
        var makeTop = nowPage == 0?0:parseInt(-1*blockOffset[nowPage].top + makeCenterTop());
        if(doMove1&&page==7||doMove1&&page==6){
            S.one(win).stop().animate({
                scrollTop:makeScrollTop
            }, 1.5, "easeOut",function(){
                doAnim = false;
            });
        }
        else{
            S.one(".L_conBox").animate({
                left:makeLeft,
                top:makeTop
            },1,'easeOut',function(){
                doAnim = false;
                if(nowPage == 6){
//					S.one("#footer").show();
                    S.one(".L_main").css("height",blockOffset[nowPage].height);//+20
                }
                else{
//					S.one("#footer").hide();
                    S.one(".L_main").css("height",parseInt(allHeight));
                }
                S.one(win).stop().animate({
                    scrollTop:makeScrollTop
                }, 1.5, "easeOut",function(){
                    D.scrollTop(makeScrollTop+1);
                });
            })
        }
    }
    //当前点闪动动画
    function mapNow(){
        if(S.all(".map_now").length == 1){
            S.one(".map_now").toggleClass("map_now_ani");
            mapNowTime = setTimeout(function(){mapNow()},800);
        }
        else{
            return;
        }
    }

    function OfTop(){
        if(D.scrollTop()>=95&& S.one(".map_small").attr("class") == "map_small map_stay"){
            S.one(".map_small").removeClass("map_stay");
        }
        else if(D.scrollTop()<95&&nowPage == 0){
            S.one(".map_small").addClass("map_stay");
            S.one(".map_box").addClass("map_box_stay");
            S.one(".tishi_msg").addClass("tishi_msg_stay");
        }
        if(D.scrollTop()>=95&& S.one(".map_box").attr("class") == "map_box map_box_stay"){
            S.one(".map_box").removeClass("map_box_stay");
        }
        if(D.scrollTop()>=95){
            S.one(".tishi_msg").removeClass("tishi_msg_stay");
        }
    }
	
    S.ready(function(){
        E.on(doc, 'mousewheel', bindScroll);
        E.on(doc, 'keydown', bindScroll);
        E.on(win, 'resize', boxViewInit);
        D.get(".L_main").ontouchmove = bindScroll;
        boxViewInit();
        S.one(".bottom_nav").all("a").on("click",function(){
            var page = parseInt(D.attr(this,"page"));
            pageAnim(page);
        });
        D.scrollTop(0);
//		S.one("#footer").hide();
        S.all(".map_nav_btn").on("click",function(){
            var page = parseInt(D.attr(this,"page"));
            pageAnim(page);
        });
		S.all(".slider_img_btn").on("click",function(){
            var page = parseInt(D.attr(this,"page"));
            pageAnim(page);
        });
		S.all(".backHome").on("click",function(){
            var page = parseInt(D.attr(this,"page"));
            pageAnim(page);
        });
        S.one(".j_topBegin").on("click",function(){
            pageAnim(1);
        })
        if(!ifIE6){
            if(viewHeight >= blockOffset[0].height+133&&nowPage == 0){
                S.one(".L_bottom").css({'position':'absolute','top':blockOffset[0].height-20});
            }
            var strag=setInterval(OfTop,100);
            S.one("#J_mapShow").on("click",function(){
                S.one(".map_small").fadeOut(0.5,function(){
                    S.one(".map_box").fadeIn(0.5);
                });
                userClose = false;
                mapClose = false;
                mapNow();
            });
            S.one(".btn_Close").on("click",function(){
                S.one(".map_box").fadeOut(0.5,function(){
                    S.one(".map_box").hide();
                    S.one(".map_small").fadeIn(0.5);;
                })
                userClose = true;
                mapClose =true;
                clearTimeout(mapNowTime);
                mapNowTime = null;
            })
            S.all(".map_nav_btn").item(nowPage).addClass("map_now");
            S.all(".map_nav_btn").item(nowPage).removeClass("map_nav_hover");
            mapNow();
        }
       
        S.all(".j_backTop").on("click",function(){
            pageAnim(0);
        })
    })
})(KISSY,window,document)