/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 16.02.11
 * Time: 22:37
 */
package ru.ipo.kio._11.semiramida {
import flash.display.Sprite;
import flash.text.TextField;

import flash.text.TextFieldAutoSize;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.TextUtils;

public class ResultsPanel extends Sprite {

    private var _rooms:int;
    private var _pipesLength:int;

    private var ftRooms:TextField;
    private var ftLength:TextField;

    public function ResultsPanel(caption:String, width:int) {
        var api:KioApi = KioApi.instance(SemiramidaProblem.ID);

        var ftCaption:TextField = TextUtils.createCustomTextField(false);
        ftCaption.width = width;
        ftCaption.htmlText = "<p class='h15'>" + caption + "</p>";
        addChild(ftCaption);

        var ftRoomsLabel:TextField = TextUtils.createCustomTextField(false);
        ftRoomsLabel.y = ftCaption.y + ftCaption.textHeight + 6;
        ftRoomsLabel.htmlText = "<p class='h2'>" + api.localization.results.rooms + ":" + "</p>";
        ftRoomsLabel.width = width / 2;
        addChild(ftRoomsLabel);

        var ftLengthLabel:TextField = TextUtils.createCustomTextField(false);
        ftLengthLabel.y = ftRoomsLabel.y + ftRoomsLabel.textHeight + 6;
        ftLengthLabel.htmlText = "<p class='h2'>" + api.localization.results.length + ":" + "</p>";
        ftLengthLabel.width = width / 2;
        addChild(ftLengthLabel);

        ftRooms = TextUtils.createCustomTextField(false);
//        ftRooms.autoSize = TextFieldAutoSize.RIGHT;
        ftRooms.width = width / 2;
        ftRooms.y = ftRoomsLabel.y;
        ftRooms.x = width / 2;
        addChild(ftRooms);

        ftLength = TextUtils.createCustomTextField(false);
//        ftLength.autoSize = TextFieldAutoSize.RIGHT;
        ftLength.width = width / 2;
        ftLength.y = ftLengthLabel.y;
        ftLength.x = width / 2;
        addChild(ftLength);
    }

    public function get rooms():int {
        return _rooms;
    }

    public function set rooms(value:int):void {
        _rooms = value;
        ftRooms.htmlText = "<p>" + value + "</p>";
    }

    public function get pipesLength():int {
        return _pipesLength;
    }

    public function set pipesLength(value:int):void {
        _pipesLength = value;
        ftLength.htmlText = "<p>" + value + "</p>";
    }
}
}