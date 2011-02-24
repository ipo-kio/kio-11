package ru.ipo.kio.base {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import flash.profiler.profile;

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

    private var spaceSettings:SpaceSettingsDialog = new SpaceSettingsDialog;

    [Embed(source="resources/shell.ru.json-config",mimeType="application/octet-stream")]
    private var locTxt:Class;

    public function KioBase() {
        KioApi.registerLocalization(KioBase.BASE_API_ID, new Settings(locTxt).data);
    }

    public function init(stage:DisplayObjectContainer, problems:Array, year:int, level:int):void {
        _level = level;
        _lsoProxy = LsoProxy.getInstance(level, year);

        this.stage = stage;
        this.problems = problems;

        _problems_bg = new Resources.BG_PR_IMAGE;
        _problems_bg.visible = false;
        stage.addChild(_problems_bg);

        //test this is the first start

        /*if (_lsoProxy.getGlobalData().notFirstTime)
            currentDisplay = new ProblemsDisplay;
        else*/
            currentDisplay = new WelcomeDisplay;
    }

    public function initOneProblem(stage:DisplayObjectContainer, problem:KioProblem):void {
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

    public function set currentProblem(problem:KioProblem):void {
        _currentProblem = problem;

        if (workspace)
            stage.removeChild(workspace);

        if (!
                contestPanel) {
            contestPanel = new ContestPanel;
            contestPanel.x = GlobalMetrics.CONTEST_PANEL_X;
            contestPanel.y = GlobalMetrics.CONTEST_PANEL_Y;
            stage.addChild(contestPanel);
        }

        _problems_bg.visible = true;

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

    public function set currentDisplay(display:Sprite):void {
        _currentProblem = null;

        if (workspace)
            stage.removeChild(workspace);
        if (contestPanel) {
            stage.removeChild(contestPanel);
            contestPanel = null;
        }

        _problems_bg.visible = true;

        workspace = display;
        workspace.x = 0;
        workspace.y = 0;
        stage.addChild(workspace);
    }

    public function get lsoProxy():LsoProxy {
        return _lsoProxy;
    }

    public function complainLSO():void {
        if (!stage.contains(spaceSettings))
            stage.addChild(spaceSettings);
    }

    public function setProblem(pind:int):void {
        currentProblem = problems[pind];
    }

    public function problem(ind:int):KioProblem {
        return problems[ind];
    }

    public function loadAllData(data:*):void {
        KioBase.instance.lsoProxy.data = data;
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