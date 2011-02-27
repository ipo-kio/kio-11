/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 27.02.11
 * Time: 12:35
 */
package ru.ipo.kio._11.ariadne.model {
import flash.events.Event;
import flash.events.EventDispatcher;

public class AriadneData extends EventDispatcher {

    private static var _instance:AriadneData = new AriadneData;

    public static const POINT_CHANGED:String = "point changed";
    public static const PATH_CHANGED:String = "path changed";

    public static function get instance():AriadneData {
        return _instance;
    }

    private var _terra:Terra;
    private var _path:Path;
    private var _selected_point_index:int = -1;
    private var _selected_segment_index:int = -1;

    public function AriadneData() {
        _terra = new AriadneTerra;
        initPath();
    }

    private function initPath():void {
        _path = new Path(new IntegerPoint(1, 1), new IntegerPoint(_terra.width - 1, _terra.height - 1));
    }

    public function get pointsCount():int {
        return _path.pointsCount;
    }

    public function getPoint(ind:int):IntegerPoint {
        return _path.getPoint(ind);
    }

    public function get terra():Terra {
        return _terra;
    }

    public function get selected_point_index():int {
        return _selected_point_index;
    }

    public function get selected_segment_index():int {
        return _selected_segment_index;
    }

    public function set selected_point_index(value:int):void {
        if (value <= 0)
            value = -1;
        if (value >= _path.pointsCount - 1)
            value = -1;

        _selected_point_index = value;
    }

    public function set selected_segment_index(value:int):void {
        if (value < 0)
            value = -1;
        if (value >= _path.pointsCount - 1)
            value = -1;

        _selected_segment_index = value;
    }

    public function removePoint():void {
        if (selected_point_index > 0 && selected_point_index < _path.pointsCount - 1) {
            _path.remove(selected_point_index);
            _selected_point_index = -1;
            dispatchEvent(new Event(PATH_CHANGED));
        }
    }

    public function addPoint(ip:IntegerPoint):void {
        var segment_index:int = _selected_point_index;
        if (segment_index < 0)
            segment_index = _path.pointsCount - 2;

        _path.insert(ip, segment_index);
        _selected_segment_index = segment_index + 1;
        _selected_point_index = segment_index + 1;

        dispatchEvent(new Event(PATH_CHANGED));
    }

    public function clearPath():void {
        initPath();

        dispatchEvent(new Event(PATH_CHANGED));
    }
}
}
