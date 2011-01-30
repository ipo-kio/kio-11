package ru.ipo.kio.api.impl 
{
	import flash.net.SharedObject;
	import ru.ipo.kio.api.DataSource;
	import ru.ipo.kio.api.KioApi;
	import ru.ipo.kio.api.KioProblem;
	
	/**
	 * ...
	 * @author Ilya
	 */
	public class LSODataSource implements DataSource
	{
		
		private var so:SharedObject;
		
		//throws error if creation failed
		public function LSODataSource(problem:KioProblem, source_id:String)
		{			
			var name:String = "kio/" + problem.year + "/" + problem.level + "/" + problem.id + "/" + source_id;
			so = SharedObject.getLocal(name, "/");
		}
		
		public function get data():Object {
			return so.data;
		}
		
		public function flush():void {
			so.flush();
		}

		
	}

}