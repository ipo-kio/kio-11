/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 25.02.11
 * Time: 20:06
 */
package ru.ipo.kio._11.ariadne {
public class Segment {

    private var _start:Point;
    private var _finish:Point;

    public function Segment(start:Point, finish:Point) {
        this._start = start;
        this._finish = finish;
    }


    public function get start():Point {
        return _start;
    }

    public function get finish():Point {
        return _finish;
    }
}
}
