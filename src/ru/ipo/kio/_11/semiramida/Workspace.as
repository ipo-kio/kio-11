package ru.ipo.kio._11.semiramida {
import flash.display.Sprite;

import flash.text.TextField;

import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.resources.Resources;

public class Workspace extends Sprite {

    private var house:House;

    public function Workspace() {
        var house:House = new House(450,450);
        house.x = 10;
        house.y = 10;
        addChild(house);

/*        var a:A;

        var textField:TextField = TextUtils.createCustomTextField();
        textField.htmlText = "<p class='warning'>Hello World g ;dlskjg lsd;fgj s;ldjg ;lsdgj d ; gdsfhg kdsjhg lksdjhg lsdkjhg dklsfg h!</p><img width='200' height='90' src='ru.ipo.kio._11.semiramida.A' /><p>AaaaaaaaaaaAAAAA K: lKJ :LKJ k World!</p>";
        textField.x = 100;
        textField.y = 100;
        textField.width = 400;
        addChild(textField);*/
    }

}
}