/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 25.02.11
 * Time: 16:38
 */
package ru.ipo.kio._11.ariadne {
public class Rational {

    private var _n:int;
    private var _d:int;

    public function Rational(n:int, d:int) {
        _n = n;
        _d = d;
        normalize();
    }

    private function normalize():void {
        if (_d < 0) {
            _n = - _n;
            _d = - _d;
        }

        var a:int = Math.abs(_n);
        var b:int = _d;

        while (b != 0) {
            var t:int = b;
            b = a % b;
            a = t;
        }

        var gcd:int = a + b;

        _n /= gcd;
        _d /= gcd;
    }

    public function get n():int {
        return _n;
    }

    public function get d():int {
        return _d;
    }

    public function equals(r:Rational):Boolean {
        return _n == r._n && _d == r._d;
    }
}
}
