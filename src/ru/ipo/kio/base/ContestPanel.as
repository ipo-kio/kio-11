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

            var loc:Object = KioApi.instance(KioBase.BASE_API_ID).localization;
			
			var loadButton : TextButton = new TextButton(loc.buttons.load);
			var saveButton : TextButton = new TextButton(loc.buttons.save);
			
			loadButton.x = 100;
			loadButton.y = 20;
			
			saveButton.x = 300;
			saveButton.y = 20;

            addChild(loadButton);
			addChild(saveButton);

			loadButton.addEventListener(MouseEvent.CLICK, function(e:Event):void {
				FileUtils.loadSolution(KioBase.instance.currentProblem);
			});

			saveButton.addEventListener(MouseEvent.CLICK, function(e:Event):void {
				FileUtils.saveSolution(KioBase.instance.currentProblem);
			});
		}
		
	}

}