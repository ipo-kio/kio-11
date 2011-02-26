package ru.ipo.kio._11.semiramida {
import ru.ipo.kio.api_example.*;

import flash.display.Sprite;
import flash.events.Event;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.base.KioBase;

public class TestSemiramida extends Sprite {

    public function TestSemiramida() {
        /*var pattern:RegExp = /^bob/;
        var str:String = "foo\n"
                + "bob";
        trace(pattern.multiline); // false
        trace(pattern.exec(str)); // null

        pattern = /(\n|\r\n|\r|\n\r)/g;
        trace(pattern.multiline); // true
        trace(str.replace(pattern, " ")); // bob*/


        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        KioApi.registerLocalization(
                ExampleProblem.ID, //идентификатор
        {                              //объект локализации
            text1 : "Hello World",
            text2 : "text 2",
            menu : {
                file : "Файл",
                exit : "Выйти"
            }
        }
                );

        KioBase.instance.initOneProblem(this, new SemiramidaProblem(1));
    }

}

}