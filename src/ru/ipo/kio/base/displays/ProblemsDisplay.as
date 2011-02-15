/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 10.02.11
 * Time: 21:27
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;

import flash.text.TextField;

import flash.text.TextFieldAutoSize;

import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class ProblemsDisplay extends Sprite {
    public function ProblemsDisplay() {
        addChild(new Resources.BG_IMAGE);

        var prs:Array = [
            Resources.PR1_IMAGE,
            Resources.PR2_IMAGE,
            Resources.PR3_IMAGE
        ];

        var prname:Array = [
            "Пересеченная местность",
            "Глаз робота",
            "Сады Семирамиды"
        ];

        for (var i:int = 0; i < 3; i++) {
            var up:DisplayObject = new prs[i];

            var over:DisplayObject = new prs[i];
            over.filters = [new BlurFilter(2, 2)];

            var down:DisplayObject = new prs[i];
            down.filters = [new BlurFilter(4, 4)];

            var prb:SimpleButton = new SimpleButton(up, over, down, up);

            prb.y = 100;
            var skip:int = 20;
            var emptySpace:int = (GlobalMetrics.STAGE_WIDTH - prb.width * 3 - 2 * skip) / 2;
            prb.x = emptySpace + i * prb.width + i * skip;
//            prb.x = (GlobalMetrics.STAGE_WIDTH / 4) * (i + 1) - prb.width / 2;

            addChild(prb);

            var caption:TextField = TextUtils.createCustomTextField();
            caption.width = prb.width;
            //caption.autoSize = TextFieldAutoSize.CENTER;
            caption.htmlText = "<p class='c'>" + prname[i] + "</p>";
            caption.x = prb.x;// + (prb.width - caption.textWidth) / 2;
            caption.y = prb.y + prb.height + 10;

            addChild(caption);

            prb.addEventListener(MouseEvent.CLICK, function(pind:int):Function {
                return function(event:Event):void {
                    KioBase.instance.setProblem(pind);
                }
            } (i));
        }

        var formButton:TextButton = new TextButton("Заполнить анкету", 200);
        var loadButton:TextButton = new TextButton("Загрузить рабочую область", 200);
        var saveButton:TextButton = new TextButton("Сохранить рабочую область", 200);

        formButton.x = GlobalMetrics.H_PADDING;
        loadButton.x = GlobalMetrics.H_PADDING;
        saveButton.x = GlobalMetrics.H_PADDING;
        formButton.y = 400;
        loadButton.y = 465;
        saveButton.y = 500;

        addChild(formButton);
        addChild(loadButton);
        addChild(saveButton);

        formButton.addEventListener(MouseEvent.CLICK, formButtonClick);
    }

    private function formButtonClick(event:Event):void {
        KioBase.instance.currentDisplay = new AnketaDisplay;
    }
}
}
