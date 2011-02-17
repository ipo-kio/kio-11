package ru.ipo.kio._11.semiramida {
import flash.display.DisplayObject;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;

public class SemiramidaProblem implements KioProblem {

    public static const ID:String = "semiramida";

    private var sp:Workspace;

    private var recordRooms:int = 0;
    private var recordLength:int = 0;

    public function SemiramidaProblem() {
        KioApi.initialize(this);

        sp = new Workspace;

        var api:KioApi = KioApi.instance(ID);
        if (loadSolution(api.bestSolution)) {
            recordRooms = sp.house.roomsCount;
            recordLength = sp.house.pipesLength;
        }
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
        if (!solution || !solution.pipes)
            return false;
        sp.house.removeAllPipes();
        for each (var pipe:* in solution.pipes)
            sp.house.createPipe(pipe.floors, pipe.pos);
        return true;
    }

    public function check(solution:Object):Object {
        loadSolution(solution);
        return {
            rooms:sp.house.roomsCount,
            length:sp.house.pipesLength
        };
    }

    public function compare(solution1:Object, solution2:Object):int {
        return 1;
    }

}

}