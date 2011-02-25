/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 25.02.11
 * Time: 19:53
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.ariadne {
public class Point {

    private var _x:Rational;
    private var _y:Rational;
    private var _type:int;

    public function Point(x:Rational, y:Rational, type:int) {
        _x = x;
        _y = y;
        _type = type;
    }

    public function get x():Rational {
        return _x;
    }

    public function get y():Rational {
        return _y;
    }

    public function get type():int {
        return _type;
    }

    public function equals(p:Point):Boolean {
        return _x.equals(p._x) && _y.equals(p._y);
    }

    /**
     * intersects segment with square left-top x0,y0 and size 1
     * @return segment, null if no intersection
     */
    public function intersect(x0:int, y0:int):Segment {

    }

    //intersect with half plane; a x + b y + c >= 0
    private function intersectWithHalfPlane(a:int, b:int, c:int):Segment {

    }
}
}
