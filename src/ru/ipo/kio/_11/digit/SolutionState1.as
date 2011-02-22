/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.02.11
 * Time: 20:45
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.digit {

public class SolutionState1 implements SolutionState {

    private var _data:Array = new Array(10); //digit -> right or wrong
    private var _recognized:int;

    public function updateData():void {
        var f:Field = Globals.instance.workspace.field;

        //rd - real digit, td - test digit
        for (var rd:int = 0; rd < 10; rd++) {
            f.resetAllGates();
            _data[rd] = true;
            _recognized ++;
            for (var td:int = 0; td < 10; td++) {
                //true must be only when td == rd
                var r1:Boolean = f.gates[td].value == 1;
                var r2:Boolean = td == rd;
                if (r1 != r2) {
                    _data[rd] = false;
                    _recognized --;
                    break;
                }
            }
        }
    }

    //must be called only right after updateData if needed
    public function updateView():void {

    }
}
}
