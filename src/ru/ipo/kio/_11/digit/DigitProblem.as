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
        _recordCheck = check(api.bestSolution);
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
        var sol:Object = {};
        //TODO implement
        return sol;
    }

    public function loadSolution(solution:Object):Boolean {
        return loadSolutionWithExplicitAutoSave(solution, true);
    }

    public function loadSolutionWithExplicitAutoSave(solution:Object, autoSave:Boolean):Boolean {
        //TODO load solution

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
        //TODO implement compare
        return 0;
    }

    //user has new solution, submits it
    public function submitSolution(/*rooms:int, pipesLength:int*/):void {
        var currentCheck:Object = {};/*{rooms:rooms, pipesLength:pipesLength};*/
        if (compare(currentCheck, _recordCheck) > 0) {
            _recordCheck = currentCheck;
            //sp.updateResults(true, rooms, pipesLength);
            api.saveBestSolution();
        }

        //sp.updateResults(false, rooms, pipesLength);
        //TODO update results
        api.autoSaveSolution();
    }

    public function get recordCheck():Object {
        return _recordCheck;
    }

    /*
    [Embed(source='resouces/icon.png')]
    private const ICON:Class;
    */

    public function get icon():Class {
        //TODO make normal ICON
        //return ICON;
        return null;
    }
}
}