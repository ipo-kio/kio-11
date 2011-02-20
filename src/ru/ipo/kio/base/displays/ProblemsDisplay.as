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

import flash.filters.ColorMatrixFilter;
import flash.net.sendToURL;
import flash.text.TextField;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class ProblemsDisplay extends Sprite {

    public function ProblemsDisplay() {
        addChild(new Resources.BG_IMAGE);

        for (var i:int = 0; i < 3; i++) {
            var problem:KioProblem = KioBase.instance.problem(i);
            var title:String;
            if (KioApi.getLocalization(problem.id).title)
                title = KioApi.getLocalization(problem.id).title;
            else
                title = 'No title';

            var imageClass:Class;
            if (KioApi.getLocalization(problem.id).image)
                imageClass = KioApi.getLocalization(problem.id).image;
            else
                imageClass = Resources.NO_PROBLEM_IMG;

            var upDownImage:* = new imageClass;

            var over:DisplayObject = new imageClass;
            var brightness:ColorMatrixFilter = new ColorMatrixFilter();
            /*brightness.matrix = [
             1.14948, 0.293459, 0.0569921, 0, 0,
             0.149511, 1.29352, 0.057004, 0, 0,
             0.1495, 0.2935, 1.057, 0, 0,
             0, 0, 0, 1, 0
             ];*/
            brightness.matrix = [
                1.07474, 0.14673, 0.028496, 0, 0,
                0.0747553, 1.14767, 0.028502, 0, 0,
                0.07475, 0.14675, 1.0285, 0, 0,
                0, 0, 0, 1, 0
            ];

            over.filters = [brightness];

            var prb:SimpleButton = new SimpleButton(upDownImage, over, upDownImage, upDownImage);

            prb.y = 100;
            var skip:int = 20;
            var emptySpace:int = (GlobalMetrics.STAGE_WIDTH - prb.width * 3 - 2 * skip) / 2;
            prb.x = emptySpace + i * prb.width + i * skip;
//            prb.x = (GlobalMetrics.STAGE_WIDTH / 4) * (i + 1) - prb.width / 2;

            addChild(prb);

            var caption:TextField = TextUtils.createCustomTextField();
            caption.width = prb.width;
            //caption.autoSize = TextFieldAutoSize.CENTER;
            caption.htmlText = "<p class='c'>" + title + "</p>";
            caption.x = prb.x;// + (prb.width - caption.textWidth) / 2;
            caption.y = prb.y + prb.height + 10;

            addChild(caption);

            prb.addEventListener(MouseEvent.CLICK, function(pind:int):Function {
                return function(event:Event):void {
                    KioBase.instance.setProblem(pind);
                }
            }(i));
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
