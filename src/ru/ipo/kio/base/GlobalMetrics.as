package  
ru.ipo.kio.base{
	/**
	 * ...
	 * @author Ilya
	 */
	public class GlobalMetrics 
	{

		public static const STAGE_WIDTH : int = 900;
		public static const STAGE_HEIGHT : int = 600;

        public static const CONTEST_PANEL_WIDTH : int = 120;
		public static const CONTEST_PANEL_HEIGHT : int = STAGE_HEIGHT;
		
		public static const WORKSPACE_WIDTH : int = STAGE_WIDTH - CONTEST_PANEL_WIDTH;
		public static const WORKSPACE_HEIGHT : int = STAGE_HEIGHT;
		
		public static const WORKSPACE_X : int = 0;
		public static const WORKSPACE_Y : int = 0;

		public static const CONTEST_PANEL_X : int = WORKSPACE_WIDTH;
		public static const CONTEST_PANEL_Y : int = 0;
		
	}

}