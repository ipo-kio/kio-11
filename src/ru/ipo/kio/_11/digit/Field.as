/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 16:11
 */
package ru.ipo.kio._11.digit {
import flash.display.Sprite;

public class Field extends Sprite {

    public static const WIDTH:int = 592;
    public static const HEIGHT:int = 392;
    public static const X0:int = 184;
    public static const Y0:int = 4;

    private static var _gates:Array = [];

    public function Field() {
        x = X0;
        y = Y0;
    }

    public function removeGate(g:Gate):void {
        var ind:int = _gates.indexOf(g);
        if (ind < 0)
            return;
        _gates.splice(ind, 1);

        g.removeFromDisplay();
    }

    public function addGate(g:Gate, x0:Number, y0:Number):void {
        g.x = x0;
        g.y = y0;
        g.addTo(this);

        _gates.push(g);
    }
}
}
