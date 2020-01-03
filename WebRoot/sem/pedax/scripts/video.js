function getFlv(flvurl,auto,pic,width,height){
	var s1 = new SWFObject("flvplayer.swf"/*tpa=http://www.pedax.cn/scripts/flvplayer.swf*/,"single",width,height,"7");
	s1.addParam("allowfullscreen","true");
	s1.addVariable("file",flvurl);
	s1.addVariable("image",pic);
	s1.addVariable("width",width);
	s1.addVariable("height",height);
    s1.addVariable("autostart", auto);
	s1.write("videocontent");	
}
