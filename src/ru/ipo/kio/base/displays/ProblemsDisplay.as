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

import flash.text.TextField;

import ru.ipo.kio.api.FileUtils;
import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.api.controls.BrightnessFilter;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class ProblemsDisplay extends Sprite {

    public function ProblemsDisplay() {
        DisplayUtils.placeBackground(this);

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID);

        var message:TextField = TextUtils.createCustomTextField();
        message.htmlText = "<p class='h1'>" + loc.screen.problems.header + "</p>";
        message.width = GlobalMetrics.DISPLAYS_TEXT_WIDTH;
        message.x = (GlobalMetrics.STAGE_WIDTH - message.textWidth/*GlobalMetrics.DISPLAYS_TEXT_WIDTH*/) / 2;
        message.y = GlobalMetrics.DISPLAYS_TEXT_TOP;

        addChild(message);

        for (var i:int = 0; i < 3; i++) {
            var problem:KioProblem = KioBase.instance.problem(i);
            var title:String;
            if (KioApi.getLocalization(problem.id).title)
                title = KioApi.getLocalization(problem.id).title;
            else
                title = 'No title';

            var imageClass:Class;
            if (problem.icon)
                imageClass = problem.icon;
            else
                imageClass = Resources.NO_PROBLEM_IMG;

            var upDownImage:* = new imageClass;

            var over:DisplayObject = new imageClass;
            over.filters = [BrightnessFilter(5/4)];

            var prb:SimpleButton = new SimpleButton(upDownImage, over, upDownImage, upDownImage);

            prb.y = message.y + message.textHeight + 20;
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

        var formButton:SimpleButton = new ShellButton(loc.screen.problems.fill_form, true);
        var loadButton:SimpleButton = new ShellButton(loc.buttons.load_workspace, true);
        var saveButton:SimpleButton = new ShellButton(loc.buttons.save_workspace, true);

        formButton.x = Math.floor((GlobalMetrics.STAGE_WIDTH - formButton.width) / 2);
        loadButton.x = Math.floor((GlobalMetrics.STAGE_WIDTH - loadButton.width) / 2);
        saveButton.x = Math.floor((GlobalMetrics.STAGE_WIDTH - saveButton.width) / 2);
        formButton.y = 440;
        loadButton.y = 505;
        saveButton.y = 540;

        addChild(formButton);
        addChild(loadButton);
        addChild(saveButton);

        formButton.addEventListener(MouseEvent.CLICK, formButtonClick);
        loadButton.addEventListener(MouseEvent.CLICK, loadButtonClick);
        saveButton.addEventListener(MouseEvent.CLICK, saveButtonClick);
    }

    private function saveButtonClick(event:Event):void {
        FileUtils.saveAll();
    }

    private function loadButtonClick(event:Event):void {
        FileUtils.loadAll();
    }

    private function formButtonClick(event:Event):void {
        KioBase.instance.currentDisplay = new AnketaDisplay;
    }

}
}
