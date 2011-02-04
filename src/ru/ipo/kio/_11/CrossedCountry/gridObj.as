package ru.ipo.kio._11.CrossedCountry  
{
	/**
	 * ...
	 * @author Anna
	 */
	import flash.display.Sprite;
	import flash.events.*;
	 
	public class gridObj extends Sprite
	{
		private var gridShape:Sprite;
		private var i:int;
		private var j:int;
		
		public function gridObj() 
		{
			
			for (j = 0; j < 50; j++ )
			{
				gridShape = new Sprite();
				gridShape.x = 20;
				gridShape.y = 25+j*10;
			
				gridShape.graphics.lineStyle(1);
				for (i= 0; i < 40; i++) 
				{
				gridShape.graphics.lineTo(500, 0);
				}
				addChild(gridShape);
			}
			for (j = 0; j < 50; j++ )
			{
				gridShape = new Sprite();
				gridShape.x = 25+j*10;
				gridShape.y = 20;
			
				gridShape.graphics.lineStyle(1);
				for (i = 0; i < 40; i++) 
				{
				gridShape.graphics.lineTo(0, 500);
				}
				addChild(gridShape);
			}
		
		}
		
	}
}