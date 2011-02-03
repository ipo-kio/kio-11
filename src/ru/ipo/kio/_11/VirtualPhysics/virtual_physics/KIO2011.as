package ru.ipo.kio._11.VirtualPhysics.virtual_physics 
{
	import ru.ipo.kio.api.KioApi;
	import ru.ipo.kio.base.KioBase;
	/**
	 * ...
	 * @author Ilya
	 */
	public class KIO2011 extends Sprite
	{
		
		public function KIO2011() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			KioBase.instance.init(this, []);
		}
		
	}

}