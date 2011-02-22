/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 16:11
 */
package ru.ipo.kio._11.digit {
import flash.display.Sprite;

import ru.ipo.kio.base.KioBase;

public class Field extends Sprite {

    public static const WIDTH:int = 592;
    public static const HEIGHT:int = 392;
    public static const X0:int = 184;
    public static const Y0:int = 4;

    private var _gates:Array = [];
    private var _inputs:Array;
    private var _outs:Array; //always is _gates concat _outs
    private var _exits:Array;

    private var wires_layer:Sprite = new Sprite;
    private var gates_layer:Sprite = new Sprite;
    private var connections_layer:Sprite = new Sprite;

    public function Field() {
        x = X0;
        y = Y0;

        addChild(wires_layer);
        addChild(gates_layer);
        addChild(connections_layer);

        var inputsCount:int = KioBase.instance.level == 1 ? 7 : 9;
        _inputs = new Array(inputsCount);
        for (var i:int = 0; i < inputsCount; i++) {
            _inputs[i] = new SchemeInput(i);
            gates_layer.addChild(_inputs[i]);
        }

        _outs = _gates.concat(_inputs);

        _exits = new Array(10);
        for (var d:int = 0; d <= 9; d++) {
            _exits[d] = GatesFactory.createGate(GatesFactory.TYPE_OUTPUT);
            _exits[d].movable = false;
            _exits[d].x = 751 - Field.X0;
            _exits[d].y = 16 + d * 39 - Field.Y0;
            _exits[d].addTo(wires_layer, gates_layer, connections_layer);
        }
    }

    public function removeGate(g:Gate):void {
        var ind:int = _gates.indexOf(g);
        if (ind < 0)
            return;
        _gates.splice(ind, 1);

        g.removeFromDisplay();

        _outs = _gates.concat(_inputs);
    }

    public function addGate(g:Gate, x0:Number, y0:Number):void {
        g.x = x0;
        g.y = y0;
        g.addTo(wires_layer, gates_layer, connections_layer);

        _gates.push(g);

        _outs = _gates.concat(_inputs);
    }

    public function get gates():Array {
        return _gates;
    }

    public function get outs():Array {
        return _outs;
    }

}
}
