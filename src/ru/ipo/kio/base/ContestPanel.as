package ru.ipo.kio.base {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ru.ipo.kio.api.controls.TextButton;

	import ru.ipo.kio.api.KioApi;
	import ru.ipo.kio.api.FileUtils;

	/**
	 * ...
	 * @author Ilya
	 */
	public class ContestPanel extends Sprite
	{
		
		public function ContestPanel() 
		{
			graphics.beginFill(0xAABBCC);
			graphics.lineStyle(1, 0x000000);
			graphics.drawRect(0, 0, GlobalMetrics.CONTEST_PANEL_WIDTH - 1, GlobalMetrics.CONTEST_PANEL_HEIGHT - 1);
			graphics.endFill();

            var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID);
			
			var loadButton : TextButton = new TextButton(loc.buttons.load);
			var saveButton : TextButton = new TextButton(loc.buttons.save);
			
			loadButton.x = 10;
			loadButton.y = 20;
			
			saveButton.x = 10;
			saveButton.y = 100;

            addChild(loadButton);
			addChild(saveButton);

			loadButton.addEventListener(MouseEvent.CLICK, function(e:Event):void {
				//FileUtils.loadSolution(KioBase.instance.currentProblem);
                KioBase.instance.lsoProxy.getGlobalData().push = 239;
                KioBase.instance.lsoProxy.flush();
			});

			saveButton.addEventListener(MouseEvent.CLICK, function(e:Event):void {
				FileUtils.saveSolution(KioBase.instance.currentProblem);
			});
		}
		
	}

}