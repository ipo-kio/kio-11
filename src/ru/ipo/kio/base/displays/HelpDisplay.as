/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 24.02.11
 * Time: 17:37
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;

import flash.text.TextField;

import mx.utils.DisplayUtil;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;

public class HelpDisplay extends Sprite {
    public function HelpDisplay(problem:KioProblem, is_statement:Boolean) {

        DisplayUtils.placeBackground(this);

        var loc:Object = KioApi.getLocalization(problem.id);
        var loc_sh:Object = KioApi.getLocalization(KioBase.BASE_API_ID);
        var title:String = is_statement ? loc_sh.contest_panel.buttons.statement : loc_sh.contest_panel.buttons.help;
        var text:String = is_statement ?
                String(DisplayUtils.getKyByLevel(loc, 'statement', problem.level)) :
                String(DisplayUtils.getKyByLevel(loc, 'help', problem.level));

        var header:TextField = TextUtils.createCustomTextField();
        header.htmlText = '<p class="h1">' + title + '</p>';
        header.width = GlobalMetrics.DISPLAYS_TEXT_WIDTH;
        header.x = (GlobalMetrics.STAGE_WIDTH - header.textWidth) / 2;
        header.y = GlobalMetrics.DISPLAYS_TEXT_TOP;
        addChild(header);

        var main_text_start:Number = header.y + header.textHeight + 10;

        var imgCl:Class = problem.icon_help;
        if (imgCl != null) {
            var img:DisplayObject = new imgCl;
            img.x = GlobalMetrics.STAGE_WIDTH - GlobalMetrics.H_PADDING - img.width;
            img.y = main_text_start;
            addChild(img);
        }

        var text_width:int = Math.min(2 * GlobalMetrics.DISPLAYS_TEXT_WIDTH, img.x - 2 * GlobalMetrics.H_PADDING);

        var tf:TextField = TextUtils.createCustomTextField();
        tf.text = text;
        tf.width = text_width;
        tf.x = GlobalMetrics.H_PADDING;
        tf.y = main_text_start;
        addChild(tf);

        var continueButton:SimpleButton = DisplayUtils.placeContinueButton(this);

        continueButton.addEventListener(MouseEvent.CLICK, function (event:Event):void {
            KioBase.instance.currentProblem = problem;
        });

    }

}
}
