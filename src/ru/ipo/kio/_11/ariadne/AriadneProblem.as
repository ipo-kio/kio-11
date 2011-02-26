package ru.ipo.kio._11.ariadne {
import flash.display.DisplayObject;

import flash.display.Sprite;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.Settings;
import ru.ipo.kio.api_example.ExampleProblemSprite;

/**
 * Пример задачи
 */
public class AriadneProblem implements KioProblem {

    public static const ID:String = "ariadne";

    private var sp:Sprite;
    private var _recordCheck:Object = null;

    [Embed(source="resources/Ariadne.ru.json-settings",mimeType="application/octet-stream")]
    public static var ARIADNE_RU:Class;

    public function AriadneProblem() {
        KioApi.registerLocalization(ID, KioApi.L_RU, new Settings(ARIADNE_RU).data);

        KioApi.initialize(this);

        sp = new ExampleProblemSprite(true, ID);
    }

    public function get id():String {
        return ID;
    }

    public function get year():int {
        return 2011;
    }

    public function get level():int {
        return 1;
    }

    public function get display():DisplayObject {
        return sp;
    }

    public function get solution():Object {
        return {};
    }

    public function loadSolution(solution:Object):Boolean {
        return false;
    }

    public function check(solution:Object):Object {
        return {};
    }

    public function compare(solution1:Object, solution2:Object):int {
        if (!solution1)
            return solution2 ? 0 : -1;
        if (!solution2)
            return 1;

        return solution1.time - solution2.time; //sm. semiramidaProblem, add null check
    }

    [Embed(source="resources/icon.jpg")]
    public static const ICON:Class;

    public function get icon():Class {
        return ICON;
    }

    public function get icon_help():Class {
        return null;
    }
}

}