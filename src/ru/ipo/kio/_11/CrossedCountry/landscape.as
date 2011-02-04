package ru.ipo.kio._11.CrossedCountry  
{
	import flash.display.*;
	import flash.events.*;
	import flash.sampler.NewObjectSample;
	import flash.utils.*;
	import flash.text.*;
	import flash.filters.DropShadowFilter;
	
	import flash.geom.*;
	
	/**
	 * ...
	 * @author Anna
	 */
	public class landscape extends Sprite
	{
		public var picObj1:String = "mountain1.jpg";
		public var picObj2:String = "swamp1.jpg";
		public var picObj3:String = "swamp2.jpg";
		public var picObj4:String = "Water.jpg";
		public var picObj5:String = "sand2.jpg";
		public var picObj6:String = "Forest1.jpg";
		public var picObj7:String = "wall.JPG";
		
		public var mShape:landObj;
		
		// объекты ландшафта
		public var ObjArray1:Array = new Array(240, 0,240,40,220,40, 220, 80,140,80, 140,100,100,100,100,80,0, 80, 0, 0, "горы");
		public var ObjArray2:Array = new Array(140, 0, 140, 380, 260, 380, 260, 500,80,500,80,80,0,80,0,0, "болото");
		public var ObjArray3:Array = new Array(300, 0, 300, 60, 60,60,60,200,0,200, 0, 0, "болото"); // координаты объекта относительно заданных для этого объекта начал координат
		public var ObjArray4:Array = new Array(100, 0, 100, 300, 120, 300, 120, 340,0,340,0,0, "озеро");
		public var ObjArray5:Array = new Array(80, 0, 80, -140, 180, -140,180,-80,200,-80,200,-40,180,-40, 180, 180,140,180,140,-80,120,-80,120,40,40,40,40,60,120,60,120,180,0,180,0,0, "песок");
		public var ObjArray6:Array = new Array(100, 0, 100, 360, 0, 360, 0,240,-20,240,-20,200,0,200,0, 0, "лес");
		// стены 
		public var ObjArray7:Array = new Array(100, 0, 100, 20, 0, 20, 0, 0, "стена");
		public var ObjArray8:Array = new Array(80,0,80,-40,100,-40,100,0,180, 0, 180, 420, 160, 420,160,20,0,20, 0, 0, "стена");
		public var ObjArray9:Array = new Array(60, 0, 60, -140, 200, -140, 200,-60,180,-60,180,-120,80,-120,80,20,0,20, 0, 0, "стена");
		public var ObjArray10:Array = new Array(80, 0, 80, -120, 100,-120,100,140,80,140,80,20,0, 20, 0, 0, "стена");
		public var ObjArray11:Array = new Array(20, 0, 20, 200, 0, 200, 0, 0, "стена");
		public var ObjArray12:Array = new Array(20, 0, 20, 220, 0, 220, 0, 0, "стена");
		public var ObjArray13:Array = new Array(20, 0, 20, 120,120,120,120,140, 0, 140, 0, 0, "стена");
		
		public var ArrayObjs:Array = new Array();
		
		public var ObjsArrays:Array = new Array();
		public var ObjNArray:Array = new Array();
		public var PointCrossArray:Array = new Array();
		public var ArrayCheckObj:Array = new Array();
		public var ArrayWeight:Array = new Array(7,9,9,10,13,20,1,1,1,1,1,1,1); // скорость в 1м/ 1мин
		public var interval:uint;
		private var delay:Number=2000;
		private var label_txt:String = "болото";
		public var alt:Sprite = new Sprite();
		public var alt1:Sprite;
		public var ObjIndex:int;
		public var notRemoved:int=0;
		public var landObjN:landObj;
		//
		public var land1:landObj = new landObj(picObj1, 20, 20, 10, ObjArray1);
		public var land2:landObj = new landObj(picObj2, 260, 20, 8, ObjArray2);
		public var land3:landObj = new landObj(picObj3, 20, 120, 6, ObjArray3);
		public var land4:landObj = new landObj(picObj4, 220, 180, 6, ObjArray4);
		public var land5:landObj = new landObj(picObj5, 20, 340, 18, ObjArray5);
		public var land6:landObj = new landObj(picObj6, 420, 20, 8, ObjArray6);
		// стена
		public var land7:landObj = new landObj(picObj7, 20, 100, 4, ObjArray7);
		public var land8:landObj = new landObj(picObj7, 160, 100, 10, ObjArray8);
		public var land9:landObj = new landObj(picObj7, 20, 320, 10, ObjArray9);
		public var land10:landObj = new landObj(picObj7, 60, 380, 8, ObjArray10);
		public var land11:landObj = new landObj(picObj7, 400, 20, 4, ObjArray11);
		public var land12:landObj = new landObj(picObj7, 200, 300, 4, ObjArray12);
		public var land13:landObj = new landObj(picObj7, 400, 260, 6, ObjArray13);

		
		public var eventX:Number;
		public var eventY:Number;
		public var target:DisplayObjectContainer ;
		public var h:Boolean = false;
		public var lMath:LMath = new LMath;
		
		public var PathLand:Number = 0;
		public var PathTime:Number = 0;
		
		public function landscape() 
		{
			ArrayObjs.push(land1, land2, land3,land4,land5,land6,land7,land8,land9,land10,land11,land12,land13);
		
			// вывод на экран всех объектов
			for (var l:int = 0; l < ArrayObjs.length; l++ )
				{
					addChild(ArrayObjs[l]);
					ObjsArrays.push(ArrayObjs[l].ObjArrXY());
				}
				
			ArrayCheckObj.push(true, true, true, true, true, true, true, true, true, true, true, true, true);
			
			// вывод на экран сетки
			var grid:gridObj = new gridObj();
			addChild(grid);
		}
		
		
		public function eventHandler(e:MouseEvent):void 
		{
			
			eventX = e.stageX;
			eventY = e.stageY;
			
			for (var k:int = 0; k < ArrayObjs.length; k++ )
			{
				if (ArrayObjs[k].mShape.hitTestPoint(e.stageX, e.stageY, true))
			{
				if (ArrayCheckObj[k])
				{
					for (var m:int = 0; m < ArrayCheckObj.length; m++ )
					{
						if (k != m)
							ArrayCheckObj[m] = true;
						else
							ArrayCheckObj[k] = false;
					}
					landObjN = ArrayObjs[k];
					clearInterval(interval);
					ObjIndex = k + 1;
					drawCap();
					
					trace("object " + (k + 1));
					
				}
				
			}
			}
			
		}
		
		public function drawCap():void
		{
			if (notRemoved)
				removeDrawC();
			
			clearInterval(interval);
			alt1 = new Sprite();
			
			alt1.graphics.beginFill(0xC1FFC1);
			alt1.graphics.drawRoundRect(0, 0, 100, 100/2,20);
			alt1.graphics.endFill();
			
			alt1.x = eventX + 10;
			alt1.y = eventY + 15;
			
			var altFormat:TextFormat = new TextFormat();
			altFormat.font = "arial";
			altFormat.size = 15;
			
			var label:TextField = new TextField();
			
			label.setTextFormat(altFormat);
			label.selectable = false;
			label.borderColor = 0x000000;
			label.text = landObjN.ObjA[landObjN.ObjA.length - 1] + "   " + ArrayWeight[ObjIndex - 1] + " м/с";
			
			label.x = 0;
			label.y = 0;
			
			//trace(label.text);
			
			addChild(alt1);
			alt1.addChild(label);
			//trace("add");
			notRemoved = 1;
			
			interval = setInterval(removeDrawC, delay);
			
			
		}
		
		
		
		
		public function removeDrawC():void
		{
			//trace("remove");
			clearInterval(interval);
			if (alt1)
				if (alt1.parent != null)
					{
						this.removeChild(alt1);
						notRemoved = 0;
					}
		}
			
		
		public function collisionTest(pointArray:Array):Number
		{
			PathLand = 0;
			PathTime = 0;
			
			var i:int;
			var k:int;
			var j:int;
			var lp0:Point = new Point, lp1:Point = new Point, p0:Point = new Point, p1:Point = new Point,colP:Point;
			//var StartP:Point = new Point;
			var StEndPoint:Boolean = false;
			
			
			for (k = 0; k < ObjsArrays.length; k++ )
			{
				ObjNArray = ObjsArrays[k];
			
			
			for (i = 0; i < pointArray.length-5 ; i = i + 3 )
			{
				
				
				
				p0.x = pointArray[i + 1];
				p0.y = pointArray[i + 2];
				p1.x = pointArray[i + 4];
				p1.y = pointArray[i + 5];
			
				StEndPoint = false;
			
				if (ArrayObjs[k].mShape.hitTestPoint(p0.x, p0.y, true))
					{
						PointCrossArray.push(p0.x, p0.y);
						//trace("начальная точка принадлежит");
						StEndPoint = true;
					}
				
			var h:int = 0;
			
			for (j = 0; j < ObjNArray.length - 3 ; j = j + 2 )
			{
				
				
				lp0.x = ObjNArray[j] ;
				lp0.y = ObjNArray[j+1];
				lp1.x = ObjNArray[j+2];
				lp1.y = ObjNArray[j + 3];
				
				
				if (lMath.lineCross(lp0, lp1, p0, p1) == true)
				{
					//trace("пересекает объект" + (k+1));
					colP = lMath.lineIntersect(lp0, lp1, p0, p1);
					
				
					
					for (var g:int = 0; g < PointCrossArray.length; g=g+2)
						if((PointCrossArray[g] == colP.x) && (PointCrossArray[g+1] == colP.y))
							h = 1;
					if (h != 1 )
						PointCrossArray.push(colP.x, colP.y); // точки пересечения 
					
					
				}
			}
			
			
			if (ArrayObjs[k].mShape.hitTestPoint(p1.x, p1.y, true))
					{
						PointCrossArray.push(p1.x, p1.y);
						StEndPoint = true;
						//trace("2 точка принадлежит");
					}
					
			if(PointCrossArray.length == 2)
				if (StEndPoint != true)
					PointCrossArray.splice(0);
					
			//trace(PointCrossArray);
			
				var m:int;
				var n:int;
				var minX:Number;
				var minY:Number;
				var l:int;
				var min_index:int;
				var min:Number;
				var min0:Number;
			
				
					while (PointCrossArray.length!=0)
					{
						m = 0;
						minX = PointCrossArray[m];
						minY = PointCrossArray[m + 1];
						// нахождение ближайшей точки к началу координат
						
						for (l = 2; l < PointCrossArray.length; l=l+2 )
							{
								if (PointCrossArray[l] < PointCrossArray[m])
									{
										m = l;
										minX = PointCrossArray[l];
										minY = PointCrossArray[l + 1];
									}
									
							
								else
									if (PointCrossArray[l] == PointCrossArray[m])
										if (PointCrossArray[l + 1] < PointCrossArray[m + 1])
											{
												m = l;
												minY = PointCrossArray[l + 1];
											}
							}
						PointCrossArray.splice(m, 2);
							
					
						min0 = Math.sqrt(Math.pow(minX - PointCrossArray[0], 2) + Math.pow(minY - PointCrossArray[1], 2));
						min_index = 0;
						
						
					//	trace(min0);
						
						for (n = 2; n < PointCrossArray.length; n = n + 2 )
						{
							
							min  = Math.sqrt(Math.pow(minX - PointCrossArray[n], 2) + Math.pow(minY - PointCrossArray[n + 1], 2));
							if (min0 > min)
								{
									min0 = min;
									min_index = n;
								}
						}
						
						
						PointCrossArray.splice(min_index, 2);
						
						PathLand = PathLand + min0;
						PathTime = PathTime + min0/ ArrayWeight[k];
					
						
						
					}
			
			}
			
			}
		
		return PathLand;
		
		}
		
	}

}