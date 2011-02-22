/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.02.11
 * Time: 16:01
 */
package ru.ipo.kio._11.digit {
import flash.display.BitmapData;
import flash.display.Sprite;

import ru.ipo.kio.base.KioBase;

public class Digit extends Sprite {

    // D

    [Embed(source="resources/lamps/Lamp_D_01.png")]
    private const LAMP_D_ON:Class;
    private const LAMP_D_ON_BMP:BitmapData = new LAMP_D_ON().bitmapData;

    [Embed(source="resources/lamps/Lamp_D_02.png")]
    private const LAMP_D_BR:Class;
    private const LAMP_D_BR_BMP:BitmapData = new LAMP_D_BR().bitmapData;

    [Embed(source="resources/lamps/Lamp_D_03.png")]
    private const LAMP_D_OFF:Class;
    private const LAMP_D_OFF_BMP:BitmapData = new LAMP_D_OFF().bitmapData;

    [Embed(source="resources/lamps/Lamp_D_04.png")]
    private const LAMP_D_OFF_OVER:Class;
    private const LAMP_D_OFF_OVER_BMP:BitmapData = new LAMP_D_OFF_OVER().bitmapData;

    [Embed(source="resources/lamps/Lamp_D_05.png")]
    private const LAMP_D_ON_OVER:Class;
    private const LAMP_D_ON_OVER_BMP:BitmapData = new LAMP_D_ON_OVER().bitmapData;

    // V

    [Embed(source="resources/lamps/Lamp_V_01.png")]
    private const LAMP_V_ON:Class;
    private const LAMP_V_ON_BMP:BitmapData = new LAMP_V_ON().bitmapData;

    [Embed(source="resources/lamps/Lamp_V_02.png")]
    private const LAMP_V_BR:Class;
    private const LAMP_V_BR_BMP:BitmapData = new LAMP_V_BR().bitmapData;

    [Embed(source="resources/lamps/Lamp_V_03.png")]
    private const LAMP_V_OFF:Class;
    private const LAMP_V_OFF_BMP:BitmapData = new LAMP_V_OFF().bitmapData;

    [Embed(source="resources/lamps/Lamp_V_04.png")]
    private const LAMP_V_OFF_OVER:Class;
    private const LAMP_V_OFF_OVER_BMP:BitmapData = new LAMP_V_OFF_OVER().bitmapData;

    [Embed(source="resources/lamps/Lamp_V_05.png")]
    private const LAMP_V_ON_OVER:Class;
    private const LAMP_V_ON_OVER_BMP:BitmapData = new LAMP_V_ON_OVER().bitmapData;

    // H

    [Embed(source="resources/lamps/Lamp_H_01.png")]
    private const LAMP_H_ON:Class;
    private const LAMP_H_ON_BMP:BitmapData = new LAMP_H_ON().bitmapData;

    [Embed(source="resources/lamps/Lamp_H_02.png")]
    private const LAMP_H_BR:Class;
    private const LAMP_H_BR_BMP:BitmapData = new LAMP_H_BR().bitmapData;

    [Embed(source="resources/lamps/Lamp_H_03.png")]
    private const LAMP_H_OFF:Class;
    private const LAMP_H_OFF_BMP:BitmapData = new LAMP_H_OFF().bitmapData;

    [Embed(source="resources/lamps/Lamp_H_04.png")]
    private const LAMP_H_OFF_OVER:Class;
    private const LAMP_H_OFF_OVER_BMP:BitmapData = new LAMP_H_OFF_OVER().bitmapData;

    [Embed(source="resources/lamps/Lamp_H_05.png")]
    private const LAMP_H_ON_OVER:Class;
    private const LAMP_H_ON_OVER_BMP:BitmapData = new LAMP_H_ON_OVER().bitmapData;

    private var _broken_index:int;
    //noinspection JSMismatchedCollectionQueryUpdateInspection
    private var _elements:Array;

    private var _val:int;

    public function Digit() {
        if (KioBase.instance.level == 1) {
            _elements = [
                createHElement(0),
                createVElement(1),
                createVElement(2),
                createHElement(3),
                createVElement(4),
                createVElement(5),
                createHElement(6)
            ];

            positionElement(_elements[0], 90, 145);
            positionElement(_elements[1], 50, 179);
            positionElement(_elements[2], 130, 179);
            positionElement(_elements[3], 90, 213);
            positionElement(_elements[4], 50, 247);
            positionElement(_elements[5], 130, 247);
            positionElement(_elements[6], 90, 281);
        } else {
            _elements = [
                createHElement(0),
                createVElement(1),
                createDElement(2),
                createVElement(3),
                createHElement(4),
                createVElement(5),
                createDElement(6),
                createVElement(7),
                createHElement(8)
            ];

            positionElement(_elements[0], 90, 145);
            positionElement(_elements[1], 50, 179);
            positionElement(_elements[2], 90, 179);
            positionElement(_elements[3], 130, 179);
            positionElement(_elements[4], 90, 213);
            positionElement(_elements[5], 50, 247);
            positionElement(_elements[6], 90, 247);
            positionElement(_elements[7], 130, 247);
            positionElement(_elements[8], 90, 281);

            for each (var e:DigitElement in _elements)
                e.breakable = true;
        }

        val = 0;
    }

    private function positionElement(_element:DigitElement, x:int, y:int):void {
        _element.x = 1 + x - _element.width / 2;
        _element.y = y - _element.height / 2;
        addChild(_element);
    }

    private function createHElement(ind:int):DigitElement {
        return new DigitElement(this, ind, LAMP_H_ON_BMP, LAMP_H_OFF_BMP, LAMP_H_ON_OVER_BMP, LAMP_H_OFF_OVER_BMP, LAMP_H_BR_BMP);
    }

    private function createDElement(ind:int):DigitElement {
        return new DigitElement(this, ind, LAMP_D_ON_BMP, LAMP_D_OFF_BMP, LAMP_D_ON_OVER_BMP, LAMP_D_OFF_OVER_BMP, LAMP_D_BR_BMP);
    }

    private function createVElement(ind:int):DigitElement {
        return new DigitElement(this, ind, LAMP_V_ON_BMP, LAMP_V_OFF_BMP, LAMP_V_ON_OVER_BMP, LAMP_V_OFF_OVER_BMP, LAMP_V_BR_BMP);
    }

    public function get broken_index():int {
        return _broken_index;
    }

    public function set broken_index(value:int):void {
        if (_broken_index >= 0)
            _elements[_broken_index].broken = false;

        _broken_index = value;

        if (_broken_index >= 0)
            _elements[_broken_index].broken = true;

        Globals.instance.workspace.field.evaluate();
    }

    public function get val():int {
        return _val;
    }

    public function set val(value:int):void {
        _val = value;

        if (KioBase.instance.level == 1) {
            switch (_val) {
                case 0:
                    setElements(1, 1, 1, 0, 1, 1, 1);
                    break;
                case 1:
                    setElements(0, 0, 1, 0, 0, 1, 0);
                    break;
                case 2:
                    setElements(1, 0, 1, 1, 1, 0, 1);
                    break;
                case 3:
                    setElements(1, 0, 1, 1, 0, 1, 1);
                    break;
                case 4:
                    setElements(0, 1, 1, 1, 0, 1, 0);
                    break;
                case 5:
                    setElements(1, 1, 0, 1, 0, 1, 1);
                    break;
                case 6:
                    setElements(1, 1, 0, 1, 1, 1, 1);
                    break;
                case 7:
                    setElements(1, 0, 1, 0, 0, 1, 0);
                    break;
                case 8:
                    setElements(1, 1, 1, 1, 1, 1, 1);
                    break;
                case 9:
                    setElements(1, 1, 1, 1, 0, 1, 1);
                    break;
            }
        } else {
            switch (_val) {
                case 0:
                    setElements(1, 1, 0, 1, 0, 1, 0, 1, 1);
                    break;
                case 1:
                    setElements(0, 0, 1, 1, 0, 0, 0, 1, 0);
                    break;
                case 2:
                    setElements(1, 0, 0, 1, 0, 0, 1, 0, 1);
                    break;
                case 3:
                    setElements(1, 0, 1, 0, 1, 0, 1, 0, 0);
                    break;
                case 4:
                    setElements(0, 1, 0, 1, 1, 0, 0, 1, 0);
                    break;
                case 5:
                    setElements(1, 1, 0, 0, 1, 0, 0, 1, 1);
                    break;
                case 6:
                    setElements(0, 0, 1, 0, 1, 1, 0, 1, 1);
                    break;
                case 7:
                    setElements(1, 0, 1, 0, 0, 1, 0, 0, 0);
                    break;
                case 8:
                    setElements(1, 1, 0, 1, 1, 1, 0, 1, 1);
                    break;
                case 9:
                    setElements(1, 1, 0, 1, 1, 0, 1, 0, 0);
                    break;
            }
        }


        var sp:Workspace = Globals.instance.workspace;
        if (sp)
            sp.field.evaluate();
    }

    private function setElements(... args):void {
        for (var i:int = 0; i < _elements.length; i++)
            _elements[i].on = args[i] == 1;
    }

    public function getValueAt(ind:int):int {
        return _elements[ind].on && !_elements[ind].broken ? 1 : 0;
    }
}
}
