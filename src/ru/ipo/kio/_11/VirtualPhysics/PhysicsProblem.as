package ru.ipo.kio._11.VirtualPhysics {
import flash.display.DisplayObject;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.Settings;

/**
 * Пример задачи
 * @author Ilya
 */
public class PhysicsProblem implements KioProblem {

    public static const ID:String = "physics";

    private var sp:PhysicsMain;

    [Embed(source="resources/physics.ru.json-settings",mimeType="application/octet-stream")]
    public static var PHYSICS_RU:Class;
    [Embed(source="resources/physics.es.json-settings",mimeType="application/octet-stream")]
    public static var PHYSICS_ES:Class;

    //конструктор задачи
    public function PhysicsProblem() {

        KioApi.registerLocalization(ID, KioApi.L_RU, new Settings(PHYSICS_RU).data);
        KioApi.registerLocalization(ID, KioApi.L_ES, new Settings(PHYSICS_ES).data);

        KioApi.initialize(this);


//			sp = new ExampleProblemSprite(true, ID); //Это вызов заглушки, которая показывает, что задача будет доступна позже
        sp = new PhysicsMain;
    }

    public function get id():String {
        return ID;
    }

    /**
     * Год задачи
     */
    public function get year():int {
        return 2011;
    }

    public function get level():int {
        return 2;
    }

    public function get display():DisplayObject {
        return sp;
    }

    public function get solution():Object {
        return {
            _11: sp._11.text,
            _12: sp._12.text,
            _22: sp._22.text,
            r1: sp.resultLabel_1.text,
            r2: sp.resultLabel_2.text,
            r3: sp.resultLabel_3.text
        };
    }

    public function loadSolution(solution:Object):Boolean {
        if (!solution)
            return false;
        if (!solution._11 || !solution._12 || !solution._22 || !solution.r1 || !solution.r2 || !solution.r3)
            return false;

        sp._11.text = solution._11;
        sp._12.text = solution._12;
        sp._22.text = solution._22;

        sp.resultLabel_1.text = solution.r1;
        sp.resultLabel_2.text = solution.r2;
        sp.resultLabel_3.text = solution.r3;

        sp.testNewRecord(false);

        return true;
    }

    public function check(solution:Object):Object {
        return new Object();
    }

    public function compare(solution1:Object, solution2:Object):int {
        return 1;
    }

    [Embed(source="resources/icon.jpg")]
    private static const ICON:Class;

    public function get icon():Class {
        return ICON;
    }

    [Embed(source='resources/help_icon.jpg')]
    private const ICON_HELP:Class;

    public function get icon_help():Class {
        return ICON_HELP;
    }
}

}