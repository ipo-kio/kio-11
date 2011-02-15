/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 09.02.11
 * Time: 21:41
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11 {
import ru.ipo.kio._11.CrossedCountry.Pr1;
import ru.ipo.kio._11.recognition.Pr1;
import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api_example.Pr1;
import ru.ipo.kio.base.*;

import flash.display.Sprite;
import flash.events.Event;

import ru.ipo.kio.api.controls.SpaceSettingsDialog;

public class KioShell1 extends Sprite {

    public function KioShell1() {
        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        KioApi.registerLocalization(
				ru.ipo.kio.api_example.Pr1.ID, //идентификатор
				{                              //объект локализации
					text1 : "Hello World",
					text2 : "text 2",
					menu : {
						file : "Файл",
						exit : "Выйти"
					}
				}
			);

        KioApi.registerLocalization(
				ru.ipo.kio._11.recognition.Pr1.ID, //идентификатор
				{                              //объект локализации
					text1 : "Hello World",
					text2 : "text 2",
					menu : {
						file : "Файл",
						exit : "Выйти"
					}
				}
			);

        KioApi.registerLocalization(
				ru.ipo.kio._11.CrossedCountry.Pr1.ID, //идентификатор
				{                              //объект локализации
					text1 : "Hello World",
					text2 : "text 2",
					menu : {
						file : "Файл",
						exit : "Выйти"
					}
				}
			);

        KioBase.instance.init(this,
                [
                    //new ru.ipo.kio._11.CrossedCountry.Pr1()
                    new ru.ipo.kio.api_example.Pr1(),
                    new ru.ipo.kio._11.recognition.Pr1(),
//                    new ru.ipo.kio.api_example.Pr1(),
                    new ru.ipo.kio.api_example.Pr1()
                ],
                2011,
                1
        );

        /*var spaceSettingsDialog:SpaceSettingsDialog = new SpaceSettingsDialog;
        addChild(spaceSettingsDialog);*/
    }

}
}
