/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 1:42
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.digit {
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Gate extends Sprite implements Out {

    private var _wires:Array; //Wire
    private var _connectors:Array; //Connector
    private var _in_connectors:Array; //Connector
    private var _arity:int;

    private var _mouse_over:Boolean;
    private var _on_bmp:BitmapData;
    private var _off_bmp:BitmapData;

    private var _function:Function;

    private static const VAL_0:int = 0;
    private static const VAL_1:int = 1;
    private static const VAL_UNCONNECTED:int = 2;
    private static const VAL_UNKNOWN:int = 3;
    private static const VAL_EVALUATING:int = 4;
    private static const VAL_CYCLE:int = 5;

    private var _value:int = VAL_UNKNOWN;

    public function Gate(arity:int, f:Function, on:BitmapData, off:BitmapData) {
        _on_bmp = on;
        _off_bmp = off;
        _function = f;
        _arity = arity;

        addEventListener(MouseEvent.ROLL_OVER, mouseRollOver);
        addEventListener(MouseEvent.ROLL_OUT, mouseRollOut);

        _wires = new Array(arity);
        _in_connectors = new Array(arity);

        for (var i:int; i = 0; i < arity) {
            _wires[i] = new Wire();
            _in_connectors[i] = new Connector(_wires[i]);
        }
    }

    private function mouseRollOver(event:Event):void {
        _mouse_over = true;
    }

    private function mouseRollOut(event:Event):void {
        _mouse_over = false;
    }

    public function get mouse_over():Boolean {
        return _mouse_over;
    }

    public function set mouse_over(value:Boolean):void {
        if (_mouse_over == value)
            return;
        _mouse_over = value;
        redraw();
    }

    private function redraw():void {
        graphics.clear();
        var bitmap:BitmapData = _mouse_over ? _on_bmp : _off_bmp;
        graphics.beginBitmapFill(bitmap);
        graphics.lineStyle(0, 0, 0);
        graphics.drawRect(0, 0, bitmap.width, bitmap.height);
        graphics.endFill();
    }

    public function get connectors():Array {
        return _connectors;
    }

    public function get value():int {
        if (_value != VAL_UNKNOWN)
            return _value;

        _value = VAL_EVALUATING;

        var vals:Array = new Array(_arity);

        for (var i:int = 0; i < _arity; i++) {
            var v:int = VAL_UNCONNECTED;
            var dest:Out = Connector(_in_connectors[i]).dest;
            if (dest)
                v = dest.value;
            if (v == VAL_EVALUATING || v == VAL_CYCLE) {
                _value = VAL_CYCLE;
                return _value;
            } else if (v == VAL_UNCONNECTED) {
                _value = VAL_UNCONNECTED;
                return _value;
            }

            vals[i] = v;
        }

        if (_arity == 1)
            _value = _function(vals[0]);
        else // if arity = 2
            _value = _function(vals[0], vals[1]);
        return _value;
    }

    public function resetValue():void {
        _value = VAL_UNKNOWN;
    }

}
}
