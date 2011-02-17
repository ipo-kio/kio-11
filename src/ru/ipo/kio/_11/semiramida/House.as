/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 14.02.11
 * Time: 21:33
 */
package ru.ipo.kio._11.semiramida {
import flash.display.Shape;
import flash.display.Sprite;

import ru.ipo.kio._11.CrossedCountry.landObj;

public class House extends Sprite {

    public const FLOORS:int = 20;

    private const BORDER_WIDTH:Number = 2;
    private const BORDER_COLOR:uint = 0xFFFFEE;
    private const BORDER_ALPHA:Number = 0.8;

    private const FLOOR_WIDTH:Number = 1.5;
    private const FLOOR_COLOR:uint = 0xFFFFEE;
    private const FLOOR_ALPHA:Number = 0.8;

    private const WALL_WIDTH:Number = 0.8;
    private const WALL_COLOR:uint = 0xFFFFEE;
    private const WALL_ALPHA:Number = 0.8;

    private var _house_width:int;
    private var _house_height:int;

    private var _pipes:Array = [];
    private var _selected_pipe:Pipe = null;

    private var grid:Shape = new Shape;
    private var rooms:Array = []; //rooms: floor -> ind -> Room

    private var split_points:Array = [];

    private function gcd(a:int, b:int):int {
        while (a > 0 && b > 0) {
            if (a > b)
                a = a % b;
            else
                b = b % a;
        }
        return a + b;
    }

    public function House(width:int, height:int) {
        _house_width = width;
        _house_height = height;

        for (i = 0; i < FLOORS; ++i) {
            var rooms_on_the_floor:Array = [];
            for (var j:int = 0; j <= FLOORS - i; ++j) {
                var r:Room = new Room(this, i, j);
                r.visible = false;
                addChild(r);
                rooms_on_the_floor.push(r);
            }
            rooms.push(rooms_on_the_floor);
        }

        grid.graphics.lineStyle(BORDER_WIDTH, BORDER_COLOR, BORDER_ALPHA);
        grid.graphics.drawRect(0, 0, _house_width, _house_height);

        grid.graphics.lineStyle(FLOOR_WIDTH, FLOOR_COLOR, FLOOR_ALPHA);
        for (var i:int = 1; i < FLOORS; ++i) {
            var h:Number = i * _house_height / FLOORS;
            grid.graphics.moveTo(0, h);
            grid.graphics.lineTo(_house_width, h);
        }

        grid.graphics.lineStyle(WALL_WIDTH, WALL_COLOR, WALL_ALPHA);
        for (i = 0; i < FLOORS; i++)
            for (j = 1; j <= i + 1; ++j) {
                grid.graphics.moveTo(j * _house_width / (i + 2), i * _house_height / FLOORS);
                grid.graphics.lineTo(j * _house_width / (i + 2), (i + 1) * _house_height / FLOORS);
            }

        grid.x = 0;
        grid.y = 0;
        addChild(grid);

        //evaluate split points
        for (var q:int = 1; q <= FLOORS + 1; q++)
            for (var p:int = 0; p <= q; p++)
                if (gcd(p, q) == 1)
                    split_points.push(p / q);
        split_points.sort();
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

    public function createPipe(floor:int = -1, n:Number = -1):void {
        if (floor < 0)
            floor = FLOORS / 2;
        var pipe:Pipe = new Pipe(this, floor, n);
        _pipes.push(pipe);

        selected_pipe = pipe;

        addChild(pipe);

        refreshRooms();
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

    public function get roomsCount():int {
        var rooms_count:int = 0;

        //noinspection JSMismatchedCollectionQueryUpdateInspection
        var room_floor:Array;
        for each (room_floor in rooms)
            for each (var room:Room in room_floor)
                if (room.visible)
                    rooms_count++;

        return rooms_count;
    }

    public function allRooms():int {
        return (FLOORS + 1) * (FLOORS + 2) / 2 - 1;
    }

    public function get pipesLength():int {
        var len:int = 0;
        for each (var pipe:Pipe in pipes)
            len += Math.round(pipe.floors);
        return len;
    }

    public function refreshRooms():void {
        const eps:Number = 1e-10;

        //noinspection JSMismatchedCollectionQueryUpdateInspection
        var room_floor:Array;
        for each (room_floor in rooms)
            for each (var room:Room in room_floor)
                room.visible = false;

        for each (var pipe:Pipe in pipes) {
            var pipe_floors:int = Math.round(pipe.floors);
            for (var f:int = 0; f < pipe_floors; f++) {
                //evaluate room ind
                const rooms_on_the_floor:int = FLOORS + 1 - f;
                const ind_n:Number = pipe.n * rooms_on_the_floor;
                var ind:int = Math.round(ind_n);
                if (Math.abs(ind - ind_n) < eps)
                    continue;
                ind = Math.floor(ind_n);
                if (ind < 0)
                    ind = 0;
                if (ind >= rooms_on_the_floor)
                    ind = rooms_on_the_floor - 1;
                rooms[f][ind].visible = true;
            }
        }
    }

    public function removePipe(pipe:Pipe = null):void {
        if (!pipe)
            pipe = selected_pipe;
        if (!pipe)
            return;

        var sel_ind:int = pipes.indexOf(selected_pipe);
        if (sel_ind < 0)
            return;

        pipes.splice(sel_ind, 1);

        if (pipes.length > 0)
            selected_pipe = pipes[pipes.length - 1];

        removeChild(pipe);

        refreshRooms();
    }

    public function removeAllPipes():void {
        for each (var pipe:Pipe in pipes)
            removeChild(pipe);

        pipes = [];
        selected_pipe = null;
        refreshRooms();
    }

    public function movePipe(dir:int):void { //dir is +1 or -1
        if (!selected_pipe)
            return;
        var ind_r:int = 0;
        while (ind_r < split_points.length && selected_pipe.n > split_points[ind_r])
            ind_r++;

        var ind_l:int = ind_r - 1;
        if (ind_l < 0) {
            ind_l = 0;
            ind_r = 1;
        }

        ind_l += dir;
        ind_r += dir;

        if (ind_l < 0 || ind_r >= split_points.length)
            return;

        selected_pipe.n = (split_points[ind_l] + split_points[ind_r]) / 2;
    }

    public function changePipeLength(dir:int):void {
        if (!selected_pipe)
            return;
        var fl:int = selected_pipe.floorsInt;
        fl += dir;

        if (fl < 1)
            fl = 1;
        if (fl > FLOORS)
            fl = FLOORS;

        selected_pipe.floors = fl;
    }
}
}