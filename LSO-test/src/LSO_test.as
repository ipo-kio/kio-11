package {
import flash.display.Sprite;
import flash.events.NetStatusEvent;
import flash.net.SharedObject;
import flash.net.registerClassAlias;
import flash.system.Security;
import flash.system.SecurityPanel;
import flash.system.System;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class LSO_test extends Sprite {

    private var LSO_NAME:String = "test-kio-11-lso";
    private var textField:TextField = null;

    private function outputText(lines:Array):void {
        if (textField)
            removeChild(textField);

        textField = new TextField();

        textField.text = '';
        for each (var line:String in lines)
            textField.appendText(line + '\n');

        textField.setTextFormat(new TextFormat("MONOSPACE", 24));
        textField.autoSize = TextFieldAutoSize.LEFT;

        textField.x = 20;
        textField.y = 20;
        //textField.antiAliasType = AntiAliasType.ADVANCED;
        addChild(textField);
    }

    private function get lso():SharedObject {
        try {
            return SharedObject.getLocal(LSO_NAME, "/");
        } catch (er:Error) {
            //failed to get lso
        }
        return null;
    }

    public function LSO_test() {
        var so:SharedObject = lso;
        /*so.data.x = 42;
        so.flush();*/
        outputText([so.data.x]);

        /*
        var so:SharedObject;
        so = SharedObject.getLocal("kio-test", "/");
        so.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        so.data.field = 1;
        var txt : String = so.flush(1000000);
        outputText([txt]);
*/
        /*

        so = lso;
        so.data.field = 1;
        var result:String = so.flush(239);
        outputText([result]);*/
        /*
        if (so) {
            outputText(['удача']);
        } else {
            outputText(['неудача']);
        }*/

        /*while (true) {
            so = lso;
            if (!so) {
                outputText(
                        [
                            "Не удалось получить данные.",
                            "Пожалуйста, установите в настройках разрешение на сохранение данных"
                        ]
                        );
                System.showSettings(1);
            }
        }*/
    }

    private function netStatusHandler(e : NetStatusEvent):void {
        outputText(["HERE"]);
    }
}
}
