/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 25.02.11
 * Time: 23:48
 */
package ru.ipo.kio._11.ariadne {
import flash.display.Sprite;

public class TestEvaluations extends Sprite {

    public function TestEvaluations() {
        var ariadneTerra:AriadneTerra = new AriadneTerra();

        var split:Array = Segment.create(10, 10, 40, 7).split(ariadneTerra);
        for each (var e:Segment in split)
            trace(e);

        /*test(0, 1, 3, 2);
        test(0, 1, 2, 3);
        test(0, 0, 10, 10);
        test(0, 0, 10, 9);
        test(1, 0, 1, 10);*/
    }

    private function test(x1:int, y1:int, x2:int, y2:int):void {
        var s:Segment = new Segment(
                new RationalPoint(new Rational(x1, 1), new Rational(y1, 1)),
                new RationalPoint(new Rational(x2, 1), new Rational(y2, 1)),
                0
                );

        var segment:Segment = s.intersect(1, 1);
        if (segment)
            trace(
                    "(" + segment.start.x.n + "/" + segment.start.x.d + ", " + segment.start.y.n + "/" + segment.start.y.d + ")" +
                            " --- " +
                            "(" + segment.finish.x.n + "/" + segment.finish.x.d + ", " + segment.finish.y.n + "/" + segment.finish.y.d + ")"
                    );
        else
            trace("null");
    }

}
}
