/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 10.02.11
 * Time: 21:49
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.DisplayObject;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.Security;
import flash.system.SecurityPanel;
import flash.text.TextField;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.LsoProxy;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class SettingsDisplay extends Sprite {

    public function SettingsDisplay() {
        addChild(new Resources.BG_IMAGE);

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID).screen;

        var message:TextField = TextUtils.createCustomTextField();
        message.htmlText = loc.settings.mainMessage;
        message.width = GlobalMetrics.STAGE_WIDTH - 2 * GlobalMetrics.H_PADDING;
        message.x = GlobalMetrics.H_PADDING;
        message.y = GlobalMetrics.V_PADDING;

        addChild(message);

        var img:* = new Resources.SETTINGS_HELPER_RU;
        img.x = GlobalMetrics.H_PADDING;
        img.y = message.y + message.height + 6;

        addChild(img);

        var messageContinuation:TextField = TextUtils.createCustomTextField();
        messageContinuation.htmlText = loc.settings.mainMessageContinuation;
        messageContinuation.width = GlobalMetrics.STAGE_WIDTH - 2 * GlobalMetrics.H_PADDING;
        messageContinuation.x = GlobalMetrics.H_PADDING;
        messageContinuation.y = img.y + img.height;

        addChild(messageContinuation);

        var setupButton:TextButton = new TextButton(loc.settings.configure_button, 100);
        setupButton.x = img.x + img.width + 32;
        setupButton.y = img.y + (img.height - setupButton.height) / 2;
        setupButton.addEventListener(MouseEvent.CLICK, setupClicked);

        addChild(setupButton);

        var continueButton:TextButton = new TextButton(loc.buttons.continue_, 200, 100);
        continueButton.x = GlobalMetrics.STAGE_WIDTH - continueButton.width - GlobalMetrics.H_PADDING;
        continueButton.y = GlobalMetrics.STAGE_HEIGHT - continueButton.height - GlobalMetrics.V_PADDING;
        continueButton.addEventListener(MouseEvent.CLICK, continueButtonClicked);

        addChild(continueButton);
    }

    private function continueButtonClicked(event:Event):void {
        KioBase.instance.currentDisplay = new AnketaDisplay;

        var lso:LsoProxy = KioBase.instance.lsoProxy;
        lso.getGlobalData().notFirstTime = true;
        lso.flush();
    }

    private function setupClicked(event:Event):void {
        Security.showSettings(SecurityPanel.LOCAL_STORAGE);
    }

}
}
