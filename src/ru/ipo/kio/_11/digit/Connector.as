/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 2:13
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.digit {
import flash.display.BitmapData;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.core.BitmapAsset;

public class Connector extends Sprite {

    [Embed(source="resources/Connector_01.png")]
    public static const OFF_IMAGE:Class;
    public static const OffImage:BitmapData = new OFF_IMAGE().bitmapData;

    [Embed(source="resources/Connector_02.png")]
    public static const ON_IMAGE:Class;
    public static const OnImage:BitmapData = new ON_IMAGE().bitmapData;

    private var _on:Boolean;
    private var _dest:Out;
    private var _wire:Wire;

    public function get on():Boolean {
        return _on;
    }

    public function set on(value:Boolean):void {
        if (_on == value)
            return;
        _on = value;
        redraw();
    }

    public function Connector(wire:Wire) {
        _wire = wire;

        addEventListener(MouseEvent.ROLL_OVER, mouseRollOver);
        addEventListener(MouseEvent.ROLL_OUT, mouseRollOut);
    }

    private function redraw():void {
        graphics.clear();
        var bitmap:BitmapData = _on ? OnImage : OffImage;
        graphics.beginBitmapFill(bitmap);
        graphics.lineStyle(0, 0, 0);
        graphics.drawRect(0, 0, bitmap.width, bitmap.height);
        graphics.endFill();
    }

    private function mouseRollOver(event:Event):void {
        _on = true;
    }

    private function mouseRollOut(event:Event):void {
        _on = false;
    }

    public function get dest():Out {
        return _dest;
    }

    public function set dest(value:Out):void {
        _dest = value;
    }
}
}
