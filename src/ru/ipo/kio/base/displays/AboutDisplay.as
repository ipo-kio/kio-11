/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 24.02.11
 * Time: 14:57
 */
package ru.ipo.kio.base.displays {
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import flash.text.TextField;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;


public class AboutDisplay extends Sprite {
    public function AboutDisplay() {
        DisplayUtils.placeBackground(this);
        var continueButton:SimpleButton = DisplayUtils.placeContinueButton(this);
        continueButton.addEventListener(MouseEvent.CLICK, continueButtonClick);

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID);

        var header:TextField = TextUtils.createCustomTextField();
        header.htmlText = '<p class="h1">' + loc.screen.about.header + '</p>';
        header.width = GlobalMetrics.DISPLAYS_TEXT_WIDTH;
        header.x = (GlobalMetrics.STAGE_WIDTH - header.textWidth) / 2;
        header.y = GlobalMetrics.DISPLAYS_TEXT_TOP;

        addChild(header);

        var text_width:int = 1.5 * GlobalMetrics.DISPLAYS_TEXT_WIDTH;

        var text:TextField = TextUtils.createCustomTextField();
        text.htmlText = loc.screen.about.text;
        text.width = text_width;
        text.x = (GlobalMetrics.STAGE_WIDTH - text_width) / 2;
        text.y = header.y + header.textHeight + 20;

        addChild(text);

        addChild(header);
    }

    private function continueButtonClick(event:Event):void {
        KioBase.instance.currentDisplay = new ProblemsDisplay;
    }
}
}
