/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 20:15
 */
package ru.ipo.kio._11.digit {
public class Globals {

    private static const _instance:Globals = new Globals;

    public static function get instance():Globals {
        return _instance;
    }

    public static const DRAG_TYPE_NOTHING:int = 0;
    public static const DRAG_TYPE_GATE:int = 1;
    public static const DRAG_TYPE_CONNECTOR:int = 2;
    public static const DRAG_TYPE_NEW_GATE:int = 3;

    private var _selected_wire:Wire = null;
    private var _drag_type:int = DRAG_TYPE_NOTHING;
    private var _drag_object:* = null;

    private var _workspace:Workspace;

    public function get selected_wire():Wire {
        return _selected_wire;
    }

    public function set selected_wire(value:Wire):void {
        if (_selected_wire)
            _selected_wire.selected = false;

        _selected_wire = value;

        if (_selected_wire)
            _selected_wire.selected = true;
    }

    public function get drag_type():int {
        return _drag_type;
    }

    public function set drag_type(value:int):void {
        _drag_type = value;
    }

    public function get drag_object():* {
        return _drag_object;
    }

    public function set drag_object(value:*):void {
        _drag_object = value;
    }

    public function get workspace():Workspace {
        return _workspace;
    }

    public function set workspace(value:Workspace):void {
        _workspace = value;
    }

}
}
