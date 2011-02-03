package  
{
	/**
	 * ...
	 * @author Anna
	 */
	import adobe.utils.CustomActions;
	import flash.events.*;
	import flash.text.*;
	import flash.display.*;
	
	public class description extends Sprite
	{
		public var but:Sprite = new Sprite();
		public var deleteLastPoint:Boolean = false;
		public var b:button = new button();
		public var b2:button = new button();
		public var format:TextFormat = new TextFormat();
		public var t1:TextField = new TextField();
		public var t2:TextField = new TextField();
		
		public function description () 
		{
			uint1();
			uint2();
		
		}
		
		private function uint1 (e:Event = null):void
		{
			
			
			t1.text = "Длина";
			t2.text = "Время";
			
			format.font = "_sans";
			format.size = 15;
			t1.setTextFormat(format);
			t2.setTextFormat(format);
			t1.x = 600;
			t1.y = 20;
			t2.x = 600;
			t2.y = 40;
			addChild(t1);
			addChild(t2);
		}
		private function uint2 (e:Event = null):void
		{
			
			b.x = 600;
			b.y = 200;
			addChild(b);
			
			b2.x = 600;
			b2.y = 270;
			
			addChild(b2);
			
			
			var label:TextField = new TextField();
			var label2:TextField = new TextField();
			
			
			format.font = "_sans";
			format.size = 15;
			label.setTextFormat(format);
			label.wordWrap = true ;
			label.multiline;
			label.text = "Удалить последний шаг";
			
			
			b.addChild(label);
			
			label.autoSize = "left";
			label.selectable = false;
			
			
			label2.setTextFormat(format);
			label2.wordWrap = true ;
			label2.multiline;
			label2.text = "Удалить точку";
			label2.autoSize = "left";
			label2.selectable = false;
			
			b2.addChild(label2);
		}
		
		
		
	}

}