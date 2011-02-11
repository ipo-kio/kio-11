package {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.NetStatusEvent;
import flash.net.SharedObject;
import flash.net.SharedObjectFlushStatus;
import flash.net.registerClassAlias;
import flash.system.Security;
import flash.system.SecurityPanel;
import flash.system.System;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import mx.charts.AreaChart;

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

        textField.setTextFormat(new TextFormat("MONOSPACE", 18));
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.type = TextFieldType.INPUT;
        textField.textColor = 0xCC0000;

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

        lso.data.x = 42;

        lso.flush();

        outputText(["hello"]);

        var s : Sprite = new Sprite();
        s.graphics.beginFill(0);
        s.graphics.drawRect(200,200,100,100);
        s.graphics.endFill();
        addChild(s);

        s.addEventListener(MouseEvent.CLICK, function(e:Event):void{
            outputText([lso.data.x]);
        });

        for (var k:* in lso.data) {
            trace(k);
            trace(lso.data[k]);
        }

        /*so.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

        outputText(["42"]);

        var a:Array = new Array;
        for (var i:int = 0; i < 1000; i++) {
            a.push(i);
        }
        so.data.ar = a;

        outputText([so.data.ar]);

        var flushStatus:String = null;
        try {
            flushStatus = so.flush(100000);
        } catch (error:Error) {
            outputText(["Error...Could not write SharedObject to disk"]);
        }
        if (flushStatus != null) {
            switch (flushStatus) {
                case SharedObjectFlushStatus.PENDING:
                    outputText(["Requesting permission to save object...\n"]);
                    so.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
                    break;
                case SharedObjectFlushStatus.FLUSHED:
                    outputText(["Value flushed to disk.\n"]);
                    break;
            }
        }

        var s:Sprite = new Sprite();
        s.x = 0;
        s.y = 0;
        s.graphics.beginFill(0x0000AA, 0.5);
        s.graphics.drawRect(0, 0, 640, 480);
        s.graphics.endFill();
        addChild(s);*/

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

    private function onFlushStatus(event:NetStatusEvent):void {
        outputText(["User closed permission dialog...\n"]);
        switch (event.info.code) {
            case "SharedObject.Flush.Success":
                outputText(["User granted permission -- value saved.\n"]);
                break;
            case "SharedObject.Flush.Failed":
                outputText(["User denied permission -- value not saved.\n"]);
                break;
        }

        //so.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
    }

    private function netStatusHandler(e:NetStatusEvent):void {
        outputText(["HERE"]);
    }
}
}
