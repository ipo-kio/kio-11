/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 10.02.11
 * Time: 20:06
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import ru.ipo.kio.api.FileUtils;
import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.LsoProxy;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class WelcomeDisplay extends Sprite {

    private static const SECURITY_PANEL_WIDTH:int = 213;
    private static const SECURITY_PANEL_HEIGHT:int = 136;

    private static const TEXT_COLOR:uint = 0xDDDDDD;

    public function WelcomeDisplay() {
        addChild(new Resources.BG_IMAGE);

        var loc:* = KioApi.getLocalization(KioBase.BASE_API_ID).screen;

        var mainMessage:TextField = TextUtils.createCustomTextField();
        mainMessage.htmlText = '<html>' + loc.welcome.mainMessage + '</html>';
        mainMessage.width = GlobalMetrics.STAGE_WIDTH - 2 * GlobalMetrics.H_PADDING;
        mainMessage.x = GlobalMetrics.H_PADDING;
        mainMessage.y = GlobalMetrics.V_PADDING;

        addChild(mainMessage);

        var loadWorkspaceButton:TextButton = new TextButton(loc.buttons.loadWorkspace);
        loadWorkspaceButton.x = GlobalMetrics.H_PADDING;
        loadWorkspaceButton.y = GlobalMetrics.STAGE_HEIGHT - loadWorkspaceButton.height - GlobalMetrics.V_PADDING;

        addChild(loadWorkspaceButton);

        var continueButton:TextButton = new TextButton(loc.buttons.continue_, 200, 100);
        continueButton.x = GlobalMetrics.STAGE_WIDTH - continueButton.width - GlobalMetrics.H_PADDING;
        continueButton.y = GlobalMetrics.STAGE_HEIGHT - continueButton.height - GlobalMetrics.V_PADDING;

        addChild(continueButton);

        var loadWorkspaceMessage:TextField = TextUtils.createCustomTextField();
        loadWorkspaceMessage.htmlText = '<p class="footnote"><i>' + loc.welcome.loadWorkspace + '</i></p';
        loadWorkspaceMessage.width = 3 * loadWorkspaceButton.width;
        loadWorkspaceMessage.x = GlobalMetrics.H_PADDING;
        loadWorkspaceMessage.y = loadWorkspaceButton.y - loadWorkspaceMessage.height - 6;

        addChild(loadWorkspaceMessage);

        loadWorkspaceButton.addEventListener(MouseEvent.CLICK, loadWorkspaceButtonClicked);
        continueButton..addEventListener(MouseEvent.CLICK, continueButtonClicked);
    }

    private function continueButtonClicked(event:Event):void {
        KioBase.instance.currentDisplay = new SettingsDisplay;
    }

    private function loadWorkspaceButtonClicked(event:Event):void {
        FileUtils.loadAll();
    }

}
}
