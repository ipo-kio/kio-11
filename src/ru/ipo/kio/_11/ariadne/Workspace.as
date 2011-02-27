/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 26.02.11
 * Time: 18:57
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11.ariadne {
import flash.display.Sprite;

public class Workspace extends Sprite {

    [Embed(source='resources/Bg_All.jpg')]
    private static const BG:Class;

    private var _land:Land = new Land(11);

    public function Workspace() {

        addChild(new BG);

        _land.x = 25;
        _land.y = 20;
        addChild(_land);
    }

    public function get land():Land {
        return _land;
    }
}
}
