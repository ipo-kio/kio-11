/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 27.02.11
 * Time: 11:21
 */
package ru.ipo.kio._11.ariadne.view {
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;

import flash.geom.Point;

import ru.ipo.kio._11.ariadne.model.AriadneData;

public class PathSegment extends Sprite {

    private var _ind:int;
    private var _land:Land;

    private var _hitArea:Sprite;

    public function PathSegment(land:Land, ind:int) {
        _ind = ind;
        _land = land;

        _hitArea = new Sprite;
        _hitArea.mouseEnabled = false;
        _hitArea.visible = false;
        addChild(_hitArea);
        hitArea = _hitArea;

        addEventListener(MouseEvent.ROLL_OVER, mouseRollOver);
        addEventListener(MouseEvent.ROLL_OUT, mouseRollOut);
        addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);

        redraw();
    }

    private function mouseDown(event:Event):void {
        trace('down on segment');
        AriadneData.instance.selected_segment_index = _ind;
    }

    private function mouseRollOut(event:Event):void {
        _hitArea.visible = false;
    }

    private function mouseRollOver(event:Event):void {
        _hitArea.visible = true;
    }

    public function get selected():Boolean {
        return _ind == AriadneData.instance.selected_segment_index;
    }

    public function redraw():void {
        graphics.clear();
        graphics.lineStyle(selected ? 2 : 1, 0xFFFFFF);
        var p_start:Point = _land.logicalToScreen(AriadneData.instance.getPoint(_ind));
        graphics.moveTo(p_start.x, p_start.y);
        var p_finish:Point = _land.logicalToScreen(AriadneData.instance.getPoint(_ind + 1));
        graphics.lineTo(p_finish.x, p_finish.y);

        _hitArea.graphics.clear();
        _hitArea.graphics.lineStyle(6, 0xe9d835, 0.6);
        _hitArea.graphics.moveTo(p_start.x, p_start.y);
        _hitArea.graphics.lineTo(p_finish.x, p_finish.y);
    }
}
}
