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

    private var wires_layer:Sprite = new Sprite;
    private var gates_layer:Sprite = new Sprite;
    private var connections_layer:Sprite = new Sprite;

    public function Field() {
        x = X0;
        y = Y0;

        addChild(wires_layer);
        addChild(gates_layer);
        addChild(connections_layer);
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
        g.addTo(wires_layer, gates_layer, connections_layer);

        _gates.push(g);
    }

    public function get gates():Array {
        return _gates;
    }
}
}
