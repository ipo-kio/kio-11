/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 27.02.11
 * Time: 13:58
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.ariadne.model {
import flash.events.Event;

public class PointChangedEvent extends Event {

    private var _point_index:int;

    public function PointChangedEvent(point_index:int) {
        super(AriadneData.POINT_CHANGED);
        _point_index = point_index;
    }

    public function get point_index():int {
        return _point_index;
    }
}
}
