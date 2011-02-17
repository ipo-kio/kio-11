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

import ru.ipo.kio.api.TextUtils;

public class ResultsPanel extends Sprite {

    private var _rooms:int;
    private var _length:int;

    private var ftRooms:TextField;
    private var ftLength:TextField;

    public function ResultsPanel(caption:String, width:int) {
        var ftCaption:TextField = TextUtils.createCustomTextField(false);
        ftCaption.htmlText = "<p class='h15'>" + caption + "</p>";
        addChild(ftCaption);

        var ftRoomsLabel:TextField = TextUtils.createCustomTextField(false);
        ftRoomsLabel.y = ftCaption.y + ftCaption.textHeight + 6;
        ftRoomsLabel.htmlText = "<p class='h2'>" + "Орошено комнат:" + "</p>";
        ftRoomsLabel.width = width / 2;
        addChild(ftRoomsLabel);

        var ftLengthLabel:TextField = TextUtils.createCustomTextField(false);
        ftLengthLabel.y = ftRoomsLabel.y + ftRoomsLabel.textHeight + 6;
        ftLengthLabel.htmlText = "<p class='h2'>" + "Длина труб в этажах:" + "</p>";
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
        ftLength.y = ftLength.y;
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

    public function get length():int {
        return _length;
    }

    public function set length(value:int):void {
        _length = value;
        ftLength.htmlText = "<p>" + value + "</p>";
    }
}
}