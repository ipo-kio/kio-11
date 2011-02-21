package ru.ipo.kio._11.semiramida {
import flash.display.DisplayObject;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.Settings;

public class SemiramidaProblem implements KioProblem {

    public static const ID:String = "semiramida";
    private var sp:Workspace;
    private var _recordCheck:Object = null;
    private var api:KioApi;

    [Embed(source="resouces/Semiramida.json-settings",mimeType="application/octet-stream")]
    public static var locTxt:Class;

    //private var spitter:SpitMem = new SpitMem;

    public function SemiramidaProblem() {
        KioApi.registerLocalization(ID, new Settings(locTxt).data);
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
        return 2;
    }

    public function get display():DisplayObject {
        return sp;
    }

    public function get solution():Object {
        var sol:Object = {};
        sol.pipes = [];
        for each (var pipe:Pipe in sp.house.pipes)
            sol.pipes.push({pos:pipe.n, floors:pipe.floorsInt});
        return sol;
    }

    public function loadSolution(solution:Object):Boolean {
        return loadSolutionWithExplicitAutoSave(solution, true);
    }

    public function loadSolutionWithExplicitAutoSave(solution:Object, autoSave:Boolean):Boolean {
        if (!solution || !solution.pipes)
            return false;
        sp.house.removeAllPipes();
        for each (var pipe:* in solution.pipes)
            sp.house.createPipe(pipe.floors, pipe.pos);
        sp.house.refreshRooms(autoSave);

        sp.updateResults(false, sp.house.roomsCount, sp.house.pipesLength);

        return true;
    }

    public function check(solution:Object):Object {
        if (!loadSolutionWithExplicitAutoSave(solution, false))
            return null;
        return {
            rooms:sp.house.roomsCount,
            pipesLength:sp.house.pipesLength
        };
    }

    public function compare(solution1:Object, solution2:Object):int {
        if (!solution1)
            return solution2 ? 0 : -1;
        if (!solution2)
            return 1;
        var r:int = solution1.rooms - solution2.rooms;
        if (r == 0)
            r = solution2.pipesLength - solution1.pipesLength;
        return r;
    }

    public function submitSolution(rooms:int, pipesLength:int):void {
        var currentCheck:Object = {rooms:rooms, pipesLength:pipesLength};
        if (compare(currentCheck, _recordCheck) > 0) {
            _recordCheck = currentCheck;
            sp.updateResults(true, rooms, pipesLength);
            api.saveBestSolution();
        }

        sp.updateResults(false, rooms, pipesLength);
    }

    public function get recordCheck():Object {
        return _recordCheck;
    }

    [Embed(source='resouces/icon.png')]
    private const ICON:Class;

    public function get icon():Class {
        return ICON;
    }
}
}