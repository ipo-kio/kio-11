package  
{
	import flash.display.Sprite;
	import flash.geom.*;
	import flash.display.*;
	import flash.events.*;
	/**
	 * ...
	 * @author Anna
	 */
	public class pointer extends Sprite
	{
		public var pt:Sprite = new Sprite();;
		public var dr:Boolean = false;
		public var startdr: Boolean = false;
		public var pX:int;
		public var pY:int;
		public var p1X:int;
		public var p2Y:int;
		public var mouseOver:Boolean;
		public var land:landscape;
		public var selPt:int = 0;
		 
		public function pointer(ptX:int, ptY:int, color:uint, rad:int, alpha:Number) 
		{
			pt.graphics.beginFill(color, alpha);
			pt.graphics.drawCircle(ptX, ptY, rad);
			pt.graphics.endFill();
			addChild(pt);	
			p1X = ptX;
			p2Y = ptY;
		}
		public function DragPt(e:MouseEvent):void
		{
			StDr();	
			pt.startDrag();
			startdr = true;
				trace("draag");
		}
		public function DropPt(e:MouseEvent):void
		{
			if(land.hitTestPoint(e.stageX,e.stageY,true))
			{
			pt.stopDrag();
			trace("drop pt");
			startdr = false;
			dr = true;
			}
			
			pX = (e.stageX - e.stageX % 10)+5;
			pY = (e.stageY - e.stageY % 10)+5;
			
		}
		public function PickPt(e:MouseEvent):void
		{
			//pX = (e.stageX - e.stageX % 10)+10;
			//pY = (e.stageY - e.stageY % 10)+10;
			pX = p1X;
			pY = p2Y;
			if (!mouseOver)
				{
				
				
				pt.graphics.clear();
				pt.graphics.beginFill(0x00ff00, 1.0);
				pt.graphics.drawCircle(pX, pY, 5);
				pt.graphics.endFill();
				mouseOver = true;
				trace("pick");
				trace(pX, pY);
				trace(e.stageX, e.stageY);
				
				}
		}
		
		public function NotPickPt(e:MouseEvent):void
		{
				pt.graphics.clear();
				pt.graphics.beginFill(0x00ff00, 1.0);
				pt.graphics.drawCircle(pX, pY, 3);
				pt.graphics.endFill();
			mouseOver = false;
			trace("not pick");
			trace(pX, pY);
			trace(e.stageX, e.stageY);

		}
		
		public function SelectedPt(e:MouseEvent):void
		{
			mouseOver = false;
			trace("selecting");
			pX = (e.stageX - e.stageX % 10)+5;
			pY = (e.stageY - e.stageY % 10)+5;
			
			if ((selPt&1) == 0)
				{
				
				pt.graphics.clear();
				pt.graphics.beginFill(0x0000ff, 1.0);
				pt.graphics.drawCircle(pX, pY, 5);
				pt.graphics.endFill();
				trace("одно выделение");
				
				}
			else
			{
				pt.graphics.clear();
				pt.graphics.beginFill(0x00ff00, 1.0);
				pt.graphics.drawCircle(pX, pY, 3);
				pt.graphics.endFill();
				trace("два выделения");
			}
			
			selPt++;
		}
		
		public function Dr(l:landscape):void
		{
			land = l;
			pt.addEventListener(MouseEvent.MOUSE_DOWN, DragPt);
			pt.addEventListener(MouseEvent.MOUSE_UP, DropPt);
			pt.addEventListener(MouseEvent.MOUSE_OVER, PickPt);
			pt.addEventListener(MouseEvent.MOUSE_OUT, NotPickPt);
			
			
		}
		
		public function Check():Boolean
		{
			if (dr)
			{
				dr = false;
				return true;
			}
			else
				return false;
		}
		public function CheckPick():Boolean
		{
			if (mouseOver)
			{
				return true;
			}
			else
				return false;
		}
		
		public function StDr():void 
		{
			pt.removeEventListener(MouseEvent.MOUSE_OVER, PickPt);
			pt.removeEventListener(MouseEvent.MOUSE_OUT, NotPickPt);
		}
		
		public function DelEvents():void
		{
			StDr();
			pt.removeEventListener(MouseEvent.MOUSE_DOWN, DragPt);
			pt.removeEventListener(MouseEvent.MOUSE_UP, DropPt);
		}
	}

}