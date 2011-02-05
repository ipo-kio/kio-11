package {

import flash.display.Sprite;
import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class LSO_test extends Sprite {

    private function createText(lines:Array):TextField
    {
        var textField:TextField = new TextField();

        textField.text = '';
        for each (var line:String in lines)
            textField.appendText(line + '\n');

        textField.setTextFormat(new TextFormat(null, 16));
        textField.autoSize = TextFieldAutoSize.LEFT;
        return textField;
    }

    public function LSO_test() {
        //place code here
    }
}
}
