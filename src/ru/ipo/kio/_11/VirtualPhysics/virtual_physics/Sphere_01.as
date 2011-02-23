package ru.ipo.kio._11.VirtualPhysics.virtual_physics 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Sphere_01 
	{
		[Embed(source="../images/Sphere_01.png",mimeType="application/octet-stream")]
		public var MyEmbed:Class;
		public function Sphere_01() 
		{
			var bitmapAsset:BitmapAsset = new MyEmbed();
			return bitmapAsset.bitmapData;
		}
		
	}

}