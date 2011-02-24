package ru.ipo.kio.base {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ru.ipo.kio.api.controls.SpaceSettingsDialog;
import ru.ipo.kio.base.displays.ProblemsDisplay;
import ru.ipo.kio.base.displays.WelcomeDisplay;

import ru.ipo.kio.api.*;
import ru.ipo.kio.base.resources.Resources;

/**
 * ...
 * @author Ilya
 */
public class KioBase {

    public static const BASE_API_ID:String = "kio-base";
    private static var _instance:KioBase;

    private var _currentProblem:KioProblem;

    private var workspace:DisplayObject = null;
    private var contestPanel:DisplayObject = null;
    private var stage:DisplayObjectContainer;
    //noinspection JSMismatchedCollectionQueryUpdateInspection
    private var problems:Array /*KioProblem*/ = new Array;

    private var _lsoProxy:LsoProxy;
    private var _level:int;
    private var _problems_bg:DisplayObject;

    private var spaceSettings:SpaceSettingsDialog = null;

    [Embed(source="resources/shell.ru.json-config",mimeType="application/octet-stream")]
    private var locTxt:Class;

    public function KioBase() {
        KioApi.registerLocalization(KioBase.BASE_API_ID, new Settings(locTxt).data);
    }

    private function basicInitialization(level:int, year:int, stage:DisplayObjectContainer, problems:Array):void {
        _level = level;
        _lsoProxy = LsoProxy.getInstance(level, year);

        this.stage = stage;
        this.problems = problems;

        _problems_bg = new Resources.BG_PR_IMAGE;
        _problems_bg.visible = false;
        stage.addChild(_problems_bg);
    }

    public function init(stage:DisplayObjectContainer, problems:Array, year:int, level:int):void {
        basicInitialization(level, year, stage, problems);

        //test this is the first start
        if (_lsoProxy.getGlobalData().anketa_filled)
            currentDisplay = new ProblemsDisplay;
        else
            currentDisplay = new WelcomeDisplay;
    }

    public function initOneProblem(stage:DisplayObjectContainer, problem:KioProblem):void {
        basicInitialization(problem.level, problem.year, stage, [problem]);

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

    /*private function copyObjectTo(o1:Object, o2:Object):void {
        for (var key:String in o1) {
            o2[key] = o1[key];
        }
    }*/

    public function set currentProblem(problem:KioProblem):void {
        _currentProblem = problem;

        if (workspace)
            stage.removeChild(workspace);

        if (!contestPanel) {
            contestPanel = new ContestPanel;
            contestPanel.x = GlobalMetrics.CONTEST_PANEL_X;
            contestPanel.y = GlobalMetrics.CONTEST_PANEL_Y;
            stage.addChild(contestPanel);
        }

        _problems_bg.visible = true;

        //place problem view on the screen
        workspace = problem.display;
        workspace.x = GlobalMetrics.WORKSPACE_X + Math.floor((GlobalMetrics.WORKSPACE_WIDTH - workspace.width) / 2);
        workspace.y = GlobalMetrics.WORKSPACE_Y + Math.floor((GlobalMetrics.WORKSPACE_HEIGHT - workspace.height) / 2);
        stage.addChild(workspace);

        //load autosave solution
        var problemData:Object = _lsoProxy.getProblemData(problem.id);

        var best:Object = problemData.best;
        var autoSave:Object = problemData.autoSave;

        if (best)
            problem.loadSolution(best);

        if (autoSave)
            problem.loadSolution(autoSave);
    }

    public function set currentDisplay(display:Sprite):void {
        _currentProblem = null;

        if (workspace)
            stage.removeChild(workspace);
        if (contestPanel) {
            stage.removeChild(contestPanel);
            contestPanel = null;
        }

        _problems_bg.visible = false;

        workspace = display;
        workspace.x = 0;
        workspace.y = 0;
        stage.addChild(workspace);
    }

    public function get lsoProxy():LsoProxy {
        return _lsoProxy;
    }

    public function complainLSO():void {
        if (!spaceSettings) {
            spaceSettings = new SpaceSettingsDialog;
            stage.addChild(spaceSettings);
        } else {
            stage.setChildIndex(spaceSettings, stage.numChildren - 1);
        }
    }

    public function LSOConcernResolved():void {
        if (spaceSettings)
            stage.removeChild(spaceSettings);
        spaceSettings = null;
    }

    public function setProblem(pind:int):void {
        currentProblem = problems[pind];
    }

    public function problem(ind:int):KioProblem {
        return problems[ind];
    }

    public function loadAllData(data:*):void {
        var lso:LsoProxy = KioBase.instance.lsoProxy;
//        copyObjectTo(data, lso.data);
        lso.data = data;

        for (var i:int = 0; i < problems.length; i++) {
            var best:Object = lso.getProblemData(problems[i].id).best;
            var autoSave:Object = lso.getProblemData(problems[i].id).autoSave;

            if (best)
                problems[i].loadSolution(best);

            if (autoSave)
                problems[i].loadSolution(autoSave);
        }

        if (_currentProblem)
            currentProblem = _currentProblem;
        else
            currentDisplay = new ProblemsDisplay;
    }

    public function get level():int {
        return _level;
    }
}
}