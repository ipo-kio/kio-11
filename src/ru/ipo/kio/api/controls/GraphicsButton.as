/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.02.11
 * Time: 12:00
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api.controls {
import flash.display.BitmapData;
import flash.display.SimpleButton;
import flash.display.Sprite;

import flash.text.TextField;

import ru.ipo.kio.api.TextUtils;

public class GraphicsButton extends SimpleButton {

    public function GraphicsButton(title:String, up:BitmapData, over:BitmapData, down:BitmapData, fontName:String, up_size:int, down_size:int) {
        var up_sprite:Sprite = createSprite(title, up, fontName, up_size);
        super(
                up_sprite,
                createSprite(title, over, fontName, up_size),
                createSprite(title, down, fontName, down_size),
                up_sprite
                );
    }

    private function createSprite(title:String, bmp:BitmapData, fontName:String, size:int):Sprite {
        var sprite:Sprite = new Sprite;

        sprite.graphics.beginBitmapFill(bmp);
        sprite.graphics.drawRect(0, 0, bmp.width, bmp.height);
        sprite.graphics.endFill();

        var textField:TextField = TextUtils.createTextFieldWithFont(fontName, size, false);
//        TextUtils.setTextForTextField(textField, title, fontName, size);
        //textField.htmlText = "<p>" + title + "</p>";
        textField.text = title;
        textField.x = (bmp.width - textField.width) / 2;
        textField.y = (bmp.height - textField.height) / 2;
        sprite.addChild(textField);

        return sprite;
    }
}
}
