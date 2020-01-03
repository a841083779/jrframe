package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	public class container extends MovieClip
	{
		public var tempX:Number=0;
		public var tempIndex:int=0;
		public var speed:Number=0;
		public var templength:Number=0;
		public function container():void
		{
			tempX=this.x;
		}
		public function moveImage(index:int):void
		{
			if(index!=tempIndex)
			{
				tempIndex=index;
				tempX=(-1)*templength*tempIndex;
				speed=int((tempX-this.x)/15);
				this.addEventListener(Event.ENTER_FRAME,MoveImageEvent);
			}
		}
		public function MoveImageEvent(e:Event):void
		{
			if(Math.abs(this.x-tempX)>100)
			{
				this.x+=speed;
			}
			else
			{
				if(speed>0)
				{
					if(Math.abs(this.x-tempX)>8)
					{
						this.x+=8;
					}
					else
					{
						this.x=tempX;
						this.removeEventListener(Event.ENTER_FRAME,MoveImageEvent);
					}
				}
				else
				{
					
					if(Math.abs(this.x-tempX)>8)
					{
						this.x-=8;
					}
					else
					{
						this.x=tempX;
						this.removeEventListener(Event.ENTER_FRAME,MoveImageEvent);
					}
				}
			}
		}
	}
}