/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 09.02.11
 * Time: 15:26
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api.controls {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BevelFilter;

import flash.system.Security;
import flash.system.SecurityPanel;
import flash.text.TextFieldAutoSize;

import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.GlobalMetrics;

import ru.ipo.kio.base.KioBase;

public class SpaceSettingsDialog extends Sprite {

    private static const ALPHA:Number = 0.5;
    private static const COLOR_BG:uint = 0xAA0000;
    private static const COLOR:uint = 0xFF8C00;
//    private static const COLOR_BORDER:uint = 0x880022;
    private static const WIDTH:int = 560;
    private static const HEIGHT:int = 420;

    private static const BORDER_SIZE:int = 10;

    [Embed(source="../../../../../../resources/imgs/settings_ru.png")]
    public var SettingsImage:Class;

    public function SpaceSettingsDialog() {
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void {

        x = 0;
        y = 0;

        graphics.beginFill(COLOR_BG, ALPHA);
        graphics.drawRect(0, 0, GlobalMetrics.STAGE_WIDTH, GlobalMetrics.STAGE_HEIGHT);
        graphics.endFill();

        //center panel

        var centerPanel:Sprite = new Sprite();

        centerPanel.x = (GlobalMetrics.STAGE_WIDTH - WIDTH) / 2;
        centerPanel.y = (GlobalMetrics.STAGE_HEIGHT - HEIGHT) / 2;

        centerPanel.graphics.beginFill(COLOR);
        centerPanel.graphics.drawRect(0, 0, WIDTH, HEIGHT);
        centerPanel.filters = [new BevelFilter(1.0/*, -30, COLOR_BORDER*/)];
        centerPanel.graphics.endFill();

        addChild(centerPanel);

        //set text
        TextUtils.moveTo(centerPanel, BORDER_SIZE, BORDER_SIZE, 6);
        TextUtils.output(
                centerPanel,
                TextUtils.drawText(
                        "ВНИМАНИЕ!", TextUtils.NORMAL_TEXT_SIZE, TextFieldAutoSize.LEFT, 0x880000, 1
                        )
                );
        TextUtils.output(
                centerPanel,
                TextUtils.drawTextWidth("Для работы программы конкурса КИО ей необходимо разрешить хранить данные на диске. \n" +
                        "Нажмите кнопку \"Открыть окно настроек\" и позвольте программе пользоваться как минимум одним мегабайтом. Для этого установите настройки как на картинке:",
                        WIDTH - 2 * BORDER_SIZE, TextUtils.NORMAL_TEXT_SIZE, TextFieldAutoSize.LEFT, 0, 1
                        )
                );
        TextUtils.output(
                centerPanel,
                new SettingsImage
                );
        TextUtils.output(
                centerPanel,
                TextUtils.drawTextWidth("Только после этого вы сможете закрыть это окно кнопкой \"Закрыть\"",
                        WIDTH - 2 * BORDER_SIZE, TextUtils.NORMAL_TEXT_SIZE, TextFieldAutoSize.LEFT, 0, 1
                        )
                );

        var openSettingButton:TextButton = new TextButton("Открыть окно настроек", WIDTH / 3);
        openSettingButton.x = BORDER_SIZE;
        openSettingButton.y = HEIGHT - BORDER_SIZE - openSettingButton.height;
        centerPanel.addChild(openSettingButton);
        openSettingButton.addEventListener(MouseEvent.CLICK, openSettingButtonClicked);
        stage.focus = openSettingButton;
        //todo make it modal

        var closeButton:TextButton = new TextButton("Закрыть");
        closeButton.x = WIDTH - BORDER_SIZE - closeButton.width;
        closeButton.y = HEIGHT - BORDER_SIZE - closeButton.height;
        centerPanel.addChild(closeButton);
        closeButton.addEventListener(MouseEvent.CLICK, closeButtonClicked)
    }

    private function openSettingButtonClicked(event:Event):void {
        Security.showSettings(SecurityPanel.LOCAL_STORAGE);
    }

    private function closeButtonClicked(event:Event):void {
        this.parent.removeChild(this);
        KioBase.instance.lsoProxy.flush();
    }

}
}
