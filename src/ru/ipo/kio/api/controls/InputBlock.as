/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 12.02.11
 * Time: 16:12
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api.controls {
import flash.display.Sprite;
import flash.text.TextField;

import ru.ipo.kio.api.TextUtils;

public class InputBlock extends Sprite {

    private var inputs:Array;

    public function InputBlock(caption:String, labels:Array, filters:Array, labelWidth:int, inputWidth:int) {
        var captionTF:TextField = TextUtils.createCustomTextField();
        captionTF.wordWrap = false;
        captionTF.multiline = false;
        addChild(captionTF);
        captionTF.htmlText = "<p class='h2'>" + caption + "</p>";

        inputs = [];

        var y0:int = captionTF.textHeight + 4;

        for (var i:int = 0; i < labels.length; i++) {
            var inp:InputTextField = new InputTextField(inputWidth, TextUtils.NORMAL_TEXT_SIZE);

            var label:TextField = TextUtils.createCustomTextField();
            label.wordWrap = false;
            label.multiline = false;
            label.width = labelWidth;
            label.htmlText = "<p>" + labels[i] + "</p>";

            inputs.push(inp);

            label.x = 0;
            label.y = y0;

            inp.x = labelWidth + 10;
            inp.y = y0;

            inp.filter = filters[i];

            addChild(inp);
            addChild(label);

            y0 += inp.height;
        }
    }

    public function restrict(ind:int, value:String):void {
        inputs[ind].restrict = value;
    }
}
}
