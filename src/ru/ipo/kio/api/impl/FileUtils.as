package ru.ipo.kio.api.impl 
{
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import ru.ipo.kio.api.KioProblem;
	/**
	 * ...
	 * @author Ilya
	 */
	public class FileUtils 
	{
		
		public static function loadSolution(problem:KioProblem):void {
			//TODO handle errors
			
			var fr:FileReference = new FileReference();
			
			fr.browse();
			fr.addEventListener(Event.SELECT, function(e:Event):void {
				fr.addEventListener(Event.COMPLETE, function(e:Event):void {
					var data:ByteArray = fr.data;					
					var o : Object = data.readObject();
					problem.loadSolution(o);
				});
				fr.load();
			});
		}
		
		public static function saveSolution(problem:KioProblem):void {
			var fr:FileReference = new FileReference();
			var data:ByteArray = new ByteArray();
			var sol:Object = problem.solution;
			data.writeObject(sol);
			fr.save(data);
		}
		
		public static function saveSolutionLOS(problem:KioProblem, type:String):void {
			
		}
	}

}