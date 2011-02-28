/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 27.02.11
 * Time: 11:21
 */
package ru.ipo.kio._11.ariadne.view {
import flash.display.Sprite;

import flash.geom.Point;

import ru.ipo.kio._11.ariadne.model.AriadneData;
import ru.ipo.kio._11.ariadne.model.Path;

public class PathPoint extends Sprite {
    private var _ind:int;
    private var _path:Path;
    private var _land:Land;

    private static const RADIUS:int = 2;

    public function PathPoint(land:Land, path:Path, ind:int) {
        _ind = ind;
        _path = path;
        _land = land;
    }

    public function get selected():Boolean {
        return _ind == AriadneData.instance.selected_point_index;
    }

    public function get selectable():Boolean {
        return _ind == 0 || _ind + 1 == _path.pointsCount;
    }

    public function redraw():void {
        var p:Point = _land.logicalToScreen(_path.getPoint(_ind));

        graphics.clear();
        graphics.beginFill(selectable ? (selected ? 0x7de33b : 0xe9d835) : 0xffffff);
        graphics.drawCircle(p.x, p.y, RADIUS);
        graphics.endFill();
    }
}
}
