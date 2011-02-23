/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 11.02.11
 * Time: 10:04
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;

import flash.text.TextField;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.api.controls.InputBlock;
import ru.ipo.kio.api.controls.InputTextField;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;
import ru.ipo.kio.base.KioBase;
import ru.ipo.kio.base.resources.Resources;

public class AnketaDisplay extends Sprite {

    private var inputTextFields:Array;
    private var continueButton:TextButton;

    public function AnketaDisplay() {
        addChild(new Resources.BG_IMAGE);

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID).screen;

        var must_be_filled:Function = function(text:String):String {
            if (trim(text).length == 0)
                return loc.form.field_must_be_filled;
            return null;
        };

        var header:TextField = TextUtils.createCustomTextField();
        header.htmlText = '<p class="h1">' + loc.form.header + '</p>';
        header.width = GlobalMetrics.STAGE_WIDTH - 2 * GlobalMetrics.H_PADDING;
        header.x = GlobalMetrics.H_PADDING;
        header.y = GlobalMetrics.V_PADDING;

        addChild(header);

        continueButton = new TextButton(loc.buttons.continue_, 200, 100);
        continueButton.x = GlobalMetrics.STAGE_WIDTH - continueButton.width - GlobalMetrics.H_PADDING;
        continueButton.y = GlobalMetrics.STAGE_HEIGHT - continueButton.height - GlobalMetrics.V_PADDING;
        continueButton.addEventListener(MouseEvent.CLICK, continueButtonClicked);

        addChild(continueButton);

        /*var placeHolder:TextField = TextUtils.createCustomTextField();
         placeHolder.htmlText = '<p class="warning">' + 'Анкета пока не оформлена. Жмите "продолжить".' + '</p>';
         placeHolder.width = GlobalMetrics.STAGE_WIDTH - 2 * GlobalMetrics.H_PADDING;
         placeHolder.x = GlobalMetrics.H_PADDING;
         placeHolder.y = header.y + header.height + 32;

         addChild(placeHolder);*/

        var fio:InputBlock = new InputBlock(
                loc.form.participant_name,
                [
                    loc.form.surname,
                    loc.form.name,
                    loc.form.second_name
                ],
                [
                    must_be_filled,
                    must_be_filled,
                    must_be_filled
                ],
                ['surname', 'name', 'second_name'],
                100,
                300
                );

        fio.x = GlobalMetrics.H_PADDING;
        fio.y = 80;
        addChild(fio);

        for (var bi:int = 0; bi < 3; bi++)
            fio.restrict(bi, loc.form.name_restriction);

        var connection:InputBlock = new InputBlock(
                loc.form.connection,
                [
//                    "Телефон",
            loc.form.e_mail
        ],
                [
                    must_be_filled
                ],
                ['email'],
                100,
                300
                );

        connection.x = GlobalMetrics.H_PADDING;
        connection.y = fio.y + fio.height;
        addChild(connection);

        var school:InputBlock = new InputBlock(
                loc.form.institution,
                [
                    loc.form.institution_name,
                    loc.form.zip,
                    loc.form.address
                    /*"Город",
                     "Улица",
                     "Дом",
                     "Корпус"*/
                ],
                [
                    must_be_filled,
                    must_be_filled,
                    must_be_filled
                ],
                ['inst_name', 'zip', 'address'],
                100,
                300,
                [1, 1, 3]
                );

        school.x = GlobalMetrics.H_PADDING;
        school.y = connection.y + connection.height;
        addChild(school);

        inputTextFields = [];
        inputTextFields = inputTextFields.concat(fio.inputs);
        inputTextFields = inputTextFields.concat(connection.inputs);
        inputTextFields = inputTextFields.concat(school.inputs);

        //load values, add listeners
        var anketa:Object = KioBase.instance.lsoProxy.getAnketa();
        for each (var inp:InputTextField in inputTextFields) {
            inp.text = anketa[inp.id];
            inp.addEventListener(Event.CHANGE, valueChanged);
        }

        setEnabledForContinueButton();
    }

    private function valueChanged(event:Event):void {
        var i:InputTextField = InputTextField(event.currentTarget);
        var anketa:Object = KioBase.instance.lsoProxy.getAnketa();
        if (!i.error)
            anketa[i.id] = i.text;
        setEnabledForContinueButton();
    }

    private function setEnabledForContinueButton():void {
        var hasError:Boolean = false;
        for each (var inp:InputTextField in inputTextFields)
            if (inp.error) {
                hasError = true;
                break;
            }

        //TODO make sure enabled means not clickable
        continueButton.enabled = ! hasError;
    }

    private function continueButtonClicked(event:Event):void {
        if (continueButton.enabled)
            KioBase.instance.currentDisplay = new ProblemsDisplay;
    }

    private function trim(s:String):String {
        return s.replace('/ /', '');
    }
}
}