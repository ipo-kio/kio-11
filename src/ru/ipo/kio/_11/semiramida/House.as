/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 14.02.11
 * Time: 21:33
 */
package ru.ipo.kio._11.semiramida {
import flash.display.Sprite;

public class House extends Sprite {

    private const FLOORS:int = 20;

    private const BORDER_WIDTH:Number = 2;
    private const BORDER_COLOR:uint = 0x000022;
    private const BORDER_ALPHA:Number = 0.8;

    private const FLOOR_WIDTH:Number = 1.5;
    private const FLOOR_COLOR:uint = 0x000022;
    private const FLOOR_ALPHA:Number = 0.8;

    private const WALL_WIDTH:Number = 0.8;
    private const WALL_COLOR:uint = 0x000022;
    private const WALL_ALPHA:Number = 0.8;

    private var _house_width:int;
    private var _house_height:int;

    private var _pipes:Array = [];
    private var _selected_pipe:Pipe = null;

    public function House(width:int, height:int) {
        _house_width = width;
        _house_height = height;

        graphics.lineStyle(BORDER_WIDTH, BORDER_COLOR, BORDER_ALPHA);
        graphics.drawRect(0, 0, _house_width, _house_height);

        graphics.lineStyle(FLOOR_WIDTH, FLOOR_COLOR, FLOOR_ALPHA);
        for (var i:int = 1; i < FLOORS; ++i) {
            var h:Number = i * _house_height / FLOORS;
            graphics.moveTo(0, h);
            graphics.lineTo(_house_width, h);
        }

        graphics.lineStyle(WALL_WIDTH, WALL_COLOR, WALL_ALPHA);
        for (i = 0; i < FLOORS; i++)
            for (var j:int = 1; j <= i + 1; ++j) {
                graphics.moveTo(j * _house_width / (i + 2), i * _house_height / FLOORS);
                graphics.lineTo(j * _house_width / (i + 2), (i + 1) * _house_height / FLOORS);
            }

        createPipe();
        createPipe();
        createPipe();
    }

    public function get pipes():Array {
        return _pipes;
    }

    public function set pipes(value:Array):void {
        _pipes = value;
    }

    public function get floorHeight():Number {
        return _house_height / FLOORS;
    }


    public function get house_width():int {
        return _house_width;
    }

    public function get house_height():int {
        return _house_height;
    }

    public function createPipe(floor:int = -1):void {
        if (floor < 0)
            floor = FLOORS / 2;
        var pipe:Pipe = new Pipe(this, floor);
        _pipes.push(pipe);

        selected_pipe = pipe;

        addChild(pipe);
    }

    public function get selected_pipe():Pipe {
        return _selected_pipe;
    }

    public function set selected_pipe(value:Pipe):void {
        if (_selected_pipe)
            _selected_pipe.selected = false;
        _selected_pipe = value;
        _selected_pipe.selected = true;
    }
}
}