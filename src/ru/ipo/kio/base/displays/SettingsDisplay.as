/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 10.02.11
 * Time: 21:49
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.Security;
import flash.system.SecurityPanel;
import flash.text.TextField;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.LsoProxy;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class SettingsDisplay extends Sprite {

    public function SettingsDisplay() {
        addChild(new Resources.BG_IMAGE);

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID).screen;

        var message:TextField = TextUtils.createCustomTextField();
        message.htmlText = loc.settings.mainMessage;
        message.width = GlobalMetrics.DISPLAYS_TEXT_WIDTH;
        message.x = (GlobalMetrics.STAGE_WIDTH - GlobalMetrics.DISPLAYS_TEXT_WIDTH) / 2;
        message.y = GlobalMetrics.DISPLAYS_TEXT_TOP;

        addChild(message);

        //settings sprite with image and button

        var settings_sprite:Sprite = new Sprite;

        var img:* = new Resources.SETTINGS_HELPER_RU;
        settings_sprite.addChild(img);

        var setupButton:SimpleButton = new ShellButton(loc.settings.configure_button);
        setupButton.x = Math.floor(img.x + img.width + 32);
        setupButton.y = Math.floor(img.y + (img.height - setupButton.height) / 2);
        setupButton.addEventListener(MouseEvent.CLICK, setupClicked);

        settings_sprite.addChild(setupButton);

        settings_sprite.x = Math.floor((GlobalMetrics.STAGE_WIDTH - settings_sprite.width) / 2);
        settings_sprite.y = Math.floor(message.y + message.textHeight + 10);
        addChild(settings_sprite);

        //message continuation

        var messageContinuation:TextField = TextUtils.createCustomTextField();
        messageContinuation.htmlText = loc.settings.mainMessageContinuation;
        messageContinuation.width = GlobalMetrics.DISPLAYS_TEXT_WIDTH;
        messageContinuation.x = (GlobalMetrics.STAGE_WIDTH - GlobalMetrics.DISPLAYS_TEXT_WIDTH) / 2;
        messageContinuation.y = settings_sprite.y + settings_sprite.height + 10;

        addChild(messageContinuation);

        var continueButton:SimpleButton = new ShellButton(loc.buttons.continue_);
        continueButton.x = GlobalMetrics.STAGE_WIDTH - continueButton.width - GlobalMetrics.H_PADDING;
        continueButton.y = GlobalMetrics.STAGE_HEIGHT - continueButton.height - GlobalMetrics.V_PADDING;

        addChild(continueButton);

        continueButton.addEventListener(MouseEvent.CLICK, continueButtonClicked);
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
