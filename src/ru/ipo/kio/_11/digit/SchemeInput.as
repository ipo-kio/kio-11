/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.02.11
 * Time: 2:05
 */
package ru.ipo.kio._11.digit {
import flash.display.BitmapData;
import flash.display.Sprite;

import ru.ipo.kio.base.KioBase;

public class SchemeInput extends Sprite implements Out{

    [Embed(source="resources/elements/Exit.png")]
    private static const EXIT:Class;
    private static const EXIT_IMG:BitmapData = new EXIT().bitmapData;

    private var _connectors:Array = [];

    private var _ind:int;

    private static var X_OUTPUT_OFFSET:int = 2;

    public function SchemeInput(ind:int) {
        _ind = ind;
        graphics.clear();
        graphics.beginBitmapFill(SchemeInput.EXIT_IMG);
        graphics.drawRect(0, 0, SchemeInput.EXIT_IMG.width, SchemeInput.EXIT_IMG.height);
        graphics.endFill();

        //get level
        x = 195 - Field.X0;
        if (KioBase.instance.level == 2)
            y = 27 + 40 * (ind - 1) - Field.Y0;
        else
            y = 27 + 40 * ind - Field.Y0;
    }

    public function get connectors():Array {
        return _connectors;
    }

    public function get value():int {
        return (_ind + 1) % 2;
    }

    public function get ind():int {
        return _ind;
    }

    public function bindConnector(c:Connector):void {
        _connectors.push(c);
        c.dest = this;
        positionConnectors();
    }

    private function positionConnectors():void {
        for each (var con:Connector in _connectors) {
            con.x = x + EXIT_IMG.width + X_OUTPUT_OFFSET;
            con.y = y + Math.floor(EXIT_IMG.height / 2);
            con.positionSubElements();
        }
    }
}
}