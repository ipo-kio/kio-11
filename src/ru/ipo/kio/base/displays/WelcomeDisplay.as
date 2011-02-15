/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 10.02.11
 * Time: 20:06
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.Sprite;

import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.LsoProxy;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class WelcomeDisplay extends Sprite {

    private static const SECURITY_PANEL_WIDTH:int = 213;
    private static const SECURITY_PANEL_HEIGHT:int = 136;

    private static const V_PADDING:int = 20;
    private static const H_PADDING:int = 20;
    private static const TEXT_COLOR:uint = 0xDDDDDD;

    public function WelcomeDisplay() {
        addChild(new Resources.BG_IMAGE);

        var mainMessage:TextField = new TextField();
        //mainMessage.embedFonts = true;
        mainMessage.multiline = true;
        mainMessage.wordWrap = true;
        mainMessage.width = GlobalMetrics.STAGE_WIDTH - 2 * H_PADDING;
        mainMessage.embedFonts = true;
        mainMessage.autoSize = TextFieldAutoSize.LEFT;
        mainMessage.styleSheet = new StyleSheet();
        mainMessage.styleSheet.parseCSS(TextUtils.CSS);
        mainMessage.htmlText = '<html>' + KioApi.getLocalization(KioBase.BASE_API_ID).screen.welcome.mainMessage + '</html>';
        mainMessage.x = H_PADDING;
        mainMessage.y = V_PADDING;

        addChild(mainMessage);
    }

}
}
