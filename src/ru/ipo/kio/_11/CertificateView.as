/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.04.11
 * Time: 17:07
 */
package ru.ipo.kio._11 {
import com.adobe.serialization.json.JSON;

import flash.display.BitmapData;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.text.TextField;
import flash.utils.ByteArray;

import mx.core.BitmapAsset;

import mx.events.ModuleEvent;

import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.displays.ShellButton;

public class CertificateView extends Sprite {

    [Embed(source="resources/cert-1.png")]
    private static var LEVEL_1:Class;
    private var IMG_1:BitmapAsset = new LEVEL_1;

    [Embed(source="resources/cert-2.png")]
    private static var LEVEL_2:Class;
    private var IMG_2:BitmapAsset = new LEVEL_2;

    private static const BUTTONS_LEFT:int = 4;
    private static const BUTTONS_SKIP:int = 10;
    private static const BUTTONS_TOP:int = 4;

    private var buttonsPanel:Sprite;
    private var welcomePanel:Sprite;

    //certificate panel
    private var certificatePanel:Sprite;

    private var topHeight:int;

    private var certificateFile:FileReference;

    public function CertificateView() {
        if (!stage)
            addEventListener(Event.ADDED_TO_STAGE, init);
        else
            init();
    }

    private function init(event:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        placeElement();
        stage.addEventListener(Event.RESIZE, placeElement);

        createButtonsPanel();
        createCertificatePanel();
        createWelcomePanel();

        addChild(welcomePanel);
    }

    private function createCertificatePanel():void {
        certificatePanel = new Sprite;
        certificatePanel.x = 0;
        certificatePanel.y = topHeight;
    }

    private function createButtonsPanel():void {
        buttonsPanel = new Sprite;
        var load:SimpleButton = new ShellButton("Загрузить");
        var print:SimpleButton = new ShellButton("Напечатать");
        load.x = BUTTONS_LEFT;
        load.y = BUTTONS_TOP;
        print.x = load.x + load.width + BUTTONS_SKIP;
        print.y = BUTTONS_TOP;

        load.addEventListener(MouseEvent.CLICK, loadClick);
        print.addEventListener(MouseEvent.CLICK, printClick);

        buttonsPanel.addChild(load);
        buttonsPanel.addChild(print);

        topHeight = 2 * BUTTONS_TOP + load.height;
    }

    private function loadClick(event:MouseEvent):void {
        certificateFile = new FileReference();
        certificateFile.addEventListener(Event.SELECT, fileSelected);
        certificateFile.browse([
            new FileFilter("Файлы сертификатов конкурса КИО", "*.kio-certificate"),
            new FileFilter("Все файлы", "*.*")
        ]);
    }

    private function createWelcomePanel():void {
        welcomePanel = new Sprite;

        var hello:TextField = TextUtils.createCustomTextField(false);
        hello.htmlText = "<h1 align='center'>Нажмите на любое место экрана, чтобы загрузить сертификат</h1><p align='center'>одинодин</p>";
        welcomePanel.addChild(hello);
        welcomePanel.graphics.beginFill(0xAAAAAA);
        welcomePanel.graphics.drawRect(0, 0, 640, 480);
        welcomePanel.graphics.endFill();

        welcomePanel.addEventListener(MouseEvent.CLICK, loadClick);
    }

    private function placeElement(event:Event = null):void {
        resizeButtonsPanel();
        resizeCertificatePanel();
        resizeWelcomePanel();
    }

    private function resizeWelcomePanel():void {
        trace('resize welcome panel');
    }

    private function resizeCertificatePanel():void {
        trace('resize certificate panel');
    }

    private function resizeButtonsPanel():void {
        trace('resize buttons panel');
    }

    private function fileSelected(event:Event):void {
        if (welcomePanel) {
            removeChild(welcomePanel);
            welcomePanel = null;
            addChild(buttonsPanel);
            addChild(certificatePanel);
        }

        certificateFile.addEventListener(Event.COMPLETE, fileLoaded);
        certificateFile.load();
    }

    private function fileLoaded(event:Event):void {
        var certificate:Object = loadCertificate(certificateFile.data);

        var img:BitmapData = (certificate.level == 1 ? IMG_1 : IMG_2).bitmapData;
        certificatePanel.graphics.clear();
        certificatePanel.graphics.beginBitmapFill(img);
        certificatePanel.graphics.drawRect(0, 0, img.width, img.height);
        certificatePanel.graphics.endFill();
    }

    private function loadCertificate(data:ByteArray):Object {
        var keyed_certificate:Object = JSON.decode(data.readUTFBytes(data.length));
        var json_certificate:String = keyed_certificate.json_certificate;
        if (KioChecker.signString(json_certificate) != keyed_certificate.signature)
            throw new IOError('Не сходится подпись');
        return JSON.decode(json_certificate);
    }

    private function printClick():void {
        welcomePanel.
    }

}
}
