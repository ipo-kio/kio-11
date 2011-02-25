/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 09.02.11
 * Time: 21:41
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11 {
import flash.events.Event;

import mx.core.UIComponent;

import ru.ipo.kio._11.CrossedCountry.CrossedCountry;
import ru.ipo.kio._11.VirtualPhysics.PhysicsProblem;
import ru.ipo.kio._11.digit.DigitProblem;
import ru.ipo.kio._11.semiramida.SemiramidaProblem;
import ru.ipo.kio.base.*;

public class KioShell extends UIComponent {

    private var _level:int;

    public function KioShell(level:int) {
        _level = level;
        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

//        LsoProxy.getInstance(1, 2011).cleanup();

        KioBase.instance.init(this,
                [
                    //new ru.ipo.kio._11.CrossedCountry.Pr1()
                    new SemiramidaProblem(_level),
                    new DigitProblem(_level),
                    _level == 1 ? new CrossedCountry : new PhysicsProblem
                ],
                2011,
                _level
        );

    }

}
}
