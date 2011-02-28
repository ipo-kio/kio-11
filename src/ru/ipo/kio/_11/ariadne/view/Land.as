/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 26.02.11
 * Time: 18:57
 */
package ru.ipo.kio._11.ariadne.view {
import flash.display.Shape;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import flash.geom.Rectangle;

import ru.ipo.kio._11.ariadne.model.AriadneData;
import ru.ipo.kio._11.ariadne.model.IntegerPoint;
import ru.ipo.kio._11.ariadne.model.PointMovedEvent;
import ru.ipo.kio._11.ariadne.model.SelectionChangedEvent;
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

    private var _dragged_index:int = -1;

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
        ghost_point.graphics.drawCircle(0, 0, 7);
        ghost_point.graphics.endFill();
        ghost_point.visible = false;

        addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
        addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);

        AriadneData.instance.addEventListener(AriadneData.PATH_CHANGED, pathChangedHandler);
        AriadneData.instance.addEventListener(AriadneData.POINT_MOVED, pointMovedHandler);
        AriadneData.instance.addEventListener(AriadneData.POINT_SELECTION_CHANGED, pointSelectionHandler);
        AriadneData.instance.addEventListener(AriadneData.SEGMENT_SELECTION_CHANGED, segmentSelectionHandler);

        redrawPath();
    }

    private function segmentSelectionHandler(event:SelectionChangedEvent):void {
        trace('segment selection changed from ' + event.previous_index + ' to ' + event.new_index);
        if (event.previous_index >= 0)
            _segments[event.previous_index].redraw();
        if (event.new_index >= 0)
            _segments[event.new_index].redraw();
    }

    private function pointSelectionHandler(event:SelectionChangedEvent):void {
        if (event.previous_index >= 0)
            _points[event.previous_index].redraw();
        if (event.new_index >= 0)
            _points[event.new_index].redraw();
    }

    private function pointMovedHandler(event:PointMovedEvent):void {
        _segments[event.point_index - 1].redraw();
        _segments[event.point_index].redraw();
        _points[event.point_index].redraw();
    }

    private function pathChangedHandler(event:Event):void {
        redrawPath();
        trace('path changed');
    }

    private function mouseUpHandler(event:Event):void {
        if (_dragged_index >= 0) {
            //_points[_dragged_index].stopDrag();
            _dragged_index = -1;
        }
    }

    private function mouseDownHandler(event:MouseEvent):void {
        if (!ghost_logical_point)
            return;

        //find point if over
        var points_count:int = AriadneData.instance.pointsCount;
        var point_over_index:int = -1;
        for (var i:int = 1; i < points_count - 1; i++)
            if (ghost_logical_point.equals(AriadneData.instance.getPoint(i))) {
                point_over_index = i;
                break;
            }

        //if not over - add, else - start move
        if (point_over_index < 0) {
            //test no segment under

            //if over segment - return
            for (var segment_ind:int = 0; segment_ind < -1 + AriadneData.instance.pointsCount; segment_ind++)
                if (_segments[segment_ind].hitTestPoint(event.stageX, event.stageY, true))
                    return;

            AriadneData.instance.addPoint(ghost_logical_point);
        } else {
            var zeroPoint:IntegerPoint = screenToLogical(new Point(0, 0));
            var greatestPoint:IntegerPoint = screenToLogical(new Point(width, height));

            var zero_p:Point = logicalToScreen(zeroPoint);
            var greatest_p:Point = logicalToScreen(greatestPoint);
            var current_p:Point = logicalToScreen(AriadneData.instance.getPoint(point_over_index));

            /*_points[point_over_index].startDrag(false, new Rectangle(
             zero_p.x - current_p.x,
             zero_p.y - current_p.y,
             greatest_p.x - zero_p.x,
             greatest_p.y - zero_p.x
             )
             );*/
            _dragged_index = point_over_index;
        }
    }

    private function rollOutHandler(event:Event):void {
        ghost_logical_point = null;
        ghost_point.visible = false;
    }

    private function rollOverHandler(event:Event):void {
        ghost_point.visible = true;
    }

    private function mouseMoveHandler(event:MouseEvent):void {
        /*if (!event.buttonDown)
         _dragged_index = -1;*/

        ghost_logical_point = screenToLogical(new Point(mouseX, mouseY));
        var sp:Point = logicalToScreen(ghost_logical_point);
        ghost_point.x = sp.x;
        ghost_point.y = sp.y;

        if (_dragged_index >= 0)
            AriadneData.instance.setPoint(_dragged_index, ghost_logical_point);
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

    private function redrawPath():void {
        //remove points and segments
        for each (var p:PathPoint in _points)
            points_layer.removeChild(p);

        for each (var s:PathSegment in _segments)
            segments_layer.removeChild(s);

        var path_length:int = AriadneData.instance.pointsCount;

        _points = new Array(path_length);
        _segments = new Array(path_length - 1);

        for (var i:int = 0; i < path_length; i++) {
            var pathPoint:PathPoint = new PathPoint(this, i);
            _points[i] = pathPoint;
            points_layer.addChild(pathPoint);
        }

        for (var j:int = 0; j < path_length - 1; j++) {
            var pathSegment:PathSegment = new PathSegment(this, j);
            segments_layer.addChild(pathSegment);
            _segments[j] = pathSegment;
        }
    }
}
}
