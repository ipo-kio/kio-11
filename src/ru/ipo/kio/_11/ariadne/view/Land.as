/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 26.02.11
 * Time: 18:57
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.ariadne.view {
import flash.display.Shape;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import ru.ipo.kio._11.ariadne.model.AriadneData;
import ru.ipo.kio._11.ariadne.model.IntegerPoint;
import ru.ipo.kio._11.ariadne.model.Terra;

public class Land extends Sprite {

    private var _cell_size:int;
    private var _terra:Terra;
    private var x_min:int;
    private var y_min:int;
    private var x_max:int;
    private var y_max:int;

    private var segments_layer:Sprite;
    private var points_layer:Sprite;
    private var ghost_point:Shape;
    private var ghost_logical_point:IntegerPoint;

    private var _points:Array = []; //Array of PathPoint
    private var _segments:Array = []; //Array of PathSegments

    /**
     * Constructs a land.
     * @param cell_size size of cell, not including grid
     */
    public function Land(cell_size:int) {
        _cell_size = cell_size + 1;
        _terra = AriadneData.instance.terra;

        this.x_min = 1;
        this.x_max = _terra.width - 1;
        this.y_min = 1;
        this.y_max = _terra.height - 1;

        //set hit area
        var _hitArea:Sprite = new Sprite;
        _hitArea.graphics.beginFill(0);
        _hitArea.graphics.drawRect(0, 0, _cell_size * _terra.width - 1, _cell_size * _terra.height - 1);
        _hitArea.graphics.endFill();
        _hitArea.mouseEnabled = false;
        _hitArea.visible = false;
        addChild(_hitArea);

        hitArea = _hitArea;

        //draw grid
        graphics.lineStyle(1, 0xFFFFFF, 0.2);

        var f:Point;
        for (var y:int = y_min; y <= y_max; y++) {
            f = logicalToScreen(new IntegerPoint(x_min - 1, y));
            graphics.moveTo(f.x + 1, f.y);
            f = logicalToScreen(new IntegerPoint(x_max + 1, y));
            graphics.lineTo(f.x - 1, f.y);
        }

        for (var x:int = x_min; x <= x_max; x++) {
            f = logicalToScreen(new IntegerPoint(x, y_min - 1));
            graphics.moveTo(f.x, f.y + 1);
            f = logicalToScreen(new IntegerPoint(x, y_max + 1));
            graphics.lineTo(f.x, f.y - 1);
        }

        addChild(segments_layer = new Sprite);
        addChild(points_layer = new Sprite);
        addChild(ghost_point = new Shape);

        //draw ghost_point
        ghost_point.graphics.beginFill(0xe9d835, 0.6);
        ghost_point.graphics.drawCircle(0, 0, 4);
        ghost_point.graphics.endFill();
        ghost_point.visible = false;

        addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
        addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);

        AriadneData.instance.addEventListener(AriadneData.PATH_CHANGED, pathChangedHandler);

        redrawPath();
    }

    private function redrawPath():void {
        //remove points and segments
        for each (var p:PathPoint in _points)
            points_layer.removeChild(p);

        for each (var s:PathSegment in _segments)
            segments_layer.removeChild(s);

        _points = [];
        _segments = [];

        var path_length:int = AriadneData.instance.pointsCount;

        for (var i:int = 0; i < path_length; i++);

    }

    private function pathChangedHandler(event:Event):void {

    }

    private function mouseDownHandler(event:Event):void {
        if (!ghost_logical_point)
            return;

        AriadneData.instance.addPoint(ghost_logical_point);
    }

    private function rollOutHandler(event:Event):void {
        ghost_logical_point = null;
        ghost_point.visible = false;
    }

    private function rollOverHandler(event:Event):void {
        ghost_point.visible = true;
    }

    private function mouseMoveHandler(event:Event):void {
        ghost_logical_point = screenToLogical(new Point(mouseX, mouseY));
        var sp:Point = logicalToScreen(ghost_logical_point);
        ghost_point.x = sp.x;
        ghost_point.y = sp.y;
    }

    public function screenToLogical(s_p:Point):IntegerPoint {
        var x0:int = Math.round((s_p.x + 1) / _cell_size);
        var y0:int = Math.round((s_p.y + 1) / _cell_size);

        if (x0 < x_min)
            x0 = x_min;
        if (x0 > x_max)
            x0 = x_max;

        if (y0 < y_min)
            y0 = y_min;
        if (y0 > y_max)
            y0 = y_max;

        return new IntegerPoint(x0, y0);
    }

    public function logicalToScreen(l_p:IntegerPoint):Point {
        //0, 0 -> -1, -1
        //0  3   7
        //***|***|***|***
        return new Point(_cell_size * l_p.x - 1, _cell_size * l_p.y - 1);
    }
}
}
