package ru.ipo.kio._11.semiramida {
import ru.ipo.kio.api_example.*;

import flash.display.Sprite;
import flash.events.Event;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.base.KioBase;

public class TestSemiramida extends Sprite {

    public function TestSemiramida() {
        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        KioApi.registerLocalization(
                Pr1.ID, //идентификатор
        {                              //объект локализации
            text1 : "Hello World",
            text2 : "text 2",
            menu : {
                file : "Файл",
                exit : "Выйти"
            }
        }
                );

        KioBase.instance.initOneProblem(this, new SemiramidaProblem);
    }

}

}