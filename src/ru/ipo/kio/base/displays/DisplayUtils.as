/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 24.02.11
 * Time: 12:52
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;

import flash.text.TextField;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class DisplayUtils {

    private static var BG_IMAGE:DisplayObject = new Resources.BG_IMAGE;

    public static function placeBackground(display:Sprite):void {
        //place background

        display.addChild(BG_IMAGE);

        //place title

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID);
        var title:String = loc.contest_header + ", " + loc.contest_level[-1 + KioBase.instance.level];

        var header:TextField = TextUtils.createTextFieldWithFont(TextUtils.FONT_MESSAGES, 13, false);
        header.x = 10;
        header.y = 0;
        header.text = title;
        display.addChild(header);
    }

    public static function placeContinueButton(display:Sprite):SimpleButton {
        var continueButton:SimpleButton = new ShellButton(KioApi.getLocalization(KioBase.BASE_API_ID).screen.buttons.continue_);
        continueButton.x = GlobalMetrics.STAGE_WIDTH - continueButton.width - GlobalMetrics.H_PADDING;
        continueButton.y = GlobalMetrics.STAGE_HEIGHT - continueButton.height - GlobalMetrics.V_PADDING;

        display.addChild(continueButton);

        return continueButton;
    }

}
}
