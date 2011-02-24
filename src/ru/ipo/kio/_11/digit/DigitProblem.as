package ru.ipo.kio._11.digit {
import flash.display.DisplayObject;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.Settings;

public class DigitProblem implements KioProblem {

    public static const ID:String = "digit";
    private var sp:Workspace;
    private var _recordCheck:Object = null;
    private var api:KioApi;
    private var _level:int;

    [Embed(source="resources/digit.ru.json-settings",mimeType="application/octet-stream")]
    public static var locTxt_ru:Class;

    //private var spitter:SpitMem = new SpitMem;

    public function DigitProblem(level:int) {
        _level = level;
        Globals.instance.level = level;

        KioApi.registerLocalization(ID, new Settings(locTxt_ru).data);
        KioApi.initialize(this);

        sp = new Workspace;

        api = KioApi.instance(ID);
        if (api.bestSolution)
            _recordCheck = api.bestSolution.record;
        else
            _recordCheck = {recognized:0, elements:0};

        sp.solutionState.updateData();
        sp.solutionState.updateView();

        sp.updateResultsInfo(true, _recordCheck.recognized, _recordCheck.elements);

        updateSolutionInfo();
    }

    private function updateSolutionInfo():void {
        sp.solutionState.updateData();
        sp.solutionState.updateView();
        sp.updateResultsInfo(false, sp.solutionState.recognized, sp.field.gates.length);
    }

    public function get id():String {
        return ID;
    }

    public function get year():int {
        return 2011;
    }

    public function get level():int {
        return _level;
    }

    public function get display():DisplayObject {
        return sp;
    }

    public function get solution():Object {
        var f:Field = Globals.instance.workspace.field;
        var gates:Array = f.gates;
        var exits:Array = f.exits;

        var sol:Object = {
            gates: new Array(gates.length),
            exits: new Array(exits.length)
        };

        for (var i:int = 0; i < gates.length; i++)
            sol.gates[i] = gates[i].serialization;

        for (i = 0; i < exits.length; i++)
            sol.exits[i] = exits[i].serialization;

        sol.record = {
            recognized:Globals.instance.workspace.solutionState.recognized,
            elements:Globals.instance.workspace.field.gates.length
        };

        return sol;
    }

    public function loadSolution(solution:Object):Boolean {
        return loadSolutionWithExplicitAutoSave(solution, true);
    }

    public function loadSolutionWithExplicitAutoSave(solution:Object, autoSave:Boolean):Boolean {
        if (!solution)
            return false;

        var f:Field = Globals.instance.workspace.field;

        //TODO optimize, don't evaluate while loading

        while (f.gates.length > 0)
            f.removeGate(f.gates[0]);

        for (var i:int = 0; i < solution.gates.length; i++)
            f.addGate(GatesFactory.createGate(solution.gates[i].type), 239, 42);

        for (i = 0; i < solution.gates.length; i++)
            f.gates[i].serialization = solution.gates[i];

        for (i = 0; i < solution.exits.length; i++)
            f.exits[i].serialization = solution.exits[i];

        if (autoSave)
            KioApi.instance(ID).autoSaveSolution();

        updateSolutionInfo();

        return true;
    }

    public function check(solution:Object):Object {
        if (!loadSolutionWithExplicitAutoSave(solution, false))
            return null;
        return {
            //TODO put solution info here
        };
    }

    public function compare(solution1:Object, solution2:Object):int {
        if (!solution1)
            return solution2 ? 0 : -1;
        if (!solution2)
            return 1;

        var r:int = solution1.recognized - solution2.recognized;
        if (r == 0)
            r = solution2.elements - solution1.elements;
        return r;
    }

    //user has new solution, submits it
    public function submitSolution(recognized:int, elements:int):void {
        var currentCheck:Object = {recognized:recognized, elements:elements};
        if (compare(currentCheck, _recordCheck) > 0) {
            _recordCheck = currentCheck;
            sp.updateResultsInfo(true, recognized, elements);
            api.saveBestSolution();
        }

        sp.updateResultsInfo(false, recognized, elements);
        //TODO update results
        api.autoSaveSolution();
    }

    public function get recordCheck():Object {
        return _recordCheck;
    }

    [Embed(source='resources/icon.jpg')]
    private const ICON:Class;

    public function get icon():Class {
        return ICON;
        return null;
    }
}
}