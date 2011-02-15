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
    public function AnketaDisplay() {
        addChild(new Resources.BG_IMAGE);

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID).screen;

        var header:TextField = TextUtils.createCustomTextField();
        header.htmlText = '<p class="h1">' + loc.form.header + '</p>';
        header.width = GlobalMetrics.STAGE_WIDTH - 2 * GlobalMetrics.H_PADDING;
        header.x = GlobalMetrics.H_PADDING;
        header.y = GlobalMetrics.V_PADDING;

        addChild(header);

        var continueButton:TextButton = new TextButton(loc.buttons.continue_, 200, 100);
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
                "ФИО Участника",
                [
                    "Фамилия",
                    "Имя",
                    "Отчество"
                ],
                [
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнена";
                            if (text.toUpperCase() != text)
                                return "Поле необходимо набрать заглавными буквами";
                            return null;
                        },
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            if (text.toUpperCase() != text)
                                return "Поле необходимо набрать заглавными буквами";
                            return null;
                        },
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            if (text.toUpperCase() != text)
                                return "Поле необходимо набрать заглавными буквами";
                            return null;
                        }
                ],
                100,
                200
                );

        fio.x = GlobalMetrics.H_PADDING;
        fio.y = 80;
        addChild(fio);

        var connection:InputBlock = new InputBlock(
                "Связь",
                [
                    "Телефон",
                    "e-mail"
                ],
                [
                        null,
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            return null;
                        }
                ],
                100,
                200
                );

        connection.x = GlobalMetrics.H_PADDING;
        connection.y = fio.y + fio.height;
        addChild(connection);

        var school:InputBlock = new InputBlock(
                "Образовательное учеререждение",
                [
                    "Название",
                    "Индекс",
                    "Город",
                    "Улица",
                    "Дом",
                    "Корпус"
                ],
                [
                        null,
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            return null;
                        },
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            return null;
                        },
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            return null;
                        },
                        function(text:String):String {
                            if (trim(text).length == 0)
                                return "Поле должно быть заполнено";
                            return null;
                        },
                        null
                ],
                100,
                200
                );

        school.x = GlobalMetrics.H_PADDING;
        school.y = connection.y + connection.height;
        addChild(school);
    }

    private function continueButtonClicked(event:Event):void {
        KioBase.instance.currentDisplay = new ProblemsDisplay;
    }

    private function trim(s:String):String {
        return s.replace('/ /', '');
    }
}
}