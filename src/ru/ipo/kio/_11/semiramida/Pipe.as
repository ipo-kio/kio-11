/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 14.02.11
 * Time: 23:56
 */
package ru.ipo.kio._11.semiramida {
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.Timer;

public class Pipe extends Sprite {

    private var _house:House;
    private var _n:Number;
    private var _floors:Number;
    private var _selected:Boolean = false;
    private var _gradient_translate:Number = 100;

    private static const WATER_COLOR_1:uint = 0x0000ff;
    private static const WATER_COLOR_2:uint = 0x42aaff;
//    private static const WATER_COLOR_1:uint = 0x000000;
//    private static const WATER_COLOR_2:uint = 0xffffff;

    //TODO try to replace with flash.display.Shape
    private var _body:Sprite = new Sprite;
    private var _top:Sprite = new Sprite;
    private var _bottom:Shape = new Shape;
    private var _highlight_all:Sprite = new Sprite;
    private var _highlight_top:Sprite = new Sprite;

    /**
     * Creates a pipe for the specific house
     * @param house the house to hold a pipe, this house must be a parent to the pipe
     */
    public function Pipe(house:House, floors:int, n:Number = -1) {
        _house = house;
        _floors = floors;

        if (n < 0 || n > 1) {
            var pipes:Array = _house.pipes;

            var points:Array = [0];
            for each (var pipe:Pipe in pipes) {
                points.push(pipe.n);
            }
            points.push(1);

            var right_point_for_max_segment:int = -1;
            var max_len:Number = 0;
            points.sort();
            for (var i:int = 1; i < points.length; ++i) {
                var len:Number = points[i] - points[i - 1];
                if (len > max_len) {
                    right_point_for_max_segment = i;
                    max_len = len;
                }
            }

            drawPipe();
            redraw();
            setupHandlers();

            this.n = (points[right_point_for_max_segment - 1] + points[right_point_for_max_segment]) / 2;
        } else {
            this.n = n;
        }

        var shiftTimer:Timer = new Timer(1000 / 24);
        shiftTimer.start();
        shiftTimer.addEventListener(TimerEvent.TIMER, shiftTimerHandler);
    }

    private function setupHandlers():void {
        _body.addEventListener(MouseEvent.ROLL_OVER, handleBodyRollOver);
        _body.addEventListener(MouseEvent.ROLL_OUT, handleBodyRollOut);
        _top.addEventListener(MouseEvent.ROLL_OVER, handleTopRollOver);
        _top.addEventListener(MouseEvent.ROLL_OUT, handleTopRollOut);

        _body.addEventListener(MouseEvent.MOUSE_DOWN, handleBodyMouseDown);
        _top.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMouseDown);
    }

    public function initializeDragging(horizontal:Boolean):void {
        _house.selected_pipe = this;

        if (horizontal) {
            startDrag(false, new Rectangle(0, baseLine(), _house.house_width, 0));
            _house.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMoveWhileHorizontalDragging);
        } else {
            _house.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMoveWhileVerticalDragging);
        }

        stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
    }

    public function stopDragging(event:MouseEvent = null):void {
        stopDrag();
        _house.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMoveWhileHorizontalDragging);
        _house.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMoveWhileVerticalDragging);
        stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
        floors = Math.round(floors);
    }

    private function handleBodyMouseDown(event:MouseEvent):void {
        initializeDragging(true);
    }

    private function handleTopMouseDown(event:MouseEvent):void {
        initializeDragging(false);
    }

    private function handleBodyRollOut(event:MouseEvent):void {
        _highlight_all.visible = false;
    }

    private function handleBodyRollOver(event:MouseEvent):void {
        _highlight_all.visible = true;
        trace('highlight ' + Math.random());
    }

    private function handleTopRollOut(event:MouseEvent):void {
        _highlight_top.visible = false;
    }

    private function handleTopRollOver(event:MouseEvent):void {
        _highlight_top.visible = true;
    }

    private function handleMouseMoveWhileHorizontalDragging(event:MouseEvent):void {
        n = _house.mouseX / _house.width;
    }

    private function handleMouseMoveWhileVerticalDragging(event:MouseEvent):void {
        /*trace('localY = ' + event.localY);
        trace('mouseY in house = ' + _house.mouseY);
        trace('height = ' + (baseLine() - event.localY));
        trace('floor no = ' + (baseLine() - event.localY) / _house.floorHeight);*/
        var new_floors:Number = /*Math.round*/((baseLine() - _house.mouseY) / _house.floorHeight);
        if (new_floors != floors && new_floors >= 1 && new_floors <= _house.FLOORS)
            floors = new_floors;
        //event.updateAfterEvent();
    }

    private function shiftTimerHandler(event:TimerEvent):void {
        _gradient_translate += 10;
        redraw();
    }

    public function get n():Number {
        return _n;
    }

    public function set n(value:Number):void {
        _n = value;
        replace();
        _house.refreshRooms();
    }

    public function get floors():Number {
        return _floors;
    }

    public function get floorsInt():int {
        return Math.round(_floors);
    }

    public function set floors(value:Number):void {
        _floors = value;
        redraw();
        _house.refreshRooms();
    }

    private function drawPipe():void {
        //0 0 is at the very bottom of the pipe.
        //body and bottom are added also at 0, 0
        //top is added to 0, - floor size * floors

        _highlight_all.x = 0;
        _highlight_all.y = 0;
        _highlight_all.visible = false;
        _highlight_all.mouseEnabled = false;
        addChild(_highlight_all);

        _body.x = 0;
        _body.y = 0;
        _body.hitArea = _highlight_all;
        addChild(_body);

        _bottom.x = 0;
        _bottom.y = 0;
        _bottom.graphics.lineStyle(1, 0, 1);
        _bottom.graphics.moveTo(0, 0);
        _bottom.graphics.lineTo(-3, 6);
        _bottom.graphics.lineTo(3, 6);
        _bottom.graphics.lineTo(0, 0);
        _bottom.graphics.endFill();

        addChild(_bottom);

        _highlight_top.x = 0;
        //_highlight_top.y is set up in resize()
        _highlight_top.visible = false;
        _highlight_top.mouseEnabled = false;
        addChild(_highlight_top);

        _top.graphics.beginFill(0x22AA22);
        _top.graphics.lineStyle(0.5, 0);
        _top.graphics.drawCircle(0, 0, 3);
        _top.graphics.endFill();
        _top.x = 0;
        _top.hitArea = _highlight_top;
        //_top.y is set up in resize()

        _highlight_top.graphics.beginFill(0xFFFF00, 0.5);
        _highlight_top.graphics.drawCircle(0, 0, 7);
        _highlight_top.graphics.endFill();

        addChild(_top);
    }

    private function redraw():void {
        const line_width:int = 1;
        const h:Number = _house.floorHeight * floors;

        var gr_matr:Matrix = new Matrix();
        gr_matr.createGradientBox(line_width, h, - Math.PI / 2);
        gr_matr.translate(0, _gradient_translate);

        _body.graphics.clear();
        _body.graphics.lineStyle(_selected ? 3 : 2);
        _body.graphics.lineGradientStyle(
                GradientType.LINEAR,
                [WATER_COLOR_1, WATER_COLOR_2],
                [1, 1],
                [0, 255], //[0, 100],
                gr_matr,
                SpreadMethod.REFLECT
                );

        _body.graphics.moveTo(0, 0);
        _body.graphics.lineTo(0, -h);
//        _body.graphics.drawRect(-line_width / 2, -h, line_width, h);

        _top.y = -h;

        //highlight objects
        _highlight_all.graphics.clear();
        _highlight_all.graphics.lineStyle(10, 0xFFFF00, 0.5);
        _highlight_all.graphics.moveTo(0, 10);
        _highlight_all.graphics.lineTo(0, -h);

        _highlight_top.y = -h;
    }

    private function replace():void {
        this.x = _house.house_width * n;
        this.y = baseLine();
    }

    private function baseLine():int {
        return _house.house_height + 10;
    }


    public function get selected():Boolean {
        return _selected;
    }

    public function set selected(value:Boolean):void {
        _selected = value;
        redraw();
    }

}
}
