package ru.ipo.kio._11.semiramida {

	import flash.display.DisplayObject;
	import ru.ipo.kio.api.KioApi;
	import ru.ipo.kio.api.KioProblem;
	
	public class SemiramidaProblem implements KioProblem
	{
		
		public static const ID:String = "semiramida";
	
		private var sp:Workspace;
		
		public function SemiramidaProblem() {
			KioApi.initialize(this);
			
			sp = new Workspace;
		}
		
	    public function get id():String {
			return ID;
		}

		public function get year():int {
			return 2011;
		}

		public function get level():int {
			return 2;
		}

		public function get display():DisplayObject {
			return sp;
		}

		public function get solution():Object {
			return {};
		}

		public function loadSolution(solution:Object):Boolean {
			return solution.txt;
		}

		public function check(solution:Object):Object {
			return new Object();
		}

		public function compare(solution1:Object, solution2:Object):int {
			return 1;
		}
		
	}

}