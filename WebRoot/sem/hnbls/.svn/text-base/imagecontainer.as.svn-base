package
{
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	public class imagecontainer extends MovieClip
	{
		public var url:String=new String();
		public var imageloader:Loader=new Loader();
		public function imagecontainer():void
		{
			this.buttonMode=true;
			this.addEventListener(MouseEvent.CLICK,MouseClickEvent);
		}
		//加载图片
		public function loadImage(str:String):void
		{
			imageloader.load(new URLRequest(str));
			imageloader.contentLoaderInfo.addEventListener(Event.COMPLETE,LoadedEvent);
			imageloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,LoadProgressEvent);
			imageloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadErrorEvent);
		}
		//鼠标点击事件
		public function MouseClickEvent(e:MouseEvent):void
		{
            var request:URLRequest = new URLRequest(url);
            navigateToURL(request,"_blank");
		}
		//加载过程
		private function LoadProgressEvent(e:ProgressEvent):void
		{
			var percent:int=int(e.target.bytesLoaded*100/e.target.bytesTotal);
			loading.gotoAndStop(percent);
		}
		//加载完成
		private function LoadedEvent(e:Event):void
		{
			loading.visible=false;
			e.target.removeEventListener(ProgressEvent.PROGRESS,LoadProgressEvent);
			e.target.removeEventListener(Event.COMPLETE,LoadedEvent);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR,LoadErrorEvent);
			//imageloader.scaleX=this.width/imageloader.width;
			//imageloader.scaleY=this.height/imageloader.height;
			this.addChild(imageloader);
		}
		//加载失败
		private function LoadErrorEvent(e:IOErrorEvent):void
		{
			loading.visible=false;
			e.target.removeEventListener(ProgressEvent.PROGRESS,LoadProgressEvent);
			e.target.removeEventListener(Event.COMPLETE,LoadedEvent);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR,LoadErrorEvent);
			trace("加载失败！");
		}
	}
}