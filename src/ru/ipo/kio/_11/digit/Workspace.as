/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 15:57
 */
package ru.ipo.kio._11.digit {
import flash.display.Sprite;

public class Workspace extends Sprite {

    [Embed(source="resources/Background+Robot.jpg")]
    private static const BG:Class;

    public function Workspace() {
        addChild(new BG);
    }
}
}
