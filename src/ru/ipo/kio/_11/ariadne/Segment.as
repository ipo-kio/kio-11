/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 25.02.11
 * Time: 20:06
 */
package ru.ipo.kio._11.ariadne {

public class Segment {

    private var _start:RationalPoint;
    private var _finish:RationalPoint;
    private var _type:int;

    public function Segment(start:RationalPoint, finish:RationalPoint, type:int) {
        this._start = start;
        this._finish = finish;
        _type = type;
    }

    public function get start():RationalPoint {
        return _start;
    }

    public function get finish():RationalPoint {
        return _finish;
    }

    public function get type():int {
        return _type;
    }

    /**
     * intersects segment with square left-top x0,y0 and size 1
     * @return segment, null if no intersection. Point means no intersection
     */
    public function intersect(x0:int, y0:int, type:int = -1):Segment {
        var s:Segment = intersectWithHalfPlane(x0, 1, true, type);
        if (!s)
            return null;
        s = s.intersectWithHalfPlane(x0 + 1, -1, true, type);
        if (!s)
            return null;
        s = s.intersectWithHalfPlane(y0, 1, false, type);
        if (!s)
            return null;
        s = s.intersectWithHalfPlane(y0 + 1, -1, false, type);

        return s;
    }

    /**
     * intersect with a vertical half plane; dir * (x - x0) >= 0.
     * So, if dir > 0 then it is x >= x0, and vice versa
     */
    private function intersectWithHalfPlane(z0:int, dir:int, is_vertical:Boolean, type:int = -1):Segment {
        var z1:Rational = is_vertical ? _start.x : _start.y;
        var z2:Rational = is_vertical ? _finish.x : _finish.y;
        var t1:Rational = is_vertical ? _start.y : _start.x;
        var t2:Rational = is_vertical ? _finish.y : _finish.x;

        var start_is_inside:Boolean = z1.sub_int(z0).mul_int_(dir).nonNegative();
        var finish_is_inside:Boolean = z2.sub_int(z0).mul_int_(dir).nonNegative();

        if (start_is_inside && finish_is_inside)
            return new Segment(_start, _finish, type < 0 ? _type : type);

        if (!start_is_inside && !finish_is_inside)
            return null;

        //evaluate intersection

        // (z - z1) / (z2 - z1) = (t - t1) / (t2 - t1)
        // t0 = (z0 - z1) * (t2 - t1) / (z2 - z1) + t1

        var t0:Rational = z1.sub_int(z0).mul_(t1.sub(t2)).div_(z2.sub(z1)).add_(t1);

        var intersection:RationalPoint;
        if (is_vertical)
            intersection = new RationalPoint(new Rational(z0, 1), t0);
        else
            intersection = new RationalPoint(t0, new Rational(z0, 1));

        if (start_is_inside)
            return intersection.equals(_start) ? null : new Segment(_start, intersection, type < 0 ? _type : type);
        else
            return intersection.equals(_finish) ? null : new Segment(intersection, _finish, type < 0 ? _type : type);
    }

    public function split(terra:Terra):Array {
        var w:int = terra.width;
        var h:int = terra.height;

        var elements:Array = [];

        //if horizontal or vertical
        if (_start.x.equals(_finish.x) || _start.y.equals(_finish.y)) {

        } else { // diagonal
            var grows:Boolean = _finish.x.sub(_start.x).positive();

            for (var x:int = 0; x < w; x++)
                for (var y:int = 0; y < h; y++) {
                    var s:Segment = intersect(x, y, terra.squareType(x, y));
                    if (s)
                        elements.push(s);
                }

            var e_len:int = elements.length;
            for (var i:int = 0; i < e_len; i++)
                for (var j:int = i + 1; j < e_len; j++)
                    if (elements[i].start.x.sub(elements[j].start.x).positive() == grows) {
                        var e:Segment = elements[i];
                        elements[i] = elements[j];
                        elements[j] = e;
                    }
        }

        return elements;
    }

    public function toString():String {
        return "(" + start.x.n + "/" + start.x.d + ", " + start.y.n + "/" + start.y.d + ")" +
                " --- " +
                "(" + finish.x.n + "/" + finish.x.d + ", " + finish.y.n + "/" + finish.y.d + ")" +
                "        [" + _type + "]";
    }

    public static function create(x1:int, y1:int, x2:int, y2:int):Segment {
        return new Segment(
                new RationalPoint(new Rational(x1, 1), new Rational(y1, 1)),
                new RationalPoint(new Rational(x2, 1), new Rational(y2, 1)),
                0
                );
    }
}
}
