package ru.ipo.kio.base{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ru.ipo.kio.api.controls.SpaceSettingsDialog;
import ru.ipo.kio.base.displays.ProblemsDisplay;
import ru.ipo.kio.base.displays.WelcomeDisplay;
import ru.ipo.kio.base.loc.BaseLocalization_RU;
	
	import ru.ipo.kio.api.*;
	
	/**
	 * ...
	 * @author Ilya
	 */
	public class KioBase
	{
		
		public static const BASE_API_ID:String = "kio-base";
		private static var _instance:KioBase;

        private var _currentProblem:KioProblem;
		
        private var workspace:DisplayObject = null;
        private var contestPanel:DisplayObject = null;
		private var stage:DisplayObjectContainer;
		private var problems:Array /*KioProblem*/ = new Array;

        private var _lsoProxy : LsoProxy;

        public function KioBase() {
            KioApi.registerLocalization(KioBase.BASE_API_ID, BaseLocalization_RU.mapping);
        }

        public function init(stage : DisplayObjectContainer, problems:Array, year:int, level:int):void {
            _lsoProxy = LsoProxy.getInstance(level, year);

			this.stage = stage;
            this.problems = problems;

            //test this is the first start

            if (_lsoProxy.getGlobalData().notFirstTime)
                currentDisplay = new ProblemsDisplay;
            else
                currentDisplay = new WelcomeDisplay;
		}
		
		public function initOneProblem(stage : DisplayObjectContainer, problem: KioProblem):void {
			this._lsoProxy = LsoProxy.getInstance(problem.level, problem.year);

			this.stage = stage;
			this.problems = [problem];

			currentProblem = problem;
		}
		
		public static function get instance():KioBase {
            if (!_instance)
                _instance = new KioBase;
			return _instance;
		}

        public function get currentProblem():KioProblem {
            return _currentProblem;
        }

        public function set currentProblem(problem : KioProblem):void {
            _currentProblem = problem;

            if (workspace)
                stage.removeChild(workspace);

            if (!contestPanel) {
                contestPanel = new ContestPanel;
                contestPanel.x = GlobalMetrics.CONTEST_PANEL_X;
                contestPanel.y = GlobalMetrics.CONTEST_PANEL_Y;
                stage.addChild(contestPanel);
            }

            //place problem view on the screen
            workspace = problem.display;
            workspace.x = GlobalMetrics.WORKSPACE_X;
            workspace.y = GlobalMetrics.WORKSPACE_Y;
            stage.addChild(workspace);

            //load autosave solution
            var problemData:Object = _lsoProxy.getProblemData(problem.id);
            var autoSave:Object = problemData.autoSave;
            if (autoSave)
                problem.loadSolution(autoSave);
        }

        public function set currentDisplay(display : Sprite):void {
            _currentProblem = null;

            if (workspace)
                stage.removeChild(workspace);
            if (contestPanel) {
                stage.removeChild(contestPanel);
                contestPanel = null;
            }

            workspace = display;
            workspace.x = 0;
            workspace.y = 0;
            stage.addChild(workspace);
        }

        public function get lsoProxy():LsoProxy {
            return _lsoProxy;
        }

        public function complainLSO():void {
            stage.addChild(new SpaceSettingsDialog);
        }

        public function setProblem(pind:int):void {
            currentProblem = problems[pind];
        }
    }
}