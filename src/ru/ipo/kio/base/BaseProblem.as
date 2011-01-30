/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 24.12.10
 * Time: 2:37
 */
package ru.ipo.kio.base {
import flash.display.DisplayObject;

import ru.ipo.kio.api.KioProblem;

public class BaseProblem implements KioProblem{


    public function get id():String {
        return KioBase.BASE_API_ID;
    }

    public function get year():int {
        return 0;
    }

    public function get level():int {
        return 0;
    }

    public function get display():DisplayObject {
        return null;
    }

    public function get solution():Object {
        return null;
    }

    public function loadSolution(solution:Object):Boolean {
        return false;
    }

    public function check(solution:Object):Object {
        return null;
    }

    public function compare(solution1:Object, solution2:Object):int {
        return 0;
    }
}
}
