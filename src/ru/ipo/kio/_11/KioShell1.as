/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 09.02.11
 * Time: 21:41
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11 {
import flash.display.Sprite;
import flash.events.Event;

import ru.ipo.kio._11.digit.DigitProblem;
import ru.ipo.kio._11.semiramida.SemiramidaProblem;
import ru.ipo.kio.api_example.Pr1;
import ru.ipo.kio.base.*;

public class KioShell1 extends Sprite {

    public function KioShell1() {
        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        KioBase.instance.init(this,
                [
                    //new ru.ipo.kio._11.CrossedCountry.Pr1()
                    new SemiramidaProblem(1),
                    new DigitProblem(1),
                    new Pr1(1)
                ],
                2011,
                1
        );

    }

}
}
