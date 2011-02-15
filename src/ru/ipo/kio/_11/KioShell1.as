/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 09.02.11
 * Time: 21:41
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11 {
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

        KioBase.instance.init(this, [], 2011, 2);

        /*var spaceSettingsDialog:SpaceSettingsDialog = new SpaceSettingsDialog;
        addChild(spaceSettingsDialog);*/
    }

}
}
