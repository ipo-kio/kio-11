package  
ru.ipo.kio.api.controls{
	import flash.display.SimpleButton;
	/**
	 * ...
	 * @author Ilya
	 */
	public class TextButton extends SimpleButton
	{
		
		private static const WIDTH:int = 70;
		private static const HEIGHT:int = 25;
		
		private static const BORDER_COLOR:uint = 0x000000;
		private static const UP_COLOR:uint = 0xAAFF33;
		private static const OVER_COLOR:uint = 0xBB7700;
		private static const DOWN_COLOR:uint = 0xFF4455;
		private static const UP_TEXT_COLOR:uint = 0x000000;
		private static const OVER_TEXT_COLOR:uint = 0x00FF00;
		
		public function TextButton(caption:String) 
		{
			this.upState = new TextSprite(caption, WIDTH, HEIGHT, BORDER_COLOR, UP_COLOR, UP_TEXT_COLOR, 0, 0);
			this.overState = new TextSprite(caption, WIDTH, HEIGHT, BORDER_COLOR, OVER_COLOR, OVER_TEXT_COLOR, 0, 0);
			this.downState = new TextSprite(caption, WIDTH, HEIGHT, BORDER_COLOR, DOWN_COLOR, OVER_TEXT_COLOR, 2, 1);
			
			this.hitTestState = this.overState;
		}
		
	}

}