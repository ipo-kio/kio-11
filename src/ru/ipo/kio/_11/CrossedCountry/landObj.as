package  
{
	/**
	 * ...
	 * @author Anna
	 */
	
	import flash.errors.InvalidSWFError;
	import flash.events.*;
	import flash.display.*;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.*;
	
	
	public class landObj extends Sprite
	{
		private var shape:Sprite;
		private var loader:Loader;
		private var bmpImage:BitmapData;
		public var mShape:Sprite;
		public var ObjN:Number;
		public var ObjA:Array;
		public var delay:Number;
		
		public var checkCapy:Boolean = true;
		private var interval:uint;
		private var label_txt:String = "болото";
		public var alt:MovieClip = new MovieClip();
		public var eventX:Number;
		public var eventY:Number;
		private var drawB:Boolean = false;
		
		public function landObj(picObj:String,ObjX:Number,ObjY:Number,ObjNum:Number,ObjArray:Array) 
		{
			
			delay = 10000;
			loader = new Loader;
			mShape = new Sprite();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,picLoaded);
			loader.load(new URLRequest(picObj));
			
			mShape.x = ObjX;
			mShape.y = ObjY;
			ObjN = ObjNum;
			ObjA = ObjArray;
			
		}
		
		public function ObjArrXY():Array
		{
			var Arr:Array = new Array();
			
			Arr.push(mShape.x);
			Arr.push(mShape.y);
			
			for (var i:int = 0; i < ObjA.length - 1; i=i+2 )
				{
					Arr.push(ObjA[i] + mShape.x);
					Arr.push(ObjA[i+1] + mShape.y);
				}
			return Arr;	
		}
		
		private function picLoaded(event:Event):void
		{
			bmpImage = new BitmapData(loader.width, loader.height);
			bmpImage.draw(loader);
			mShape.graphics.lineStyle(2);
			mShape.graphics.beginBitmapFill(bmpImage);
			for (var i:Number = 0; i < ((ObjN*2)-2); i=i+2 )
			{
			mShape.graphics.lineTo(ObjA[i], ObjA[i+1]);
			}
			mShape.graphics.endFill();
			addChild(mShape);
			
		}
		
		
		private function setupEvents():void
		{
			mShape.addEventListener(MouseEvent.MOUSE_MOVE, eventHandler);
			
		}
		
		public function eventHandler(e:MouseEvent):void 
		{
			if (mShape.hitTestPoint(e.stageX, e.stageY))
			{
				eventX = e.stageX;
				eventY = e.stageY;
				if (drawB) removeDrawC();
				
				if (checkCapy)
				{
					
					interval = setInterval(drawC, delay);
					trace("попал на объект " + ObjA[ObjA.length - 1]);	
					
				}
				
			}
			
			
			
		}
		
		private function drawC():void
		{
			clearInterval(interval);
			
			var format:TextFormat = new TextFormat();
			format.size = 10;
			
			var target:DisplayObject = mShape.parent;
			
		
		}
		
		private function updatePosition():void
		{
			var target:DisplayObjectContainer = mShape.parent;
			alt.x = eventX - (100 / 2);
			alt.y = eventY - (50 + 5);
			
		}
		
		private function removeDrawC():void
		{
			removeChild(alt);
			drawB = false;
		}
		
		
		
		
	}
	

}